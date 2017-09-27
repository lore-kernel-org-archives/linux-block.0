Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <clm@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>,
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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a530c31b-93ed-c00f-ebf6-8c229740b7be@kernel.dk>
Date: Wed, 27 Sep 2017 14:41:01 +0200
MIME-Version: 1.0
In-Reply-To: <CA+55aFwfQkksqSC9UiUE2g-nGKi+=MoYtE3oh3Fxx=b_zKK_AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


Travel stable again, catching up. Chris did a great job explaining what
our issues were, so thanks for that.

On 09/26/2017 12:21 AM, Linus Torvalds wrote:
> On Mon, Sep 25, 2017 at 2:17 PM, Chris Mason <clm@fb.com> wrote:
>>
>> My understanding is that for order-0 page allocations and
>> kmem_cache_alloc(buffer_heads), GFP_NOFS is going to either loop forever or
>> at the very least OOM kill something before returning NULL?
> 
> That should generally be true. We've occasionally screwed up in the
> VM, so an explicit GFP_NOFAIL would definitely be best if we then
> remove the looping in fs/buffer.c.

Reworked to include that. More below.

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

Right. But I'd like to stress that my development practice is to engineer
things that make sense in general, AND that fix the specific issue at
hand. This is never about making the general case worse, while fixing
some FB specific issue.

I'm very sure that others hit this case as well. Maybe not to the
extent of getting softlockups, but abysmal behavior happens long before
that. It just doesn't trigger any dmesg complaints.

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

So I reworked the series, to include three prep patches that end up
killing off free_more_memory(). This means that we don't have to do the
1024 -> 0 change in there. On top of that, I added a separate bit to
manage range cyclic vs non range cyclic flush all work. This means that
we don't have to worry about the laptop case either.

I think that should quell any of the concerns in the patchset, you can
find the new series here:

http://git.kernel.dk/cgit/linux-block/log/?h=wb-start-all

Unless you feel comfortable taking it for 4.14, I'm going to push this
to 4.15. In any case, it won't be ready until tomorrow, I need to push
this through the test machinery just in case.

-- 
Jens Axboe
