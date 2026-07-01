// ============================================================
//  AmarVote — VOTER MANUAL
//  A concise, end-to-end guide to registering, voting, and
//  verifying your ballot on AmarVote.
// ============================================================

#let ink      = rgb("#0f172a")   // near-black text
#let sub      = rgb("#64748b")   // secondary text
#let faint    = rgb("#94a3b8")   // tertiary / captions
#let brand    = rgb("#4338ca")   // indigo — primary brand
#let brand2   = rgb("#6366f1")   // indigo — lighter accent
#let brandbg  = rgb("#eef2ff")   // indigo tint background
#let hairline = rgb("#e2e8f0")   // hairlines / borders
#let panel    = rgb("#f8fafc")   // panel background
#let good     = rgb("#16a34a")   // success green
#let goodbg   = rgb("#f0fdf4")
#let warn     = rgb("#d97706")   // warning amber
#let warnbg   = rgb("#fffbeb")

#let sans = "Inter"

// ------------------------------------------------------------
//  PAGE SETUP
// ------------------------------------------------------------
#set page(
  paper: "a4",
  margin: (top: 2.1cm, bottom: 2cm, left: 2cm, right: 2cm),
  header: context {
    if counter(page).get().first() > 1 {
      grid(
        columns: (1fr, 1fr),
        align(left)[
          #text(8.3pt, fill: faint, tracking: 0.5pt)[AmarVote]
          #text(8.3pt, fill: hairline)[ · ]
          #text(8.3pt, fill: faint)[VOTER MANUAL]
        ],
        align(right)[
          #text(8.3pt, fill: faint)[#context counter(heading).display() ] 
        ]
      )
      v(-2pt)
      line(length: 100%, stroke: 0.5pt + hairline)
    }
  },
  footer: context {
    if counter(page).get().first() > 1 {
      line(length: 100%, stroke: 0.5pt + hairline)
      v(4pt)
      grid(
        columns: (1fr, 1fr),
        align(left, text(8pt, fill: faint)[End-to-end verifiable voting with ElectionGuard SDK]),
        align(right, text(8pt, fill: faint)[Page #counter(page).display() of #context counter(page).final().first()])
      )
    }
  }
)

#set text(font: sans, size: 9.6pt, fill: ink, lang: "en")
#set par(leading: 0.62em, justify: false)

// ------------------------------------------------------------
//  HEADING STYLES
// ------------------------------------------------------------
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(2pt)
  block(above: 0pt, below: 22pt)[
    #text(10pt, weight: "medium", fill: brand, tracking: 1.5pt)[
      PART #context counter(heading).display("01")
    ]
    #v(4pt)
    #text(23pt, weight: "black", fill: ink)[#it.body]
    #v(6pt)
    #line(length: 36pt, stroke: 2.6pt + brand)
  ]
}

#show heading.where(level: 2): it => {
  v(14pt)
  block(above: 0pt, below: 10pt)[
    #grid(
      columns: (auto, auto),
      column-gutter: 9pt,
      align: horizon,
      box(
        fill: brand, radius: 4pt, width: 22pt, height: 22pt,
        align(center + horizon, text(9.5pt, weight: "bold", fill: white)[
          #context counter(heading).display("1.1")
        ])
      ),
      text(13.5pt, weight: "bold", fill: ink)[#it.body]
    )
  ]
}

// ------------------------------------------------------------
//  HELPERS
// ------------------------------------------------------------

// Framed screenshot — consistent card treatment for every image
#let shot(path, w: 100%) = {
  box(
    width: w,
    stroke: 0.8pt + hairline,
    radius: 7pt,
    fill: white,
    inset: 0pt,
    clip: true,
    // Formats the directory path flawlessly
    image("amarvote_screenshots/" + path, width: 100%)
  )
}

