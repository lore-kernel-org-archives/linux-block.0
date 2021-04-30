Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D946CC433B4
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 02:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA354611F1
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 02:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhD3Cw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 22:52:29 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36539 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3Cw2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 22:52:28 -0400
Received: by mail-pl1-f170.google.com with SMTP id a11so4960030plh.3
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 19:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEst/G1P2xE1Q3iha5k7NOrX/KxfjM8gNCm7Fv5EZ3w=;
        b=k+qWCZAVXaP86sXWboh7WdbpvfYwDveGkrduGjOz3A54iIlFLuvz7i0SmpE6SVFq54
         YAOv4J3g3r0lqU/MPI1pf1LWH4DoDxWQBSG5220asiOaw92w7HTK28sOjB7INdND2qJO
         tBLRwewPL3JmNK6ZPKOJlfik1Ca7UQgusAnUjh5ntHO6Xj/ehMkuopqXUtksbG3d8cDk
         LIDXLttTgZHhjZMF/MbTYxdE+kt4/7a7WM6o78arzKVVFLcewJK47PKXtFWLwgQzBy7T
         Pjck4uAzUfTPCZ78PDSshoEIE56XhqSdgHARcMu+azSMhiYQwjQUWYJVyuKvY2/l8/0h
         iX2A==
X-Gm-Message-State: AOAM533mwfhI9XpVKnX88gN0NNQ13LfeWDI93zgfwEx9wfM7NYxCrlu5
        tNKLLL604lM1iwNQb+P+eg8=
X-Google-Smtp-Source: ABdhPJw3k3wG8fcKy5vuGE3BRIykjjdzB7bcWCuTxstnqyEXYddkNrlKAjlUUj3ct/WK5rbget2cXQ==
X-Received: by 2002:a17:902:c943:b029:ee:8f40:6225 with SMTP id i3-20020a170902c943b02900ee8f406225mr2878636pla.52.1619751101051;
        Thu, 29 Apr 2021 19:51:41 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 205sm387516pfc.201.2021.04.29.19.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 19:51:40 -0700 (PDT)
Subject: Re: [PATCH V4 1/4] block: avoid double io accounting for flush
 request
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <20210429023458.3044317-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <254e529e-f07c-b87a-e117-07dbb02312af@acm.org>
Date:   Thu, 29 Apr 2021 19:51:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429023458.3044317-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 7:34 PM, Ming Lei wrote:
> For flush request, rq->end_io() may be called two times, one is from
> timeout handling(blk_mq_check_expired()), another is from normal
> completion(__blk_mq_end_request()).
> 
> Move blk_account_io_flush() after flush_rq->ref drops to zero, so
> io accounting can be done just once for flush request.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-flush.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 7942ca6ed321..1002f6c58181 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -219,8 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  	unsigned long flags = 0;
>  	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
>  
> -	blk_account_io_flush(flush_rq);
> -
>  	/* release the tag's ownership to the req cloned from */
>  	spin_lock_irqsave(&fq->mq_flush_lock, flags);
>  
> @@ -230,6 +228,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  		return;
>  	}
>  
> +	blk_account_io_flush(flush_rq);
>  	/*
>  	 * Flush request has to be marked as IDLE when it is really ended
>  	 * because its .end_io() is called from timeout code path too for

How about adding the following:

Fixes: b68663186577 ("block: add iostat counters for flush requests")

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
