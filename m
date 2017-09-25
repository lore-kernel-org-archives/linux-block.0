Return-Path: <prvs=0441863fad=clm@fb.com>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <bb904bc0-e73e-2920-29a2-283380676296@kernel.dk>
 <CA+55aFzXDzoMqHic3RxUzyYzxDkHB1sr_oHJTEv2k4V1wjOa=g@mail.gmail.com>
 <20170924130304.GA21904@infradead.org>
 <CA+55aFx3Pxw+cqRCJY9TmnCCePhKY-x0A74SJ=QvG7nHNV19xw@mail.gmail.com>
 <ab2cab66-4d47-23d0-78f8-ef8450ab4b5b@kernel.dk>
 <CA+55aFzmyHRXu+zUBdWr3a9Xt_WoJp9OCzV5u6BZoRHKSKdbEQ@mail.gmail.com>
 <2856cdcf-a639-c2c9-5efe-7159fc574467@kernel.dk>
 <CA+55aFzyMoTV5Be1xQeOkgW7PwSu0j=dZFiQ_rDQp7FaQY44-w@mail.gmail.com>
 <7a7a141e-b756-72f9-ece6-1dc229267068@fb.com>
 <CA+55aFwfQkksqSC9UiUE2g-nGKi+=MoYtE3oh3Fxx=b_zKK_AA@mail.gmail.com>
From: Chris Mason <clm@fb.com>
Message-ID: <f2c45794-be20-1d96-3192-12718dab1581@fb.com>
Date: Mon, 25 Sep 2017 18:48:57 -0400
MIME-Version: 1.0
In-Reply-To: <CA+55aFwfQkksqSC9UiUE2g-nGKi+=MoYtE3oh3Fxx=b_zKK_AA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 09/25/2017 06:21 PM, Linus Torvalds wrote:
> On Mon, Sep 25, 2017 at 2:17 PM, Chris Mason <clm@fb.com> wrote:
>>
>> My understanding is that for order-0 page allocations and
>> kmem_cache_alloc(buffer_heads), GFP_NOFS is going to either loop forever or
>> at the very least OOM kill something before returning NULL?
> 
> That should generally be true. We've occasionally screwed up in the
> VM, so an explicit GFP_NOFAIL would definitely be best if we then
> remove the looping in fs/buffer.c.

Right, I wouldn't remove the looping without the NOFAIL.  But in the 
normal case, it shouldn't be possible for free_more_memory() to be 
called without an OOM and without already having triggered the full flush.

That's why using the full flush in free_more_memory() felt like a small 
change to me.  But if you'd rather see GFP_NOFAIL in the next merge 
window I don't have any objections to that method either.

> 
>>> What is it that triggers that many buffer heads in the first place?
>>> Because I thought we'd gotten to the point where all normal file IO
>>> can avoid the buffer heads entirely, and just directly work with
>>> making bio's from the pages.
>>
>> We're not triggering free_more_memory().  I ran a probe on a few production
>> machines and it didn't fire once over a 90 minute period of heavy load.  The
>> main target of Jens' patchset was preventing shrink_inactive_list() ->
>> wakeup_flusher_threads() from creating millions of work items without any
>> rate limiting at all.
> 
> So the two things I reacted to in that patch series were apparently
> things that you guys don't even care about.

Yes and no.  fs/buffer.c didn't explode in prod recently, but we do 
exercise the OOM code often.  Even though I haven't seen it happen, I'd 
rather not leave fs/buffer.c able to trigger the same work explosion 
during an OOM spiral.  I know it's really unlikely, but java.

> 
> I reacted to the fs/buffer.c code, and to the change in laptop mode to
> not do circular writeback.
> 
> The latter is another "it's probably ok, but it can be a subtle
> change". In particular, things that re-write the same thing over and
> over again can get very different behavior, even when you write out
> "all" pages.
> 
> And I'm assuming you're not using laptop mode either on your servers
> (that sounds insane, but I remember somebody actually ended up using
> laptop mode even on servers, simply because they did *not* want the
> regular timed writeback model, so it's not quite as insane as it
> sounds).

I'd honestly have to do a query to make sure we aren't using it in some 
dark corner.  I sometimes think people try things just to see how long 
it takes Jens to notice.

-chris