// A single numbered step: image on one side, instruction on the other.
// side: "left" puts the image on the left, "right" puts it on the right.
#let step(n, title, img, body, side: "left", imgw: 47%) = {
  let txtw = 100% - imgw - 4%
  let photo = shot(img, w: 100%)
  let copy = [
    #grid(
      columns: (18pt, 1fr),
      column-gutter: 7pt,
      box(
        fill: brandbg, radius: 100pt, width: 18pt, height: 18pt,
        align(center + horizon, text(8.5pt, weight: "bold", fill: brand)[#n])
      ),
      text(10.6pt, weight: "semibold", fill: ink)[#title]
    )
    #v(5pt)
    #text(9.4pt, fill: sub)[#body]
  ]
  block(breakable: false, above: 0pt, below: 16pt)[
    #if side == "left" [
      #grid(
        columns: (imgw, txtw),
        column-gutter: 5%,
        align: horizon,
        box(width: 100%, photo),
        copy
      )
    ] else [
      #grid(
        columns: (txtw, imgw),
        column-gutter: 5%,
        align: horizon,
        copy,
        box(width: 100%, photo)
      )
    ]
  ]
}

// A compact step where the image sits full-width above a short caption —
// used for tall/narrow screenshots (modals, dialogs).
#let microstep(n, title, img, body, imgw: 38%) = {
  block(breakable: false, above: 0pt, below: 16pt)[
    #grid(
      columns: (imgw, 100% - imgw - 5%),
      column-gutter: 5%,
      align: horizon,
      box(width: 100%, shot(img)),
      [
        #grid(
          columns: (18pt, 1fr),
          column-gutter: 7pt,
          box(
            fill: brandbg, radius: 100pt, width: 18pt, height: 18pt,
            align(center + horizon, text(8.5pt, weight: "bold", fill: brand)[#n])
          ),
          text(10.6pt, weight: "semibold", fill: ink)[#title]
        )
        #v(5pt)
        #text(9.4pt, fill: sub)[#body]
      ]
    )
  ]
}

// Section intro paragraph directly under an H2
#let intro(body) = block(above: 0pt, below: 14pt)[
  #text(9.6pt, fill: sub)[#body]
]

// Callout box — info / success / warning
#let callout(kind: "info", body) = {
  let (bg, accent, label) = if kind == "success" {
    (goodbg, good, "VERIFIED")
  } else if kind == "warning" {
    (warnbg, warn, "NOTE")
  } else {
    (brandbg, brand, "TIP")
  }
  block(width: 100%, above: 6pt, below: 16pt, breakable: false)[
    #rect(
      width: 100%, fill: bg, radius: 6pt, inset: (x: 12pt, y: 9pt),
      stroke: (left: 2.6pt + accent)
    )[
      #text(7.8pt, weight: "bold", fill: accent, tracking: 1pt)[#label]
      #v(3pt)
      #text(9.2pt, fill: ink.lighten(10%))[#body]
    ]
  ]
}

// Outcome card used inside the challenge-flow triples
#let outcome-card(label, img, tag, ok: true) = {
  let (accent, bg) = if ok { (good, goodbg) } else { (warn, warnbg) }
  box(width: 100%)[
    #text(8.3pt, weight: "medium", fill: sub)[#label]
    #v(4pt)
    #shot(img)
    #v(5pt)
    #box(fill: bg, radius: 100pt, inset: (x: 8pt, y: 3pt))[
      #text(7.6pt, weight: "bold", fill: accent)[#tag]
    ]
  ]
}

// Three-up image row with a verdict strip beneath it
#let triple(title, lead, img1, img2, img3, labels, tags, ok: true, note) = {
  block(width: 100%, breakable: false, above: 4pt, below: 18pt)[
    #text(10.6pt, weight: "semibold", fill: ink)[#title]
    #v(2pt)
    #text(9.2pt, fill: sub)[#lead]
    #v(9pt)
    #grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 12pt,
      outcome-card(labels.at(0), img1, tags.at(0), ok: true),
      outcome-card(labels.at(1), img2, tags.at(1), ok: ok),
      outcome-card(labels.at(2), img3, tags.at(2), ok: ok),
    )
    #v(10pt)
    #callout(kind: if ok { "success" } else { "warning" }, note)
  ]
}

