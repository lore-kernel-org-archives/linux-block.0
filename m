Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6367C433DF
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 04:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7B9206B5
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 04:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgHTEa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:30:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45060 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHTEa2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 00:30:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id z18so729369wrm.12
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 21:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1a1+7otDaTJz5KXKmossaZSX1hzkhNhAN/X/8U5gyvU=;
        b=A7sUcZqDl9q5h9WL3S+MaNn3kOjNu1IECNbBf9qVE6rACW7CKU1cl0Mb8NMFh428ei
         jvTrWkOCfEI/qA4ErzxHRxQfS1NgFWFbF8zv/OLn1K7AjaztZYr5Bm2ey5YIfQ7yFXp7
         TTKvsI8e/BQv6pfzDlEfxbuFUSWswyeHxmdlTSOx0OfKPwRinlvOcJggp8kd5uvJPsLP
         gOWVXuQ8VLqxYR/lajhl/duM5Ut+ESFD8SKkgyyzdbKG1KaADylTbZhrQb6Y1qp1DPY4
         hlKrFFt656Tnh+XuE3gY7HVD53DTPEVEptHf/cUr1U8DJYCM2FgaP6HHyH+Oeh6i2ACK
         cxqw==
X-Gm-Message-State: AOAM531cJG4S4pTK5ZrGInlOxzBUadgEIHA189yFwsJ1QTE8HumPSM++
        CuYDxSoB9qsaxjwnOVP4XiQ=
X-Google-Smtp-Source: ABdhPJxIbEBC+ER++Pop3ryb6BEwbAoJbZ9qIj2L5hkIGDARNzfBKBku6NiAMboqqNK28wizBhBwEQ==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr1165135wrw.365.1597897826211;
        Wed, 19 Aug 2020 21:30:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3? ([2601:647:4802:9070:7ced:8569:4373:1bd3])
        by smtp.gmail.com with ESMTPSA id i6sm1536213wrp.92.2020.08.19.21.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 21:30:25 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
References: <20200820035413.1790-1-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
Date:   Wed, 19 Aug 2020 21:30:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820035413.1790-1-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 74f76aa78b02..f4c347fe925a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1422,21 +1422,25 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
>   	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
>   
> -static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> +static int nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
>   	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
>   	int status;
>   
>   	if (!supported_aens)
> -		return;
> +		return 0;
>   
>   	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
>   			NULL, 0, &result);
> -	if (status)
> +	if (status) {
>   		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
>   			 supported_aens);
> +		if (status < 0)
> +			return status;

Why do you need to check status < 0, you need to fail it regardless.
