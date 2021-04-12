Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3A5C070DF
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937726120F
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhDLJb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbhDLJXd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:23:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA1C061370
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:21:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sd23so10428952ejb.12
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9IOKrWU95ZRvfpZkdKwDcDDphdVloJpayno+OPrGl0o=;
        b=1Kwmi+Sysa4wTvMX/yMtXBTGFMX+5BuGhNDc3YEn9ZxRL9s2wAtLRKVxJ41WkCTR6i
         Aq7H/lKBfPsTGmc/KHKSDUcOUJimh/sGEe+PpauMLQlVPkEpr7XsPntGW9oSiM+l3KQo
         aZ3DNuUBXrklUVtVp3anwnk67i4bS785DM/yZTQ2JeRrSfcM5xDiWQsXNYRJE+OLLFXn
         gjSFR18CZgHTfZPpbFI2X+Y2zUHddXYftPcLQSpLI9UuYl7LOKr054D8RormsMq8ilFb
         Xi/qIhbqJangsJqOehcgd/Z8xBdWk9aJJL7CKNe16qTJCpn6FYBJeHuWJ4JeH9OprKEo
         SAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9IOKrWU95ZRvfpZkdKwDcDDphdVloJpayno+OPrGl0o=;
        b=lnYKGdLUisGGzHD/NH49eQslAkbItc93xXottEYL4WhocbOro/+p19giMjszjW54cP
         C8m5S6RzCzZvixtOyZtpymebUOvQk85Z6SDSZ/lPO5hOWENUucXEu3ohmBxEWmMYGg8V
         CZKFD1ocmwBuLRnk7zHvhcKM56Zl6fHEfFHm0XOp65DtkL5aleZaS5KCdKkIJnqufyhk
         ZlBBeW4DhDFwreJ6TW6NjAxg6CUuOdrgoo9JIqAfv4FEhM4QiYRIwLFrgHZqxlNi3mS+
         hMidSovg4TZsP7brVi8jXNHFy9ShWAu7KY/QyRpsSGPnP0UkjAZ9rxchd+Xwyk/bUrY/
         Fvmw==
X-Gm-Message-State: AOAM531CVD71bML/9ItDuORsKIpT6b2UBWO1E+kLPmCkwU3eGKjFj2in
        F3kP09hb+4/xsZ3jS9RnFH9UuSqhLpVT/g==
X-Google-Smtp-Source: ABdhPJxDJZRN7yFZ+iKwftAwM78EABKNXzHa+3YcKieF41T0TBFMlXCOhhvAqL+84VIMKqdL7arhyg==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr10915856ejd.278.1618219272605;
        Mon, 12 Apr 2021 02:21:12 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id p2sm5255857ejo.108.2021.04.12.02.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 02:21:12 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210412081257.2585860-1-hch@lst.de>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
Date:   Mon, 12 Apr 2021 11:21:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210412081257.2585860-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/04/2021 10.12, Christoph Hellwig wrote:
> Lightnvm was an innovative idea to expose more low-level control over SSDs.
> But it failed to get properly standardized and remains a non-standarized
> extension to NVMe that requires vendor specific quirks for a few now mostly
> obsolete SSD devices.  The standardized ZNS command set for NVMe has take
> over a lot of the approaches and allows for fully standardized operation.
>
> Remove the Linux code to support open channel SSDs as the few production
> deployments of the above mentioned SSDs are using userspace driver stacks
> instead of the fairly limited Linux support.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/lightnvm/Kconfig | 4 +++-
>   drivers/lightnvm/core.c  | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index 4c2ce210c1237d..04caa0f2d445c7 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,7 +4,7 @@
>   #
>   
>   menuconfig NVM
> -	bool "Open-Channel SSD target support"
> +	bool "Open-Channel SSD target support (DEPRECATED)"
>   	depends on BLOCK
>   	help
>   	  Say Y here to get to enable Open-channel SSDs.
> @@ -15,6 +15,8 @@ menuconfig NVM
>   	  If you say N, all options in this submenu will be skipped and disabled
>   	  only do this if you know what you are doing.
>   
> +	  This code is deprecated and will be removed in Linux 5.15.
> +
>   if NVM
>   
>   config NVM_PBLK
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 28ddcaa5358b14..4394f47c81296a 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
>   {
>   	int ret, exp_pool_size;
>   
> +	pr_warn_once("lightnvm support is deprecated and will be removed in Linux 5.15.\n");
> +
>   	if (!dev->q || !dev->ops) {
>   		kref_put(&dev->ref, nvm_free);
>   		return -EINVAL;

Thanks, Christoph.

I'll send it to Jens with today's lightnvm PR.
