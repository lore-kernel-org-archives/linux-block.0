Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19CC433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8971A20897
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jxYRINII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404449AbgE1P3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404446AbgE1P3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 11:29:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB23C08C5C6
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 08:29:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so13689983pfa.2
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6hh6aW8X6dPaUqmUNUKIPNGpkpGmHF3l+Ej1630rR7c=;
        b=jxYRINIIuvSu4hsFlBFfH1FE4xWexxwsX1KrxYPcDF/eTTvuvpnSGNTG6NtK8wTdXo
         +2z92bAppPkWjSyz5JqSgIyLYHwdMRjWcd3PYKu0h+rYC6cWPuQ4nv4yU6NuA0715QLE
         tH5zcKQA9BpcjhMLysPMkIaU+1G5Ns3THixRQwB4Mt8s3x+BQ1lJfU5DFvDK+bI9f2KQ
         dnVPZzWPa8+CGL7ykDXY86nSgBliSY82AWsc5Wwz8zOyOXYZvvce/I7PkTYTeUrRTccJ
         HFgVJXx1dVU2WIYvAjBDbhbyubRRIgx7fgw2EJNLiJyeiL/T1VobzGU3RNiheFHuxBC4
         r3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6hh6aW8X6dPaUqmUNUKIPNGpkpGmHF3l+Ej1630rR7c=;
        b=Am67OqnbHMWqUHQGMXdFMte+4MbRX/kVFuak5ybyfTmtyXjr8CHThfodQdY62h1boO
         9LwiJIOtMsIVCeVtvSaXtHgRqj2qqVKR3k+SY6svlCXhBBPGnyOtSHU1/0zlPqCyGd6Q
         lDAeN2mjrE3xVbupr+R5IWJmy4YwC4i+Ei1khKAAAuRfgAHWF0uR1Dq0qcge0Lik+rWn
         Z3raPYJmsFhJ/U4cSDe8UiSWa/S4qv9Er4sYOuBoIbgevEjBnnyWOiIYGMi2v4WNkH2X
         UHb7vtcqM78zLKuaPz0AjGddBc8GeXMG3AjzIyd6hLU8f+GjLOiCuZ2KdeW++b7Yh9ye
         4fEw==
X-Gm-Message-State: AOAM53310RQL0SRhI73g5gXlUDKqtGTwOz4e6lwIyyst+zaWRWQDQGHO
        LFU0cDPmyjrmrLd9yHrjf6vkgV0DYzHwDA==
X-Google-Smtp-Source: ABdhPJz7b1KR9vT+ueAV8UIPrsY2TXg80aHNh2ckVH4KMc5hUGe8XyWk1oCnWvZJ5Bh6Y1ur8UK1Xw==
X-Received: by 2002:a62:15c7:: with SMTP id 190mr3640090pfv.190.1590679755304;
        Thu, 28 May 2020 08:29:15 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m188sm5386142pfd.67.2020.05.28.08.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:29:14 -0700 (PDT)
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
References: <20200528151931.3501506-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85d8ac0f-a0fd-2644-d59b-755867ad8b29@kernel.dk>
Date:   Thu, 28 May 2020 09:29:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528151931.3501506-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/28/20 9:19 AM, Keith Busch wrote:
> For when drivers have a need to bypass error injection.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-mq.c         | 3 ++-
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cac11945f602..3c61faf63e15 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -556,7 +556,7 @@ static void __blk_mq_complete_request_remote(void *data)
>  	q->mq_ops->complete(rq);
>  }
>  
> -static void __blk_mq_complete_request(struct request *rq)
> +void __blk_mq_complete_request(struct request *rq)
>  {
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
>  	struct request_queue *q = rq->q;
> @@ -602,6 +602,7 @@ static void __blk_mq_complete_request(struct request *rq)
>  	}
>  	put_cpu();
>  }
> +EXPORT_SYMBOL(__blk_mq_complete_request);

Let's please make that _GPL

-- 
Jens Axboe

