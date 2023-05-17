Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD40C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEQHie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjEQHie (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:38:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7B13E
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:38:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D4B7F20502;
        Wed, 17 May 2023 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhN3XwO4yjMGvWGxfeyXOG+BnL2nFcIQ+l+o/XqAHUk=;
        b=IxMxEd++0+C3x4IQofdXtwpOaILMp62kCEbqI/DHMRzDNgugs7RjZWK6H29GyLS3U4FmTX
        4oFE77d7Ib539PdBdjMg31pOY0FJnM2AQ/HAKuGPdxJDUHLhhX80j0cn7j+00V3pcDQHa6
        vc0pBUtCZZRVeBvMwEA1clBd/MGZp0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhN3XwO4yjMGvWGxfeyXOG+BnL2nFcIQ+l+o/XqAHUk=;
        b=rM0w03uIyIYwR18t/OPdofD34SMxxg4fxWIvdM/kALdIydjlBpfECx24uIKBNlULImrQJH
        glQ8UP7M5xE+KmBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EFA413358;
        Wed, 17 May 2023 07:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7lAqIXeEZGRyEgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:38:31 +0000
Message-ID: <95b60eea-782c-848a-926b-081ac8f69116@suse.de>
Date:   Wed, 17 May 2023 09:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 04/11] block: Introduce blk_rq_is_seq_zoned_write()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-5-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Introduce the function blk_rq_is_seq_zoned_write(). This function will
> be used in later patches to preserve the order of zoned writes that
> require write serialization.
> 
> This patch includes an optimization: instead of using
> rq->q->disk->part0->bd_queue to check whether or not the queue is
> associated with a zoned block device, use rq->q->disk->queue.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c      |  5 +----
>   include/linux/blk-mq.h | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 835d9e937d4d..096b6b47561f 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -60,10 +60,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
>   	if (!rq->q->disk->seq_zones_wlock)
>   		return false;
>   
> -	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
> -		return blk_rq_zone_is_seq(rq);
> -
> -	return false;
> +	return blk_rq_is_seq_zoned_write(rq);
>   }
>   EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 06caacd77ed6..301d72f85486 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1164,6 +1164,17 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>   	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
>   }
>   
> +/**
> + * blk_rq_is_seq_zoned_write() - Check if @rq requires write serialization.
> + * @rq: Request to examine.
> + *
> + * Note: REQ_OP_ZONE_APPEND requests do not require serialization.
> + */
> +static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
> +{
> +	return op_is_zoned_write(req_op(rq)) && blk_rq_zone_is_seq(rq);
> +}
> +
>   bool blk_req_needs_zone_write_lock(struct request *rq);
>   bool blk_req_zone_write_trylock(struct request *rq);
>   void __blk_req_zone_write_lock(struct request *rq);
> @@ -1194,6 +1205,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
>   	return !blk_req_zone_is_write_locked(rq);
>   }
>   #else /* CONFIG_BLK_DEV_ZONED */
> +static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
> +{
> +	return false;
> +}
> +
>   static inline bool blk_req_needs_zone_write_lock(struct request *rq)
>   {
>   	return false;
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

