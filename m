Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CDBC433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 13:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4E020707
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 13:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="TPgbvM9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgHZNOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgHZNOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 09:14:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A977C061574
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 06:14:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so1019702pgb.2
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=96S2fyCwnO5jCulVGmko8MP9KCX2ee5EN88+HjU48Rg=;
        b=TPgbvM9sgbnQN3gFBEX46yoi+agIKZQidqifjf7QTXQiSxMgdOmp5A7ro03P7oxEex
         RVUyU32bwFKzkvdbZqZxkef70k6GnVNmNrSZFswhcmi5EcsoxnUBuRvX65HL0WK6v/pe
         4BPgh0/aZUsdYeuj93HrdUsO2wFjQ6pOBCRI6UzZs08NTiITlUOx6hIJJ42aK1Lc5kZm
         y0j3GOCqBhNz1kIJt2IN+nRUM7p+EJBYCnTb1YGFs9ihEn5dYe4PDtxcIyrOeu7PSyH0
         NLyIpKJ4tAua7JmcCwS5Q8HoigByB1F98eNFJHexX3J7M0Boj7T4fXsvZrKWCyGPXxNz
         Jgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=96S2fyCwnO5jCulVGmko8MP9KCX2ee5EN88+HjU48Rg=;
        b=BTAmsanSb/TTqf3/mNGYujWIbh/O77WuSzQGXbU3hMmlUivxYZnPYFASuCT1hCCifC
         eS8pdeJxb3oQmiHf4f8rCz9sWod5pGCKFYsfmSgtfQXzsiYQLsQTe8emQ3JEhS3c5O5e
         azo4GAURSmHsbkkXzgD2zLXm22Fxc/3xNg2jwQlloTYGHDIKzJ+zUcwV6U007QYKrr0h
         Mhb+Tq3tqQ+AdaPtunA4SSQ5ormK2/WmHGcNYoC7rSlOH7MmeDiaWyif2L5LlsDifgRd
         yPuNHkUIMsLyd/iOZtMCqx2bxOPK+8MKGoDwfYq52a/F69sVC3y1d9tS2SzyvAbQftUO
         NElQ==
X-Gm-Message-State: AOAM533WDGEhCxXiaIR4R8YOXVSzOj/UQZ0ia493X+ROTCkC5g2WBtZJ
        EViZiIWvSHZdYEo8wDJDRLOdOA==
X-Google-Smtp-Source: ABdhPJydYo6ciBCCbIhLTRCkFEu/Rwx2WGVfCABYeKC2M4EKPPOfYYLmlHbUOVtfkZSKN+kGJuzIQA==
X-Received: by 2002:a63:4451:: with SMTP id t17mr9620534pgk.92.1598447651834;
        Wed, 26 Aug 2020 06:14:11 -0700 (PDT)
Received: from [10.8.0.34] ([89.187.161.160])
        by smtp.gmail.com with ESMTPSA id o16sm3226483pfu.188.2020.08.26.06.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 06:14:10 -0700 (PDT)
Subject: Re: [PATCH] rnbd: Fix an error code in process_rdma()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200826113242.GC393664@mwanda>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <85d5a2a9-a304-a32e-1bfd-143f42cd0b50@cloud.ionos.com>
Date:   Wed, 26 Aug 2020 15:13:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826113242.GC393664@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/26/20 13:32, Dan Carpenter wrote:
> The error code is uninitialized on this error path.
>
> Fixes: 735d77d4fd28 ("rnbd: remove rnbd_dev_submit_io")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/block/rnbd/rnbd-srv.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 0fb94843a495..5b69bc56b225 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -149,6 +149,7 @@ static int process_rdma(struct rtrs_srv *sess,
>   	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
>   		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
> +		err = PTR_ERR(bio);
>   		goto sess_dev_put;
>   	}
>   

Thanks for the fix, Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Guoqing
