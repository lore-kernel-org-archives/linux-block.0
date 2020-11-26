Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA6FC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB38E21D40
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbgKZQ1u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 11:27:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45976 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391309AbgKZQ1t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 11:27:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id 62so2068001pgg.12;
        Thu, 26 Nov 2020 08:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fapffKzj5pJupvS4Tasqmky7DVQH81Xk12pbcyyGjoQ=;
        b=JFj6hZgE65v1ahuwEQHoMmZ4M37s+4+ph9zfuXVfmdewscNFKXSjWlD5VfUOGPtHFp
         XCcEmG58guiDDDor5t59cMfLaplyHxUnfaRabxgws95ieRXif5/70UBOfFTZEVy85S6T
         5TZj8d26ubTvoavaPPHjzQN4q7eda9pE5eoRwK2eeCIlreOPqaFgRG/JgMqU5kI1XNS1
         CHX8uYYAEV+m0Em0mUq/RDm0V45N/P+UeLoOh/YbuKHfj/R9Th2mScOLiMqDAAaXwlpp
         CnUGG/Na+5E6efyHpc4o1QSEvZX9lUZ7pMDk7T7rMk0fsUTkWKAyhbxqlH4voOk9GjJg
         nt6g==
X-Gm-Message-State: AOAM530EEc3bJQ/Fpjj+5A0zasIUspXsttXcoPyzInzJ0QvlX/E2B3sR
        icATDmWOhrvTgb84p845XyENay/LCf8=
X-Google-Smtp-Source: ABdhPJx5OzU1RlFxOEdmQV/MP1XUQLo0Hq7A3nnM/02sUsGEsZyR4dnZAuvdjSzYx7FteoaehjK4vw==
X-Received: by 2002:a63:4950:: with SMTP id y16mr2165485pgk.415.1606408068393;
        Thu, 26 Nov 2020 08:27:48 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s30sm5012324pgl.39.2020.11.26.08.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 08:27:47 -0800 (PST)
Subject: Re: [PATCH V1] block: Fix use-after-free while iterating over
 requests
To:     Pradeep P V K <ppvk@codeaurora.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org
References: <1606402925-24420-1-git-send-email-ppvk@codeaurora.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c94fcada-7f6d-a1e3-4c88-d225af1a676e@acm.org>
Date:   Thu, 26 Nov 2020 08:27:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606402925-24420-1-git-send-email-ppvk@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 7:02 AM, Pradeep P V K wrote:
> Observes below crash while accessing (use-after-free) request queue
> member of struct request.
> 
> 191.784789:   <2> Unable to handle kernel paging request at virtual
> address ffffff81429a4440
> ...
> 191.786174:   <2> CPU: 3 PID: 213 Comm: kworker/3:1H Tainted: G S
> O      5.4.61-qgki-debug-ge45de39 #1
> ...
> 191.786226:   <2> Workqueue: kblockd blk_mq_timeout_work
> 191.786242:   <2> pstate: 20c00005 (nzCv daif +PAN +UAO)
> 191.786261:   <2> pc : bt_for_each+0x114/0x1a4
> 191.786274:   <2> lr : bt_for_each+0xe0/0x1a4
> ...
> 191.786494:   <2> Call trace:
> 191.786507:   <2>  bt_for_each+0x114/0x1a4
> 191.786519:   <2>  blk_mq_queue_tag_busy_iter+0x60/0xd4
> 191.786532:   <2>  blk_mq_timeout_work+0x54/0xe8
> 191.786549:   <2>  process_one_work+0x2cc/0x568
> 191.786562:   <2>  worker_thread+0x28c/0x518
> 191.786577:   <2>  kthread+0x160/0x170
> 191.786594:   <2>  ret_from_fork+0x10/0x18
> 191.786615:   <2> Code: 0b080148 f9404929 f8685921 b4fffe01 (f9400028)
> 191.786630:   <2> ---[ end trace 0f1f51d79ab3f955 ]---
> 191.786643:   <2> Kernel panic - not syncing: Fatal exception
> 
> Fix this by updating the freed request with NULL.
> This could avoid accessing the already free request from other
> contexts while iterating over the requests.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  block/blk-mq.c | 1 +
>  block/blk-mq.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5..9996cb1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -492,6 +492,7 @@ static void __blk_mq_free_request(struct request *rq)
>  
>  	blk_crypto_free_request(rq);
>  	blk_pm_mark_last_busy(rq);
> +	hctx->tags->rqs[rq->tag] = NULL;
>  	rq->mq_hctx = NULL;
>  	if (rq->tag != BLK_MQ_NO_TAG)
>  		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index a52703c..8747bf1 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -224,6 +224,7 @@ static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
>  static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>  					   struct request *rq)
>  {
> +	hctx->tags->rqs[rq->tag] = NULL;
>  	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>  	rq->tag = BLK_MQ_NO_TAG;  

Is this perhaps a block driver bug instead of a block layer core bug? If
this would be a block layer core bug, it would have been reported before.

Bart.
