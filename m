Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8549C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 08:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiFTIkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiFTIkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 04:40:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E525912AC4
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 01:40:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A52E91F972;
        Mon, 20 Jun 2022 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655714403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymlZN+GfzB486KRG8PwSZDayv6yiuWlMHOzRd7/NFC0=;
        b=c7qThiWl4idLC+O61VXu6NE492PJpKeNmrgLJotypEB9c63Uh24x72FaiLU5rRaCgrEQ/P
        3Cj9y7KWPwuieVcGtfk+wlTAdskRALbPGyFHetaSOOGr8YpzCKkgpl13qLN4j5mHIH6CIN
        lUqiqvOXpB/t8B5UHR+nI8jEA2979kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655714403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymlZN+GfzB486KRG8PwSZDayv6yiuWlMHOzRd7/NFC0=;
        b=R67rg+AB/oM6ZX29NcOwQRpaBIBM5v26pFqeTPJwzrEaeYFUwnX+CvMI8FZ3L/nGkO+VMt
        B0JMSOa5WLagKnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99B5713638;
        Mon, 20 Jun 2022 08:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yQ5AJWMysGKcKgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:40:03 +0000
Message-ID: <b3b813eb-357c-54f1-65e6-7e919b0e0d8c@suse.de>
Date:   Mon, 20 Jun 2022 10:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/6] block: stop setting the nomerges flags in
 blk_cleanup_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220619060552.1850436-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 08:05, Christoph Hellwig wrote:
> These flags only apply to file system I/O, and all file system I/O is
> already drained by del_gendisk and thus can't be in progress when
> blk_cleanup_queue is called.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 088332984cd1b..2f418606e3bd3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -304,9 +304,6 @@ void blk_cleanup_queue(struct request_queue *q)
>   	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
>   	blk_queue_start_drain(q);
>   
> -	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
> -	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
> -
>   	/*
>   	 * Drain all requests queued before DYING marking. Set DEAD flag to
>   	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
