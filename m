Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F28C433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 10:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384605AbhLDKrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:47:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54820 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhLDKrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Dec 2021 05:47:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54AAD1FD33;
        Sat,  4 Dec 2021 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638614631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xCeDoITMT2MiEuGfcfJOSHioleZsgJAHq0XZJkyrvo=;
        b=LPj1Ou1VIi8MWxDxhubextTKLBuTPXNqo27Ds4CoGAlDglPyjBfGPnwjQMifyYj3rtai8C
        wc2wM6uVdMETgluyrmMrgUC0VLQp1sBSrGqffeEldoEyVgmg2UFCTOhE7F/451oaUkxbVY
        78PTdaX/tklHjIDVQ3qqi9plybl5YgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638614631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xCeDoITMT2MiEuGfcfJOSHioleZsgJAHq0XZJkyrvo=;
        b=90i7YebLEpnEEEIM+Sd8DLOSeuxMa50D2mH0EswdTVLlDwwtmeuX6JXqub3ZwHI7jJy5A0
        tmDE3mcIyxvn3jCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25B1E13BF8;
        Sat,  4 Dec 2021 10:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YBAtCGdGq2HGagAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 04 Dec 2021 10:43:51 +0000
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-2-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2a3fb650-4b6e-9eb1-aa6b-318236717ccf@suse.de>
Date:   Sat, 4 Dec 2021 11:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211203214544.343460-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 10:45 PM, Jens Axboe wrote:
> If we have a list of requests in our plug list, send it to the driver in
> one go, if possible. The driver must set mq_ops->queue_rqs() to support
> this, if not the usual one-by-one path is used.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c         | 24 +++++++++++++++++++++---
>   include/linux/blk-mq.h |  8 ++++++++
>   2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 22ec21aa0c22..9ac9174a2ba4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2513,6 +2513,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   {
>   	struct blk_mq_hw_ctx *this_hctx;
>   	struct blk_mq_ctx *this_ctx;
> +	struct request *rq;
>   	unsigned int depth;
>   	LIST_HEAD(list);
>   
> @@ -2521,7 +2522,26 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   	plug->rq_count = 0;
>   
>   	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
> -		blk_mq_run_dispatch_ops(plug->mq_list->q,
> +		struct request_queue *q;
> +
> +		rq = plug->mq_list;
> +		q = rq->q;
> +
> +		/*
> +		 * Peek first request and see if we have a ->queue_rqs() hook.
> +		 * If we do, we can dispatch the whole plug list in one go. We
> +		 * already know at this point that all requests belong to the
> +		 * same queue, caller must ensure that's the case.
> +		 */
> +		if (q->mq_ops->queue_rqs &&
> +		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {

What is the dependency on shared tags here?
 From what I've seen it's just about submitting requests; the only 
difference to shared tags is the way the tags are allocated.
Care to explain?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
