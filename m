Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336AC4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 22:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE560FDA
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 22:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhHSWJR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 18:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229605AbhHSWJR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 18:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629410919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkspXG8hxbvDqLFevLus8MJ8WZKNmd5YtLC8hca/MbA=;
        b=G9ASgtTrDFcVncjYddArKifsJTOdxVnKttL+cY9CEAGFbS5vxNkUtJJqqpM8Q+L4aIM1MP
        q0gMuQYYeiA+FcJADts4LBUqgzTf/DDmhtXT/9w64LtxNWXwpV33rN/s+vwQyfiwqmvz4w
        /I4auP8/FVE1ycfMY+OWzPIXt9brz7Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-qdkyaQH1PiyvrnjaiNB76w-1; Thu, 19 Aug 2021 18:08:38 -0400
X-MC-Unique: qdkyaQH1PiyvrnjaiNB76w-1
Received: by mail-qk1-f197.google.com with SMTP id d20-20020a05620a1414b02903d24f3e6540so5195930qkj.7
        for <linux-block@vger.kernel.org>; Thu, 19 Aug 2021 15:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkspXG8hxbvDqLFevLus8MJ8WZKNmd5YtLC8hca/MbA=;
        b=unXWYcIUpRj+6Yrbo9K8UsoDlljYNpKc76JnnYndGgIjHXEvb8jbvG6aaLHnc+hhwi
         91GuaFKBJTD/T5gcCAAr2GCKAQCXDhVNGPTFwm3W9IkKOsf70Am5vwI+EVZllOlVsFVu
         2THEmqLmkhrS8YlWioL+WoqWXlMoFRHlS4/3+Xhqs/WoGIrDcUSqe1hlHId+hINHQi7J
         MUUOwJmEofH366RNook5SUwPTCx2VzIFbnrYZ6bLjS2hzInvD0LCwYOL8iWvkLUuNcsn
         CDqFMOfKUjHw70Vvm4nYMWYUsnlivHOeWo2eLs6ZhyW4HDb5VfEm70nPUDJ2UZeO/D8N
         G05Q==
X-Gm-Message-State: AOAM5330GLJunepoJOgGRVHAPbVlnaAshnKVN3uReSG8OCsjomDNEAEt
        Cvb6vJbbz6tDsyPch3r2MdKIRC9mI/X+sjYXqypkrKOy2Ns4P1LZNO82HEvuZHDpqWlSNWS352S
        +Zm3zkHBK5H5kw4irs+/G/g==
X-Received: by 2002:a05:6214:aa8:: with SMTP id ew8mr16900248qvb.43.1629410918166;
        Thu, 19 Aug 2021 15:08:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywm4rLEeaipm0n2jLzSiRC/vpgsoEKNvs8yaeY/GnmilqaKXYkZjRRVU1i4zcMh9j7mDyFlg==
X-Received: by 2002:a05:6214:aa8:: with SMTP id ew8mr16900225qvb.43.1629410917907;
        Thu, 19 Aug 2021 15:08:37 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s185sm2291159qkd.2.2021.08.19.15.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 15:08:37 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:08:36 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: Re: holders not working properly, regression [was: Re: use regular
 gendisk registration in device mapper v2]
Message-ID: <YR7WZEZgxw6hI369@redhat.com>
References: <20210804094147.459763-1-hch@lst.de>
 <YR5/wMEkr1TwV7FD@redhat.com>
 <20210819180559.GA14001@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819180559.GA14001@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19 2021 at  2:05P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Manually reverting "block: remove the extra kobject reference in
> bd_link_disk_holder" as show below fixed the issue for me.  I'll spend
> some more time tomorrow trying to fully understan the life time rules
> tomorrow before sending a patch, though.
> 
> ---
> From 6b94f5435900d23769db8d07ff47415aab4ac63e Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 19 Aug 2021 20:01:43 +0200
> Subject: Revert "block: remove the extra kobject reference in
>  bd_link_disk_holder"
> 
> This reverts commit fbd9a39542ecdd2ade55869c13856b2590db3df8.
> ---
>  block/holder.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/holder.c b/block/holder.c
> index 4568cc4f6827..ecbc6941e7d8 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -106,6 +106,12 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  	}
>  
>  	list_add(&holder->list, &disk->slave_bdevs);
> +	/*
> +	 * bdev could be deleted beneath us which would implicitly destroy
> +	 * the holder directory.  Hold on to it.
> +	 */
> +	kobject_get(bdev->bd_holder_dir);
> +
>  out_unlock:
>  	mutex_unlock(&disk->open_mutex);
>  	return ret;
> @@ -138,6 +144,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
>  		if (disk->slave_dir)
>  			__unlink_disk_holder(bdev, disk);
> +		kobject_put(bdev->bd_holder_dir);
>  		list_del_init(&holder->list);
>  		kfree(holder);
>  	}
> -- 
> 2.30.2
> 

OK, this fixed it for me too, thanks.

Mike

