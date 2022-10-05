Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56805C4332F
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 17:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJERS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJERSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 13:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B764B9BB
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664990316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EQGZeMMosYwUdiU0OrsifprAdKF8zlo/1AkIo/J/cWU=;
        b=CQC02lrzZJLtnIDXu608v/TiWvqFKwNv+ehEioMnW1D062Tvn8/nJBtuZn/4kf8kjfmG8I
        Q7loWStUNmk7AGZ+4RnyMJvXTB6vtxSFk9ZmT1n7ZcvV6weGoH2oRmVqQ2vw9afDiwfLQR
        390VIELFQiwV2btbRQZVFH8cm3+azic=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-tra22_f7MNeaIymcQWGoRA-1; Wed, 05 Oct 2022 13:18:35 -0400
X-MC-Unique: tra22_f7MNeaIymcQWGoRA-1
Received: by mail-qt1-f199.google.com with SMTP id n16-20020ac85b50000000b0035ce9e26eb1so11547754qtw.8
        for <linux-block@vger.kernel.org>; Wed, 05 Oct 2022 10:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EQGZeMMosYwUdiU0OrsifprAdKF8zlo/1AkIo/J/cWU=;
        b=ovVigkAfH4HO9mpDiny6BnkiaafrHTUxRelJtAxuIbvfr2G3doBl0mPhbA1P2w08FD
         PIihr7Kw+zGFCGhXTxgZYtcBM8E4DQ+IPSvk2bAOVQDYk5xpHIlMo2lS+RHjha1G/jx9
         C9SRYL02dMGGWMlPFvmN7+z6tBK6RKto2uCsDLPojwJfqQB/gL4CZmjYnFyLkIqR4XKM
         C5mkEn5govH+nFKZZO0PN9V3LZDsgFIQv/vIavFeGdMRskZZRRh08jwb6D5Ix1+ksh61
         5sji6lqoxeyGgVfuAxMO17laqNlEe7wz2qdVdm2S+blzEOWADBFnGeo2HvjNSGnQTKrP
         hsRw==
X-Gm-Message-State: ACrzQf20+GKwfpK0aKkE1AIITmLKBZEO8nzt2ycBQs5GYrkuNAK3TAy3
        hwSqSPpaYR3HAEahaaibzOiHPYZHslWGYYdBf7XysoL7bP5YnZzG8NhP5sXLTdrLFTXDR/eQgbm
        8lt0FiKmK3G7Lpyw+Wgxe6N0=
X-Received: by 2002:a05:620a:2a02:b0:6ce:90fb:51b8 with SMTP id o2-20020a05620a2a0200b006ce90fb51b8mr486806qkp.460.1664990314785;
        Wed, 05 Oct 2022 10:18:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7aP3yRogasFXufFvt47NK7C57mBsP2uou9HRoFvjEEhQfi2tAKg2wbRInBFvXH0icM++ahPA==
X-Received: by 2002:a05:620a:2a02:b0:6ce:90fb:51b8 with SMTP id o2-20020a05620a2a0200b006ce90fb51b8mr486784qkp.460.1664990314537;
        Wed, 05 Oct 2022 10:18:34 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id x6-20020a37ae06000000b006b9c9b7db8bsm16665351qke.82.2022.10.05.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:18:34 -0700 (PDT)
Date:   Wed, 5 Oct 2022 13:18:32 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/6] null_blk: allow write zeores on membacked
Message-ID: <Yz28aEOOUqrCUhe2@bfoster>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005031701.79077-3-kch@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 04, 2022 at 08:16:57PM -0700, Chaitanya Kulkarni wrote:
> Add a helper functions to enable the REQ_OP_WRITE_ZEROES operations
> when null_blk is configured with the membacked mode.
> 
> Since write-zeroes is a non-trivial I/O operation we need this to
> add a blktest so we can test the non-trivial I/O path from the
> application to the block layer.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 46 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index fc3e883f7b84..2d592b4eb815 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
...
> @@ -875,6 +877,24 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
>  	}
>  }
>  
> +static void null_zero_sector(struct nullb_device *d, sector_t sect,
> +			     sector_t nr_sects, bool cache)
> +{

Any reason to not just pass the tree root directly here instead of the
cache boolean? It might make the callers more readable and also
eliminates the need to pass the nullb_device.

Brian

> +	struct radix_tree_root *root = cache ? &d->cache : &d->data;
> +	struct nullb_page *t_page;
> +	unsigned int offset;
> +	void *dest;
> +
> +	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
> +	if (!t_page)
> +		return;
> +
> +	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
> +	dest = kmap_atomic(t_page->page);
> +	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
> +	kunmap_atomic(dest);
> +}
> +
>  static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
>  	struct nullb_page *t_page, bool is_cache)
>  {
...

