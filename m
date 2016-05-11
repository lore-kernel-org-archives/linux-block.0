Return-Path: <coder.callahan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADm5WxP9OVuQH0_Y0qQC3bZGXwA+aApOMezZjmeDoTbBz3c1sA@mail.gmail.com>
References: <tc2eg9en97m.fsf@vmbox.dyndns.org>
	<x49lh3h698p.fsf@segfault.boston.devel.redhat.com>
	<CADm5WxO-ANFW+HhdQh3EHNETXmMMJkoASQdYM9U+TzJFPfxh=Q@mail.gmail.com>
	<CADm5WxNZbJpDNfLjKg_x9-YaTNEoXfrgPw=vAhbfsC56DmWaPA@mail.gmail.com>
	<57336C73.4090903@kernel.dk>
	<CADm5WxP9OVuQH0_Y0qQC3bZGXwA+aApOMezZjmeDoTbBz3c1sA@mail.gmail.com>
Date: Wed, 11 May 2016 14:15:21 -0600
Message-ID: <CADm5WxPDQ42MGmyrhuk_Ex8aT+6TqXe0cHOkTL2ErXnE7XB7fA@mail.gmail.com>
Subject: Re: [PATCH 3/4] block: Add and use a rw_stat_group function for
 indexing partition stat fields.
From: Michael Callahan <coder.callahan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeff Moyer <jmoyer@redhat.com>, Michael Callahan <michaelcallahan@fb.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, May 11, 2016 at 1:46 PM, Michael Callahan
<coder.callahan@gmail.com> wrote:
> On Wed, May 11, 2016 at 11:31 AM, Jens Axboe <axboe@kernel.dk> wrote:
>> On 05/11/2016 11:25 AM, Michael Callahan wrote:
>>>
>>> On Tue, May 10, 2016 at 3:18 PM, Michael Callahan
>>> <coder.callahan@gmail.com> wrote:
>>>>
>>>> On Tue, May 10, 2016 at 12:47 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
>>>>>
>>>>> Michael Callahan <michaelcallahan@fb.com> writes:
>>>>>
>>>>> Sorry for the segmented review.
>>>>>
>>>>>> diff --git a/block/bio.c b/block/bio.c
>>>>>> index 807d25e..91b082d 100644
>>>>>> --- a/block/bio.c
>>>>>> +++ b/block/bio.c
>>>>>> @@ -1678,27 +1678,29 @@ void bio_check_pages_dirty(struct bio *bio)
>>>>>>        }
>>>>>>   }
>>>>>>
>>>>>> -void generic_start_io_acct(int rw, unsigned long sectors,
>>>>>> +void generic_start_io_acct(int sgrp, unsigned long sectors,
>>>>>>                           struct hd_struct *part)
>>>>>>   {
>>>>>> +     const int rw = stat_group_to_rw(sgrp);
>>>>>>        int cpu = part_stat_lock();
>>>>>>
>>>>>>        part_round_stats(cpu, part);
>>>>>> -     part_stat_inc(cpu, part, ios[rw]);
>>>>>> -     part_stat_add(cpu, part, sectors[rw], sectors);
>>>>>> +     part_stat_inc(cpu, part, ios[sgrp]);
>>>>>> +     part_stat_add(cpu, part, sectors[sgrp], sectors);
>>>>>>        part_inc_in_flight(part, rw);
>>>>>>
>>>>>>        part_stat_unlock();
>>>>>>   }
>>>>>>   EXPORT_SYMBOL(generic_start_io_acct);
>>>>>>
>>>>>> -void generic_end_io_acct(int rw, struct hd_struct *part,
>>>>>> +void generic_end_io_acct(int sgrp, struct hd_struct *part,
>>>>>>                         unsigned long start_time)
>>>>>>   {
>>>>>>        unsigned long duration = jiffies - start_time;
>>>>>> +     const int rw = stat_group_to_rw(sgrp);
>>>>>
>>>>>
>>>>> You modified these functions to take a stat group, then changed all
>>>>> callers to turn an rw_flag into a stat group, and then turn right around
>>>>> and convert that back into rw as the first order of business.  Why can't
>>>>> you do the conversion in generic_start/end_io_acct from rw to stat
>>>>> group?
>>>>>
>>>>> Cheers,
>>>>> Jeff
>>>>
>>>>
>>>> stat_group_to_rw returns the data_dir and should probably be renamed
>>>> as such.  Really there were a couple of options here: 1) Per-cpu the
>>>> partition in_flight counter.  I mixed up this patch to play with and
>>>> it appears to work fine except for the weirdness of code duplication
>>>> in the raid driver.  I'll post what I have in case anyone is
>>>> interested in looking at md.  Anyway, doing this would make the
>>>> in_flight counter just take the sgrp and this conversion would not be
>>>> necessary.  2) Extend generic_*_io_acct to take both rw and sgrp flags
>>>> and just pass in both.  This makes these functions not backwards
>>>> compatible but also not compile if you try to use them that way.  3)
>>>> Change the first parameter of these two functions to be the complete
>>>> set of bi_rw or cmd_flags rather than just the data direction.  I
>>>> suppose this works as well as data_dir is a strict subset of the flags
>>>> (& 1).  However note that there does not appear to be a rw_data_dir()
>>>> function to convert rw flags into a data direction.
>>>>
>>>> I'll see if there is any interest in per-cpu inflight counting as that
>>>> seems cleanest to me.
>>>>
>>>>    Michael
>>>
>>>
>>> Is this what you had in mind?  I'm not especially fond of the
>>> 'rw_flags & 1' but I don't see anything cleaner available.
>>>
>>> void generic_start_io_acct(int rw_flags, unsigned long sectors,
>>>                             struct hd_struct *part)
>>> {
>>>          const int sgrp = rw_stat_group(rw_flags);
>>>          const int rw = rw_flags & 1;
>>
>>
>> Just do:
>>
>> const int index = (rw_flags & REQ_WRITE) != 0;
>>
>> then you're not making any assumptions about what the WRITE bit is.
>>
>> --
>> Jens Axboe
>>
>
> drivers/block/zram/zram_drv.c:zram_rw_page appears to be the only
> .rw_page function that tracks stats via zram_bvec_rw.  However there
> is no rw_flags associated with this callback, just the data_dir.  What
> would be the best way to handle this case?

err = zram_bvec_rw(zram, &bv, index, offset, rw, rw ? REQ_WRITE : 0);

Look reasonable?
