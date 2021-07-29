Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A21C4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7820D60EFD
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhG2QeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230228AbhG2QeF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 12:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627576442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DgXxi6D01R6oKUlD2nkhQCbT4XAjmQsHUMsVJ3OLl1M=;
        b=e16KIvzyMVNglqutSEmPLHwLjOLI9lr4Dx1OYwBTIOm77bp8Qv7vSxr68AAJ0YXuHO7FNK
        H9ZIoD3+vs+PaLzrE2/sYDmYKh5UM9Sv56Zgm6u9Eh0xFy68m6To2JTj5mmTKchOG8+x/M
        elF2Ag4y9eFIBU+5EFzWn+3pfm2PMjc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-f2x7AgCgNZGVnJVIZtM9Tw-1; Thu, 29 Jul 2021 12:34:01 -0400
X-MC-Unique: f2x7AgCgNZGVnJVIZtM9Tw-1
Received: by mail-qt1-f200.google.com with SMTP id g10-20020ac8768a0000b029023c90fba3dcso2977501qtr.7
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 09:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgXxi6D01R6oKUlD2nkhQCbT4XAjmQsHUMsVJ3OLl1M=;
        b=cTdNBw0v1jCr4DQWxvkg9DHLYB1ihF5qYI6ZiLu5rfakvlJSNFspB3rHOQ8xYkPV7I
         qSCUIcmAuRoMGEwjeY7xoIu1p/pLc6kNOBoFXlNDoOqg/n1LhNMl9RPtAQ/KJ2qZV0mN
         F9wtn0qV4qyoIMSqC52iIb4AYMtAf7yeTgwhn4uNq1juT9GL253N/J/J8ztc98WkiEvQ
         wjfIrq7HnypYBf1cUmCj9tBJ4xY/FeQe1lngEZmj+45X3uYDe91FvlDM2obeeudRUamB
         KcimD/kqdz5VnROWUUF3u1/flm+OciDwm5yGdq8kHHgK9jHh/sI3xbiql2T6kOdSaLRA
         aviA==
X-Gm-Message-State: AOAM531vG8dc6KJsrcVopjYEX82cCtdYVcgUcGPPkQMqWnUYyYWpJGqN
        /C+9wSQsKll+TUktVVMAmf/6PponKFH5s+y2meYt8TqQy0yQWFop6hDMGDZju/hcV5WZ5YtkBKm
        8WCsQxChcv8TQJXohIJ9fOA==
X-Received: by 2002:a05:6214:3a4:: with SMTP id m4mr6063688qvy.17.1627576440739;
        Thu, 29 Jul 2021 09:34:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv1S4jWuxGbYYg+j5zXIOLgd53p4g7zvBIyfaJi4vITOLDVn0ErbgJkGs/edEleml6VmwnIQ==
X-Received: by 2002:a05:6214:3a4:: with SMTP id m4mr6063679qvy.17.1627576440600;
        Thu, 29 Jul 2021 09:34:00 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id e12sm1951965qkm.65.2021.07.29.09.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:34:00 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:33:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 5/8] dm: cleanup cleanup_mapped_device
Message-ID: <YQLYd2DKQIVVWtuQ@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <20210725055458.29008-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> md->queue is not always set when md->disk is set, so simplify the
> conditionas a bit.

s/not/now/
s/conditionas/conditionals/

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

> ---
>  drivers/md/dm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2c5f9e585211..7971ec8ce677 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1694,13 +1694,9 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  		md->disk->private_data = NULL;
>  		spin_unlock(&_minor_lock);
>  		del_gendisk(md->disk);
> -	}
> -
> -	if (md->queue)
>  		dm_queue_destroy_keyslot_manager(md->queue);
> -
> -	if (md->disk)
>  		blk_cleanup_disk(md->disk);
> +	}
>  
>  	cleanup_srcu_struct(&md->io_barrier);
>  
> -- 
> 2.30.2
> 

