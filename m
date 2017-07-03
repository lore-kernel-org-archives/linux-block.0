Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <c2565c20-527f-72fb-dc5c-bb81f56220f9@kernel.dk>
References: <c2565c20-527f-72fb-dc5c-bb81f56220f9@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jul 2017 10:49:38 -0700
Message-ID: <CA+55aFw4OeKay4Vp7wDkAM+bWepRY88dMRO=KJs8+UNzt9S25Q@mail.gmail.com>
Subject: Re: [GIT PULL] Core block/IO changes for 4.13-rc
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, Jul 2, 2017 at 4:44 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
> This is the main pull request for the block layer for 4.13. Not a huge
> round in terms of features, but there's a lot of churn related to some
> core cleanups. Note that merge request will throw 3 merge failures for
> you. I've included how I resolved them in the for-next (or
> for-4.13/merge) branch after the pull stats, at the end of this email.

So Jens, I got a semi-complaint about this constant churn in an
entirely unrelated scheduler tracing thread.

Basically, the block IO layer is apparently really painful to do
various instrumentation on, because it keeps having these random
idiotic interface churn with the status and flags and various random
command bytes changing semantics.

Can we stop with the masturbatory "let's just randomly change things
around" already?

It doesn't just result in annoying merge conflicts, it's just
*confusing* to people when the interfaces keep changing. And confusion
is bad.

And the fact that these things keep changing is also, I think, a sign
of something being fundamentally wrong.

WTF is going on that the block layer *constantly* ends up having these
stupid "let's move random command flag bits from one field to another"
or randomly changing the error returns?

Anyway, all merged up in my tree, but your "for-4.13/merge" branch did
*not* match what I got from you. Your main for-4.13 branch had some
additional random lightnvm/pblk changes too.

               Linus
