// ── Fonts & base style ──────────────────────────────────────
#set text(font: "Inter", size: 10.5pt, weight: 400)
#set par(leading: 0.65em, justify: true)

// ── Color palette ───────────────────────────────────────────
#let primary    = rgb("#0F2B5C")   // deep navy
#let primary-bright = rgb("#1E4DB7")
#let accent     = rgb("#F59E0B")   // warm gold
#let gray-dark  = rgb("#374151")
#let gray-mid   = rgb("#6B7280")
#let gray-light = rgb("#E5E7EB")
#let bg-blue    = rgb("#F0F7FF")
#let white      = rgb("#FFFFFF")

// ── Page layout ────────────────────────────────────────────
// ── Page layout (Professional Editorial Style) ─────────────────────────
#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: {
    context {
      // Don't show the running header on the very first page if text somehow overflows
      if counter(page).get().first() > 1 [
        #grid(
          columns: (1fr, 1fr),
          align(left)[
            #text(size: 8.5pt, weight: "bold", fill: primary, tracking: 1.5pt)[AmarVote ]
          ],
          align(right)[
            #text(size: 8.5pt, weight: "medium", fill: gray-mid, tracking: 0.5pt)[Voter  Manual]
          ]
        )
        #v(0.2cm)
        #line(length: 100%, stroke: 0.5pt + gray-light)
      ]
    }
  },
  footer: {
    context {
      if counter(page).get().first() > 1 [
        #line(length: 100%, stroke: 0.5pt + gray-light)
        #v(0.2cm)
        #grid(
          columns: (1fr, 1fr),
          align(left)[
            #text(size: 8pt, fill: gray-mid)[Confidential • Academic Release]
          ],
          align(right)[
            #text(size: 8.5pt, weight: "bold", fill: primary)[#counter(page).display("1")]
          ]
        )
      ]
    }
  }
)

// ── Headings ──────────────────────────────────────────────────
#show heading.where(level: 1): it => {
  v(12pt, weak: true)
  block(
    stroke: (left: 4pt + primary-bright),
    inset: (left: 12pt, bottom: 4pt),
    text(size: 16pt, weight: "bold", fill: primary)[#it.body]
  )
  v(8pt, weak: true)
}

#show heading.where(level: 2): it => {
  v(10pt, weak: true)
  text(size: 13pt, weight: "semibold", fill: primary-bright)[#it.body]
  v(6pt)
}

// ── Image helpers ─────────────────────────────────────────────
#let img(file, width: 100%) = {
  block(
    stroke: 0.4pt + gray-light,
    radius: 6pt,
    inset: 0pt,
    image("amarvote_screenshots/" + file, width: width)
  )
}

#let image-grid(images, caption: none, cols: 2) = {
  let n = images.len()
  let rows = calc.ceil(n / cols)
  let col-widths = (1fr,) * cols
  figure(
    grid(
      columns: col-widths,
      rows: (auto,) * rows,
      gutter: 12pt,
      ..images
    ),
    caption: caption
  )
}

#let triple-image(a, b, c, caption: none) = {
  figure(
    grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 10pt,
      img(a, width: 100%),
      img(b, width: 100%),
      img(c, width: 100%),
    ),
    caption: caption
  )
}

// ── Callout / note block ─────────────────────────────────────
#let note(body) = block(
  fill: bg-blue,
  stroke: 0.5pt + primary-bright,
  radius: 8pt,
  inset: 10pt,
  text(size: 10pt, fill: primary)[
    #text(weight: "bold", fill: accent)[💡 ] #body
  ]
)

