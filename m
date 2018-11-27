Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C26C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715C520851
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="TrpOnNqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715C520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeK1KbQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:31:16 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34741 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeK1KbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:31:16 -0500
Received: by mail-io1-f66.google.com with SMTP id f6so18489437iob.1
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VCP8kBm14Mkml2JYsgPergpnO++8oDQcp0rJoreduyw=;
        b=TrpOnNqJFW1U5j/neCv+h44j5+5dJnAOEo7A/V6B1QzJUAAK882EHmYIe7Z22+95Lz
         EVXlNd9d2k/FfRiI8OSBR6sDVq12mooeQ0jzY1MfTCyadFyV5r/FpZZ9gyJdnryn3Y6P
         zIKS0UlUgz7Hw2O6gB8vkktmE6Mo8a5wd8L5eiD7EYH1KXEE/w2mUToEa9oF8sBcQZGS
         Ay5cFcf5YCg07HEbmy9Cn19JjjzLuHABm4oPa5TmUF3eWg9IXc6E17kpMUEJh5xmScz+
         ZTmMWEh4MJzJDB/pGpB+nmYnYjFCVYeY3BHQbtdTvTjcL5Qs/GlHrkcuEIOw5dwDNuNI
         Mhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VCP8kBm14Mkml2JYsgPergpnO++8oDQcp0rJoreduyw=;
        b=Bq7G6NryCW1WgSQS3/jEHAwfsfm+MPNn06sELYgUFRkGhWBAxU7krLRjk9fHQ3BfFl
         3C8+XX0Br+HsKeBfvqau8c6sAPE6zORHvGlSLr4iQ9CCHhqj00siS8Edyq6kPnN2hAbJ
         ZtUhw9gUJV6k3xPKl38fJrAUMNUj781tR2kTzRghIVly/7ue1JcggKRx28wAsqWJT0HJ
         c7ldrViLrYqkWlfkRZIxEeOjtlwMGnzfKKvP8sdACG6DvFbgt4QJppx/ZBup2kr2a7/Y
         Y7fcwsdmKjbW/F2Kd+5DHefwJc6Hc7xSS8AwHYaokcVnI3H5CE8cX81Jz3+hf+RNc/xq
         rZOg==
X-Gm-Message-State: AA+aEWY7+WHZBkIg03G1urBczkQ/KJjQ3YOGbe44WlUHknb62tqjswJA
        cBoCf3NOLn3U3XeS3Ny64ZDT3g==
X-Google-Smtp-Source: AFSGD/XDwGu4FKScO/mWwLQenR49NbleDVnAJ0VA/S43Rw9dJz66RrmAQF8NjYaLmCFJu02YKn7I+A==
X-Received: by 2002:a6b:8bc6:: with SMTP id n189mr24012154iod.234.1543361504539;
        Tue, 27 Nov 2018 15:31:44 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id x17sm1196792ioa.6.2018.11.27.15.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:31:43 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:31:42 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/8] block: improve logic around when to sort a plug list
Message-ID: <20181127233142.GB846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-3-axboe@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:50AM -0700, Jens Axboe wrote:
> Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
> case if we have requests for multiple devices in the plug.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-core.c       | 1 +
>  block/blk-mq.c         | 7 +++++--
>  include/linux/blkdev.h | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index be9233400314..c9758d185357 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
>  	INIT_LIST_HEAD(&plug->mq_list);
>  	INIT_LIST_HEAD(&plug->cb_list);
>  	plug->rq_count = 0;
> +	plug->do_sort = false;
>  
>  	/*
>  	 * Store ordering should not be needed here, since a potential
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 99c66823d52f..6a249bf6ed00 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  	list_splice_init(&plug->mq_list, &list);
>  	plug->rq_count = 0;
>  
> -	list_sort(NULL, &list, plug_rq_cmp);
> +	if (plug->do_sort)
> +		list_sort(NULL, &list, plug_rq_cmp);
>  
>  	this_q = NULL;
>  	this_hctx = NULL;
> @@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  		list_add_tail(&rq->queuelist, &plug->mq_list);
>  		plug->rq_count++;
> +		plug->do_sort = true;
>  	} else if (plug && !blk_queue_nomerges(q)) {
>  		blk_mq_bio_to_request(rq, bio);
>  
> @@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  			data.hctx = same_queue_rq->mq_hctx;
>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>  					&cookie);
> -		}
> +		} else if (plug->rq_count > 1)
> +			plug->do_sort = true;

If plug->rq_count == 2, there's no benefit to sorting, either. The
nr_hw_queues == 1 case could also avoid sorting in that case. So maybe
this whole patch could just be replaced with:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7b7dff85cf6c..de93c14e4700 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1675,9 +1675,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	unsigned int depth;
 
 	list_splice_init(&plug->mq_list, &list);
-	plug->rq_count = 0;
 
-	list_sort(NULL, &list, plug_rq_cmp);
+	if (plug->rq_count > 2)
+		list_sort(NULL, &list, plug_rq_cmp);
+	plug->rq_count = 0;
 
 	this_q = NULL;
 	this_hctx = NULL;

That will also handle the multi-queue case since we only plug one
request per multi-queue device. Thoughts?
