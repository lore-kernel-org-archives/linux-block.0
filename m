Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170924130304.GA21904@infradead.org>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com> <20170924130304.GA21904@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Sep 2017 10:34:59 -0700
Message-ID: <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, Sep 24, 2017 at 6:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Sep 22, 2017 at 05:18:49PM -1000, Linus Torvalds wrote:
>> WTF? Why is this so hard? It used to be that IDE drove people crazy.
>> Now it's NVMe and generic block layer stuff.
>
> Can you please explain what problems you have with the nvme patches?

This time it wasn't the NVMe parts (that was the last few releases).
This time it was the random writeback patches that had been committed
only days before, and that completely change some fundamental code.
Some of the commits say "this changes no semantics", but that's after
the previous commit just changed the argument values exactly so that
the next commit wouldn't change semantics.

Don't get me wrong - all the commits look perfectly _sane_.  That's
not my issue. But these commits literally showed up on lkml just a
couple of days before getting sent to me, and even when they were sent
the cover letter for the series of six patches was literally

   More graceful flusher thread memory reclaim wakeup

which *really* does not say "this is an important big fix or regression" to me.

What made it ok to send that outside the merge window? It looks like a
nice cleanup, no question about it, and it probably fixes some
behavioral problem at FB. But that behavioral problem is not *new*, as
far as I can tell.

So why was it sent as a bug-fix pull request?

Now, if this was some other subsystem that _hadn't_ had problems in
EVERY SINGLE recent merge window, I'd likely have been more than happy
to take it early in the rc series because that subsystem wasn't on my
list of "increased scrutiny due to historical issues".

But as it is, the block layer _is_ on my list of increased scrutiny
(and part of that reason is NVMe patches - again, "fixes" being sent
that were really just normal on-going development)

                            Linus