// --- PROFESSIONAL TITLE PAGE ---
#page(header: none, footer: none)[
  #align(center + horizon)[
    // 1. Subtle, high-end cryptographic-themed background accent
    // #place(top + left, dx: -10%, dy: -15%)[
    //   #circle(radius: 6cm, fill: primary-bright.transparentize(92%))
    // ]
    // #place(top + left, dx: -5%, dy: -10%)[
    //   #circle(radius: 4cm, fill: primary.transparentize(94%))
    // ]

    #v(-2cm)
    
    // 2. Document Category Tag
    #rect(
      fill: primary.transparentize(90%),
      radius: 4pt,
      inset: (x: 10pt, y: 6pt),
      stroke: none
    )[
      #text(size: 10pt, weight: "bold", fill: primary, tracking: 2pt)[SYSTEM DOCUMENTATION]
    ]
    
    #v(1cm)

    // 3. Main Title
    #text(size: 38pt, weight: "light", fill: primary, tracking: 1pt)[AmarVote] \
    #v(-0.5cm)
    #text(size: 38pt, weight: "bold", fill: primary, tracking: 1.5pt)[Voter Manual]
    
    #v(0.8cm)
    
    // 4. Elegant Minimalist Divider Bar
    #rect(width: 80pt, height: 4pt, fill: accent, radius: 2pt)
    
    #v(1cm)

    // 5. Executive Subtitle / Abstract Panel
    #block(width: 75%, fill: rgb("#f8fafc"), inset: 15pt, radius: 8pt, stroke: 0.5pt + gray-mid.transparentize(50%))[
      #text(size: 12pt, weight: "medium", fill: gray-dark)[
        End-to-End Verifiable Cryptographic Electronic Voting
      ]
      #v(6pt)
      #text(size: 10pt, style: "italic", fill: gray-mid)[
        "With the help of ElectionGuard SDK"
      ]
    ]
    
    #v(4cm)
    
    // 6. Institutional / Project Metadata
    #grid(
      columns: 1,
      row-gutter: 8pt,
      text(size: 10pt, weight: "bold", fill: gray-dark)[AmarVote Development Team],
      // text(size: 9pt, fill: gray-mid)[Bangladesh University of Engineering and Technology (BUET)],
      text(size: 9pt, fill: gray-mid)[June 2026]
    )
  ]
]

#pagebreak()
// ── End of Title Page ─────────────────────────────────────────


// ── Content (unchanged sequence) ─────────────────────────────

= Registration

AmarVote is open only to officially enlisted voters. Your registration uses the email address registered with the election authority.

1. #text(weight: "bold")[From the Home Page], click #text(fill: primary-bright)["Register"].

#img("Amarvote_Home_Page_Registration.png")

2. Enter the email that is on your voter list, then click #text(weight: "bold")["Send Verification Code"].

#img("Registration_init.png")

3. AmarVote will send a 6‑digit verification code to that email.

#img("Verification_Code_Email.png")

4. Input the code on the next screen.

#img("Verify_Email.png")

5. You will now be asked to set a strong password.  
   #text(size: 10pt, fill: gray-mid)[Must be at least 12 characters with uppercase, lowercase, digits & special characters.]

#img("Set_Password.png")

6. Once the password is set, you are taken to your Dashboard — registration complete!

#img("Dashboard.png")

#note[Keep your password safe.]

= Two‑Factor Authentication (Optional)

Enabling two‑step verification adds an extra layer of security to your account.

1. On the Dashboard, click the #text(weight: "bold")[Profile button] in the top‑right corner.

#img("Profile_Click.png")

2. In the profile panel, locate “Two‑Step Authentication” and click #text(weight: "bold")["Turn On"].

#img("Turn_On_Click.png")

3. Scan the QR code with an authenticator app (e.g., Google Authenticator, Authy) and enter the code it displays.

#img("QR_Code_Scan_2_Step_Verification.png")

From now on, every login will require a code from your authenticator app.

= Signing In

When you return to AmarVote, use the Home Page to log in.

1. Click the #text(weight: "bold")["Log In"] button on the Home Page.

#img("Amarvote_Home_Page_Login_Click.png")

2. Enter your email and password.

#img("Sign_In_AmarVote.png")

== Forgot Your Password

If you forgot your password, reset it from the login page:

1. On the login page, click #text(weight: "bold")["Forgot Password?"].

#img("Forgot_Password_Click.png")

2. Enter the email address registered with your account.

#img("Forgot_Password_Enter_Email.png")

3. AmarVote will send a six-digit code to that email.

#img("Forgot_Password_email_Six_Digit_Code.png")

4. Enter the six-digit code on the next screen.

#img("Forgot_password_enter_six_digit_code.png")

5. Set a new password.  
   #text(size: 10pt, fill: gray-mid)[Must be at least 12 characters with uppercase, lowercase, digits & special characters.]

#img("Forgot_Password_Set_New_Password.png")

3. If two‑factor authentication is enabled, you will be prompted for a code.  
   Enter the 6‑digit code shown in your authenticator app.

#img("Two_Factor_Authentication.png")

4. After successful login, you are back on your Dashboard, ready to vote.

#img("Dashboard.png")

= Finding an Election

From the Dashboard you have three ways to reach an election:

- *Ongoing elections* are shown directly on the Dashboard — just click one to enter.
- Use the *search bar* to find an election by name.
- Open the *menu* (top‑left hamburger icon) and select “All Elections” to browse the complete list.

