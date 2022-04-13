Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F62C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 00:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiDMACx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 20:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDMACw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 20:02:52 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F10A2611B
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 17:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649808033; x=1681344033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v0UR0B46HKwKKmbfy/6oiTxJwibqFJYnvE7l/c4jKWw=;
  b=fAwFhbRENUWrwH4Txzj7To5AiGkWDCf8KHaXMEsEh+8RDkQwnEq+t1DS
   PHyddrFrmfjvwWlsjfRf5vqI1ChWfW5w89z/pyxlqnzsCs9FBH3rf5bcL
   NUvZlA1Y3Ud0DkGCCyrdZZrP2dE1O0XcYxZCk4hye+Gr2l2khFccDF0Hc
   DYDmes2VwIS2sA9rEvq1qzNnAv9/j7Fvt0j+yJfgTj5asJq0v5dyTegXX
   43xttvIhW2eCSi15T0ztCG6m7X8wf9Mg6IrPRoVlzAB6rHscvxTTi+NaY
   deTN20nr5InK3/Z/78Jwfgg7X2MgHx5pE0UuFyAHsyShtAFBFT0PsxJS4
   g==;
X-IronPort-AV: E=Sophos;i="5.90,254,1643644800"; 
   d="scan'208";a="196639591"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 08:00:30 +0800
IronPort-SDR: eYTMn2/0qoFyiWdsIS/YNlJkbriAFEMMh5VRgU7KRBhx5IKFrStq5JAvJ8GQqQW8WsJpFnArgz
 4WNosALJZd0BySbg3AUbJU60Xs4XJ7nZ6OOjDxSxK4rN1g6DIykiybI5NC0qWjQuZ5/BMTD/nl
 0x3de82n1VSWgsbk1uxMWht70MvtRwDTpHU+D53L1RC8z7BzGaI9xUZVMAcLeaCUo0H1+Mdbii
 YQeY6wBZo9p3ApYApo07nGWmTI2zHv39rpDuwIc+T++BYLGtEMJnJTXHw8XBvLlkqiog4bgrhk
 yX114cXwhhaHcX9xfrFSQO4i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 16:31:45 -0700
IronPort-SDR: ZcioxZILCavX2wx70HTJuhq9Fp1SEUfm+WiejwIZ+CSjIt1dXN0AnPUGeUw4qSIXZ/SNYpDPHt
 SCuh3D+XjrtRe6P8B5c/Y2IshuLIIFjdEWK9LcZDFEIy1d4hlm1KnSliK4Mb3ycV0sA/APwB7t
 W9r+icMdEEdfSI2C+ezUO90eszSEJiCwWzau6BoILIcSgxLe9P/SAL+0Jv9nfVgpyOzX1o/2m5
 kOvPu5f/RwoNVVCgLZwpuu0kBCEHfC1BcTz3IbJi6AgCu6dS7JFRx01c0KjgVgYho09t6nblZq
 cOk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 17:00:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KdN5T4n0rz1Rwrw
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 17:00:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649808028; x=1652400029; bh=v0UR0B46HKwKKmbfy/6oiTxJwibqFJYnvE7
        l/c4jKWw=; b=FfZg6FlX5nClatit8k3YDZS8OZN2iMA6hEoQlZlTe16VpZUod0M
        caLOzt7JeQAwjgzdvWusWR9GUDB0H7opb1xxtbJzGOQooKvZjZAF8q/s+rE+5tJ9
        AfkCk7POV7/doG7LfcBEOD9CS7cbBlKN+vOn1zqYG7WdoWuuWyScr69JivUxqXJ0
        PoOPlRO/tIMorwdKzeQKUnz5AIVOOSptxJDkhya8UxhqLz7L+jdHV9o/0Qz5ECJW
        EqlXylty99hDgEOCOYKbLOw3rH7879P7nrIeiTjIoXE5hjpTP6LB+Y++K244LaMy
        B5VwDZ/I8tA3a2v+Jlx/KzLIdYmhTXAudyQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bvQbjshtjpoG for <linux-block@vger.kernel.org>;
        Tue, 12 Apr 2022 17:00:28 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KdN5R53wzz1Rvlx;
        Tue, 12 Apr 2022 17:00:27 -0700 (PDT)
Message-ID: <34597cd1-cb19-c5de-8c44-b8c5a0a07cf7@opensource.wdc.com>
Date:   Wed, 13 Apr 2022 09:00:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com> <YlXmmB6IO7usz2c1@redhat.com>
 <c4c83c0f-a4fc-2b37-180f-ccb272085fca@opensource.wdc.com>
 <YlYEq0XC2XL6bv2b@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YlYEq0XC2XL6bv2b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/22 08:00, Mike Snitzer wrote:
