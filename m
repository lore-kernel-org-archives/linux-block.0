Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D07C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 20:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B425620661
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 20:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="cWi59BvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B425620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbeLCUXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:23:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41537 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeLCUXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 15:23:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so6945420pfi.8
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C+Jb64N4UR0Stvftf0nkwi+ApQWzzf4fn/lCKUjbUiU=;
        b=cWi59BvH43BcW2fxt0AQUKznDAcWzqMVuqqUoB7AqhViIB6bLDonLekl3FKsVYFcN4
         IUJ1xeqib2NYUv6Mel2q+eFgZ0Jv06LRIsEt3QGV8TJZx0Y9mgIigUcbSK1uTtnkwRyp
         wAul3xS4kCgKoxhFNHaoQshYrCDwlqHOYKS6rY31bO8hCfv6jXnLw5EO8jTrGyhwH6E2
         MKvpDnDvOdCi/UikUlxOD+oY02e4ZuWEI+gt9I1ptDfzrV45PR1M7F+C3zcJk7FqB/YZ
         UTi0ftmah7SywfG21FFwcIHlt2hbLhMtvFEDyuv5qo2/J8FH8Hidpm5rthkGnju9Z3ZO
         DnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+Jb64N4UR0Stvftf0nkwi+ApQWzzf4fn/lCKUjbUiU=;
        b=EHokh0lLs2U8FTqe5Ve4jLKO0zP0TgwMWZ0rslW9CbhrHn2XtOSm7Fxt3r8eEqHzJN
         h/fb/44HyMTpRCChTVXIuvMrY6zacfB8cNVddSQ5MqwJzMQUYaOng8d4V2oqQ/t5qghu
         nTvey0fw767MvwyP5Q2FZVLfbXCJerQxBieuD4YQt6h5k2YpHNwLKGk99BwuBl4MCkv9
         D9AK5rGo/RtUJ/2NhqBjq/H+caerhw5J+ya0f11dis8PP6W9wb9wWynTjBu5XOoKyk4S
         KKAiDZytqOZlKkQstwuFlvdFG3U9AmWnWr778bIz8MHu8kjwa1O79bpvkLlQoyKAMu1E
         xZvw==
X-Gm-Message-State: AA+aEWZlHWlbHNwRpkia+xtyJ9XZfpUuteAhNATOglZZ9rVb0wtBkmBC
        6OUEnIVifNwJEVCHGYskC+MDBQ==
X-Google-Smtp-Source: AFSGD/VJFFFcT1bwOI0FkfCngV+0mgFM59Qdhd6kTwHUsqAhTpMhsASkfTIO0cKLPzDPMBp9/iVh4g==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr14605391pgd.57.1543868579497;
        Mon, 03 Dec 2018 12:22:59 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:8421])
        by smtp.gmail.com with ESMTPSA id f64sm50980902pfh.0.2018.12.03.12.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:22:58 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:22:57 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] blk-mq: don't call ktime_get_ns() if we don't need it
Message-ID: <20181203202257.GC11220@vader>
References: <73f58a60-cfa8-5736-d42a-9297601a1f71@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f58a60-cfa8-5736-d42a-9297601a1f71@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 02:13:54PM -0700, Jens Axboe wrote:
> We only need the request fields and the end_io time if we have
> stats enabled, or if we have a scheduler attached as those may
> use it for completion time stats.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> v2: add helper, use it in both spots. also clear ->start_time_ns
>     so merging doesn't read garbage.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7dcef565dc0f..e09d7f500077 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -281,6 +281,15 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
>  }
>  EXPORT_SYMBOL(blk_mq_can_queue);
>  
> +/*
> + * Only need start/end time stamping if we have stats enabled, or using
> + * an IO scheduler.
> + */
> +static inline bool blk_mq_need_time_stamp(struct request *rq)
> +{
> +	return (rq->rq_flags & RQF_IO_STAT) || rq->q->elevator;
> +}
> +
>  static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  		unsigned int tag, unsigned int op)
>  {
> @@ -316,7 +325,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	RB_CLEAR_NODE(&rq->rb_node);
>  	rq->rq_disk = NULL;
>  	rq->part = NULL;
> -	rq->start_time_ns = ktime_get_ns();
> +	if (blk_mq_need_time_stamp(rq))
> +		rq->start_time_ns = ktime_get_ns();
> +	else
> +		rq->start_time_ns = 0;
>  	rq->io_start_time_ns = 0;
>  	rq->nr_phys_segments = 0;
>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
> @@ -522,7 +534,10 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
>  
>  inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>  {
> -	u64 now = ktime_get_ns();
> +	u64 now = 0;
> +
> +	if (blk_mq_need_time_stamp(rq))
> +		now = ktime_get_ns();
>  
>  	if (rq->rq_flags & RQF_STATS) {
>  		blk_mq_poll_stats_start(rq->q);
> -- 
> Jens Axboe
> 
