Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD3C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbjDFVPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDFVPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:15:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A984C3A
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:15:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so38635107plg.4
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWZIJ2lfp17f9FeXpcz/JXGEDXThkOLkVWQss5qOmMM=;
        b=DLYlVumXGfWn06qDXtx8flrE1Jpi+EBYEvPwMHIMF5gjMrBodQ6IoltHoCne2gbsgG
         YZJiEb1p0Y16nmSwhDYjWc4QeF414WiahrwFhSH8RqerYAsLHWJyIkMrcVki3wMAaInD
         0zVAI20HkD77qldTQSo6h3U+IdMly8Pk7JPRJXA2Og1Sx6mNY0ISuWMnoIrQF/hLJJUt
         Yk+mz+DkYNMPYY7oq/OdoTzXffFN8lk0buAYxw1I/+qUR0ggws5YTyE6NeOw/viuRatb
         /YpDhjPwezM9SCjm4jsoe63SlTxAkOpF9L+oXTUGpi7+fvlZcpl5IOPmS3s+NO0csjsd
         MJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWZIJ2lfp17f9FeXpcz/JXGEDXThkOLkVWQss5qOmMM=;
        b=RYpI0VQVNlCnC2/fW8brDs0l+D68PumAunLS8anO1LE6vpn39/uN+AnJcdQMKYJbwW
         Q3lcqWsDV9ihS4bpCmvzbPnQyh3tcbnS9pFR1UWinQFAA+uH4P+q9EbdP2lRx5+NmkHP
         FJSdZZs/CEIIC7GGq0lFXqsIVV8hJ5dJMHu4eM2Q3muYgcvORl1JpmZNnBex7QH+tKqK
         mP4fRaz5Q8RDIyh16lGpmvURnb+zHLBrjlZYdkz3kAOiXYGDk18GHaR+g/ybvAgvVpX3
         zQp3mnVJSCu0NwpuN5pxKwiwZ84QeR1bzy+WK6kLOPHTO6/Wa8vd6zh0JjPWdszsoDAb
         cG4A==
X-Gm-Message-State: AAQBX9dRVhNPwu8wr/wjNXfvSrU5gk7FRm+g+mKnlg31INHh5O7FNpvs
        lUMXJDuaTOx1d5lcOUhd+gU=
X-Google-Smtp-Source: AKy350akAlijVTm7W8kQVwKfj7f7G57sRTWakoXkv6/94EtangMmJb2pVd5kmA15ZLOHj+/m3+WjbA==
X-Received: by 2002:a17:902:c402:b0:1a1:e308:a82e with SMTP id k2-20020a170902c40200b001a1e308a82emr10181109plk.12.1680815722155;
        Thu, 06 Apr 2023 14:15:22 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709027b8300b001a1ba37d06csm1804035pll.29.2023.04.06.14.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:15:21 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:15:19 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/16] zram: refactor highlevel read and write handling
Message-ID: <ZC82ZymogIbgt0jP@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:52PM +0200, Christoph Hellwig wrote:
> Instead of having an outer loop in __zram_make_request and then branch
> out for reads vs writes for each loop iteration in zram_bvec_rw, split
> the main handler into separat zram_bio_read and zram_bio_write handlers
> that also include the functionality formerly in zram_bvec_rw.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/zram/zram_drv.c | 58 ++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 0b8e49aa3be24b..5e823dcd1975c0 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1927,38 +1927,34 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
>  	bio_endio(bio);
>  }
>  
> -/*
> - * Returns errno if it has some problem. Otherwise return 0 or 1.
> - * Returns 0 if IO request was done synchronously
> - * Returns 1 if IO request was successfully submitted.
> - */

It was mess from rw_page. Thanks!

Acked-by: Minchan Kim <minchan@kernel.org>
