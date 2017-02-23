Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170222215058.GA291@x4>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
 <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk> <CA+55aFwkdDmO0LPYv8g=VxCXuxF4_JRHdG7-tfF4QSRvQYJFKQ@mail.gmail.com>
 <6d5d4b2b-5343-09ff-72c3-4e9a7e591d68@kernel.dk> <CA+55aFxFtiAz2nnczcBQLPS6sMwgRnDq-j6U-s1yPS=mN2VgAQ@mail.gmail.com>
 <CA+55aFwXmBsHBPJJLzxnY0H4ib-iro__TdYA6=rpUnoh+BbyGA@mail.gmail.com>
 <c1d07f31-40e7-0fb0-7251-24067564a0ad@kernel.dk> <20170222215058.GA291@x4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Feb 2017 16:16:45 -0800
Message-ID: <CA+55aFxJATS5i1Z91RmK9nzxjSXa5c1xHQg3Zbe1u3-HTixEig@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 22, 2017 at 1:50 PM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
>
> But what about e.g. SATA SSDs? Wouldn't they be better off without any
> scheduler?
> So perhaps setting "none" for queue/rotational==0 and mq-deadline for
> spinning drives automatically in the sq blk-mq case?

Jens already said that the merging advantage can outweigh the costs,
but he didn't actually talk much about it.

The scheduler advantage can outweigh the costs of running a scheduler
by an absolutely _huge_ amount.

An SSD isn't zero-cost, and each command tends to have some fixed
overhead on the controller, and pretty much all SSD's heavily prefer
fewer large request over lots of tiny ones.

There are also fairness/latency issues that tend to very heavily favor
having an actual scheduler, ie reads want to be scheduled before
writes on an SSD (within reason) in order to make latency better.

Ten years ago, there were lots of people who argued that you don't
want to do do scheduling for SSD's, because SSD's were so fast that
you only added overhead. Nobody really believes that fairytale any
more.

So you might have particular loads that look better with noop, but
they will be rare and far between. Try it, by all means, and if it
works for you, set it in your udev rules.

The main place where a noop scheduler currently might make sense is
likely for a ramdisk, but quite frankly, since the main real usecase
for a ram-disk tends to be to make it easy to profile and find the
bottlenecks for performance analysis (for emulating future "infinitely
fast" media), even that isn't true - using noop there defeats the
whole purpose.

              Linus
