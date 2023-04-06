Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2565C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDFVKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjDFVKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:10:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE18A5B
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:10:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso44089322pjb.3
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9USIm4vRATJtNvelamL7s61OhS1/8dBSps7mpF/Qe7A=;
        b=o45/2hCHQov7ZdDPOhe2vFAI6+yLU1aoXb02kmFRNMJh0yA1KXp9CBH3fYCqJ4i2wc
         Qp1iaMZ5PUUYFCBD/DDolUJm2tsP9owtxcIAI9URSze+B2TI0E32EsyhTqrIlDW0wDW4
         z1ScmSkbSnMZhQ4hWQxipAAjPgZoX0lZ5MDjfVr2wv7r6FuUqQYtSAf3sG6ptTBX+fLM
         U0pcECsPmnkCn60GSLSvZTPL6Y42POIMlJXQWbuMhz8bZ/h41tcXl12PAbzI0F9uFk1z
         MNXZIpRxUSWNyLtGA+gpdXjyhWDTM069TFJN6aSJ7KTmRFkxEV6LJ2q3xPb9R427En4W
         rpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9USIm4vRATJtNvelamL7s61OhS1/8dBSps7mpF/Qe7A=;
        b=4nmpdf/za6fgMxg+Pja928pFaMGDCTdhpoudGZnW7eq/g4iDK0YPdqjYCV5bAJQMqr
         V0NPQ3NoNB8bHD0iJZH4L+U+bnmwASlZN+/ETKN9ruhnxAQXBPW8C9+phvF6dEEVnq1T
         3biucCydm7tXaaW5Lp19ugcaYRn/GqEgdXGskaJ2LfpKziphvHo9L57C+mk/9wBTJ9rJ
         FSl+CixxdCG4JzxUJMQtgg1wYmLnJ9nECSlO7TbGeJCofHDecH1BXJAth/yqO+xf+vub
         ijDsWS541ZHLiSgEudx5HqpPGvBypaZieQay+nsipYLCQCBGwdA1NaqJOwHShqQio7ac
         ltCA==
X-Gm-Message-State: AAQBX9ftUtPoFp96m3lm1kECF0sYJMk+TOB6CQVvNMjpv2cEybL/v3/2
        HDT53nq7+7dw7rclI7GMLIg=
X-Google-Smtp-Source: AKy350aT/DSvcP2ZehWLuoxClkJ9hzw1LEueY9LsYpHU9OdDMrxTG69gxFxlkPURWd40Od3tyGw+sQ==
X-Received: by 2002:a17:90b:1d8b:b0:23a:5f51:6ee5 with SMTP id pf11-20020a17090b1d8b00b0023a5f516ee5mr13287124pjb.12.1680815410815;
        Thu, 06 Apr 2023 14:10:10 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id z20-20020a17090ab11400b0023670dbb82fsm1564166pjq.25.2023.04.06.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:10:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:10:07 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/16] zram: remove valid_io_request
Message-ID: <ZC81LyKt+QS18LzT@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:47PM +0200, Christoph Hellwig wrote:
> All bios hande to drivers from the block layer are checked against the
> device size and for logical block alignment already (and have been since
> long before zram was merged), so don't duplicate those checks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 34 +---------------------------------
>  drivers/block/zram/zram_drv.h |  1 -
>  2 files changed, 1 insertion(+), 34 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index aa490da3cef233..0c6b3ba2970b5f 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -174,30 +174,6 @@ static inline u32 zram_get_priority(struct zram *zram, u32 index)
>  	return prio & ZRAM_COMP_PRIORITY_MASK;
>  }
>  
> -/*
> - * Check if request is within bounds and aligned on zram logical blocks.
> - */
> -static inline bool valid_io_request(struct zram *zram,
> -		sector_t start, unsigned int size)
> -{
> -	u64 end, bound;
> -
> -	/* unaligned request */
> -	if (unlikely(start & (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1)))
> -		return false;
> -	if (unlikely(size & (ZRAM_LOGICAL_BLOCK_SIZE - 1)))
> -		return false;
> -
> -	end = start + (size >> SECTOR_SHIFT);
> -	bound = zram->disksize >> SECTOR_SHIFT;
> -	/* out of range */
> -	if (unlikely(start >= bound || end > bound || start > end))
> -		return false;
> -
> -	/* I/O request is valid */
> -	return true;
> -}
> -
>  static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
>  {
>  	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
> @@ -1190,10 +1166,9 @@ static ssize_t io_stat_show(struct device *dev,
>  
>  	down_read(&zram->init_lock);
>  	ret = scnprintf(buf, PAGE_SIZE,
> -			"%8llu %8llu %8llu %8llu\n",
> +			"%8llu %8llu 0 %8llu\n",

Since it's sysfs, I don't think we could remove it at this moment.
Instead, just return always 0?
