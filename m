Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>, Christoph Hellwig <hch@infradead.org>,
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
 <a530c31b-93ed-c00f-ebf6-8c229740b7be@kernel.dk>
 <CA+55aFzXueAygL0LNqwHvN7CSBpWQofYwLu1xivw_dKD1STPNw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <87f2fa29-99bd-4206-297c-c5459612b540@kernel.dk>
Date: Wed, 27 Sep 2017 21:24:12 +0200
MIME-Version: 1.0
In-Reply-To: <CA+55aFzXueAygL0LNqwHvN7CSBpWQofYwLu1xivw_dKD1STPNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/27/2017 07:36 PM, Linus Torvalds wrote:
> On Wed, Sep 27, 2017 at 5:41 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> So I reworked the series, to include three prep patches that end up
>> killing off free_more_memory(). This means that we don't have to do the
>> 1024 -> 0 change in there. On top of that, I added a separate bit to
>> manage range cyclic vs non range cyclic flush all work. This means that
>> we don't have to worry about the laptop case either.
>>
>> I think that should quell any of the concerns in the patchset, you can
>> find the new series here:
>>
>> http://git.kernel.dk/cgit/linux-block/log/?h=wb-start-all
> 
> Yeah, this I feel more confident about.
> 
> It still has some subtle changes (nr_pages is slightly different for
> laptop mode, and the whole "we rely on the VM to not return NULL") but
> I cannot for the life of me imagine that those changes are noticeable
> or meaningful.
> 
> So now that last commit that limits the pending flushes is the only
> one that seems to matter, and the one you wanted to build up to. It's
> not a subtle change, but that's the one that fixes the actual bug you
> see, so now the rest of the series really looks like "prep-work for
> the bug fix".
> 
> Of course, with the change to support range_cycling for the laptop
> mode case, there's actually possibly _two_ pending full flushes (the
> range-cyclic and the "all" one), so that last changelog may not be
> entirely accurate.

Yeah good point. I did modify it a little bit, but I should make that
clear throughout that changelog. Functionally it's identical as far as
the bug is concerned, 1 or 2 is a far cry from hundreds of thousands or
millions.

> Long-term, I would prefer to maybe make the "range_whole" case to
> always be range-cyclic, because I suspect that's the better behavior,
> but I think that series is the one that changes existing semantics the
> least for the existing cases, so I think your approach is better for
> now.

I agree, I was actually contemplating whether to make that change or
not. I don't see a reason to ever NOT do range cyclic writeback for the
full range request. Then we could kill the second wb->state bit and get
back to just having the one in flight.

> As far as I can tell, the cases that do not set range_cyclic right now are:
> 
>  - wakeup_flusher_threads()
> 
>  - sync_inodes_sb()
> 
> and in neither case does that lack of range_cyclic really seem to make
> any sense.
> 
> It might be a purely historical artifact (an _old_ one: that
> range_cyclic logic goes back to 2006, as far as I can tell).
> 
> But there might also be something I'm missing.
> 
> Anyway, your series looks fine to me.

Thanks for taking a look. I feel like the change should be made to do
range cyclic flushes for any request that wants to start writeback on
the full range, I can't think of a case where that make a difference.
Then we can kill the extra bit, and more importantly, kill this part:

        if (reason == WB_REASON_LAPTOP_TIMER)                                   
                range_cyclic = true;

which is a bit of a hack. I'll respin with that, and repost the series.

-- 
Jens Axboe
