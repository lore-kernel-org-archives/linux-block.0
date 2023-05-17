Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF4C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjEQHp5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjEQHpz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:45:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561ABE45
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:45:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D54AD22804;
        Wed, 17 May 2023 07:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYlHxWrHmo7hpVOG3vHy2FADDsWHsXHwDNKB7Ctvl+I=;
        b=MUPhZUnXeKavexB+jxW/kVmILoOcowZebwB2jgCMfvRiyaDSH3AED3LRBFMjVHiKEzc5zy
        LPqBPJMRnZCA4YHZa+BVIfvmYvzbFBPC83U5rijd/Fc4zoq10RZWBvO5GvdNQZpyJAy4/A
        Bg+u68jCusF1mfwe28Dpi241D8F8/tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYlHxWrHmo7hpVOG3vHy2FADDsWHsXHwDNKB7Ctvl+I=;
        b=X6OOq5twYCRnrkVq9y2z2PNobmSkA7HWXXSpOKDvs6Q7SXwjSaQ7zmOem3FMWe1m0yCfUf
        b5hS6BbS39X909Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 854E813358;
        Wed, 17 May 2023 07:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ckPkGCyGZGQRFgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:45:48 +0000
Message-ID: <78e71a38-0496-0f08-f1ca-9229c21b604e@suse.de>
Date:   Wed, 17 May 2023 09:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 09/11] block: mq-deadline: Track the dispatch position
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-10-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-10-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Track the position (sector_t) of the most recently dispatched request
> instead of tracking a pointer to the next request to dispatch. This
> patch is the basis for patch "Handle requeued requests correctly".
> Without this patch it would be significantly more complicated to make
> sure that zoned writes are dispatched in LBA order per zone.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 45 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 06af9c28a3bf..6d0b99042c96 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -74,8 +74,8 @@ struct dd_per_prio {
>   	struct list_head dispatch;
>   	struct rb_root sort_list[DD_DIR_COUNT];
>   	struct list_head fifo_list[DD_DIR_COUNT];
> -	/* Next request in FIFO order. Read, write or both are NULL. */
> -	struct request *next_rq[DD_DIR_COUNT];
> +	/* Position of the most recently dispatched request. */
> +	sector_t latest_pos[DD_DIR_COUNT];
>   	struct io_stats_per_prio stats;
>   };
>   
> @@ -156,6 +156,25 @@ deadline_latter_request(struct request *rq)
>   	return NULL;
>   }
>   
> +/* Return the first request for which blk_rq_pos() >= pos. */
> +static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
> +				enum dd_data_dir data_dir, sector_t pos)
> +{
> +	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
> +	struct request *rq, *res = NULL;
> +
> +	while (node) {
> +		rq = rb_entry_rq(node);
> +		if (blk_rq_pos(rq) >= pos) {
> +			res = rq;
> +			node = node->rb_left;
> +		} else {
> +			node = node->rb_right;
> +		}
> +	}
> +	return res;
> +}
> +
This is getting ever more awkward; you have to traverse the entire tree 
to get the result. Doesn't that impact performance?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

