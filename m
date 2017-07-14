Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
To: Ming Lei <tom.leiming@gmail.com>, David Sterba <dsterba@suse.com>
Cc: linux-block <linux-block@vger.kernel.org>, Liu Bo <bo.li.liu@oracle.com>,
 fdmanana@suse.com
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <06376146-e4c3-efd6-8893-155052b14034@kernel.dk>
Date: Fri, 14 Jul 2017 08:22:31 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/14/2017 07:47 AM, Ming Lei wrote:
>> @@ -156,6 +156,9 @@ static inline void *bio_data(struct bio *bio)
>>  /*
>>   * drivers should _never_ use the all version - the bio may have been split
>>   * before it got to the driver and the driver won't own all of it
>> + *
>> + * Note that cloned bios must not use this as their bi_vcnt may be invalid and
>> + * this could lead to silent corruptions.
>>   */
>>  #define bio_for_each_segment_all(bvl, bio, i)                          \
>>         for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
>> --
>> 2.13.0
>>
> 
> Maybe we can add a warning here if it is a cloned bio.

I think that's a good idea, it's easy for people to get this wrong, and
the consequences can be dire. How about something like this?

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7b1cf4ba0902..13b6ac6eae29 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -155,9 +155,12 @@ static inline void *bio_data(struct bio *bio)
 
 /*
  * drivers should _never_ use the all version - the bio may have been split
- * before it got to the driver and the driver won't own all of it
+ * before it got to the driver and the driver won't own all of it.
+ *
+ * Don't use this on cloned bio's.
  */
 #define bio_for_each_segment_all(bvl, bio, i)				\
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));			\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
 
 static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,

-- 
Jens Axboe