#image-grid(
  (
    img("Dashboard_ongoing.png", width: 100%),
    img("Search_Elections.png", width: 100%),
    img("Click_Menu_Button.png", width: 100%),
    img("Menu_Click_All_Elections.png", width: 100%),
  ),
  cols: 2,
  caption: [Dashboard with ongoing election, search, menu, and All‑Elections list]
)

Once you choose an election, you land on its home page with details and a tabbed interface.

#img("Election_Home_page.png")

= Casting Your Ballot

== Enter the Voting Booth

Click the #text(weight: "bold")["Voting Booth"] tab, then scroll down to see all candidates.  
Select your choices (you may vote for up to \( n \) candidates as specified).

#image-grid(
  (
    img("Voting_Booth.png", width: 100%),
    img("Scroll_Down_To_Find_Candidates.png", width: 100%),
  ),
  cols: 2,
  caption: [Voting Booth tab and candidate selection]
)

== Create an Encrypted Ballot

Once you have made your selections, click #text(weight: "bold")["Create Encrypted Ballot"].  
The system will produce an encrypted version of your choices.

#img("create_encrypted_ballot.png")

After creation you are presented with three options:
#text(size: 10pt)[
- *Cast* – officially submit your ballot.  
- *Challenge* – test the encryption by comparing it with your choices.  
- *Discard* – throw the ballot away and start over.
]

#img("after_creating_encrypted_ballot.png")

== Challenge the Ballot (Optional Verification)

Challenging a ballot lets you verify that the encryption truly contains your selections — without ever casting it.  
You can challenge any number of times; each challenged ballot is discarded and cannot be cast.

#note[You must return to the Voting Booth and create a new encrypted ballot if you wish to eventually cast a vote.]

*Correct Challenge* (choices match the encrypted ballot):

#triple-image(
  "create_encrypted_ballot.png",
  "correct_challenge_choice.png",
  "correct_challenge_output.png",
  caption: [Same choices → encryption matches ✓]
)

*Wrong Challenge* (different choices from the encrypted ballot):

#triple-image(
  "create_encrypted_ballot.png",
  "wrong_challenge_choice.png",
  "wrong_challenge_output.png",
  caption: [Different choices → encryption does not match ✗]
)

== Casting the Ballot

When you are ready to vote, create a fresh encrypted ballot and then choose #text(weight: "bold")["Cast"].  
You will be shown a ballot receipt with a unique tracking code and the ballot hash.

#triple-image(
  "create_encrypted_ballot.png",
  "Click_Cast_vote.png",
  "show_the_receipt.png",
  caption: [Create → Cast → Receipt]
)

== Saving Your Receipt

After casting, you can download the receipt directly, and AmarVote will also email it to you.  
Keep this receipt — you will use it later to verify that your ballot is present in the final tally.

#image-grid(
  (
    img("can_Download_the_receipt.png", width: 100%),
    img("ballot_receipt_by_email.png", width: 100%),
  ),
  cols: 2,
  caption: [Download receipt and email copy]
)

= After the Election

Once voting ends and the results are decrypted, you can view them under the #text(weight: "bold")["Result"] tab of the election.  
Scroll down to see detailed charts for each candidate.

#image-grid(
  (
    img("After_election_result_tab.png", width: 100%),
    img("Detailed_result_an_charts.png", width: 100%),
  ),
  cols: 2,
  caption: [Results overview and detailed charts]
)

== Verify Your Ballot

Head to the #text(weight: "bold")["Verify Your Vote"] tab and upload the receipt you saved.  
The system will match your tracking code with a ballot in the tally and compute the same ballot hash — confirming your vote was counted exactly as cast.

#img("Verify_your_ballot_tab_upload.png")
#img("successful_ballot_receipt_verification.png")

== Browse All Cast Ballots

The #text(weight: "bold")["Ballots in Tally"] tab shows every encrypted ballot that is part of the final result.  
You can manually search for your tracking code and verify that the corresponding ballot hash matches your receipt.

#image-grid(
  (
    img("After_election_All_ballots_in_ballot_in_tally_tab.png", width: 100%),
    img("search_your_ballot_by_manual_searching.png", width: 100%),
  ),
  cols: 2,
  caption: [Ballot list and manual tracking‑code search]
)

#v(1.5cm)
#align(center, text(size: 11pt, fill: primary-bright, weight: "medium")[*Your voice, encrypted and verifiable — Thank you for voting with AmarVote!*])
