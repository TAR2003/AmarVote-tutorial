#set page(
  paper: "a4",
  margin: (left: 2.5cm, right: 2.5cm, top: 3cm, bottom: 3cm),
  fill: rgb("#0F172A"), // Premium dark slate background for the cover page
  header: context {
    if counter(page).get().first() > 1 [
      #set text(font: "Liberation Sans", size: 9pt, fill: rgb("#6B7280"))
      #grid(
        columns: (1fr, 1fr),
        align(left)[*AmarVote* Voter Manual],
        align(right)[Secure, Private, Verifiable]
      )
      #line(length: 100%, stroke: 0.5pt + rgb("#E5E7EB"))
    ]
  },
  footer: context {
    if counter(page).get().first() > 1 [
      #line(length: 100%, stroke: 0.5pt + rgb("#E5E7EB"))
      #v(0.5em)
      #set text(font: "Liberation Sans", size: 9pt, fill: rgb("#6B7280"))
      #align(center)[Page #counter(page).display("1 / 1", both: true)]
    ]
  }
)

#set text(font: "Liberation Sans", size: 10.5pt, fill: rgb("#F8FAFC"))
#set par(justify: true, leading: 0.65em)

// Custom Headings for the body (will apply after page 1)
#show heading.where(level: 1): it => block(
  width: 100%,
  fill: rgb("#2E5BFF"),
  inset: (x: 1.5em, y: 1em),
  radius: 0.3em,
  above: 2em,
  below: 1.5em,
  [#text(fill: white, weight: "bold", size: 14pt)[#it.body]]
)

#show heading.where(level: 2): it => block(
  above: 1.5em,
  below: 1em,
  [#text(fill: rgb("#2E5BFF"), size: 12pt, weight: "bold")[#it.body]]
)

// --- ELEGANT COVER PAGE ---

// Left-side minimalist design stripe
#place(top + left, dx: -2.5cm, dy: -3cm,
  rect(width: 8mm, height: 100% + 6cm, fill: rgb("#38BDF8"))
)

#v(3cm)

#text(size: 11pt, weight: "bold", tracking: 0.2em, fill: rgb("#38BDF8"))[SECURE VOTING PLATFORM]
#v(0.5em)

#text(size: 44pt, weight: "bold", fill: white)[AmarVote] \
#v(-0.4em)
#text(size: 24pt, weight: "light", fill: rgb("#94A3B8"))[Voter Manual]

#v(1.5cm)
#line(length: 4cm, stroke: 2pt + rgb("#38BDF8"))
#v(1.5cm)

#block(width: 85%)[
  #set par(leading: 0.8em)
  #text(size: 11pt, fill: rgb("#94A3B8"))[
    An end-to-end verifiable cryptographic voting system.
  ]
]

#v(1fr)

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  [
    #set text(size: 9.5pt, fill: rgb("#64748B"))
    *DOCUMENT CONTROL* \
    #v(0.2em)
    Classification: Public Instruction \
    System Release: v1.0
  ],
  [
    #set text(size: 9.5pt, fill: rgb("#64748B"))
    *SECURITY FRAMEWORK* \
    #v(0.2em)
    Encryption: E2E Standard \
    Audit State: Independent Verified
  ]
)

#pagebreak()
// --- END OF COVER PAGE ---

// --- RESET LAYOUT FOR THE MANUAL CONTENTS ---
#set page(
  fill: white,
  margin: (left: 2cm, right: 2cm, top: 2.5cm, bottom: 2.5cm),
)
#set text(fill: rgb("#374151"))
// --------------------------------------------

#v(1em)
#text(size: 11pt, style: "italic", fill: rgb("#4B5563"))[
  Welcome to the AmarVote Voter Manual. This guide provides a highly concise, visual walkthrough to help you complete your voting process quickly and securely.
]
#v(1em)

// Step Helpers
#let step(desc, img) = {
  block(
    breakable: false,
    width: 100%,
    fill: rgb("#F9FAFB"),
    stroke: 1pt + rgb("#E5E7EB"),
    radius: 0.5em,
    inset: 1.5em,
    below: 1.5em,
    grid(
      columns: (1fr, 1.5fr),
      gutter: 2em,
      align(horizon)[
        #set par(leading: 0.65em)
        #set text(size: 11pt)
        #desc
      ],
      align(center + horizon)[
        #box(stroke: 1pt + rgb("#D1D5DB"), radius: 0.3em, clip: true)[
          #image("amarvote_screenshots/" + img, width: 100%)
        ]
      ]
    )
  )
}

#let step-multi(desc, imgs) = {
  block(
    breakable: false,
    width: 100%,
    fill: rgb("#F9FAFB"),
    stroke: 1pt + rgb("#E5E7EB"),
    radius: 0.5em,
    inset: 1.5em,
    below: 1.5em,
    [
      #set text(size: 11pt)
      #desc
      #v(1em)
      #grid(
        columns: imgs.map(x => 1fr),
        gutter: 1em,
        ..imgs.map(img => align(center + horizon)[
          #box(stroke: 1pt + rgb("#D1D5DB"), radius: 0.3em, clip: true)[
            #image("amarvote_screenshots/" + img, width: 100%)
          ]
        ])
      )
    ]
  )
}

= 1. Registration

