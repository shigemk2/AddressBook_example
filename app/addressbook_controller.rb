class AddressbookController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.underPageBackgroundColor
    load_button
    load_labels
  end

  def load_button
    @phonebook_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @phonebook_button.frame = [[50,20],[200,50]]
    @phonebook_button.setTitle("Click from Contacts", forState:UIControlStateNormal)
    @phonebook_button.addTarget(self,
                                action: :phonebook_access,
                                forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(@phonebook_button)
  end

  def load_labels
    @first_name = UILabel.new
    @first_name.text = 'First Name'
    @first_name.frame = [[100,100],[150,50]]

    @phone_number = UILabel.new
    @phone_number.text = 'Phone Number'
    @phone_number.frame = [[100,200],[150,50]]

    view.addSubview(@first_name)
    view.addSubview(@phone_number)
  end

  def phonebook_access
    @people_picker = ABPeoplePickerNavigationController.alloc.init
    @people_picker.peoplePickerDelegate = self
    presentModalViewController(@people_picker, animated:true)
  end

  def peoplePickerNavigationController(peoplePicker, shouldContinueAfterSelectingPerson:person)
    self.displayPerson(person)
    self.dismissModalViewControllerAnimated(true)
  end

  def displayPerson(person)
    firstname          = ABRecordCopyValue(person, KABPersonFirstNameProperty)
    phoneNumbers       = ABRecordCopyValue(person, KABPersonPhoneProperty)
    phone              = ABMultiValueCopyValueAtIndex(phoneNumbers, 0)
    @phone_number.text = phone
    @first_name.text   = firstname
  end

  def peoplePickerNavigationControllerDidCancel(peoplePicker)
    self.dismissModalViewControllerAnimated(true)
  end
end








