Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94926C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6123B20449
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 10:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz1xhTx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfB0K2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:28:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39950 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfB0K2H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 05:28:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so13425829eds.7
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 02:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AVjcrVZWup3WNgSmgM1fxjmj7XQtL7FErVLlRHee9D0=;
        b=gz1xhTx3G2fbSlMlpbow+QRWnADzWQMIuiRlhibq1XsC2T8CUvAdmx1teavetfuWjm
         i1v4ycFIS+ok85mqlindA1W0I9aqFLFaR2xwdRPm6Dec8QxJdwthgimPGfABVus6MICl
         ztPhBteurkk0T+1UNgstb2veaqN1jDZSGmTfg//IQ9AiXB4zulYBQIDqXE2X+XcOlcTI
         GEwYzoakTKPNqGZFjZEgaqCLuQCH/3kPtBQ+XW1LS6Xo8WKh8+2QhPSbbc7zyie1RRmG
         QN3Ye4TWGGdy/+m6d+gVeLtR1eWC8HjdXSo/Y7SgZngG7MyvlbvV9HX94YXKMxeC2yQ6
         gazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVjcrVZWup3WNgSmgM1fxjmj7XQtL7FErVLlRHee9D0=;
        b=SyjpfcQ0N3YI7CZSxzu4v+jc7DDSzuDCMZwPqUltiBpCbO+3qV/8ezXxhs++DeGkbe
         4AUX4AS5jwoY08aq5YcX8jVpxi/C1v//VxlSMFFM0Olj1n+ZbeTJSuFQKnq0KKUvqjbO
         TRxIAy19w0IlpHxHrJA0xUe7I5n9NJtflkP/xXfVsEEha0hsL8OV9RzguTWZZMNTYx0y
         c7SvGvhQQVFGBGtvobcNTBYWT91CUt7+Iqqa0bMqoLEMf/6gRdU/qsySRE6WPROl+3tG
         /2PNuoZ6WoUUngLpHvPa6y9YofB58GdXgVMqPnSchXMZEpuE6Ikd0sKIF+yhnSVJ2cAn
         Q2tA==
X-Gm-Message-State: AHQUAuYATufj9EQIW7/tFVBuzX9hBFaQLVOkiipF7/dZzL7qx7Li3CbU
        BI3KJ8ufebaR2oM9w9qZmHPWYpvp
X-Google-Smtp-Source: AHgI3IbwCNjlZm+fbQbOTaQQ17+oFmjm6O4jU89WiWqSmMfEVZPZWQ2sMU5STwd0pNz6lFCXnExpZQ==
X-Received: by 2002:a50:8b9c:: with SMTP id m28mr1712078edm.141.1551263285314;
        Wed, 27 Feb 2019 02:28:05 -0800 (PST)
Received: from [192.168.0.171] (189.26.187.79.dynamic.adsl.gvt.net.br. [189.26.187.79])
        by smtp.gmail.com with ESMTPSA id y45sm4132457edd.33.2019.02.27.02.28.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 02:28:03 -0800 (PST)
Subject: Re: [PATCH] block: add a new flag BLK_MQ_POLL_HYBRID_INVALID for
 hybrid poll
To:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <20190227062155.19732-1-yuyufen@huawei.com>
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Message-ID: <0a46f96d-1707-9e1d-cd44-4eb7dce60533@gmail.com>
Date:   Wed, 27 Feb 2019 07:27:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190227062155.19732-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Yufen,

On 2/27/19 3:21 AM, Yufen Yu wrote:
> For q->poll_nsec == -1, means using classic poll, not hybrid poll.
> We introduce a new flag BLK_POLL_DELAY_INVALID to replace -1, which
> may make code much easier to read.

In the commit message you say BLK_POLL_DELAY_INVALID, but the code and 
the commit title use BLK_MQ_POLL_HYBRID_INVALID. Is this a typo?

Thanks.

> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>   block/blk-mq.c         | 4 ++--
>   block/blk-sysfs.c      | 4 ++--
>   include/linux/blkdev.h | 3 +++
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9437a5eb07cf..8df9f6e97d2e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2857,7 +2857,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   	/*
>   	 * Default to classic polling
>   	 */
> -	q->poll_nsec = -1;
> +	q->poll_nsec = BLK_MQ_POLL_HYBRID_INVALID;
>   
>   	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
>   	blk_mq_add_queue_tag_set(set, q);
> @@ -3389,7 +3389,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>   {
>   	struct request *rq;
>   
> -	if (q->poll_nsec == -1)
> +	if (q->poll_nsec == BLK_MQ_POLL_HYBRID_INVALID)
>   		return false;
>   
>   	if (!blk_qc_t_is_internal(cookie))
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 590d1ef2f961..8775b898f96d 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -360,7 +360,7 @@ static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
>   {
>   	int val;
>   
> -	if (q->poll_nsec == -1)
> +	if (q->poll_nsec == BLK_MQ_POLL_HYBRID_INVALID)
>   		val = -1;
>   	else
>   		val = q->poll_nsec / 1000;
> @@ -381,7 +381,7 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
>   		return err;
>   
>   	if (val == -1)
> -		q->poll_nsec = -1;
> +		q->poll_nsec = BLK_MQ_POLL_HYBRID_INVALID;
>   	else
>   		q->poll_nsec = val * 1000;
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 338604dff7d0..2102447b67d9 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -50,6 +50,9 @@ struct blk_stat_callback;
>   /* Must be consistent with blk_mq_poll_stats_bkt() */
>   #define BLK_MQ_POLL_STATS_BKTS 16
>   
> +/* Using default classic polling */
> +#define BLK_MQ_POLL_HYBRID_INVALID -1
> +
>   /*
>    * Maximum number of blkcg policies allowed to be registered concurrently.
>    * Defined here to simplify include dependency.
> 
