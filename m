Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239E7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06B56113E
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhI1Frf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:47:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49412 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Frf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 01:47:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A62C3222B5;
        Tue, 28 Sep 2021 05:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632807955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSjSGCSLWWNsA7RxMdyxjBb9y4G8Pd/BYxcyrhWy7qc=;
        b=iarsVD7t2to19B/O5X569j5QSbGxB0u5KYz/DSXcTOOZcXTwx13mZnGpkCBi1wUfYKwWuu
        qs7DjrcprBaPKhw1L3xfmzxRiYFUwSjxnfNOX0nGxEIiUKIPHn4PFjNvRZUVOXbM8UHxN7
        79/mrbRkex5zPqK3JEzcumX+yA64cno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632807955;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSjSGCSLWWNsA7RxMdyxjBb9y4G8Pd/BYxcyrhWy7qc=;
        b=fd3lmriNKe/AKZbslQXLPXo4WeQa/SdentKFnL7EBbD7vnYVL1roGjP/GnEbJ1lnJiayM/
        RTL6mHWXkOVSLrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7892F13A98;
        Tue, 28 Sep 2021 05:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dKSoHBOsUmFyOAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 28 Sep 2021 05:45:55 +0000
Subject: Re: [PATCH v2 1/4] block/mq-deadline: Improve request accounting
 further
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-2-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b895ef93-78a2-2eda-7b8d-1a858f9701e8@suse.de>
Date:   Tue, 28 Sep 2021 07:45:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210927220328.1410161-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/21 12:03 AM, Bart Van Assche wrote:
> The scheduler .insert_requests() callback is called when a request is
> queued for the first time and also when it is requeued. Only count a
> request the first time it is queued. Additionally, since the mq-deadline
> scheduler only performs zone locking for requests that have been
> inserted, skip the zone unlock code for requests that have not been
> inserted into the mq-deadline scheduler.
> 
> Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 47f042fa6a68..c27b4347ca91 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -677,8 +677,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   	blk_req_zone_write_unlock(rq);
>   
>   	prio = ioprio_class_to_prio[ioprio_class];
> -	dd_count(dd, inserted, prio);
> -	rq->elv.priv[0] = (void *)(uintptr_t)1;
> +	if (!rq->elv.priv[0]) {
> +		dd_count(dd, inserted, prio);
> +		rq->elv.priv[0] = (void *)(uintptr_t)1;
> +	}
>   
>   	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>   		blk_mq_free_requests(&free);
> @@ -759,12 +761,13 @@ static void dd_finish_request(struct request *rq)
>   
>   	/*
>   	 * The block layer core may call dd_finish_request() without having
> -	 * called dd_insert_requests(). Hence only update statistics for
> -	 * requests for which dd_insert_requests() has been called. See also
> -	 * blk_mq_request_bypass_insert().
> +	 * called dd_insert_requests(). Skip requests that bypassed I/O
> +	 * scheduling. See also blk_mq_request_bypass_insert().
>   	 */
> -	if (rq->elv.priv[0])
> -		dd_count(dd, completed, prio);
> +	if (!rq->elv.priv[0])
> +		return;
> +
> +	dd_count(dd, completed, prio);
>   
>   	if (blk_queue_is_zoned(q)) {
>   		unsigned long flags;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
