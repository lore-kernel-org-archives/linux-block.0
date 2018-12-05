Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D8EC04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0089220879
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PENoLAQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0089220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeLEQas (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:30:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55234 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLEQar (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 11:30:47 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so22225283ita.4
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UjMA8GYjBXGSFO0Tdq6v3UUBevPYreEUAopQcbtKsI4=;
        b=PENoLAQDHlvM4Yx8wdadc2ZGSu2llROpwQ411ayS38IvaD+lt8V/3EaHThCZrwXovi
         +LZSQofnxplkfSL82zgTLaHKMgu14ibfDzqubHyeZFQ1v4aExm9tFufL7APu4n7q/5z2
         q07eJOrtF2qaf6cE2RiFAf3MTgJeP3RFAen/LbyyeapvNDpWXnG+zy681n9fXmE7daBg
         kGldPB1oR3YwOwLIe3hS9FBUaeBL/0LjyzWuhChig0zFX0NuiY9wpc7d71GMMSOOgpj3
         f695ExeSBvTkiJJ+3RTyIbvT9853tmX/6Nk2r+1fK8cTofI6bQGforjagYkRBtrF3SF2
         +ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UjMA8GYjBXGSFO0Tdq6v3UUBevPYreEUAopQcbtKsI4=;
        b=Xl9lg1Vm8WKGWPzyoD+SDgu8bpAqL7KdyIbfdrH4IEOOKp5vN6nMZ5oAaNo3vgE77W
         gzu+j7SgvB1nn0Ehkn7dCBvb+ODe7CmCBrEBh7ipBz3bcScqhcwyDiHxUrcLjmAMPieA
         r43Q2pFz8YXMh5pBl+erXj4t7Lh9FGh/AcWXwosV8zBMILgkv+uIrq+b/2owpxXL+71C
         HSRDhnK+9UpTsl8jg8MS2U2Mvlpl+OFDZ5lSk0EV0rKA7xFasUB468B8f6/PiZpxM9Uw
         0SKLMqjlayjS/gvV3ZigbXI6MVAGfLjWju4wg82xknVQyaB10z1WwADiYYJf7KM6kXde
         cPoQ==
X-Gm-Message-State: AA+aEWavxCaMRMs57AASPRDjIMak/Gbqy/FbukkFfqdCrYTDKbUA8NF3
        1YZkRXeLfaRj3/PD4MqMHkxPaw==
X-Google-Smtp-Source: AFSGD/VWDp/W/7ZUF1qcESATLfLxQd925a4VisnmGBV285qzsF+yF7y7RO2JCbJ+Tqj5yyDBcgcU5g==
X-Received: by 2002:a02:88cf:: with SMTP id b15mr23391906jak.10.1544027447020;
        Wed, 05 Dec 2018 08:30:47 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y8sm7219380ita.5.2018.12.05.08.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:30:46 -0800 (PST)
Subject: Re: [PATCH V9 3/4] blk-mq: issue directly with bypass 'false' in
 blk_mq_sched_insert_requests
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-4-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6cb12913-3575-d3aa-ff08-f89bcb38b3d6@kernel.dk>
Date:   Wed, 5 Dec 2018 09:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543995842-20704-4-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 12:44 AM, Jianchao Wang wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fe92e52..0dfa269 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1899,32 +1899,23 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>  void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  		struct list_head *list)
>  {
> +	blk_qc_t cookie = BLK_QC_T_INVALID;
> +

I'm fine with adding this, but I think we need some sort of check for
that not being a valid cookie. That isn't new, we really should have
already.

>  	while (!list_empty(list)) {
> -		blk_status_t ret;
>  		struct request *rq = list_first_entry(list, struct request,
>  				queuelist);
>  
> -		if (!blk_rq_can_direct_dispatch(rq))
> -			break;
> -
>  		list_del_init(&rq->queuelist);
> -		ret = blk_mq_request_issue_directly(rq, list_empty(list));
> -		if (ret != BLK_STS_OK) {
> -			if (ret == BLK_STS_RESOURCE ||
> -					ret == BLK_STS_DEV_RESOURCE) {
> -				list_add(&rq->queuelist, list);
> -				break;
> -			}
> -			blk_mq_end_request(rq, ret);
> -		}
> +		blk_mq_try_issue_directly(hctx, rq, &cookie, false,
> +				list_empty(list));

Indent the list_empty() one more tab, should be after the ( if possible.

> -	 * If we didn't flush the entire list, we could have told
> -	 * the driver there was more coming, but that turned out to
> -	 * be a lie.
> +	 * cookie is set to a valid value only when reqeust is issued successfully.
> +	 * We only need to care about the last request's result, if it is inserted,
> +	 * kick the hardware with commit_rqs hook.

reqeust -> request

Also lines are too long, limit to 80 chars please.

And why aren't we just using the list_empty() check like before, and not
having to add the inval cookie value?

> -	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
> +	if ((cookie == BLK_QC_T_INVALID) && hctx->queue->mq_ops->commit_rqs)
>  		hctx->queue->mq_ops->commit_rqs(hctx);

Redundant parens around the cookie check.

-- 
Jens Axboe

