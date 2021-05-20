Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE1C433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89B261163
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhETFy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 01:54:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:46180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETFy0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 01:54:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF2DCAD71;
        Thu, 20 May 2021 05:53:04 +0000 (UTC)
Subject: Re: [PATCH v2 04/11] dm: Fix dm_accept_partial_bio()
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-5-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bcb534a6-df16-3603-72f9-d1e2bfe31da4@suse.de>
Date:   Thu, 20 May 2021 07:53:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-5-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> Fix dm_accept_partial_bio() to actually check that zone management
> commands are not passed as explained in the function documentation
> comment. Also, since a zone append operation cannot be split, add
> REQ_OP_ZONE_APPEND as a forbidden command.
> 
> White lines are added around the group of BUG_ON() calls to make the
> code more legible.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   drivers/md/dm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index ca2aedd8ee7d..a9211575bfed 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1237,8 +1237,9 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>   
>   /*
>    * A target may call dm_accept_partial_bio only from the map routine.  It is
> - * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
> - * REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH.
> + * allowed for all bio types except REQ_PREFLUSH, zone management operations
> + * (REQ_OP_ZONE_RESET, REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and
> + * REQ_OP_ZONE_FINISH) and zone append writes.
>    *
>    * dm_accept_partial_bio informs the dm that the target only wants to process
>    * additional n_sectors sectors of the bio and the rest of the data should be
> @@ -1268,9 +1269,13 @@ void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
>   {
>   	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
>   	unsigned bi_size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
>   	BUG_ON(bio->bi_opf & REQ_PREFLUSH);
> +	BUG_ON(op_is_zone_mgmt(bio_op(bio)));
> +	BUG_ON(bio_op(bio) == REQ_OP_ZONE_APPEND);
>   	BUG_ON(bi_size > *tio->len_ptr);
>   	BUG_ON(n_sectors > bi_size);
> +
>   	*tio->len_ptr -= bi_size - n_sectors;
>   	bio->bi_iter.bi_size = n_sectors << SECTOR_SHIFT;
>   }
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
