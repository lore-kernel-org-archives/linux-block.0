Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F058C6FA8E
	for <linux-block@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBZQzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Feb 2023 11:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBZQzy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Feb 2023 11:55:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348F5BBB7;
        Sun, 26 Feb 2023 08:55:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p20so3181425plw.13;
        Sun, 26 Feb 2023 08:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMPivgJa9Oydx7VmSkBWz8cuJBhAofxxDmT7xZiRGT8=;
        b=YGFy8IrwraZ8VPbC+3pXv+6dmojn5DoM1MLgkBS6s4qQtrwOeHXBACjnod1Gw29N8n
         v0qmBVrA6mGM4mhinsGj/aienDuaaszJfR3o6//7RMPlp4k/0Cx8GavKNpa4QpkAJvUs
         EJpqeCzx6XNA/k5AYi1uM9L/NKfIJGhFntEVNRnME+nb/CtSU0lMmm7QQMzH8k4fo6IF
         O7hfZ0jr2PJy5KRTkWe/4S0Y3TVSFp4nWxgj2GeR5QVYZ5dxr4bRKE9ujxpyo5WmL8M1
         EQERtMjV7Y1MsM+NkeQ/bM2dG+dlnCq2o2RnBeitueq55OMtZionUNaaGvE53E6apL7S
         pOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMPivgJa9Oydx7VmSkBWz8cuJBhAofxxDmT7xZiRGT8=;
        b=USnvwyhrEKw2buqOYyPQkpcFIlDpjnF71tvWBHErpjDdfwr7dzox8jzU1pZIYXlWrS
         fd9tccdbwUKTbszcBDooGjlsp9M1KbhS/5XVjvKJgwrQFEJN9I/JHiN5wJ5hKP1Hf4/Z
         TjWMLIuVx1JP4cuLdWZlWEPwkO3XeA1yuYbgo5Ipo2hZkcN4O1cne/aHzYfhyBM6ASUI
         3uq967TT00LYhWmisAX3bIrohA2BfTpKDjxnliGr8/VfKkKurRVyYODEq1o63VyFXUCX
         SvjGQgyLDb/MWZbcAZN7U++myODu5CI2gQSMUFF7Y22KKorc/8Iu7KYgkoEQ8h8fqt9l
         SmQA==
X-Gm-Message-State: AO0yUKUcVhNUdumvKuo8s0wejzpUDgheoHm2tgTwa1qm9SclxvE2rot6
        bOpQDwLAWWC1R8GEi2+vxH5PmYS97M4=
X-Google-Smtp-Source: AK7set8H23ihMOCiEocAVfCGF7yK5FrAmQg18nlFbxnjnKm6GvcC5xS72+5cErLCleaJt3CBi7p9NA==
X-Received: by 2002:a17:90b:1b4e:b0:233:ee67:8eb3 with SMTP id nv14-20020a17090b1b4e00b00233ee678eb3mr25287083pjb.24.1677430552330;
        Sun, 26 Feb 2023 08:55:52 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a868900b002340b2c62e7sm4570080pjn.55.2023.02.26.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 08:55:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 26 Feb 2023 06:55:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, aherrmann@suse.de,
        linux-kernel@vger.kernel.org, hch@lst.de, leit@fb.com
Subject: Re: [PATCH] blk-iocost: initialize rqos before accessing it
Message-ID: <Y/uPFT7w+XQ9l0XE@slm.duckdns.org>
References: <20230224160714.172884-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224160714.172884-1-leitao@debian.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Breno.

On Fri, Feb 24, 2023 at 08:07:14AM -0800, Breno Leitao wrote:
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index ff534e9d92dc..6cced8a76e9c 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2878,11 +2878,6 @@ static int blk_iocost_init(struct gendisk *disk)
>  	atomic64_set(&ioc->cur_period, 0);
>  	atomic_set(&ioc->hweight_gen, 0);
>  
> -	spin_lock_irq(&ioc->lock);
> -	ioc->autop_idx = AUTOP_INVALID;
> -	ioc_refresh_params(ioc, true);
> -	spin_unlock_irq(&ioc->lock);
> -
>  	/*
>  	 * rqos must be added before activation to allow ioc_pd_init() to
>  	 * lookup the ioc from q. This means that the rqos methods may get
> @@ -2893,6 +2888,11 @@ static int blk_iocost_init(struct gendisk *disk)
>  	if (ret)
>  		goto err_free_ioc;
>  
> +	spin_lock_irq(&ioc->lock);
> +	ioc->autop_idx = AUTOP_INVALID;
> +	ioc_refresh_params(ioc, true);
> +	spin_unlock_irq(&ioc->lock);
> +

I'm a bit worried about registering the rqos before ioc_refresh_params() as
that initializes all the internal parameters and letting IOs flow through
without initializing them can lead to subtle issues. Can you please instead
explicitly pass @q into ioc_refresh_params() (and explain why we need it
passed explicitly in the function comment)?

Thanks.

-- 
tejun