#step([Go to the registration page by clicking the *Register* button on the home page.], "Amarvote_Home_Page_Registration.png")

#step([Create your account by verifying your email. Please enter the email officially listed in the voter list, as we only allow entry to officially enlisted users.], "Registration_init.png")

#step([AmarVote will send a 6-digit verification code to your email account.], "Verification_Code_Email.png")

#step([Enter the received verification code in the system.], "Verify_Email.png")

#step([Set a strong password for your account. It must be at least 12 characters long and contain uppercase, lowercase, digits, and special characters.], "Set_Password.png")

#step([Once done, you are securely logged into your account dashboard.], "Dashboard.png")

= 2. Two-Factor Authentication (Optional)

#step([To optionally enable two-factor authentication (2FA) for extra security, click your *Profile* button which is the button in the top right corner with your email address], "Profile_Click.png")

#step([Click *Turn On* in the two step verification field.], "Turn_On_Click.png")

#step([Scan the QR code with your authenticator app and enter the generated code. Your 2FA is now enabled.], "QR_Code_Scan_2_Step_Verification.png")

= 3. Logging In

#step([When returning, go to the log in window by clicking the *Log In* button on the home page.], "Amarvote_Home_Page_Login_Click.png")

#step([Enter your registered email and password.], "Sign_In_AmarVote.png")


#step([If you have 2FA enabled, enter the code from your authenticator app.], "Two_Factor_Authentication.png")

#step([You are now in your account and can view the dashboard.], "Dashboard.png")


== Forgot Your Password

#step([If you forgot your password, click the *Forgot Password?* option on the login page.], "Forgot_Password_Click.png")

#step([Enter the email address that was registered with your account.], "Forgot_Password_Enter_Email.png")

#step([AmarVote will send a six-digit code to your email.], "Forgot_Password_email_Six_Digit_Code.png")

#step([Enter the six-digit code you received.], "Forgot_password_enter_six_digit_code.png")

#step([Set a new password. It must be at least 12 characters and include uppercase, lowercase, digits, and special characters.], "Forgot_Password_Set_New_Password.png")


= 4. Finding Elections

#step([You can see ongoing elections directly on the dashboard and click them to vote.], "Dashboard_ongoing.png")

#step([Alternatively, use the top search bar to find an election by name.], "Search_Elections.png")

#step-multi([You can also browse all elections by clicking the top-left *Menu* (hamburger) button, selecting *All Elections*, and clicking the election you want.], ("Click_Menu_Button.png", "Menu_Click_All_Elections.png", "All_Elections.png"))

= 5. Casting Your Vote

#step([On the election home page, review the information.], "Election_Home_page.png")

#step([Navigate to the voting booth on the top tabs.], "Voting_Booth.png")

#step([Scroll down to select your preferred candidates (up to the allowed number).], "Scroll_Down_To_Find_Candidates.png")

#step([Click *Create Encrypted Ballot* to secure your choices.], "create_encrypted_ballot.png")

#step([After creating an encrypted ballot, you have three options: *Cast* it, *Challenge* it, or *Discard* it.], "after_creating_encrypted_ballot.png")

== Challenging a Ballot (Optional)
#step([If you choose to challenge, you can select candidates and challenge the previously created encrypted ballot to verify system integrity.], "click_Challenge.png")

#step-multi([If you challenge with the *same* choices you used to create the ballot, it will show a match.], ("create_encrypted_ballot.png", "correct_challenge_choice.png", "correct_challenge_output.png"))

#step-multi([If you select *different* choices, it will show a mismatch. \ \ *Note:* A challenged ballot is discarded regardless of the result. You can create and challenge unlimited times, but to cast a vote, you must return to the booth and create a new encrypted ballot.], ("create_encrypted_ballot.png", "wrong_challenge_choice.png", "wrong_challenge_output.png"))

== Casting Your Ballot
#step-multi([To finalize your vote, create a new encrypted ballot and click *Cast Vote*.], ("create_encrypted_ballot.png", "Click_Cast_vote.png", "show_the_receipt.png"))

#step([After successfully casting, you will receive a tracking code and ballot hash. Download and save it to verify your vote later.], "can_Download_the_receipt.png")

#step([AmarVote will also send a ballot receipt to your email for your records.], "ballot_receipt_by_email.png")

= 6. Results & Verification

#step([After the election ends and results are fully decrypted, view them in the *Result* tab.], "After_election_result_tab.png")

#step([Scroll down to see detailed charts and candidate metrics.], "Detailed_result_an_charts.png")

#step([Head to the *Verify your vote* tab and upload your receipt to ensure your vote was counted properly.], "Verify_your_ballot_tab_upload.png")

#step([Your receipt will be matched with the tally, confirming the tracking code and ballot hash match.], "successful_ballot_receipt_verification.png")

#step([You can also go to the *Ballots in Tally* tab to see the public ledger of all ballots.], "After_election_All_ballots_in_ballot_in_tally_tab.png")

#step([Alternatively, manually search by your tracking code to verify your ballot's presence and hash match in the tally.], "search_your_ballot_by_manual_searching.png")

#align(center)[
  #v(3em)
  #text(fill: rgb("#9CA3AF"), size: 10pt)[Thank you for using AmarVote. Your vote is secure, private, and verifiable.]
]
