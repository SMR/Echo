## Self-sizing Cell Using Auto Layout and Storyboard

### Introduction
As an iOS developer, I am used to writing UI layout manually with `layoutSubviews`.
However, I have spent a lot of time sizing custom table view cells in code and having to manually calculate the height of every label, image view, text field, and everything else within the cell.
Therefore, I would like to find out a more elegant and concise solution.
After surveying, I cast my attention back on two old friends --- Auto Layout and Storyboard.

### Implementation
In this article, I will build up a very simple messaging app and its feature is just to echo what a user sends.
Please notice that I will skip several insignificant steps, for example, creating the view controller or the custom table view cell class.

![Sample](https://github.com/ShengHuaWu/Echo/blob/master/Resources/Sample.png)

Let's get started with our UI components.
Drag and drop a table view, a text field, and a send button within the storyboard and hook them up with the view controller.

```
final class MessagingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    // ...
}
```

In addition, set up the following constraints with the `Pin menu` of the storyboard:
1. Pin the top edge of the table view 0 points from the top margin of its superview.
2. Pin the leading and trailing edges of the table view 0 points from the leading and trailing margins of its superview.
3. Pin the bottom edges of the table view 8 points from the top of the text field.
4. Pin the leading edge of the text field 8 points from the leading margin of its superview.
5. Pin the trailing edge of the text field 8 points from the leading of the send button.
6. Pin the bottom edge of the text field 8 points from the bottom margin of its superview.
7. Align both top and bottom edges of the text field and the send button.

![ViewControllerConstraints](https://github.com/ShengHuaWu/Echo/blob/master/Resources/ViewControllerConstraints.png)

After finishing the constraints, move to the size inspector of the text field and set `Horizontal Content Hugging Priority` to 249.
Setting this priority should help the text field get stretched and fix the warnings.

![HorizontalContentHuggingPriority](https://github.com/ShengHuaWu/Echo/blob/master/Resources/HorizontalContentHuggingPriority.png)

Secondly, drag and drop an image view and a label into the table view cell and hook them up with the custom table view cell.

```
final class MessagingCell: UITableViewCell {
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    // ...
}
```

Besides, set up the following constraints as well:
1. Pin the leading, top, trailing, and bottom edges of the image view 0 points from the margins of the content view.
2. Pin the leading, top, trailing, and bottom edges of the label 16 points from the margins of the content view.

![CellContraints](https://github.com/ShengHuaWu/Echo/blob/master/Resources/CellContraints.png)

After finishing all UI components, switch to the swift file of the view controller and add these two lines of code in the viewDidLoad method.

```
override func viewDidLoad() {
    super.viewDidLoad()

    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
}
```

When setting the rowHeight as `UITableViewAutomaticDimension`, the table view is told to use the Auto Layout constraints and the contents of its cells to determine each cell’s height.
In order for the table view to do this, you must also provide an `estimatedRowHeight`.
In this case, 100 is just an arbitrary value that works well in this particular instance.

Last but not least, implement the `sendAction` method and hook it up with the send button.

```
@IBAction func sendAction(sender: UIButton) {
    guard let text = textField.text, !text.isEmpty else { return }

    viewModel.appendMessage(with: text)
    textField.text = nil
}
```

### Conclusion
[Here](https://github.com/ShengHuaWu/Echo) is the entire sample project.

Table views are perhaps the most fundamental of structured data views in iOS.
As your apps get more complex, you’re likely to use all sorts of custom table view cell layouts.
We can take the advantages of the improvements to Storyboard to spare lots of time when implementing self-sizing cells.
Any comment and feedback are welcome, so please share your thoughts. Thank you!
