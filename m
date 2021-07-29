Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC94C4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C851660EFD
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhG2Q1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhG2Q1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 12:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627576036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEOBn01l7YnL6KGZRxsv0+siSG/m90sijpHh9E6Gd6k=;
        b=WHwksyeqOxWg94uhEMbzxEuBt3e9oliQ4+h5IyZPkQNH/AOE5ULczGmAry8ut01SU6egtO
        nfWT4ldSej18/TbW9cTgU0aCzicMXRs67VnuDm+QeNkshAg8KjjABCoWOX4wCWEFxrcv95
        Jd+nMfRJAuKheaVTeYoLFE0i9Z1K0pw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-w7sXy0GdMOiP_SgEJcWVKg-1; Thu, 29 Jul 2021 12:27:13 -0400
X-MC-Unique: w7sXy0GdMOiP_SgEJcWVKg-1
Received: by mail-qk1-f198.google.com with SMTP id w26-20020a05620a129ab02903b9eeb8b45dso4115530qki.8
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 09:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uEOBn01l7YnL6KGZRxsv0+siSG/m90sijpHh9E6Gd6k=;
        b=Nv2R4yfrwnKQDufE8XR8anRdG1WkJ8XRlYNI8D0tCu3IIJrXnLKTzpjbg7O1tBZFoT
         TbJL50qSbx2sjI94fWxHVyrEaszs7v5oG/dIz6V4VWBnPvxYGWF6XPo3dUwTwMD4wlES
         QC1YaN6ygmt5BBlftENIA1ydp7dxwxVp9Mw4lV1fsnyJb0YRRmt9S4UXQMk74CAHE1Ja
         a8YImDjlrksDE9EGvfgGSpO21+irZXIoa9Vj36jMsv5vWFOclZpW1/UyyZegVqc5r3/U
         lsbLIFsXtkm3mDaaPqkevJHrLXPGBDZlZfhBc+kqbg4KYbwi+RLZfJ0p3aqAo0ZwOD1U
         o4CA==
X-Gm-Message-State: AOAM532kmZqBCJdZWtm3B9B/D89CAtOxQIlMJUtBjijK26TN8Q4RXYPW
        4q5i4zuBqXQEcSuxwCOsEPxbsV9/nQLDpd/xShZtyhhoVTcY4qrL+Pk33tiNtGbK3dNIwugDfS7
        wzLzhMfwRnQpBA6pMhMKozw==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr6091397qvi.44.1627576033083;
        Thu, 29 Jul 2021 09:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF8lgU56Uj/RtYaTxheN50E/rxtVxZjsC/RZqw2WziWfxzdVJFRLWU0fwkN4K3N6/JjEI52A==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr6091376qvi.44.1627576032905;
        Thu, 29 Jul 2021 09:27:12 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d129sm1991921qkf.136.2021.07.29.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:27:12 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:27:11 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] block: remove the extra kobject reference in
 bd_link_disk_holder
Message-ID: <YQLW30arkuTQkKkJ@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <20210725055458.29008-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> With the new block_device life time rules there is no way for the
> bdev to go away as long as there is a holder, so remove these.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Might be useful to reference the primary commit that introduced "the
new block_device life time rules" just so readers can inform
themselves.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

> ---
>  block/holder.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/block/holder.c b/block/holder.c
> index 904a1dcd5c12..960654a71342 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -92,11 +92,6 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
>  	if (ret)
>  		goto out_del;
> -	/*
> -	 * bdev could be deleted beneath us which would implicitly destroy
> -	 * the holder directory.  Hold on to it.
> -	 */
> -	kobject_get(bdev->bd_holder_dir);
>  
>  	list_add(&holder->list, &bdev->bd_holder_disks);
>  	goto out_unlock;
> @@ -130,7 +125,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
>  		del_symlink(disk->slave_dir, bdev_kobj(bdev));
>  		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> -		kobject_put(bdev->bd_holder_dir);
>  		list_del_init(&holder->list);
>  		kfree(holder);
>  	}
> -- 
> 2.30.2
> 

