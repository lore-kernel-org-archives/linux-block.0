Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCE0C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 18:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiI2SsC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiI2SsB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 14:48:01 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820B4B0F7
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 11:48:00 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a26so4644625ejc.4
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 11:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mza/eccPB742Mh5SYeGtuuzV3UVrHBhYB7Z24YUwANs=;
        b=DSPl7omUdAC0TDOqwyZXfq4VirChknli699XUP2d2gfXs+RTr5KUBUisjfwMLwCvSf
         2Wh9yV2uBLdOBAlswVa0VrXpuH2YvoxKSPM6c4yQSZM8snL76solSGYz67Afa1bY4FLn
         L6UBrAWyIFJM+uFt/xpQWORm88IrI0WUNFrP0BXCDawaevNpLbq+vud7L4M6doova7xg
         DKkDQj1BzMGk0xxeGB4heZLfybHx94M/WlEvdNh193N5sfvVb5gu37FM73xhHu/BBnuT
         +OHZXcuny6vAy6sS6uloijRTl9H0vBBi10ATdscMegLVa5Y73W1I+eb8D0KI9CTh4y4Q
         /AKg==
X-Gm-Message-State: ACrzQf0tyGt0cT97BTgYtpnnjugLMa5zx0GCZUbXW3HEpBfUrMRrn25z
        CxxcQzKcrQAeOnLzrlstSgQ=
X-Google-Smtp-Source: AMsMyM42WIDv6+dK6BBYfV0u0LNEy8A3cOeXw31bjX3QrF2GZP557N3knNHy99c6DT7D3eP06zsm+Q==
X-Received: by 2002:a17:907:762b:b0:771:5755:82b7 with SMTP id jy11-20020a170907762b00b00771575582b7mr3618734ejc.684.1664477278947;
        Thu, 29 Sep 2022 11:47:58 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7c154000000b004582a37889csm203820edp.16.2022.09.29.11.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 11:47:57 -0700 (PDT)
Message-ID: <a3b08c1b-b8d1-f3c8-71e5-59167eb3e58b@grimberg.me>
Date:   Thu, 29 Sep 2022 21:47:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] nvme: use macro definitions for setting reservation
 values
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org
Cc:     oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
References: <20220929115919.9906-1-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220929115919.9906-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> This makes the code more readable.

I find it readable as it is. But I don't particularly
care about it all that much.

> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 12 ++++++------
>   include/linux/nvme.h     | 12 ++++++++++++
>   2 files changed, 18 insertions(+), 6 deletions(-)
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
> index ae53d74f3696..a925be0056f2 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -238,6 +238,18 @@ enum {
>   	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
>   };
>   
> +/*
> + * Reservation Type Encoding
> + */
> +enum {
> +	NVME_PR_WRITE_EXCLUSIVE = 1, /* Write Exclusive Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS = 2, /* Exclusive Access Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_REG_ONLY = 3, /* Write Exclusive - Registrants Only Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY = 4, /* Exclusive Access - Registrants Only Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_ALL_REGS = 5, /* Write Exclusive - All Registrants Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS = 6, /* Exclusive Access - All Registrants Reservation */

The comments are unneeded, the enums themselves are
self-explanatory (and also mirror the pr_type enums themselves).