> On Tue, Apr 12 2022 at  6:38P -0400,
> Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 4/13/22 05:52, Mike Snitzer wrote:
>>> On Tue, Apr 12 2022 at  4:56P -0400,
>>> Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>>> The current DM codes setup ->orig_bio after __map_bio() returns,
>>>> and not only cause kernel panic for dm zone, but also a bit ugly
>>>> and tricky, especially the waiting until ->orig_bio is set in
>>>> dm_submit_bio_remap().
>>>>
>>>> The reason is that one new bio is cloned from original FS bio to
>>>> represent the mapped part, which just serves io accounting.
>>>>
>>>> Now we have switched to bdev based io accounting interface, and we
>>>> can retrieve sectors/bio_op from both the real original bio and the
>>>> added fields of .sector_offset & .sectors easily, so the new cloned
>>>> bio isn't necessary any more.
>>>>
>>>> Not only fixes dm-zone's kernel panic, but also cleans up dm io
>>>> accounting & split a bit.
>>>
>>> You're conflating quite a few things here.  DM zone really has no
>>> business accessing io->orig_bio (dm-zone.c can just as easily inspect
>>> the tio->clone, because it hasn't been remapped yet it reflects the
>>> io->origin_bio, so there is no need to look at io->orig_bio) -- but
>>> yes I clearly broke things during the 5.18 merge and it needs fixing
>>> ASAP.
>>
>> Problem is that we need to look at the BIO op in submission AND completion
>> path to handle zone append requests. So looking at the clone on submission
>> is OK since its op is still the original one. But on the completion path,
>> the clone may now be a regular write emulating a zone append op. And
>> looking at the clone only does not allow detecting that zone append.
>>
>> We could have the orig_bio op saved in dm_io to avoid completely looking
>> at the orig_bio for detecting zone append.
> 
> Can you please try the following patch?

This works. I tested with a zoned nullblk + dm-crypt, forcing the zone
append emulation code to be used. I ran zonefs tests on top of that with
no issues. I will run btrfs tests too later today to exercise things a
little more.

