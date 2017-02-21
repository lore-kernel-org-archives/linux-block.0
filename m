Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com> <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Feb 2017 15:23:40 -0800
Message-ID: <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 21, 2017 at 3:15 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
> But under a device managed by blk-mq, that device exposes a number of
> hardware queues. For older style devices, that number is typically 1
> (single queue).

... but why would this ever be different from the normal IO scheduler?

IOW, what makes single-queue mq scheduling so special that

 (a) it needs its own config option

 (b) it is different from just the regular IO scheduler in the first place?

So the whole thing stinks. The fact that it then has an
incomprehensible config option seems to be just gravy on top of the
crap.

> "none" just means that we don't have a scheduler attached.

.. which makes no sense to me in the first place.

People used to try to convince us that doing IO schedulers was a
mistake, because modern disk hardware did a better job than we could
do in software.

Those people were full of crap. The regular IO scheduler used to have
a "NONE" option too. Maybe it even still has one, but only insane
people actually use it.

Why is the MQ stuff magically so different that NONE would make sense at all>?

And equally importantly: why do we _ask_ people these issues? Is this
some kind of sick "cover your ass" thing, where you can say "well, I
asked about it", when inevitably the choice ends up being the wrong
one?

We have too damn many Kconfig options as-is, I'm trying to push back
on them. These two options seem fundamentally broken and stupid.

The "we have no good idea, so let's add a Kconfig option" seems like a
broken excuse for these things existing.

So why ask this question in the first place?

Is there any possible reason why "NONE" is a good option at all? And
if it is the _only_ option (because no other better choice exists), it
damn well shouldn't be a kconfig option!

             Linus
