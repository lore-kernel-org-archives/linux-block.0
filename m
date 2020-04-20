Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB74C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ABA20575
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDTUrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:47:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41625 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTUrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 16:47:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id b8so5520526pfp.8
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 13:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBU6N2za40E6GYWSHCg49rdCzZV3gcmrv37br9COE8Y=;
        b=WhKDXhbLParkVrxtuNGY5nCM+FT/V1M64fP4SQy6cQnKdK9JYsWHx5dCICjSr1UH61
         8eV5Vqd4cLUcvbCMp+axuH7ZAahjseMGS99by9v/CIdS9ZyH/kSqMLl5diTVCweNFPME
         +kh20sOwAe2yCqIOGV6QVuSH4uyzy2Xu20oaB/LxBwdnvyta2kwTGF6196FSFXgGxJ8c
         AgLwbz5d1ayXALd1TPkJbyW96TH6SA805OdQVKF9ophPNQhFL+HFShqeZzo3bGy8UopZ
         yad7fQEU1GqLEa9N3YKJmYq4YFkipOD8T+MDBjjkMNtVDjRO5HRmLyfCxot1TqNxgQI/
         dcnw==
X-Gm-Message-State: AGi0PuZjIe07khDQ43a4o8+QVCjaCRcOiF6Q1P+kCvSdx3b73OHzSFiD
        8BFdcLKEkDO42hj8WZwzHUMDfR1x
X-Google-Smtp-Source: APiQypIspDxSUsJKPN2H7YfPaSInTHi2mHo3/G5iv/v6i62KPXN/xfDHL3MeDZhPj5vzKARMapMyLQ==
X-Received: by 2002:a05:6a00:2ba:: with SMTP id q26mr15518145pfs.285.1587415652820;
        Mon, 20 Apr 2020 13:47:32 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.198.105])
        by smtp.gmail.com with ESMTPSA id w125sm247073pgw.22.2020.04.20.13.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:47:32 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] block: rename blk_mq_alloc_rq_maps
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <dc8ec91cff01d55ab21a11ffc745023dd223627c.1586199103.git.zhangweiping@didiglobal.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <26c03c0d-ee4b-68aa-2fa8-e0312c955214@acm.org>
Date:   Mon, 20 Apr 2020 13:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <dc8ec91cff01d55ab21a11ffc745023dd223627c.1586199103.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 12:36 PM, Weiping Zhang wrote:
> rename blk_mq_alloc_rq_maps to blk_mq_alloc_rq_map_and_requests,
> this function alloc both map and request, make function name
> align with function.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5a322130aaf2..4692e8232699 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3000,7 +3000,7 @@ static int __blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
>    * may reduce the depth asked for, if memory is tight. set->queue_depth
>    * will be updated to reflect the allocated depth.
>    */
> -static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> +static int blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
>   {
>   	unsigned int depth;
>   	int err;
> @@ -3160,7 +3160,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>   	if (ret)
>   		goto out_free_mq_map;
>   
> -	ret = blk_mq_alloc_rq_maps(set);
> +	ret = blk_mq_alloc_rq_map_and_requests(set);
>   	if (ret)
>   		goto out_free_mq_map;

Personally I'm fine with the current name of this function. However, 
others may have another opinion.

Thanks,

Bart.

