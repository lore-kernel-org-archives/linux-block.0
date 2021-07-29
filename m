Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6182C4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8410960F0F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhG2QhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhG2QhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 12:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627576636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1RSuBssQi+q7cm+z6CE0tczu7IpqjYbm4lf0fu8TZ1I=;
        b=P4qBYbKDBraiuicjrA7eWiCzUqSjJ7USQCprW2mA1emdKxTPbcP/ped4DDBm6M2VLCQft4
        GRYidKQXxdImFTEe/NqxHIHYdxZFepixt5nrqY/q9TgV9tBOQDPgcvsNHYCTmzlrUqcUDt
        eB3H55wChOCaXUDMH6Ar+Rs//mbPOvM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-RAGLCOwNOvWBH8eK7KQxgg-1; Thu, 29 Jul 2021 12:37:14 -0400
X-MC-Unique: RAGLCOwNOvWBH8eK7KQxgg-1
Received: by mail-qv1-f71.google.com with SMTP id v16-20020a0562140510b029032511e85975so4170144qvw.23
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 09:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1RSuBssQi+q7cm+z6CE0tczu7IpqjYbm4lf0fu8TZ1I=;
        b=DZRFaMV2EhL75MRpR0rI+B14AbnpbsnIrsiM2RAXlD3MpIEZRUz3QWCsR2ogNACQJW
         h4Kse/Lqg3Ek7scJSxrLKXTTRxzaxmdyiw4p7zENmmn+A8+NloNtY/MM/uPP8PqjI0XR
         om3p85NEkDhm1iPB7cpnWll57lR4ixaQzBxA5SPvIqMLVCsA+0vbMEizMMzgxFPOJcmZ
         DoFYqN8v4N223njpRAPLkeVgoocT8c2q1zdA46XK9Vd6SxwOB6FESCnj74hao3+JWx4i
         llOIjLFfcB1qUGQD8izA+OAkp2MxVIy7wdHCk8P8geMAaqsbOsBOfY0AHRzVIPj7przG
         ioEA==
X-Gm-Message-State: AOAM531rV2wx61mlIzQ0gOvOEr+MyEYJvwnUxye/RL8grvFM8FzUMl3A
        cSablygqM35feaUEDf3mP9wZ4P/ekdS1Q8oCEC+Z3O/rlUWxYhP2OJ+pQlwm6CLwhbV1hPk5wNO
        UPPXN2ohzTgmHrRcleLG4eA==
X-Received: by 2002:a05:620a:140a:: with SMTP id d10mr6139104qkj.171.1627576633983;
        Thu, 29 Jul 2021 09:37:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc0wxWpfaIl7vXBoFkjNjlCwXG9APADqkFM5GGd2jrBukPuBRpblzl0nmz+pSqYXMAlreiLg==
X-Received: by 2002:a05:620a:140a:: with SMTP id d10mr6139092qkj.171.1627576633830;
        Thu, 29 Jul 2021 09:37:13 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m3sm2010655qkk.0.2021.07.29.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:37:13 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:37:12 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] block: remove support for delayed queue registrations
Message-ID: <YQLZOMfbV0BCkMsJ@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <20210725055458.29008-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Now that device mapper has been changed to register the disk once
> it is fully ready all this code is unused.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


> ---
>  block/elevator.c      |  1 -
>  block/genhd.c         | 29 +++++++----------------------
>  include/linux/genhd.h |  6 ------
>  3 files changed, 7 insertions(+), 29 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 52ada14cfe45..706d5a64508d 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -702,7 +702,6 @@ void elevator_init_mq(struct request_queue *q)
>  		elevator_put(e);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(elevator_init_mq); /* only for dm-rq */
>  
>  /*
>   * switch to new_e io scheduler. be careful not to introduce deadlocks -
> diff --git a/block/genhd.c b/block/genhd.c
> index e3d93b868ec5..3cd9f165a5a7 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -457,20 +457,20 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>  }
>  
>  /**
> - * __device_add_disk - add disk information to kernel list
> + * device_add_disk - add disk information to kernel list
>   * @parent: parent device for the disk
>   * @disk: per-device partitioning information
>   * @groups: Additional per-device sysfs groups
> - * @register_queue: register the queue if set to true
>   *
>   * This function registers the partitioning information in @disk
>   * with the kernel.
>   *
>   * FIXME: error handling
>   */
> -static void __device_add_disk(struct device *parent, struct gendisk *disk,
> -			      const struct attribute_group **groups,
> -			      bool register_queue)
> +
> +void device_add_disk(struct device *parent, struct gendisk *disk,
> +		     const struct attribute_group **groups)
> +
>  {
>  	int ret;
>  
> @@ -480,8 +480,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  	 * elevator if one is needed, that is, for devices requesting queue
>  	 * registration.
>  	 */
> -	if (register_queue)
> -		elevator_init_mq(disk->queue);
> +	elevator_init_mq(disk->queue);
>  
>  	/*
>  	 * If the driver provides an explicit major number it also must provide
> @@ -535,8 +534,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  		bdev_add(disk->part0, dev->devt);
>  	}
>  	register_disk(parent, disk, groups);
> -	if (register_queue)
> -		blk_register_queue(disk);
> +	blk_register_queue(disk);
>  
>  	/*
>  	 * Take an extra ref on queue which will be put on disk_release()
> @@ -550,21 +548,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  	disk_add_events(disk);
>  	blk_integrity_add(disk);
>  }
> -
> -void device_add_disk(struct device *parent, struct gendisk *disk,
> -		     const struct attribute_group **groups)
> -
> -{
> -	__device_add_disk(parent, disk, groups, true);
> -}
>  EXPORT_SYMBOL(device_add_disk);
>  
> -void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
> -{
> -	__device_add_disk(parent, disk, NULL, false);
> -}
> -EXPORT_SYMBOL(device_add_disk_no_queue_reg);
> -
>  /**
>   * del_gendisk - remove the gendisk
>   * @disk: the struct gendisk to remove
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index dd95d53c75fa..fbc4bf269f63 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -218,12 +218,6 @@ static inline void add_disk(struct gendisk *disk)
>  {
>  	device_add_disk(NULL, disk, NULL);
>  }
> -extern void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);
> -static inline void add_disk_no_queue_reg(struct gendisk *disk)
> -{
> -	device_add_disk_no_queue_reg(NULL, disk);
> -}
> -
>  extern void del_gendisk(struct gendisk *gp);
>  
>  void set_disk_ro(struct gendisk *disk, bool read_only);
> -- 
> 2.30.2
> 

