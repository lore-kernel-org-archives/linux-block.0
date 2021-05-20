Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421CBC433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 06:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201DC61184
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 06:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhETGsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 02:48:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:54462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETGsx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 02:48:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8136DB137;
        Thu, 20 May 2021 06:47:31 +0000 (UTC)
Subject: Re: [PATCH v2 10/11] dm: introduce zone append emulation
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-11-damien.lemoal@wdc.com>
 <68203e46-01bc-011c-ab8e-9c94ca60adce@suse.de>
 <DM6PR04MB7081B70FFD57914608B0349AE72A9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <be8be72c-0272-2969-ec46-ebb01db9d2ca@suse.de>
Date:   Thu, 20 May 2021 08:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081B70FFD57914608B0349AE72A9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 8:25 AM, Damien Le Moal wrote:
> On 2021/05/20 15:10, Hannes Reinecke wrote:
> [...]
>>> +/*
>>> + * First phase of BIO mapping for targets with zone append emulation:
>>> + * check all BIO that change a zone writer pointer and change zone
>>> + * append operations into regular write operations.
>>> + */
>>> +static bool dm_zone_map_bio_begin(struct mapped_device *md,
>>> +				  struct bio *orig_bio, struct bio *clone)
>>> +{
>>> +	sector_t zone_sectors = blk_queue_zone_sectors(md->queue);
>>> +	unsigned int zno = bio_zone_no(orig_bio);
>>> +	unsigned long flags;
>>> +	bool good_io = false;
>>> +
>>> +	spin_lock_irqsave(&md->zwp_offset_lock, flags);
>>> +
>>> +	/*
>>> +	 * If the target zone is in an error state, recover by inspecting the
>>> +	 * zone to get its current write pointer position. Note that since the
>>> +	 * target zone is already locked, a BIO issuing context should never
>>> +	 * see the zone write in the DM_ZONE_UPDATING_WP_OFST state.
>>> +	 */
>>> +	if (md->zwp_offset[zno] == DM_ZONE_INVALID_WP_OFST) {
>>> +		unsigned int wp_offset;
>>> +		int ret;
>>> +
>>> +		md->zwp_offset[zno] = DM_ZONE_UPDATING_WP_OFST;
>>> +
>>> +		spin_unlock_irqrestore(&md->zwp_offset_lock, flags);
>>> +		ret = dm_update_zone_wp_offset(md, zno, &wp_offset);
>>> +		spin_lock_irqsave(&md->zwp_offset_lock, flags);
>>> +
>>> +		if (ret) {
>>> +			md->zwp_offset[zno] = DM_ZONE_INVALID_WP_OFST;
>>> +			goto out;
>>> +		}
>>> +		md->zwp_offset[zno] = wp_offset;
>>> +	} else if (md->zwp_offset[zno] == DM_ZONE_UPDATING_WP_OFST) {
>>> +		DMWARN_LIMIT("Invalid DM_ZONE_UPDATING_WP_OFST state");
>>> +		goto out;
>>> +	}
>>> +
>>> +	switch (bio_op(orig_bio)) {
>>> +	case REQ_OP_WRITE_ZEROES:
>>> +	case REQ_OP_WRITE_SAME:
>>> +	case REQ_OP_WRITE:
>>> +		break;
>>> +	case REQ_OP_ZONE_RESET:
>>> +	case REQ_OP_ZONE_FINISH:
>>> +		goto good;
>>> +	case REQ_OP_ZONE_APPEND:
>>> +		/*
>>> +		 * Change zone append operations into a non-mergeable regular
>>> +		 * writes directed at the current write pointer position of the
>>> +		 * target zone.
>>> +		 */
>>> +		clone->bi_opf = REQ_OP_WRITE | REQ_NOMERGE |
>>> +			(orig_bio->bi_opf & (~REQ_OP_MASK));
>>> +		clone->bi_iter.bi_sector =
>>> +			orig_bio->bi_iter.bi_sector + md->zwp_offset[zno];
>>> +		break;
>>> +	default:
>>> +		DMWARN_LIMIT("Invalid BIO operation");
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* Cannot write to a full zone */
>>> +	if (md->zwp_offset[zno] >= zone_sectors)
>>> +		goto out;
>>> +
>>> +	/* Writes must be aligned to the zone write pointer */
>>> +	if ((clone->bi_iter.bi_sector & (zone_sectors - 1)) != md->zwp_offset[zno])
>>> +		goto out;
>>> +
>>> +good:
>>> +	good_io = true;
>>> +
>>> +out:
>>> +	spin_unlock_irqrestore(&md->zwp_offset_lock, flags);
>>
>> I'm not happy with the spinlock. Can't the same effect be achieved with
>> some clever READ_ONCE()/WRITE_ONCE/cmpexch magic?
>> Especially as you have a separate 'zone lock' mechanism ...
> 
> hmmm... Let me see. Given that what the bio completion is relatively simple, it
> may be possible. With more coffee, I amy be able to come up with something clever.
> 
More coffee is always a good idea :-)
I would look at killing the intermediate state UPDATING_WP_OFST and only 
update the pointer on endio (or if it failed).
That way we would need to update the pointer only once if we have a 
final state, and don't need to do the double update you are doing now.

>>
>>> +
>>> +	return good_io;
>>> +}
>>> +
>>> +/*
>>> + * Second phase of BIO mapping for targets with zone append emulation:
>>> + * update the zone write pointer offset array to account for the additional
>>> + * data written to a zone. Note that at this point, the remapped clone BIO
>>> + * may already have completed, so we do not touch it.
>>> + */
>>> +static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
>>> +					struct bio *orig_bio,
>>> +					unsigned int nr_sectors)
>>> +{
>>> +	unsigned int zno = bio_zone_no(orig_bio);
>>> +	blk_status_t sts = BLK_STS_OK;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&md->zwp_offset_lock, flags);
>>> +
>>> +	/* Update the zone wp offset */
>>> +	switch (bio_op(orig_bio)) {
>>> +	case REQ_OP_ZONE_RESET:
>>> +		md->zwp_offset[zno] = 0;
>>> +		break;
>>> +	case REQ_OP_ZONE_FINISH:
>>> +		md->zwp_offset[zno] = blk_queue_zone_sectors(md->queue);
>>> +		break;
>>> +	case REQ_OP_WRITE_ZEROES:
>>> +	case REQ_OP_WRITE_SAME:
>>> +	case REQ_OP_WRITE:
>>> +		md->zwp_offset[zno] += nr_sectors;
>>> +		break;
>>> +	case REQ_OP_ZONE_APPEND:
>>> +		/*
>>> +		 * Check that the target did not truncate the write operation
>>> +		 * emulating a zone append.
>>> +		 */
>>> +		if (nr_sectors != bio_sectors(orig_bio)) {
>>> +			DMWARN_LIMIT("Truncated write for zone append");
>>> +			sts = BLK_STS_IOERR;
>>> +			break;
>>> +		}
>>> +		md->zwp_offset[zno] += nr_sectors;
>>> +		break;
>>> +	default:
>>> +		DMWARN_LIMIT("Invalid BIO operation");
>>> +		sts = BLK_STS_IOERR;
>>> +		break;
>>> +	}
>>> +
>>> +	spin_unlock_irqrestore(&md->zwp_offset_lock, flags);
>>
>> You don't need the spinlock here; using WRITE_ONCE() should be sufficient.
> 
> If other references to zwp_offset use READ_ONCE(), no ?
> 
Why, but of course.
If you touch one you have to touch all :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
