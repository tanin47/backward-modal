UIViewController+PresentingViewController
========================================

I was very annoyed with  the problem that iOS 4 does not support ```self.presentingViewController```.
And that makes my code look bad when trying to dismiss a modal view.

This library allow you to use ```self.presentingViewController``` on iOS 4. (On iOS 5, it disables itself. So, no worry)

I hope it benefits you as much as it does to me.

For more information about the technique, please see my blog [here](http://tanin.nanakorn.com/b/62/ios_4_and_5_incompatibility_in_dismissing_a_modal_view)


How to use it
---------------------------

Include 2 files into your project:

* ```UIViewController+PresentingViewController.h```
* ```UIViewController+PresentingViewController.m```

That's it.

On iOS 4, you may use ```self.presentingViewController```.

On iOS 5, the files are disabled by themselves. So, don't worry about it.


How to test it
----------------------------

1. Clone the project (or Download as a zip file)
2. Run the project under iPhone 4.x simulator
3. Run the project under iPhone 5.x simulator to see that it works on both iOS


Author
--------------------------
Tanin Na Nakorn



License
---------

Do What The Fuck You Want To Public License (http://sam.zoy.org/wtfpl/)

0. You just DO WHAT THE FUCK YOU WANT TO.