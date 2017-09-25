Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
 <20170924130304.GA21904@infradead.org>
 <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
 <ab2cab66-4d47-23d0-78f8-ef8450ab4b5b@kernel.dk>
 <CA+55aFzmyHRXu+zUBdWr3a9Xt_WoJp9OCzV5u6BZoRHKSKdbEQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2856cdcf-a639-c2c9-5efe-7159fc574467@kernel.dk>
Date: Mon, 25 Sep 2017 08:46:59 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFzmyHRXu+zUBdWr3a9Xt_WoJp9OCzV5u6BZoRHKSKdbEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/24/2017 09:16 PM, Linus Torvalds wrote:
>> I knew you might object to the writeback changes. As mentioned in the
>> pull request, if you diff the whole thing, it's really not big at all.
> 
> Oh, it wasn't horribly big, and I agree that it was easy to read
> through, but it really was entirely new code and really should have
> been a merge window issue, not in a "fixes" pull.
> 
> And I did check the history of those patches, and it was all very very
> recent and had recent comments on it too - it wasn't some old patches
> that had been around for a while.
> 
> And while the patches were small, their effect were decidedly *not*
> obvious.
> 
> For example, while the patches were easy to read, one of them changed
> the "try to free some memory" behavior fairly radically, going from
> write out "at most 1024 pages" to "everything".
> 
> That may be a simple one-liner patch to read, but it sure as hell
> wasn't obvious what the behavioral change really is under different
> loads.

But still better than hiding it deep in some other patch... It's a
one-liner patch. It may not be trivial to review, but it puts the detail
that you care about right in your face.

> And when the patch is two days old, I can pretty much guarantee that
> it hasn't been tested under a huge variety of loads. Maybe it does
> exactly the right thing for *some* load, but...
> 
> It honestly looked like that patch existed purely in order to make the
> next few patches be trivial ("no functional changes in this patch")
> simply because the functional changes were done earlier.

See below for discussion on that bit.

>> It's mostly shuffling some arguments and things around, to make the
>> final patch trivial. And it does mean that it's super easy to review.
> 
> See above. I think it was "super easy to review" only on a very
> superficial level, not on a deeper one.
> 
> For example, I doubt you actually went back and looked at where that
> "1024" came from that you just changed to zero?
> 
> It comes from the bitkeeper days, commit 407ee6c87e ("[PATCH]
> low-latency page reclaim") in the historical tree:
> 
>     [PATCH] low-latency page reclaim
> 
>     Convert the VM to not wait on other people's dirty data.
> 
>      - If we find a dirty page and its queue is not congested, do some
> writeback.
> 
>      - If we find a dirty page and its queue _is_ congested then just
>        refile the page.
> 
>      - If we find a PageWriteback page then just refile the page.
> 
>      - There is additional throttling for write(2) callers.  Within
>        generic_file_write(), record their backing queue in ->current.
>        Within page reclaim, if this tasks encounters a page which is dirty
>        or under writeback onthis queue, block on it.  This gives some more
>        writer throttling and reduces the page refiling frequency.
> 
>     It's somewhat CPU expensive - under really heavy load we only get a 50%
>     reclaim rate in pages coming off the tail of the LRU.  This can be
>     fixed by splitting the inactive list into reclaimable and
>     non-reclaimable lists.  But the CPU load isn't too bad, and latency is
>     much, much more important in these situations.
> 
>     Example: with `mem=512m', running 4 instances of `dbench 100', 2.5.34
>     took 35 minutes to compile a kernel.  With this patch, it took three
>     minutes, 45 seconds.
> 
>     I haven't done swapcache or MAP_SHARED pages yet.  If there's tons of
>     dirty swapcache or mmap data around we still stall heavily in page
>     reclaim.  That's less important.
> 
>     This patch also has a tweak for swapless machines: don't even bother
>     bringing anon pages onto the inactive list if there is no swap online.
> 
> which introduced that "long nr_pages" argument to wakeup_bdflush().
> 
> Here's that patch for people who don't keep that historical tree
> around like I do:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=407ee6c87e477434e3cb8be96885ed27b5539b6f
> 
> Now, it's entirely possible that the issue that made us do that in the
> first place is long long gone, and we don't need that page limiter in
> the VM any more.
> 
> But is it "super easy to review"?
> 
> No, it sure as hell is not.

Honestly, what I really wanted to do was kill that call completely. If
you read the free_more_memory() function, it looks like crap. You have
some random call to starting writeback on a random number of pages. Then
you call into node reclaim. What I really wanted to do was kill the
wakeup_flusher_threads() completely, we want to rely on
try_to_free_pages() starting targeted writeback instead of some magic
number of pages across devices. But I decided that we should probably
just keep that random flusher wakeup, and tackle that part in a v2 for
4.15. Further code cleanups and improvements are very possible, getting
rid of the work unit allocation completely and just folding this odd
wakeup in with the general writeback starting infrastructure.

On top of that, Writeback has changed a LOT since those days, we track
write device write bandwidths and try to do the right thing, we have
per-sb flusher threads that do the actual flushing and no longer rely on
non-blocking congestion to throttle.

We also used to call free_more_memory() from getblk(), if that failed.
It's got a sched_yield() in it, for crying out loud!

>> That's why I sent it in for this series. Yes, it's not months old code,
>> but it has been tested. And it's not like it's a lot of NEW code, it's
>> mostly removing code, or moving things around.
>>
>> I can resend without this stuff, but I think it'd be a shame to release
>> 4.14 without it. Let me know, and I'll respin and send a new pull
>> request.
> 
> So in order to make sane progress, I would suggest:
> 
>  - send the actual obvious *fixes* in separately as a branch of
> unquestionable fixes. If it fixes an Oops, or is a security fix, or
> makes something not work, it's a hard fix.
> 
>  - the writeback thing may make sense, but it really is a performance
> tweak for a particular load at FB, and it should be seen as such. It's
> not obviously a fix, and it has some really subtle issues. See above.

The workload is nothing special. Getting to the point where it's bad
enough to trigger a softlockup probably requires some serious beating up
of the box, but getting to a suboptimal state wrt work units pending and
the flusher threads is pretty trivial.

> So I could still take the writeback series too. But I absolutely
> *refuse* to take that as part of a "bugfix" pull, as if it was somehow
> obviously a fix. Because it damn well is not at all obviously a fix.
> 
> So send that series *separately* as a independent branch, so that it's
> obvious that "hey, this is something else that would help some FB
> loads, we'd be super happy to have it in 4.14 due to it being a LTS
> release".
> 
> And then I might just decide "ok, the code looks ok, I'm willing to
> risk it, and if it causes problems for somebody, it came in as a
> separate merge that could trivially be reverted".
> 
> See what I'm saying?

Yes, that's a good point, it should have been a separate pull request
for the writeback changes. 

I'll split them up and resend as two separate pull requests.

-- 
Jens Axboe