// Small numbered chip used in the at-a-glance overview
#let chip(n, label) = box(
  fill: white, stroke: 0.8pt + hairline, radius: 6pt, inset: (x: 10pt, y: 7pt)
)[
  #grid(
    columns: (15pt, auto), column-gutter: 6pt, align: horizon,
    box(fill: brand, radius: 100pt, width: 15pt, height: 15pt,
      align(center+horizon, text(7pt, weight: "bold", fill: white)[#n])),
    text(8.4pt, weight: "medium", fill: ink)[#label]
  )
]

// ============================================================
//  COVER PAGE
// ============================================================
#page(margin: 0pt)[
  #box(width: 100%, height: 100%, fill: gradient.linear(
    rgb("#312e81"), rgb("#4338ca"), rgb("#6366f1"), angle: 115deg
  ))[
    #place(top + left, dx: -60pt, dy: -60pt,
      circle(radius: 160pt, fill: rgb("#ffffff0d")))
    #place(bottom + right, dx: 70pt, dy: 70pt,
      circle(radius: 220pt, fill: rgb("#ffffff0a")))
    #place(top + right, dx: 40pt, dy: 160pt,
      circle(radius: 90pt, fill: rgb("#ffffff08")))

    #place(top + left, dx: 2.4cm, dy: 2.2cm)[
      #grid(
        columns: (22pt, auto), column-gutter: 9pt, align: horizon,
        box(width: 22pt, height: 22pt, radius: 6pt, fill: white,
          align(center+horizon, text(11pt, weight: "black", fill: brand)[🗳️])),
        text(13pt, weight: "bold", fill: white, tracking: 1pt)[AmarVote]
      )
    ]

    #place(horizon + left, dx: 2.4cm, dy: -10pt)[
      #box(width: 460pt)[
        #text(11pt, fill: rgb("#c7d2fe"), tracking: 2pt, weight: "medium")[
          VOTER MANUAL
        ]
        #v(14pt)
        #text(40pt, weight: "black", fill: white)[
          Vote with confidence,\ verify with proof.
        ]
        #v(16pt)
        #text(11.5pt, fill: rgb("#e0e7ff"))[
          A complete, step-by-step guide to registering, casting an
          end-to-end verifiable ballot, and confirming it was counted —
          exactly as cast.
        ]
        #v(28pt)
        #grid(
          columns: (auto, auto, auto), column-gutter: 10pt,
          box(fill: rgb("#ffffff1a"), radius: 100pt, inset: (x: 12pt, y: 6pt),
            text(9pt, fill: white, weight: "medium")[🔒 End-to-end encrypted]),
          box(fill: rgb("#ffffff1a"), radius: 100pt, inset: (x: 12pt, y: 6pt),
            text(9pt, fill: white, weight: "medium")[✓ Independently verifiable]),
        )
      ]
    ]

    #place(bottom + left, dx: 2.4cm, dy: -2cm)[
      #line(length: 460pt, stroke: 0.6pt + rgb("#ffffff33"))
      #v(10pt)
      #text(8.8pt, fill: rgb("#c7d2fe"))[
        AmarVote Platform · Voter Documentation · 2026 Edition
      ]
    ]
  ]
]

// ============================================================
//  AT A GLANCE  (table of contents, redesigned as a journey map)
// ============================================================
#page(margin: (top: 2.4cm, bottom: 2cm, left: 2cm, right: 2cm))[
  #text(10pt, weight: "medium", fill: brand, tracking: 1.5pt)[YOUR JOURNEY]
  #v(5pt)
  #text(21pt, weight: "black", fill: ink)[Six steps, start to finish]
  #v(4pt)
  #text(9.8pt, fill: sub)[
    Everything in this manual fits into one simple path. Jump to any
    section directly, or follow it in order the first time you vote.
  ]
  #v(20pt)

  #let journey(num, title, desc, page-ref) = block(
    width: 100%, above: 0pt, below: 14pt, breakable: false
  )[
    #grid(
      columns: (34pt, 1fr, auto),
      column-gutter: 14pt, align: horizon,
      box(
        fill: brand, radius: 9pt, width: 34pt, height: 34pt,
        align(center + horizon, text(14pt, weight: "black", fill: white)[#num])
      ),
      [
        #text(11.5pt, weight: "bold", fill: ink)[#title]
        #v(2pt)
        #text(9pt, fill: sub)[#desc]
      ],
      box(
        stroke: 0.8pt + hairline, radius: 100pt, inset: (x: 10pt, y: 5pt),
        text(8.3pt, fill: sub)[#page-ref]
      )
    )
    #v(10pt)
    #line(length: 100%, stroke: 0.5pt + hairline)
  ]

  #journey("1", "Create your account",
    "Verify your voter email, confirm a one-time code, and set a strong password.",
    "Part 1")
  #journey("2", "Secure your account (optional)",
    "Turn on two-step verification for an extra layer of protection.",
    "Part 2")
  #journey("3", "Reset your password",
    "If you forget your password, reset it by verifying your email address",
    "Part 3")
  #journey("4", "Find your election",
    "Locate your election by search, menu, or dashboard.",
    "Part 4")  
  #journey("5", "Cast your ballot",
    "Pick candidates, encrypt your choices, optionally audit them, then cast.",
    "Part 5")
  #journey("6", "Verify the result",
    "After the election closes, confirm your exact ballot was counted — by you, independently.",
    "Part 6")

  #v(18pt)
  #grid(
    columns: (1fr, 1fr, 1fr), column-gutter: 12pt,
    chip("i", "Takes about 5 minutes"),
    chip("ii", "No technical knowledge needed"),
    chip("iii", "Your vote stays private"),
  )

  #v(24pt)
  #callout(kind: "info")[
    Throughout this guide, screenshots show exactly what you'll see on
    screen. Look for the numbered indigo badges — they match the step
    described beside each image.
  ]
]

