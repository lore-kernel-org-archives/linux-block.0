Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E60CCA47C
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 14:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiGLOeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiGLOd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 10:33:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9490CBA392
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 07:33:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso8190375pjj.5
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zwF8KM+QN1wrDkEu1y1myqZInsbYcwieQIeG//Czh5M=;
        b=YvAp9hap2BYWKUedYvYv1gLfcLHkjPGSrnu+ouiXvg1fz+w9UddQf3z+Jspw1C7UkN
         3Og/jjD9pDCij7aA0mCP6SZbFCJKliefl2wXnbbpJf63ChTVbAT19GktrSXv4M5rmy8E
         ET+Am8TGe1S5+J4POBPx2fjfAUqZb8AxwOxbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zwF8KM+QN1wrDkEu1y1myqZInsbYcwieQIeG//Czh5M=;
        b=6jnDnAL4+ZCKvnozqIsGIWfnk620CPKRh/DPCM7DV/iukaH3SSOggUTCwhBxDiSQy4
         GJ2fFlw17iBWzSEMc1RcNOO2kgeuaPpHaGcIFtMxZQ05N63op/EeQ986g//Re1wM++Gb
         HHHwVurMnbyW8Q2WXILHP7I7zYHBPNPhTXhFFXSyVd38x0ugq+WuJy7E6Gpa3BYiIJyE
         OWx0fWvdbSmP4pjAld8RJHcKIsEF8q2UEJYHdmOGB4ON74zZFneSRTpFFhXFEQ5srTDL
         ixYh4RtdzEfGj3E1oq/OP+Api2qBTmvJWCCAObdggLkatIHSd61C+hIWUoGTVEZksd3p
         APYw==
X-Gm-Message-State: AJIora/N1tiERpY9/4G3HPdaG4gvv1PND9mruyDfpqAT5YYFIMUmosVd
        cajUe8j2CJk/Rje1b2kvOET/UA==
X-Google-Smtp-Source: AGRyM1vFALT/kH4MpQ9lXXSKLlwZModCE+ymj2gXl0DE2+g39x4/69CMi73CAf4DAs8nYrZL+EMYjA==
X-Received: by 2002:a17:902:f785:b0:16a:4f3b:a20c with SMTP id q5-20020a170902f78500b0016a4f3ba20cmr24811436pln.118.1657636386137;
        Tue, 12 Jul 2022 07:33:06 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:695c:b409:1af4:f672])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79d09000000b005251c6fbd0csm6900113pfp.29.2022.07.12.07.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:33:05 -0700 (PDT)
Date:   Tue, 12 Jul 2022 23:33:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix unused 'zram_wb_devops' warning
Message-ID: <Ys2GHQkhAqdGqOlx@google.com>
References: <20220608072534.68850-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608072534.68850-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Andrew

Message ID: 20220608072534.68850-1-wangkefeng.wang@huawei.com

On (22/06/08 15:25), Kefeng Wang wrote:
> drivers/block/zram/zram_drv.c:55:45: warning: 'zram_wb_devops' defined but not used [-Wunused-const-variable=]
> 
> Fix the above warning if CONFIG_ZRAM_WRITEBACK not enabled.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/block/zram/zram_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 39cd1397ed3b..fff5eb4d3f20 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -52,7 +52,9 @@ static unsigned int num_devices = 1;
>  static size_t huge_class_size;
>  
>  static const struct block_device_operations zram_devops;
> +#ifdef CONFIG_ZRAM_WRITEBACK
>  static const struct block_device_operations zram_wb_devops;
> +#endif
>  
>  static void zram_free_page(struct zram *zram, size_t index);
>  static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
