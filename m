Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFDC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756B2086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="1YO2MdFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7756B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeK1LEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:04:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55004 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1LEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 06:04:40 -0500
Received: by mail-it1-f193.google.com with SMTP id m123-v6so1537892ita.4
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 16:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MM1MuaRgSJpvzqiiLHn1IUsWZTnmYZYuD26H/xw+uhQ=;
        b=1YO2MdFaxzl+G2osvJ6fyNC8Rr/CXyOLzkaTsi6TlCgjpvi7XNuomKTLL5LlSDFYHD
         aMa52bK4g/DS+lBhtYygqSDmksivA0rZpsqoa7+I3CP4eyuxsXG0Y3iEfXGTpOh3yAM0
         kfkDkfcqsu9Q55MN6UodpPY/+TYFWA/qX0u744YaLz4CME7o5cIXiGtUAZRnKq8kPuvA
         QMhPAn7WDQgEsEUxPOdGBOJ5KS9lwYN8UajykLPZ4JlGiZqRYA3ZKTvp/46b8cGSukSz
         PsG+TWh7etO3Dc/3fZbHDV3xHJE3eawskE/VPbKYhrxuSf90YaURv1ZdhCrQVfIu8GuP
         C4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MM1MuaRgSJpvzqiiLHn1IUsWZTnmYZYuD26H/xw+uhQ=;
        b=sQiaV88GkXyGV5pr1d0zHk3Ai9zQYODwEQFBaP4djn6Oj4pBpZHidY7iI1Uwki1xqn
         XwFosj2SvyTnEXzXJDF3/ZD/ICvuoS/rS340XsWM7s3He6WmF1qHb1ANwG5NOoUUIi7E
         b7/56YxhIBE3D8pwIQxu8cZBi20B84WIQfPJhkuG2hdHWMH9uwuNA8uwsF0xzOG1nN2Y
         X8nSUJNA9QtaV8IUv3F5ZorgjHTM6u+kkeNcmV0GS1RXnW6wmCulGSybX1zsAj+ckVV4
         DT7i6EQWfs27jEuwBclFmenJ3yViSCYFidU1TFJoGC6mVO3WBxRecnS9s1iVnoenYMNK
         gB3A==
X-Gm-Message-State: AA+aEWblg8mM/dUizxqcXZv2PlupxYgTtxsw+RZXQuj4y0sLt/g6zVbf
        TWa2WzNOwBxAN5wkAUCJv4lwaYFSVzs=
X-Google-Smtp-Source: AFSGD/VopF3q05uPoLRX8Y2jSvgsSzgnAuA9A1sClHhe/XPPmV4NaxSp87nfadi/OKNXqRYeE+KDQw==
X-Received: by 2002:a24:d648:: with SMTP id o69mr983821itg.31.1543363504035;
        Tue, 27 Nov 2018 16:05:04 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id p12sm1669816iom.64.2018.11.27.16.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 16:05:03 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:05:01 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/8] block: improve logic around when to sort a plug list
Message-ID: <20181128000501.GH846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk>
 <20181127233142.GB846@vader>
 <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
 <62f96268-f596-78b8-d227-6be1f5ae1cea@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f96268-f596-78b8-d227-6be1f5ae1cea@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 04:59:14PM -0700, Jens Axboe wrote:
