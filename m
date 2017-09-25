Return-Path: <prvs=0441863fad=clm@fb.com>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe
	<axboe@kernel.dk>
CC: Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
 <20170924130304.GA21904@infradead.org>
 <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
 <ab2cab66-4d47-23d0-78f8-ef8450ab4b5b@kernel.dk>
 <CA+55aFzmyHRXu+zUBdWr3a9Xt_WoJp9OCzV5u6BZoRHKSKdbEQ@mail.gmail.com>
From: Chris Mason <clm@fb.com>
Message-ID: <98c68cda-5f31-29bc-b5a9-7aaaa0fbc2c8@fb.com>
Date: Mon, 25 Sep 2017 11:52:11 -0400
MIME-Version: 1.0
In-Reply-To: <CA+55aFzmyHRXu+zUBdWr3a9Xt_WoJp9OCzV5u6BZoRHKSKdbEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/24/2017 11:16 PM, Linus Torvalds wrote:
> On Sun, Sep 24, 2017 at 5:03 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> NVMe fixes have sometimes been accepted for the current series, while
>> they should have been pushed. I'm not going to argue with that, but I
>> think we've managed to make that better the last few series. It's still
>> not squeaky clean, but it is improving substantially.  I don't believe
>> that's even been the case for core changes, which have always been
>> scrutinized much more heavily.
> 
> The NVMe fixes actually looked like real fixes. It's not what I
> reacted to, I would have happily pulled those.
> 
> The comment about "NVMe and generic block layer" was about these areas
> in general having been problem spots, and not the particular NVMe
> patches in this pull request.
> 
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
> And while the patches were small, their effect were decidedly *not* obvious.
> 
> For example, while the patches were easy to read, one of them changed
> the "try to free some memory" behavior fairly radically, going from
> write out "at most 1024 pages" to "everything".
> 
> That may be a simple one-liner patch to read, but it sure as hell
> wasn't obvious what the behavioral change really is under different
> loads.
> 
> And when the patch is two days old, I can pretty much guarantee that
> it hasn't been tested under a huge variety of loads. Maybe it does
> exactly the right thing for *some* load, but...

I've got a little more context for where these fixes came from.  We've 
been seeing softlockups in move_expired_inodes() for years, going back 
to at least v3.10 kernels.  It was relatively rare (20-80 times per week 
across the fleet) and we always recovered before anyone could hop on and 
figure out what was going on.  I assumed it was something crazy on boxes 
with lots of files and lots of filesystems where dirty inodes were 
popping back into the list, somehow making move_expired_inodes() take 
forever.

Two weeks ago we had two boxes just explode, 600,000,00+ kmalloc-64 slab 
entries, with new ones being added basically at CPU speed.  They were 
constantly waking up the flushers and adding new kmalloc-64 from 
wb_start_writeback().  Should have seen it forever ago, but the 
softlockups were just wb_do_writeback() churning through his list.

It takes a special case to hit the softlockup, since you need vmscan.c 
to send a bunch of work items but then you need the filesystems to not 
really have any dirty pages written while we process the work items. 
Some dumbass (me) typing sync to find out if the memory gets reclaimed 
does seem to help trigger.

On mainline, I was able to trigger 500,000+ work items without too much 
trouble, but I couldn't make the softlockup happen on purpose.  For more 
realistic tests, a workload with lots of memory pressure will frequently 
pile up bursts of 1000+ work items.  Each one comes from 
wakeup_flusher_threads() so each one is trying to flush all the dirty pages.

> 
> It honestly looked like that patch existed purely in order to make the
> next few patches be trivial ("no functional changes in this patch")
> simply because the functional changes were done earlier.
> 
> That's all actually very nice for bisecting etc, and honestly, I liked
> how the patch series looked and was split out, but I liked how it
> looked as a *development* series.
> 
> It didn't make me go "this is a bug fix".
> 
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
>      [PATCH] low-latency page reclaim
> 
>      Convert the VM to not wait on other people's dirty data.
> 
>       - If we find a dirty page and its queue is not congested, do some
> writeback.
> 
>       - If we find a dirty page and its queue _is_ congested then just
>         refile the page.
> 
>       - If we find a PageWriteback page then just refile the page.
> 
>       - There is additional throttling for write(2) callers.  Within
>         generic_file_write(), record their backing queue in ->current.
>         Within page reclaim, if this tasks encounters a page which is dirty
>         or under writeback onthis queue, block on it.  This gives some more
>         writer throttling and reduces the page refiling frequency.
> 
>      It's somewhat CPU expensive - under really heavy load we only get a 50%
>      reclaim rate in pages coming off the tail of the LRU.  This can be
>      fixed by splitting the inactive list into reclaimable and
>      non-reclaimable lists.  But the CPU load isn't too bad, and latency is
>      much, much more important in these situations.
> 
>      Example: with `mem=512m', running 4 instances of `dbench 100', 2.5.34
>      took 35 minutes to compile a kernel.  With this patch, it took three
>      minutes, 45 seconds.
> 
>      I haven't done swapcache or MAP_SHARED pages yet.  If there's tons of
>      dirty swapcache or mmap data around we still stall heavily in page
>      reclaim.  That's less important.
> 
>      This patch also has a tweak for swapless machines: don't even bother
>      bringing anon pages onto the inactive list if there is no swap online.
> 
> which introduced that "long nr_pages" argument to wakeup_bdflush().
> 
> Here's that patch for people who don't keep that historical tree
> around like I do:
> 
>      https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=407ee6c87e477434e3cb8be96885ed27b5539b6f
> 
> Now, it's entirely possible that the issue that made us do that in the
> first place is long long gone, and we don't need that page limiter in
> the VM any more.
> 
> But is it "super easy to review"?
> 

Looking at free_more_memory() in fs/buffer.c, it only gets called when 
grow_dev_page() returns 0 (because find_or_create_page() returned NULL) 
or in alloc_page_buffers() when alloc_buffer_head() returns NULL.

These are always done from sleeping contexts, I think from GFP_NOFS. 
So we're failing a single page or single slab allocation, and vmscan.c 
has almost certainly already done a full wakeup_flusher_threads(), and 
then fs/buffer.c does it again. For good measure, grow_dev_page() also 
does gfp_mask |= __GFP_NOFAIL.

I originally suggested we just remove the flusher wakeup completely from 
free_more_memory(), but I think Jens felt safer just turning it into a 
rate limited full flush like vmscan.c was already doing.

-chris
