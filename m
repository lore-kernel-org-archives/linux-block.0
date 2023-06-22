Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D893FEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjFVSrY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 14:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjFVSrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 14:47:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D74026AA
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 11:47:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a1a0e5c0ddso179233b6e.1
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687459626; x=1690051626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iVNPni4QP/CUuDhXuczwXGJMqdDHX8NJGBDa3laWrgM=;
        b=TPHuwuc406XQlhBAocBecYiAvoGqVNleE3ztd2v02nPxZmjXvgm3/sGtCHVfvqZKsJ
         z/xoV4I3ekvrSxcRGdnP0IzsM4NI8PJ+X3XlPRTW0uSZ/12x4DinVxN0viZQCT0y39mL
         1rxred6/Ya/ozh4plaM2hZQw4GgFslUCZzeCtwmRvpAl5rQEdVSUOJJbs1LXzyn8B+rM
         EZCP0HHTotQf9itgo+xsbNkvZXYLYFlVvtpeqzXdHAmPo5bWlFv1g73udFhPsNME3K+R
         OpQZHp454ASGbSbvU0KeIFZ3U0kb1MsyfpGjgv2UE9WdAPxzqdOtbZ8I4pBnwgSbFjKv
         zT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459626; x=1690051626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVNPni4QP/CUuDhXuczwXGJMqdDHX8NJGBDa3laWrgM=;
        b=F+VuP4nYOZVow49jcocqpEbaVIHC/SE7EVNlaB6X6rsWAPHIVsdkwtfxaKvpk5j48J
         skobdrGnvvRgdRQ6Sz/MgMc4SM0zWFGBbPYhfSDLAno05IDSHQCMsidUor2mG5uVFQkz
         hEF9KGAzdt+j/SNa9vhtyoTdcmztDwU4JQLiPG/CKn8UNu4A//Vm8Y8rq9kGtgy4d7Rf
         221Rn4fzD4gty33R+WtnQAc2qRJXIbaJrluEYe5Mxzupl830TXrxzbqq8WEhVrIGGAjt
         TvzFOubyf4WCWCj/9OxtIX42KDx2S4NVJxLVvA92cXo7JMejCp6Y8UjrjzX33fGbthB/
         LeMw==
X-Gm-Message-State: AC+VfDzqC//hWIqOlm97m2sFP1m0WpWSOTi38df9hEHPARdRI6NgL5QG
        TqpBrk2gxHdrNCqR7SLnC7wBppmnR4E=
X-Google-Smtp-Source: ACHHUZ7lPrpAE21ldErbzGaEbzlaTcZwFy7TnKL8AjoaEnQyFSTRFZkz0qk1VMYapXs3QiDhcNRJBg==
X-Received: by 2002:a05:6808:24b:b0:3a0:83b6:975b with SMTP id m11-20020a056808024b00b003a083b6975bmr1340594oie.48.1687459626608;
        Thu, 22 Jun 2023 11:47:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b00643355ff6a6sm5010127pfn.99.2023.06.22.11.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 11:47:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <10898b52-aadd-994f-0c62-ab0d85228f1a@roeck-us.net>
Date:   Thu, 22 Jun 2023 11:47:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block: don't return -EINVAL for not found names in
 devt_from_devname
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20230622150644.600327-1-hch@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230622150644.600327-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 08:06, Christoph Hellwig wrote:
> When we didn't find a device and didn't guess it might be a partition,
> it might still show up later, so don't disable rootwait for it by
> returning -EINVAL.
> 
> Fixes: 079caa35f786 ("init: clear root_wait on all invalid root= strings")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   block/early-lookup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/early-lookup.c b/block/early-lookup.c
> index a5be3c68ed079c..9e2d5a19de1b3b 100644
> --- a/block/early-lookup.c
> +++ b/block/early-lookup.c
> @@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>   	while (p > s && isdigit(p[-1]))
>   		p--;
>   	if (p == s || !*p || *p == '0')
> -		return -EINVAL;
> +		return -ENODEV;
>   
>   	/* try disk name without <part number> */
>   	part = simple_strtoul(p, NULL, 10);
> @@ -185,7 +185,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>   
>   	/* try disk name without p<part number> */
>   	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
> -		return -EINVAL;
> +		return -ENODEV;
>   	p[-1] = '\0';
>   	*devt = blk_lookup_devt(s, part);
>   	if (*devt)