#counter(page).update(1)
#counter(heading).update(0)

// ============================================================
//  PART 1 — CREATE YOUR ACCOUNT
// ============================================================
= Create your account

#intro[
  Registration confirms you're on the official voter list before
  anything else happens. You'll verify your email, set a password,
  and land straight on your dashboard.
]

== Open the registration page

#step("1", "Start from the home page", "Amarvote_Home_Page_Registration.png",
  [On the AmarVote home page, click *Register* in the top-right corner
  to begin creating your account.])

== Verify your voter email

#step("2", "Enter your official email", "Registration_init.png",
  [Enter the email address listed for you on the official voter list.
  AmarVote only grants access to addresses already on this list, so
  use the one your election authority has on file — not a personal
  alternative.], side: "right")

#callout(kind: "warning")[
  Using an email that isn't on the official voter list will not pass
  verification. If you're unsure which address is registered, contact
  your Election Officials before continuing.
]

== Confirm with a one-time code

#step("3", "Check your inbox", "Verification_Code_Email.png",
  [AmarVote emails a 6-digit verification code to the address you
  entered. It usually arrives within moments — check your spam folder
  if you don't see it right away.])

#step("4", "Enter the code", "Verify_Email.png",
  [Type the 6-digit code into the verification field to confirm you
  own this email address.], side: "right")

== Set a strong password

#step("5", "Choose your password", "Set_Password.png",
  [Create a password of *at least 12 characters*, combining uppercase
  letters, lowercase letters, numbers, and special characters. This
  protects your account from being accessed by anyone else.])

#callout(kind: "info")[
  A password manager makes this easy: generate a long, random password
  once and let it remember the rest.
]

== You're in

#step("6", "Your dashboard is ready", "Dashboard.png",
  [As soon as your password is set, AmarVote signs you in automatically
  and opens your personal dashboard. Registration is complete.],
  side: "right")


// ============================================================
//  PART 2 — SECURE YOUR ACCOUNT
// ============================================================
= Secure your account

#intro[
  Two-step verification is optional but strongly recommended.
  It adds a second, time-based code on top of your password, so a
  leaked password alone isn't enough to sign in as you.
]

== Open security settings

#step("1", "Go to your profile", "Profile_Click.png",
  [From your dashboard, click your *profile icon* in the top-right
  corner to open your account settings.])

== Turn on two-step verification

#step("2", "Enable two-step verification", "Turn_On_Click.png",
  [In the *Two-Step Verification* panel, click *Turn On* to begin
  setup.], side: "right")

#step("3", "Scan the QR code", "QR_Code_Scan_2_Step_Verification.png",
  [Open an authenticator app (such as Google Authenticator) on your
  phone, scan the QR code shown on screen, and enter the 6-digit code
  it generates to confirm the link.])

#callout(kind: "success")[
  Two-step verification is now active on your account. From your
  next login onward, you'll need both your password and a fresh code
  from your authenticator app.
]


// ============================================================
//  PART 3 — RESET YOUR PASSWORD
// ============================================================
= Reset your password

#intro[
  If you no longer remember your password, reset it from the login page.
  You'll verify your registered email, enter a one-time code, and choose a
  new password.
]

== Forgot your password?

#step("1", "Click Forgot Password?", "Forgot_Password_Click.png",
  [On the login page, click *Forgot Password?* to start the reset process.])