> 
> Really sorry for breaking dm-zone.c; please teach this man how to test
> the basics of all things dm-zoned (is there a testsuite in the tools
> or something?).
> 
> Thanks,
> Mike
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index c1ca9be4b79e..896127366000 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -360,16 +360,20 @@ static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
>  	return 0;
>  }
>  
> +struct orig_bio_details {
> +	unsigned int op;
> +	unsigned int nr_sectors;
> +};
> +
>  /*
>   * First phase of BIO mapping for targets with zone append emulation:
>   * check all BIO that change a zone writer pointer and change zone
>   * append operations into regular write operations.
>   */
> -static bool dm_zone_map_bio_begin(struct mapped_device *md,
> -				  struct bio *orig_bio, struct bio *clone)
> +static bool dm_zone_map_bio_begin(struct mapped_device *md, unsigned int zno,
> +				  struct bio *clone)
>  {
>  	sector_t zsectors = blk_queue_zone_sectors(md->queue);
> -	unsigned int zno = bio_zone_no(orig_bio);
>  	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
>  
>  	/*
> @@ -384,7 +388,7 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  		WRITE_ONCE(md->zwp_offset[zno], zwp_offset);
>  	}
>  
> -	switch (bio_op(orig_bio)) {
> +	switch (bio_op(clone)) {
>  	case REQ_OP_ZONE_RESET:
>  	case REQ_OP_ZONE_FINISH:
>  		return true;
> @@ -401,9 +405,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  		 * target zone.
>  		 */
>  		clone->bi_opf = REQ_OP_WRITE | REQ_NOMERGE |
> -			(orig_bio->bi_opf & (~REQ_OP_MASK));
> -		clone->bi_iter.bi_sector =
> -			orig_bio->bi_iter.bi_sector + zwp_offset;
> +			(clone->bi_opf & (~REQ_OP_MASK));
> +		clone->bi_iter.bi_sector += zwp_offset;
>  		break;
>  	default:
>  		DMWARN_LIMIT("Invalid BIO operation");
> @@ -423,11 +426,10 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>   * data written to a zone. Note that at this point, the remapped clone BIO
>   * may already have completed, so we do not touch it.
>   */
> -static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
> -					struct bio *orig_bio,
> +static blk_status_t dm_zone_map_bio_end(struct mapped_device *md, unsigned int zno,
> +					struct orig_bio_details *orig_bio_details,
>  					unsigned int nr_sectors)
>  {
> -	unsigned int zno = bio_zone_no(orig_bio);
>  	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
>  
>  	/* The clone BIO may already have been completed and failed */
> @@ -435,7 +437,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
>  		return BLK_STS_IOERR;
>  
>  	/* Update the zone wp offset */
> -	switch (bio_op(orig_bio)) {
> +	switch (orig_bio_details->op) {
>  	case REQ_OP_ZONE_RESET:
>  		WRITE_ONCE(md->zwp_offset[zno], 0);
>  		return BLK_STS_OK;
> @@ -452,7 +454,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
>  		 * Check that the target did not truncate the write operation
>  		 * emulating a zone append.
>  		 */
> -		if (nr_sectors != bio_sectors(orig_bio)) {
> +		if (nr_sectors != orig_bio_details->nr_sectors) {
>  			DMWARN_LIMIT("Truncated write for zone append");
>  			return BLK_STS_IOERR;
>  		}
> @@ -488,7 +490,7 @@ static inline void dm_zone_unlock(struct request_queue *q,
>  	bio_clear_flag(clone, BIO_ZONE_WRITE_LOCKED);
>  }
>  
> -static bool dm_need_zone_wp_tracking(struct bio *orig_bio)
> +static bool dm_need_zone_wp_tracking(struct bio *clone)
>  {
>  	/*
>  	 * Special processing is not needed for operations that do not need the
> @@ -496,15 +498,15 @@ static bool dm_need_zone_wp_tracking(struct bio *orig_bio)
>  	 * zones and all operations that do not modify directly a sequential
>  	 * zone write pointer.
>  	 */
> -	if (op_is_flush(orig_bio->bi_opf) && !bio_sectors(orig_bio))
> +	if (op_is_flush(clone->bi_opf) && !bio_sectors(clone))
>  		return false;
> -	switch (bio_op(orig_bio)) {
> +	switch (bio_op(clone)) {
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
>  	case REQ_OP_ZONE_RESET:
>  	case REQ_OP_ZONE_FINISH:
>  	case REQ_OP_ZONE_APPEND:
> -		return bio_zone_is_seq(orig_bio);
> +		return bio_zone_is_seq(clone);
>  	default:
>  		return false;
>  	}
> @@ -519,8 +521,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  	struct dm_target *ti = tio->ti;
>  	struct mapped_device *md = io->md;
>  	struct request_queue *q = md->queue;
> -	struct bio *orig_bio = io->orig_bio;
>  	struct bio *clone = &tio->clone;
> +	struct orig_bio_details orig_bio_details;
>  	unsigned int zno;
>  	blk_status_t sts;
>  	int r;
> @@ -529,18 +531,21 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  	 * IOs that do not change a zone write pointer do not need
>  	 * any additional special processing.
>  	 */
> -	if (!dm_need_zone_wp_tracking(orig_bio))
> +	if (!dm_need_zone_wp_tracking(clone))
>  		return ti->type->map(ti, clone);
>  
>  	/* Lock the target zone */
> -	zno = bio_zone_no(orig_bio);
> +	zno = bio_zone_no(clone);
>  	dm_zone_lock(q, zno, clone);
>  
> +	orig_bio_details.nr_sectors = bio_sectors(clone);
> +	orig_bio_details.op = bio_op(clone);
> +
>  	/*
>  	 * Check that the bio and the target zone write pointer offset are
>  	 * both valid, and if the bio is a zone append, remap it to a write.
>  	 */
> -	if (!dm_zone_map_bio_begin(md, orig_bio, clone)) {
> +	if (!dm_zone_map_bio_begin(md, zno, clone)) {
>  		dm_zone_unlock(q, zno, clone);
>  		return DM_MAPIO_KILL;
>  	}
> @@ -560,7 +565,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  		 * The target submitted the clone BIO. The target zone will
>  		 * be unlocked on completion of the clone.
>  		 */
> -		sts = dm_zone_map_bio_end(md, orig_bio, *tio->len_ptr);
> +		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
> +					  *tio->len_ptr);
>  		break;
>  	case DM_MAPIO_REMAPPED:
>  		/*
> @@ -568,7 +574,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
>  		 * unlock the target zone here as the clone will not be
>  		 * submitted.
>  		 */
> -		sts = dm_zone_map_bio_end(md, orig_bio, *tio->len_ptr);
> +		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
> +					  *tio->len_ptr);
>  		if (sts != BLK_STS_OK)
>  			dm_zone_unlock(q, zno, clone);
>  		break;
> 


-- 
Damien Le Moal
Western Digital Research
