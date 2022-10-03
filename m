Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4A6C433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 10:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiJCKDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJCKDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 06:03:41 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F28C481FD
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 03:03:40 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id f11so13277213wrm.6
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 03:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vETVOxbVj5KMETJrBODFj1FK7i7Pqa11nIJtNzfOqzg=;
        b=Ckttqsj52+Q8e5TSJFxH0V6Hxq/d1HSNc3QxOqWGCwS3DafwRBQYuUjfpGR7xDgI29
         HYJoQr6b9usAWfsM99kkYlC0C0b5cWcDRHm14NWAK3DqYvjloyogy6uqWXwo0oE6FJmE
         L+I36z8tvYCawfFKOqUx/2PE9O2n65q4jqBZTR17e0EB05TNSi1XzlzY0UhcmxyEE1R/
         CLnrw/dP/nK+zQXaluD7V8HZhlstGdhC6kY/QWW3/rageGGplBLNWWFRwskwQuYJsekJ
         DzMfeMKajJPsYfvSLMJWNfKJlRo6TkOkAzlhx377wfJwNsi0plTGziwEaShdsBwLoHW3
         ZUMA==
X-Gm-Message-State: ACrzQf0NNO4mkYPIpjJXoQeUgOGFzZ8/qxH84iOep9u97wtK3rIWWjTE
        891ap0tQFxvtnJFyIjKUQ6s=
X-Google-Smtp-Source: AMsMyM5eZILQIUOYFtClQfwBAG4J2FWi0gFye4Ur0Ekk3KjVGTcLrMcJxjPsQxOA77bcw26ps8IfBw==
X-Received: by 2002:adf:b64b:0:b0:22e:32e6:6ea7 with SMTP id i11-20020adfb64b000000b0022e32e66ea7mr4817222wre.686.1664791418723;
        Mon, 03 Oct 2022 03:03:38 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg29-20020a05600c3c9d00b003b47a99d928sm12441631wmb.18.2022.10.03.03.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 03:03:38 -0700 (PDT)
Message-ID: <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me>
Date:   Mon, 3 Oct 2022 13:03:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org
Cc:     oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221002082851.13222-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> This makes the code more readable.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> Changes from v1:
>   - remove comments (Sagi/Keith)
>   - use tabs for constants alignment, similar to 'enum pr_type' (Keith)
> ---
>   drivers/nvme/host/core.c | 12 ++++++------
>   include/linux/nvme.h     |  9 +++++++++
>   2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3f1a7dc2a2a3..50668e1bd9f1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2068,17 +2068,17 @@ static char nvme_pr_type(enum pr_type type)
>   {
>   	switch (type) {
>   	case PR_WRITE_EXCLUSIVE:
> -		return 1;
> +		return NVME_PR_WRITE_EXCLUSIVE;
>   	case PR_EXCLUSIVE_ACCESS:
> -		return 2;
> +		return NVME_PR_EXCLUSIVE_ACCESS;
>   	case PR_WRITE_EXCLUSIVE_REG_ONLY:
> -		return 3;
> +		return NVME_PR_WRITE_EXCLUSIVE_REG_ONLY;
>   	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
> -		return 4;
> +		return NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY;
>   	case PR_WRITE_EXCLUSIVE_ALL_REGS:
> -		return 5;
> +		return NVME_PR_WRITE_EXCLUSIVE_ALL_REGS;
>   	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
> -		return 6;
> +		return NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS;
>   	default:
>   		return 0;
>   	}
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index ae53d74f3696..4f777d8621a7 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -238,6 +238,15 @@ enum {
>   	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
>   };
>   
> +enum {

I'd make this named nvme_pr_type