#step("2", "Enter your registered email", "Forgot_Password_Enter_Email.png",
  [Enter the email address you used when you registered with AmarVote.],
  side: "right")

#step("3", "Check your inbox", "Forgot_Password_email_Six_Digit_Code.png",
  [AmarVote sends a 6-digit code to that email address. Check your inbox —
  and your spam folder if you don't see it right away.])

#step("4", "Enter the code", "Forgot_password_enter_six_digit_code.png",
  [Type the 6-digit code into the verification field to confirm your identity.],
  side: "right")

#step("5", "Set a new password", "Forgot_Password_Set_New_Password.png",
  [Choose a new password of *at least 12 characters*, combining uppercase
  letters, lowercase letters, numbers, and special characters. Then sign in
  with your new password.])

// =========================================
// Finding Election
// ======================
= Find your election
#intro[
  Once registered, returning to vote is quick. This section also
  covers the three ways to locate an election: your dashboard, the
  search bar, and the full elections directory.
]

== Sign in

#step("1", "Open the login page", "Amarvote_Home_Page_Login_Click.png",
  [From the home page, click *Log in* in the top-right corner.])

#step("2", "Enter your credentials", "Sign_In_AmarVote.png",
  [Enter the email and password you registered with, then continue.],
  side: "right")

#step("3", "Confirm with your authenticator", "Two_Step_Verification.png",
  [If you enabled two-ste verification, enter the current code
  shown in your authenticator app to finish signing in.])

#step("4", "You are in", "Dashboard_ongoing.png",
  [You are now signed in. You can browse the platform and cast your vote in any election you are eligible for.], side: "right")


== Find your election

#text(9.4pt, fill: sub)[
  There are three equally valid ways to reach an election — use
  whichever is fastest for you.
]
#v(10pt)

#step("5", "Browse from your dashboard", "Dashboard_ongoing.png",
  [Active elections you're eligible for appear directly on your
  dashboard. Click any election card to open it.], side: "right")

#step("6", "Or search by name", "Search_Elections.png",
  [Use the search bar at the top of the page to find an election by
  typing its name.])

#step("7", "Or browse the full directory — open the menu", "Click_Menu_Button.png",
  [Click the menu icon in the top-left corner to open the navigation
  panel.], side: "right")

#step("8", "Select \"All Elections\"", "Menu_Click_All_Elections.png",
  [Choose *All Elections* from the menu to see every election you can
  take part in.])

#step("9", "Pick your election", "All_Elections.png",
  [Browse the complete list and click the election you want to vote
  in.], side: "right")


// ============================================================
//  PART 5 — CAST YOUR BALLOT
// ============================================================
= Cast your ballot

#intro[
  This is the core of AmarVote: your selections are mathematically
  encrypted, you decide what happens to that encrypted
  ballot, and only a cast ballot is ever counted.
]

== Review the election

#step("1", "Open the election page", "Election_Home_page.png",
  [Here you'll find key details about the election — timeline, rules,
  and instructions — before you vote.])

== Enter the voting booth

#step("2", "Go to the Voting Booth tab", "Voting_Booth.png",
  [Switch to the *Voting Booth* tab at the top of the election page.],
  side: "right")

#step("3", "Scroll to see all candidates", "Scroll_Down_To_Find_Candidates.png",
  [Scroll down to view the complete candidate list before making your
  selection.])

== Make your selection

#step("4", "Select candidates and encrypt", "create_encrypted_ballot.png",
  [Select up to the number of candidates allowed for this election,
  then click *Create Encrypted Ballot*. Your choices are encrypted
  immediately on the server, no plain text choice are stored in the database],
  side: "right", imgw: 38%)

== Choose what happens next

#microstep("5", "Cast, challenge, or discard", "after_creating_encrypted_ballot.png",
  [Every encrypted ballot gives you three options:
  \ • *Cast Vote* — submit this ballot to be counted.
  \ • *Challenge Vote* — audit it to confirm it was encrypted correctly (see below).
  \ • *Discard Ballot* — throw it away and start over.],
  imgw: 36%)

#callout(kind: "info")[
  You can create and challenge as many encrypted ballots as you like.
  Only a ballot you choose to *cast* is ever counted — challenging or
  discarding never submits a vote.
]


== Cast your vote

