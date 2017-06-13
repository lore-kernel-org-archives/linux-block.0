Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/11] Add support for write life time hints
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block@vger.kernel.org,
 Michael Kerrisk-manpages <mtk.manpages@gmail.com>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
 <0c6e72e1-eb9d-4748-269a-15e218d277ed@kernel.dk>
 <2A5802CF-4DA7-477E-B5AA-F31FCD7F7908@dilger.ca>
 <ee7a8e90-5df9-c1fc-e07e-5d0e62d6334c@kernel.dk>
 <E4EBB016-5EA3-4C2C-BC63-7B8D475768AC@dilger.ca>
 <60597d4d-9067-82ba-bb2f-74ed4b27ab78@kernel.dk>
 <C89764AD-ABD1-49EE-9C6D-5157127C3189@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8fbc2dec-e37f-b00a-6f22-78d6e7cdba80@kernel.dk>
Date: Tue, 13 Jun 2017 16:12:04 -0600
MIME-Version: 1.0
In-Reply-To: <C89764AD-ABD1-49EE-9C6D-5157127C3189@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 03:53 PM, Andreas Dilger wrote:
>>>> For utilization of the space, yes, we could just use 2 bits instead of
>>>> the 4. Or use the 4 bits and potentially have the app pass in up to 16
>>>> values. For the latter, I'm still very much in favor of keeping the app
>>>> interface super simple and just retaining the 4 life time types.
>>>
>>> I don't think anyone cares too much about 4 bits.  Strictly speaking,
>>> the current implementation can't fit into 2 bits because it has 5 values
>>> if one includes "no ID".
>>
>> Right, I ended up taking 3 bits. That allows 7 valid stream IDs, and one
>> for unknown.
> 
> I wouldn't mind if that was 4 bits, especially for the userspace
> interface.  The internal bits are easily changed, but it won't be
> possible to get more contiguous bits in the RWF_* flags if a later one
> is used for something else.

Sure, find with me, simple change too.

> I guess that implies (before Michael Kerrisk asks :-) that this also
> needs a pwritev2(2) man page update to describe these flags.  I'd add
> something like:
> 
>     The RWF_WRITE_LIFE_{SHORT..EXTREME} flags are recommended for
>     identifying stream IDs of different write classes, so that multiple
>     users or applications running on a single storage back-end can
>     aggregate their IO patterns in a consistent manner.  However, there
>     are no functional semantics implied by these flags, and different
>     IO classes can use the stream IDs in arbitrary ways so long as they
>     are used consistently.

Looks good to me. Maybe add something about the kernel being free to
ignore them as well, if the underlying storage backend doesn't support
it.

>>> It is a bit of overhead to use 32 bits in most of the structs where this
>>> field is actually stored.  I suspect that using only 8 or 16 bits in the
>>> structs is better, and even if it doesn't find an existing hole ("pahole"
>>> is your friend here) it will allow something else to use the remaining
>>> space in the future.
>>
>> I packed the i_stream into a hole, and the bio part is filling a hole
>> too. So while that's not completely free, it's better than taking more
>> space.
>>
>>> For userspace, I think it is fine to define the WRITE_LIFE values as they
>>> are today, and most users will use them, but IMHO it makes sense to
>>> allow arbitrary IDs as they see fit, especially if the underlying hardware
>>> doesn't care much about the actual values.
>>
>> I change the WRITE_LIFT values to just be 1, 2, 3, 4, but shifted up.
>> Might as well keep them as values, now we've changed the space in the
>> flags field.
>>
>> I'll throw this out for more commenting soon. Meanwhile, I'd appreciate
>> if you could just take a look at the write-stream.2 branch:
>>
>> http://git.kernel.dk/cgit/linux-block/log/?h=write-stream.2
>>
>> as it should address all your concerns so far. Thanks! Until I post it,
>> I may rebase it... I'm going to throw the basic testing at it to ensure
>> it still works as designed before posting again.
> 
>>  #define RWF_DSYNC	0x00000002 /* per-IO O_DSYNC */
>>  #define RWF_SYNC	0x00000004 /* per-IO O_SYNC */
>>
>>  /*
>> + * Data life time write flags, steal 3 bits for that
>> + */
>> +#define RWF_WRITE_LIFE_SHIFT	3
>> +#define RWF_WRITE_LIFE_MASK	((1 << 3) | (1 << 4) | (1 << 5))
>> +#define RWF_WRITE_LIFE_SHORT	(1 << RWF_WRITE_LIFT_SHIFT)
>> +#define RWF_WRITE_LIFE_MEDIUM	(2 << RWF_WRITE_LIFT_SHIFT)
>> +#define RWF_WRITE_LIFE_LONG	(3 << RWF_WRITE_LIFT_SHIFT)
>> +#define RWF_WRITE_LIFE_EXTREME	(4 << RWF_WRITE_LIFT_SHIFT)
> 
> I'd recommend to use SHIFT=4 and then define the mask as:
> 
>  #define RWF_SYNC		0x00000004 /* per-IO O_SYNC */
> +#define RWF_WRITE_LIFE_MASK	0x000000f0 /* 4 bits stream IDs */
> 
> 
> so that it is in the same format as the other RWF_* masks here.  The
> actual SHORT, ..., EXTREME definitions can stay the same if you want.
> Otherwise it is error-prone to map ((1 << 3) | (1 << 4) | (1 << 5))
> into the RWF_ space to determine which is the next flag available.

OK, fine with me.

> Also, leaving one bit free before RWF_WRITE_LIFE_MASK gives us room
> for another flag to be added before the mask until we get cut off on
> the high end if others think that 4 bits isn't enough stream IDs.
> It might even be prudent to move this up to 0x000f0000 (SHIFT=16) to
> give us a bit more breathing room in that regard, given that this is
> essentially going to become a permanent userspace API?

Not so sure on that one. The whole point was not to make this overly
complicated, or add a ton of hints that nobody would then know how to
use properly. I guess it's not a big concern the way it's setup now,
where we don't tie any particular meaning to them. Users are free to use
the different bits anyway they see fit and it will work, as long as they
are consistent in how they use it.

But for now, I'd prefer to keep it at 4 bits.

> The rest of the patches look fine.  You might consider to merge patches
> #2 and #3, since the WRITE_LIFE_* constants are only used by the blk_mq
> patch (inode_init_always() could just use "0" for initialization).  You
> may also want to move the NVMe patch before the ext4/xfs/btrfs patches,
> since it isn't strictly dependent on them, and allows some testing on
> real hardware once the O_DIRECT patch is available.

OK, I can fold those two and reorder a bit. There's no real dependency
between the later half of the series, really.

> The other thing that might be interesting to include in the NVMe patch
> is what kind of hardware support is available for the Streams Directive
> (i.e. in existing hardware, draft spec only, how many stream IDs are
> available, etc.) and what kind of performance benefit this provides
> (even if not quantitative).  As it stands now, unless you already know
> what this patch series does, it doesn't explain very much.

Yes, that's useful info. On device support, I've got samples from
various vendors, but I don't know what is public yet. So I can't really
speak to number of streams available. This is ratified in the NVMe 1.3
spec, however, so that part is public.

-- 
Jens Axboe
