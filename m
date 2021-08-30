Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A134C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B8960F56
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 17:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhH3RaX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:30:23 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:35672 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3RaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 13:30:22 -0400
Received: by mail-pf1-f177.google.com with SMTP id x16so12773850pfh.2
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 10:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ByXImmwoeMaTaIFmVg6cKohAgL9nKGwc65NiX5pnMag=;
        b=IA8RuyhxFWOMDW+RFDNME5pFew/IFtRRwh+hEYiU4OSQBfwvjM3N+LzUxDFEFtcY0v
         aKiw2TeO6X1Zubxc+Bj7ql7WoZ50fIpTzxBIpON/lEeH6zJIrwgQGTTJGas9wbEj1GWY
         mAuf34yuqmRya6lanHjYUeLTf1QAnlLQt9l7+V/g3PsVCG44WlWXy/bc/OLstW+SbqmD
         nGrc2sprtmmsrMybRMBZxtveA5YPdJ8S9eaw+Dk+MLeiEplplHLc0LhgD+8VvA2BunzK
         +Z1IddRT5LtBrtpl+tYc+25qotYc3DU02jkfTMikvbRRIbheVA8kHwiNTc8kZyPDY+vq
         6/DA==
X-Gm-Message-State: AOAM530txhwyIxRmGqB27yt6jBUAKlUS2qzVWLtGf/bAun4TJk02Qbpb
        6r50WIv3Fcu/oY3dba67jN0Yxw5f7Sc=
X-Google-Smtp-Source: ABdhPJzaGED9u+3e+hO7j53vBRneLr/9nRQ0FxGcQM1sKstUAYiYxU3tBaICgUX/ul5SywxcfoBYYQ==
X-Received: by 2002:a63:704f:: with SMTP id a15mr22596009pgn.120.1630344568499;
        Mon, 30 Aug 2021 10:29:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:86a7:224:3596:de63])
        by smtp.gmail.com with ESMTPSA id x17sm14952083pfa.3.2021.08.30.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:29:27 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Use helpers to access rq->state
To:     Nikolay Borisov <nborisov@suse.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <20210512095017.235295-1-nborisov@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <36615406-97c4-5273-364b-8f2b5b1fb35f@acm.org>
Date:   Mon, 30 Aug 2021 10:29:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210512095017.235295-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 2:50 AM, Nikolay Borisov wrote:
> Instead of having a mixed bag of opencoded usage and helper usage,
> simply replace opencoded sites with the appropriate helper. No
> functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   block/blk-mq.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d4d7c1caa439..d1cfacf2734c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -644,7 +644,7 @@ static void blk_mq_raise_softirq(struct request *rq)
>   
>   bool blk_mq_complete_request_remote(struct request *rq)
>   {
> -	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> +	blk_mq_set_request_complete(rq);
>   
>   	/*
>   	 * For a polled request, always complete locallly, it's pointless
> @@ -721,7 +721,7 @@ void blk_mq_start_request(struct request *rq)
>   		rq_qos_issue(q, rq);
>   	}
>   
> -	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
> +	WARN_ON_ONCE(blk_mq_request_started(rq));
>   
>   	blk_add_timer(rq);
>   	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
> @@ -3812,7 +3812,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>   	hrtimer_set_expires(&hs.timer, kt);
>   
>   	do {
> -		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
> +		if (blk_mq_request_completed(rq))
>   			break;
>   		set_current_state(TASK_UNINTERRUPTIBLE);
>   		hrtimer_sleeper_start_expires(&hs, mode);

Is the above patch complete? I think even with the above patch applied
there are still two functions in the block layer that use WRITE_ONCE() to
modify rq->state directly:

$ git grep -nH 'WRITE_ONCE(rq->state,'
block/blk-mq.c:532:	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
block/blk-mq.c:648:	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
block/blk-mq.c:728:	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
block/blk-mq.c:747:		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
block/blk-mq.c:2416:	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
include/linux/blk-mq.h:521:	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);

Thanks,

Bart.
