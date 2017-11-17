Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFy34p7YAtts5e0Uxt5drKws8QHw5nPDoBi64YX2xXnLrw@mail.gmail.com>
References: <82ee3a59-1767-3073-7893-bf78b5933c5e@kernel.dk> <CA+55aFy34p7YAtts5e0Uxt5drKws8QHw5nPDoBi64YX2xXnLrw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Nov 2017 11:35:10 -0800
Message-ID: <CA+55aFxeRBHhTyKTHPYGAz3+bUv-ObLNwMLtqRV-cftuDhLxZA@mail.gmail.com>
Subject: Re: [GIT PULL] Followup merge window block fixes/changes
To: Jens Axboe <axboe@kernel.dk>, Luca Miccio <lucmiccio@gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 17, 2017 at 11:29 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> "F*ck no, that code is too ugly, you need to write it so that it can
> be maintained".

Dammit, the rest of the pull looks ok, so I'll take it anyway.

But I really do expect you to

 (a) clean up that mess - maybe with my patch as an example, but maybe
some entirely different way. The patch I sent is already deleted from
my tree, it was purely meant as an example.

 (b) really push back on people when they send you ugly code

It shouldn't have to always be me being upset and pushing back on the
block pulls.

              Linus
