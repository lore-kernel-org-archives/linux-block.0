Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170714205429.GC10708@lim.localdomain>
References: <20170714134051.22756-1-dsterba@suse.com> <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
 <06376146-e4c3-efd6-8893-155052b14034@kernel.dk> <20170714205429.GC10708@lim.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 15 Jul 2017 06:35:05 +0800
Message-ID: <CACVXFVM2mT5Eu45On2h-vDYb05jm+ci7M9Y6cokoNu289iddvw@mail.gmail.com>
Subject: Re: [PATCH] block: note about cloned bios and bio_for_each_segment_all
To: Liu Bo <bo.li.liu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
	linux-block <linux-block@vger.kernel.org>, fdmanana@suse.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Jul 15, 2017 at 4:54 AM, Liu Bo <bo.li.liu@oracle.com> wrote:
> On Fri, Jul 14, 2017 at 08:22:31AM -0600, Jens Axboe wrote:
>> On 07/14/2017 07:47 AM, Ming Lei wrote:
>> >> @@ -156,6 +156,9 @@ static inline void *bio_data(struct bio *bio)
>> >>  /*
>> >>   * drivers should _never_ use the all version - the bio may have been split
>> >>   * before it got to the driver and the driver won't own all of it
>> >> + *
>> >> + * Note that cloned bios must not use this as their bi_vcnt may be invalid and
>> >> + * this could lead to silent corruptions.
>> >>   */
>> >>  #define bio_for_each_segment_all(bvl, bio, i)                          \
>> >>         for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
>> >> --
>> >> 2.13.0
>> >>
>> >
>> > Maybe we can add a warning here if it is a cloned bio.
>>
>> I think that's a good idea, it's easy for people to get this wrong, and
>> the consequences can be dire. How about something like this?
>>
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 7b1cf4ba0902..13b6ac6eae29 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -155,9 +155,12 @@ static inline void *bio_data(struct bio *bio)
>>
>>  /*
>>   * drivers should _never_ use the all version - the bio may have been split
>> - * before it got to the driver and the driver won't own all of it
>> + * before it got to the driver and the driver won't own all of it.
>> + *
>> + * Don't use this on cloned bio's.
>>   */
>>  #define bio_for_each_segment_all(bvl, bio, i)                                \
>> +     WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));                     \
>>       for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
>>
>>  static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
>>
>
> This patch gave me a crash, I'm double checking it..

Hi Liu Bo,

Looks one extra warning shouldn't have trigger a crash, please double
check and update
with us.

I just start a VM and run a quick test on ext4, btrfs, looks
everything is fine, and not see
any warning.

-- 
Ming Lei