> On 11/27/18 4:49 PM, Jens Axboe wrote:
> > On 11/27/18 4:31 PM, Omar Sandoval wrote:
> >> On Mon, Nov 26, 2018 at 09:35:50AM -0700, Jens Axboe wrote:
> >>> Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
> >>> case if we have requests for multiple devices in the plug.
> >>>
> >>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>> ---
> >>>  block/blk-core.c       | 1 +
> >>>  block/blk-mq.c         | 7 +++++--
> >>>  include/linux/blkdev.h | 1 +
> >>>  3 files changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/block/blk-core.c b/block/blk-core.c
> >>> index be9233400314..c9758d185357 100644
> >>> --- a/block/blk-core.c
> >>> +++ b/block/blk-core.c
> >>> @@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
> >>>  	INIT_LIST_HEAD(&plug->mq_list);
> >>>  	INIT_LIST_HEAD(&plug->cb_list);
> >>>  	plug->rq_count = 0;
> >>> +	plug->do_sort = false;
> >>>  
> >>>  	/*
> >>>  	 * Store ordering should not be needed here, since a potential
> >>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>> index 99c66823d52f..6a249bf6ed00 100644
> >>> --- a/block/blk-mq.c
> >>> +++ b/block/blk-mq.c
> >>> @@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >>>  	list_splice_init(&plug->mq_list, &list);
> >>>  	plug->rq_count = 0;
> >>>  
> >>> -	list_sort(NULL, &list, plug_rq_cmp);
> >>> +	if (plug->do_sort)
> >>> +		list_sort(NULL, &list, plug_rq_cmp);
> >>>  
> >>>  	this_q = NULL;
> >>>  	this_hctx = NULL;
> >>> @@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >>>  
> >>>  		list_add_tail(&rq->queuelist, &plug->mq_list);
> >>>  		plug->rq_count++;
> >>> +		plug->do_sort = true;
> >>>  	} else if (plug && !blk_queue_nomerges(q)) {
> >>>  		blk_mq_bio_to_request(rq, bio);
> >>>  
> >>> @@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >>>  			data.hctx = same_queue_rq->mq_hctx;
> >>>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
> >>>  					&cookie);
> >>> -		}
> >>> +		} else if (plug->rq_count > 1)
> >>> +			plug->do_sort = true;
> >>
> >> If plug->rq_count == 2, there's no benefit to sorting, either. The
> >> nr_hw_queues == 1 case could also avoid sorting in that case. So maybe
> >> this whole patch could just be replaced with:
> > 
> > Heh yes, good point, it should be 3 at least. But if you look at the
> > later mq plug patch, we only sort for that one if we have multiple
> > queues. So the logic should be something ala:
> > 
> > if (plug->rq_count > 2 && plug->has_multiple_queues)
> > 
> > since that's the only case we want to sort for.
> 
> How about something like this?
> 
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index be9233400314..d107d016b92b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
>  	INIT_LIST_HEAD(&plug->mq_list);
>  	INIT_LIST_HEAD(&plug->cb_list);
>  	plug->rq_count = 0;
> +	plug->multiple_queues = false;
>  
>  	/*
>  	 * Store ordering should not be needed here, since a potential
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7b7dff85cf6c..02daa32c5d77 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1677,7 +1677,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  	list_splice_init(&plug->mq_list, &list);
>  	plug->rq_count = 0;
>  
> -	list_sort(NULL, &list, plug_rq_cmp);
> +	if (plug->rq_count > 2 && plug->multiple_queues)
> +		list_sort(NULL, &list, plug_rq_cmp);
>  
>  	this_q = NULL;
>  	this_hctx = NULL;
> @@ -1866,6 +1867,20 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  	}
>  }
>  
> +static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
> +{
> +	list_add_tail(&rq->queuelist, &plug->mq_list);
> +	plug->rq_count++;
> +	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
> +		struct request *tmp;
> +
> +		tmp = list_first_entry(&plug->mq_list, struct request,
> +						queuelist);
> +		if (tmp->q != rq->q)
> +			plug->multiple_queues = true;

Actually, I thought we want to sort whenever there are different
software/hardware queues on the plug list, even if they're on the same
queue?

> +	}
> +}
> +
>  static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  {
>  	const int is_sync = op_is_sync(bio->bi_opf);
> @@ -1932,8 +1947,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  			trace_block_plug(q);
>  		}
>  
> -		list_add_tail(&rq->queuelist, &plug->mq_list);
> -		plug->rq_count++;
> +		blk_add_rq_to_plug(plug, rq);
>  	} else if (plug && !blk_queue_nomerges(q)) {
>  		blk_mq_bio_to_request(rq, bio);
>  
> @@ -1948,8 +1962,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  			same_queue_rq = NULL;
>  		if (same_queue_rq)
>  			list_del_init(&same_queue_rq->queuelist);
> -		list_add_tail(&rq->queuelist, &plug->mq_list);
> -		plug->rq_count++;
> +		blk_add_rq_to_plug(plug, rq);
>  
>  		blk_mq_put_ctx(data.ctx);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 02732cae6080..08d940f85fa0 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1131,6 +1131,7 @@ struct blk_plug {
>  	struct list_head mq_list; /* blk-mq requests */
>  	struct list_head cb_list; /* md requires an unplug callback */
>  	unsigned short rq_count;
> +	bool multiple_queues;
>  };
>  #define BLK_MAX_REQUEST_COUNT 16
>  #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
