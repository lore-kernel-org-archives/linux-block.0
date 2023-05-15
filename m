Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E008C77B75
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbjEOI4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 04:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjEOI4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 04:56:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25971A4
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 01:56:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so93217435e9.1
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1684140982; x=1686732982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIIUctl1bRw1HpPNpep3ud00oldyhc4jZQaYE88JU2w=;
        b=AnVH/q8mwdjUB48br4+XKQZhQjKQbgNYSstHOvj2e3WeVlatZYBIVBfOHaBvjDENC1
         TJml1+sFf6+CtIzSrmfXqsLZJDS1OE4aTvDkKCnw1TO2UTKzEcW6wZB95U+Cbvqd4od0
         LrWFzo1i2ItrbWY+lyKP/mw+jaA5nqh/TQQhmUZKWUceiaQ4FmrxTa/kKw+6e45SCSJb
         YPeejohM0NMDtIoI8dQVnLRX6rxDT0RTPaxNq6y89LSilDHmC6/TGynFTuOHrCgX2vzW
         cRS+xGHoK0NfkPD3bqeOqTBEsDbMMo1SzPngAjOAQS8Yp2YFNn8WGb4OnGlfzbuoCC8l
         As+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684140982; x=1686732982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIIUctl1bRw1HpPNpep3ud00oldyhc4jZQaYE88JU2w=;
        b=gfy/WZZjt/WdidO+0NktCpDCwrdhI5zduNkNPjpEJ81oIRk0LK0wBDYr/b7GQnFspa
         ZoKkIG8U+28GOO9hMzeX1j0Orsp7U/OEtFaOYoNbbBBTOMz80Lzfq5uHJui0M9b8esmK
         HNMx0BFRdDsAn6QJb4kglz0eaI82E/FjbQFKLmD/QbVb7fPJf6MPPy/1WxFfCdwY+G0U
         nC7pPjZVfgkoyR8vHSLAiglFjdW4orp7cedb4+Bpufg1i6TUg3yDt2HyCzFde1KAvs3o
         e1UJ5SHD0ZlJonWHyUTn2sapzoUlEDx8eBkuZrH/QY+FiXH8HDbFgS7YNnq1c+lZ//JE
         so3A==
X-Gm-Message-State: AC+VfDz+iZkRBgKHeEIFgZEd0IyeEYAUkCGP9WVWdAETQz0J3IaLy350
        cnUBbIANW+4fhvSCaBCOfXiWFg==
X-Google-Smtp-Source: ACHHUZ7g13ecAkip6L71Cbnmd6HuFKLHUoFfhXcrcFhVn5Igf53uR9sVnUnT/BWKQcOuILeas2FNmg==
X-Received: by 2002:a05:600c:3797:b0:3f4:20ec:7601 with SMTP id o23-20020a05600c379700b003f420ec7601mr23758879wmr.34.1684140982066;
        Mon, 15 May 2023 01:56:22 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bca55000000b003f4285629casm20862789wml.42.2023.05.15.01.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 01:56:21 -0700 (PDT)
Message-ID: <2ec28ec3-1e22-e772-fc9a-d59c6d176b7d@linbit.com>
Date:   Mon, 15 May 2023 10:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] drdb: fix debugfs_create_dir and
 debugfs_create_symlink error handling
To:     mirimmad@outlook.com
Cc:     axboe@kernel.dk, drbd-dev@lists.linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mirimmad17@gmail.com,
        philipp.reisner@linbit.com, skhan@linuxfoundation.org
References: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
 <CY5PR12MB64558DB2E8ACBD592F26E61AC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <CY5PR12MB64558DB2E8ACBD592F26E61AC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 14.05.23 um 16:10 schrieb mirimmad@outlook.com:
> From: Immad Mir <mirimmad17@gmail.com>
> 
> debugfs_create_dir and debugfs_create_symlink return ERR_PTR incase of
> a failure which must be checked with the inline function IS_ERR. This
> patch attempts to do the same.
> 
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
> Changes in v2:
>     - Fix indentation
>     - Fix potential memory leak
> 
>  drivers/block/drbd/drbd_debugfs.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
> index 12460b584..ab431a3f2 100644
> --- a/drivers/block/drbd/drbd_debugfs.c
> +++ b/drivers/block/drbd/drbd_debugfs.c
> @@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *device)
> 
>  	snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
>  	dentry = debugfs_create_dir(vnr_buf, vols_dir);
> +    if (IS_ERR(dentry)) goto fail;
>  	device->debugfs_vol = dentry;
> 
>  	snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
> @@ -789,9 +790,15 @@ void drbd_debugfs_device_add(struct drbd_device *device)
>  	if (!slink_name)
>  		goto fail;
>  	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
> -	device->debugfs_minor = dentry;
> -	kfree(slink_name);
> -	slink_name = NULL;
> +    if (!IS_ERR(dentry)) {
> +        device->debugfs_minor = dentry;
> +        kfree(slink_name);
> +        slink_name = NULL;
> +    } else {
> +        kfree(slink_name);
> +        slink_name = NULL;
> +        goto fail;
> +    }
> 
>  #define DCF(name)	do {					\
>  	dentry = debugfs_create_file(#name, 0440,	\
> --
> 2.40.0
> 
> 

Hi, thanks for the patch.

Please see this commit:

commit d27e84a305980ac61df0a6841059d0eb09b8283d
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue Jun 18 17:45:49 2019 +0200

    block: drbd: no need to check return value of debugfs_create functions

    When calling debugfs functions, there is no need to ever check the
    return value.  The function can work or not, but the code logic should
    never do something different based on this.

Also, it still looks like that whitespace is garbled.

NAK.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
