Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <dfc0dc22-00c3-a28b-93d5-15dad2e55d9f@kernel.dk>
References: <c1aab1af-4dba-b324-0972-c3933816ecc8@kernel.dk>
 <CA+55aFwrpd+fz3jxK3d6dckFcApc=aCZOrsKogxRYZozwUdHrg@mail.gmail.com> <dfc0dc22-00c3-a28b-93d5-15dad2e55d9f@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Sep 2017 12:38:39 -0700
Message-ID: <CA+55aFyFYX0XAQdqXs65KP-TpBCh7buhzq-HC7ZJ_9p81oOc+w@mail.gmail.com>
Subject: Re: [GIT PULL] First set of block changes for 4.14-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 7, 2017 at 12:27 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
> Which was committed yesterday? It was not from my tree. I try to keep
> an eye out for potential conflicts or issues.

It was from Andrew, so I'm assuming it was in linux-next. Not as a git
tree, but as the usual akpm branch.

I'm not sure why I didn't see any reports from linux-next about it,
though - and I looked.

There was no actual visible merge problem, because the conflict was
not a data conflict but a semantic one.

But the issue showed up for a trivial allmodconfig build, so it
*should* have been caught automatically.

But it's not even the conflict that annoys me.

It's the *reason* for the conflict - the block layer churn that you
said was done. We've had too much of it.

>> We need *stability* by now, after these crazy changes. Make sure that happens.
>
> I am pushing back, but I can't embargo any sort of API change. This one has
> good reasoning behind it, which is actually nicely explained in the commit
> itself. It's not pointless churn, which I would define as change just for
> the sake of change itself. Or pointless cleanups.

You can definitely put your foot down on any more random changes to
the bio infrastructure. Including for good reasons.

We have had some serious issues in the block layer - and I'm not
talking about the merge conflicts. I'm talking about just the
collateral damage, with things like SCSI having to revert using blk-mq
by default etc.

Christ, things like that are pretty *fundamnetal*, wouldn't you say.
Get those right before doing more churn. And aim to have one or two
releases literally just fixing things, with a "no churn" rule.

Because the block layer really has been a black spot lately.

          Linus
