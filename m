Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
 <20170924130304.GA21904@infradead.org>
 <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ab2cab66-4d47-23d0-78f8-ef8450ab4b5b@kernel.dk>
Date: Sun, 24 Sep 2017 18:03:54 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/24/2017 11:34 AM, Linus Torvalds wrote:
> On Sun, Sep 24, 2017 at 6:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Fri, Sep 22, 2017 at 05:18:49PM -1000, Linus Torvalds wrote:
>>> WTF? Why is this so hard? It used to be that IDE drove people crazy.
>>> Now it's NVMe and generic block layer stuff.
>>
>> Can you please explain what problems you have with the nvme patches?
> 
> This time it wasn't the NVMe parts (that was the last few releases).
> This time it was the random writeback patches that had been committed
> only days before, and that completely change some fundamental code.
> Some of the commits say "this changes no semantics", but that's after
> the previous commit just changed the argument values exactly so that
> the next commit wouldn't change semantics.
> 
> Don't get me wrong - all the commits look perfectly _sane_.  That's
> not my issue. But these commits literally showed up on lkml just a
> couple of days before getting sent to me, and even when they were sent
> the cover letter for the series of six patches was literally
> 
>    More graceful flusher thread memory reclaim wakeup
> 
> which *really* does not say "this is an important big fix or regression" to me.
> 
> What made it ok to send that outside the merge window? It looks like a
> nice cleanup, no question about it, and it probably fixes some
> behavioral problem at FB. But that behavioral problem is not *new*, as
> far as I can tell.
> 
> So why was it sent as a bug-fix pull request?
> 
> Now, if this was some other subsystem that _hadn't_ had problems in
> EVERY SINGLE recent merge window, I'd likely have been more than happy
> to take it early in the rc series because that subsystem wasn't on my
> list of "increased scrutiny due to historical issues".
> 
> But as it is, the block layer _is_ on my list of increased scrutiny
> (and part of that reason is NVMe patches - again, "fixes" being sent
> that were really just normal on-going development)

Sorry for the late response, been moving this weekend and tending to
things more important than arguing on the Internet.

NVMe fixes have sometimes been accepted for the current series, while
they should have been pushed. I'm not going to argue with that, but I
think we've managed to make that better the last few series. It's still
not squeaky clean, but it is improving substantially.  I don't believe
that's even been the case for core changes, which have always been
scrutinized much more heavily.

I knew you might object to the writeback changes. As mentioned in the
pull request, if you diff the whole thing, it's really not big at all.
It's mostly shuffling some arguments and things around, to make the
final patch trivial. And it does mean that it's super easy to review.
In the original review series, we are hitting this in production, and
have been for a while. So while it's not a regression for this series,
it's something that causes us quite a bit of pain. When attempting to
free memory ends up gobling up tons of extra memory AND causing the
flusher threads to waste tons of CPU, then that's a big problem. Big
enough that we get softlockups from just attempting to process these
identical start-all-writeback requests.

That's why I sent it in for this series. Yes, it's not months old code,
but it has been tested. And it's not like it's a lot of NEW code, it's
mostly removing code, or moving things around.

I can resend without this stuff, but I think it'd be a shame to release
4.14 without it. Let me know, and I'll respin and send a new pull
request.

-- 
Jens Axboe
