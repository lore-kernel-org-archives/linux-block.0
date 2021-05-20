Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B3C433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815D36108D
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhETFv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 01:51:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETFv2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 01:51:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87BB7AF03;
        Thu, 20 May 2021 05:50:06 +0000 (UTC)
Subject: Re: [PATCH v2 02/11] block: introduce bio zone helpers
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-3-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c4b2a9b8-3d0e-1266-dcdd-cc11e5567c60@suse.de>
Date:   Thu, 20 May 2021 07:50:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> Introduce the helper functions bio_zone_no() and bio_zone_is_seq().
> Both are the BIO counterparts of the request helpers blk_rq_zone_no()
> and blk_rq_zone_is_seq(), respectively returning the number of the
> target zone of a bio and true if the BIO target zone is sequential.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   include/linux/blkdev.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f69c75bd6d27..2db0f376f5d9 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1008,6 +1008,18 @@ static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
>   /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>   const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
>   
> +static inline unsigned int bio_zone_no(struct bio *bio)
> +{
> +	return blk_queue_zone_no(bdev_get_queue(bio->bi_bdev),
> +				 bio->bi_iter.bi_sector);
> +}
> +
> +static inline unsigned int bio_zone_is_seq(struct bio *bio)
> +{
> +	return blk_queue_zone_is_seq(bdev_get_queue(bio->bi_bdev),
> +				     bio->bi_iter.bi_sector);
> +}
> +
>   static inline unsigned int blk_rq_zone_no(struct request *rq)
>   {
>   	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