#triple(
  "From encryption to receipt",
  "When you're satisfied with your ballot, cast it to submit your vote and receive proof of submission.",
  "create_encrypted_ballot.png", "Click_Cast_vote.png", "show_the_receipt.png",
  ("1. Encrypt your ballot", "2. Cast your vote", "3. Get your receipt"),
  ("READY", "SUBMIT", "RECEIPT ISSUED"),
  ok: true,
  [*Your vote is cast.* AmarVote returns a unique tracking code and
  ballot hash — your personal proof that this exact ballot was
  received.]
)

== Save your receipt

#step("6", "Download your receipt", "can_Download_the_receipt.png",
  [Download your tracking code and ballot hash. Keep this safe — it's
  necessary to verify your specific ballot later, and it never
  reveals who or what you voted for.])

#step("7", "Check your email too", "ballot_receipt_by_email.png",
  [AmarVote also sends a copy of your receipt to your registered
  email, so you have a backup record.], side: "right")

== Optional: Challenge your vote

#text(9.4pt, fill: sub)[
  Challenging lets you prove an encrypted ballot truly matches the
  choices you made — without revealing your vote to anyone else.
  Click *Challenge Vote*, then re-select the candidates to check
  against.
]
#v(6pt)
#step("8", "Select Challenge Vote", "click_Challenge.png",
  [Choose the candidates you want to check the encrypted ballot
  against, then challenge the ballot.], imgw: 36%)

#triple(
  "If your choices match",
  "Challenging with the same choices used to create the ballot reveals a confirmed match.",
  "create_encrypted_ballot.png", "correct_challenge_choice.png", "correct_challenge_output.png",
  ("Original ballot", "Challenge choice", "Result"),
  ("ENCRYPTED", "SAME CHOICE", "MATCH"),
  ok: true,
  [*Match confirmed.* The encrypted ballot accurately reflects the
  candidates you selected.]
)

#triple(
  "If your choices differ",
  "Challenging with different choices than the original ballot reveals a mismatch.",
  "create_encrypted_ballot.png", "wrong_challenge_choice.png", "wrong_challenge_output.png",
  ("Original ballot", "Challenge choice", "Result"),
  ("ENCRYPTED", "DIFFERENT CHOICE", "NO MATCH"),
  ok: false,
  [*No match — and that's correct.* This confirms the system honestly
  reports mismatches rather than hiding them.]
)

#callout(kind: "warning")[
  A challenged ballot is *always discarded*, regardless of the result.
  This is intentional: once you've used a ballot to verify the
  encryption, that same ballot can no longer be cast. Return to the
  voting booth and create a fresh encrypted ballot when you're ready
  to vote for real.
]




// ============================================================
//  PART 6 — VERIFY THE RESULT
// ============================================================
= Verify the result

#intro[
  Once the election closes and results are decrypted, you can confirm
  — independently — that your exact ballot was included in the final
  tally, untouched.
]

== See the outcome

#step("1", "Open the Results tab", "After_election_result_tab.png",
  [After decryption is complete, open the *Results* tab on the
  election page to see the outcome.])

#step("2", "Explore the detailed breakdown", "Detailed_result_an_charts.png",
  [Scroll down for detailed charts and a full breakdown of votes per
  candidate.], side: "right")

== Verify your own ballot

#step("3", "Upload your receipt", "Verify_your_ballot_tab_upload.png",
  [Go to the *Verify Your Vote* tab and upload the receipt file you
  saved earlier.])

#step("4", "Confirm the match", "successful_ballot_receipt_verification.png",
  [AmarVote locates the ballot in the public tally with your exact
  tracking code and confirms its hash matches your receipt — proof
  your vote was counted exactly as cast.], side: "right")

== Explore the public tally

#step("5", "Browse every cast ballot", "After_election_All_ballots_in_ballot_in_tally_tab.png",
  [The *Ballots in Tally* tab lists every encrypted ballot included in
  the count — anonymized, but fully public and auditable by anyone.])

#step("6", "Or search by tracking code", "search_your_ballot_by_manual_searching.png",
  [Prefer to check by hand? Search for your tracking code directly in
  the tally and compare the ballot hash yourself.], side: "right")

#v(8pt)
#callout(kind: "success")[
  This is what makes AmarVote *end-to-end verifiable*: you don't have
  to trust the system blindly. Every cast ballot, your receipt, and
  the final tally can all be checked against each other — by you.
]
