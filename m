Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 11:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiD0Lde (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiD0Ldd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 07:33:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3438191
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 04:30:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h12so1267905plf.12
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWsO9zYE+6z8Bu+J+RVWchJHdOi/jTER00tosQL2T9k=;
        b=fBiMUHL+/89DWKYwG6EjwyvTpwpWmS2S7Tq9KPIVm3Z1+65DIF65PsvxA6GBg6lX5E
         7RqX1vmosklEYI8VFjNF3/0b1d/zOlXrobjGn6xntCUrbhi3bpISDovDrxsTNVsPnogN
         2t5yfG+UyyZROV8h3L/dReZNbNN7kRmw32Q+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWsO9zYE+6z8Bu+J+RVWchJHdOi/jTER00tosQL2T9k=;
        b=B0tXJ1mIzrLdXVLJPxA0u8tyXj0jjKAZGrabWdMNzAXUUV1PsAIYLs2dd3McUdXhw1
         9M+nzwNxB1T2O0vt5nSrxXinjQw1WiP6PMj4natfmPgBBF7/lhGvq9FB09xQ+RznLLrl
         3BvOAMykoU/03RCJyjOBeHZyxLd93ZOnSRfO04G6tUm180VMxhBB7R32Y/sclfqgwGAV
         ZAEnMmH/j0gF2NXV1Bw6jgKTIC0FbTJQPoMj0Ey7l0qRrPGTz+6ZYzcMcTIMz1oE/glm
         mxzbCI/Oz7Z0Zp+2p/QChYm8knGXPE622i8JMdE7GCP0y86wLXwdtijy+O+oZ4FXpgL2
         0u/Q==
X-Gm-Message-State: AOAM531fJJXSjINMobXncdteSQ6oD+qQl8Rzmo2z4otu+DglCFJIFZ1d
        YOPyldWsejXXg5Dcn2hI4yECGA==
X-Google-Smtp-Source: ABdhPJxgII3YJrlgmRBlb+I6g1YyWPWr0arhPXRxwA6t0ftRB36wF6qpxWbiq+09MhjzTFZc/4cGUA==
X-Received: by 2002:a17:903:32d2:b0:15d:57c7:9eef with SMTP id i18-20020a17090332d200b0015d57c79eefmr1916051plr.2.1651059022158;
        Wed, 27 Apr 2022 04:30:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e2d:263:26e7:c039])
        by smtp.gmail.com with ESMTPSA id d14-20020a62f80e000000b0050d2671b11bsm14355030pfh.53.2022.04.27.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 04:30:21 -0700 (PDT)
Date:   Wed, 27 Apr 2022 20:30:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org, axboe@chromium.org,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        mnitenko@gmail.com, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v2] zram: remove double compression logic
Message-ID: <YmkpSC/gJf7Cg2Ym@google.com>
References: <20220427100345.29461-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427100345.29461-1-avromanov@sberdevices.ru>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/04/27 13:03), Alexey Romanov wrote:
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index cb253d80d72b..4be6caf43b1d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1153,9 +1153,8 @@ static ssize_t debug_stat_show(struct device *dev,
>  
>  	down_read(&zram->init_lock);
>  	ret = scnprintf(buf, PAGE_SIZE,
> -			"version: %d\n%8llu %8llu\n",
> +			"version: %d\n%8llu\n",
>  			version,
> -			(u64)atomic64_read(&zram->stats.writestall),
>  			(u64)atomic64_read(&zram->stats.miss_free));
>  	up_read(&zram->init_lock);

I think this also has to bump `version` to 2, since format of the
file has changed.
