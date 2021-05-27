Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3FAC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D526613CC
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhE0GrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 02:47:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53642 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhE0GrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 02:47:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 655671FD29;
        Thu, 27 May 2021 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622097944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJuANtw6TFW8e02cat21lQ/dYrOK0rZGG+frNuDRs08=;
        b=mq9uy+0vZncPM8ETvYo6Nh+xKdFL2A6X1LvqKAPI/m6jxRwxPfhWXPhdrtE4cxZCuqzI2l
        +50YK/JZ+TBrS4LmJ/b9McDWEtGbahL3rwyB+Swgc+C3Ydi2cFekXkwFcdLAsHELI6FgGx
        oRer3sNeTwop0vTigj9M7vgtNhbhD/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622097944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJuANtw6TFW8e02cat21lQ/dYrOK0rZGG+frNuDRs08=;
        b=DTMm/J1SH7o/6uSdnqe9lm+DOkA8DfG50CXcJbBq4pVNz82AhgOFJKrNLSERyzy8XQlOKf
        o3Wxrr7ZU161b2Aw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 4DAC511A98;
        Thu, 27 May 2021 06:45:44 +0000 (UTC)
Subject: Re: [PATCH 1/9] block/mq-deadline: Add several comments
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-2-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <8f57c1cc-e41e-5438-ad02-5d4f0d92b079@suse.de>
Date:   Thu, 27 May 2021 08:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527010134.32448-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 3:01 AM, Bart Van Assche wrote:
> Make the code easier to read by adding more comments.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 8eea2cbf2bf4..64cabbc157ea 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -139,6 +139,9 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
>  	}
>  }
>  
> +/*
> + * Callback function that is invoked after @next has been merged into @req.
> + */
>  static void dd_merged_requests(struct request_queue *q, struct request *req,
>  			       struct request *next)
>  {
> @@ -375,6 +378,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  }
>  
>  /*
> + * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
> + *
>   * One confusing aspect here is that we get called for a specific
>   * hardware queue, but we may return a request that is for a
>   * different hardware queue. This is because mq-deadline has shared
> @@ -438,6 +443,10 @@ static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
>  	return 0;
>  }
>  
> +/*
> + * Try to merge @bio into an existing request. If @bio has been merged into
> + * an existing request, store the pointer to that request into *@rq.
> + */
>  static int dd_request_merge(struct request_queue *q, struct request **rq,
>  			    struct bio *bio)
>  {
> @@ -461,6 +470,10 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
>  	return ELEVATOR_NO_MERGE;
>  }
>  
> +/*
> + * Attempt to merge a bio into an existing request. This function is called
> + * before @bio is associated with a request.
> + */
>  static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> @@ -518,6 +531,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	}
>  }
>  
> +/*
> + * Called from blk_mq_sched_insert_request() or blk_mq_sched_insert_requests().
> + */
>  static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  			       struct list_head *list, bool at_head)
>  {
> @@ -544,6 +560,8 @@ static void dd_prepare_request(struct request *rq)
>  }
>  
>  /*
> + * Callback function called from inside blk_mq_free_request().
> + *
>   * For zoned block devices, write unlock the target zone of
>   * completed write requests. Do this while holding the zone lock
>   * spinlock so that the zone is never unlocked while deadline_fifo_request()
> 
Shouldn't these be kernel-doc comments?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
