Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C7C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjEQHqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEQHqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:46:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0745E40
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:46:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7159E22804;
        Wed, 17 May 2023 07:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/SkFPbm37bxio2z1G+NoT6cWXQkuwXwL5fs05Q2b0w=;
        b=yvGOQ4592bM8hOJBtvI0AD8WC4LBbVqVLT+BYs4a1lW0qqJe04nMdmAue5SoRFK8IVX9Y4
        4C2Uhv/5rlgKFMHeX/dQWD6CgPacxjUiJn9Fxuqj7cVc1yyGo6UCK2LgMHBNJkzmlPAc8v
        AWHfO55KwK+Bt4UERYapFVKNioATMV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/SkFPbm37bxio2z1G+NoT6cWXQkuwXwL5fs05Q2b0w=;
        b=lUYi5EGAK42Qzu4N6XMJL2o0e8GGWaeOS03wVXTxOKaqgj7LzcP1guLmDtiwVcvwlpnFs5
        SfepBH2B8Z9M2mCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D19E13358;
        Wed, 17 May 2023 07:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kr0mAlyGZGR6FgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:46:36 +0000
Message-ID: <11dde30d-bd68-13af-7816-7dbb071e67dd@suse.de>
Date:   Wed, 17 May 2023 09:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 10/11] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-11-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-11-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Start dispatching from the start of a zone instead of from the starting
> position of the most recently dispatched request.
> 
> If a zoned write is requeued with an LBA that is lower than already
> inserted zoned writes, make sure that it is submitted first.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6d0b99042c96..059727fa4b98 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -156,13 +156,28 @@ deadline_latter_request(struct request *rq)
>   	return NULL;
>   }
>   
> -/* Return the first request for which blk_rq_pos() >= pos. */
> +/*
> + * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
> + * return the first request after the highest zone start <= @pos.
> + */
>   static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
>   				enum dd_data_dir data_dir, sector_t pos)
>   {
>   	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
>   	struct request *rq, *res = NULL;
>   
> +	if (!node)
> +		return NULL;
> +
> +	rq = rb_entry_rq(node);
> +	/*
> +	 * A zoned write may have been requeued with a starting position that
> +	 * is below that of the most recently dispatched request. Hence, for
> +	 * zoned writes, start searching from the start of a zone.
> +	 */
> +	if (blk_rq_is_seq_zoned_write(rq))
> +		pos -= round_down(pos, rq->q->limits.chunk_sectors);
> +
>   	while (node) {
>   		rq = rb_entry_rq(node);
>   		if (blk_rq_pos(rq) >= pos) {
> @@ -806,6 +821,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   		list_add(&rq->queuelist, &per_prio->dispatch);
>   		rq->fifo_time = jiffies;
>   	} else {
> +		struct list_head *insert_before;
> +
>   		deadline_add_rq_rb(per_prio, rq);
>   
>   		if (rq_mergeable(rq)) {
> @@ -818,7 +835,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   		 * set expire time and add to fifo list
>   		 */
>   		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
> +		insert_before = &per_prio->fifo_list[data_dir];
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		/*
> +		 * Insert zoned writes such that requests are sorted by
> +		 * position per zone.
> +		 */
> +		if (blk_rq_is_seq_zoned_write(rq)) {
> +			struct request *rq2 = deadline_latter_request(rq);
> +
> +			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
> +				insert_before = &rq2->queuelist;
> +		}
> +#endif
> +		list_add_tail(&rq->queuelist, insert_before);
>   	}
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

