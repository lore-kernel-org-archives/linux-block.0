Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0EC4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D8160F43
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhG2Qgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhG2Qgj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 12:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627576596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u3NGgM0zE4A2LSlCrpEkhVObgSJ7qzXv7ezeOeUxp8Y=;
        b=Iy8yaDXc6YAKENol7c/nNtBj1KnUSsVFuT+o+heRfuopYsaZ2LnKi0FUCA00WQAGJvP94f
        yM+CywCP2ynbHz17xJk3oHA09edoFBP0IeMFPcr69RJjVCAMWTX2KWTmMX73AgLAHwVz4T
        VuLPM9V4dchW8zUd2AjqN4hTJBzglUM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-ponBaNN9OqquZRhwjvaisA-1; Thu, 29 Jul 2021 12:36:34 -0400
X-MC-Unique: ponBaNN9OqquZRhwjvaisA-1
Received: by mail-qk1-f198.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so4102686qki.15
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 09:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u3NGgM0zE4A2LSlCrpEkhVObgSJ7qzXv7ezeOeUxp8Y=;
        b=S2oqufW/vJOzOhp3TNDIxgamZKBdQOfvzKZRHkbaon1zEweksNn1xjwkaCdya2TvAS
         +4az94dtqrEAmbtfgkQrsNgi9Hssd48cIrHrSG53PRdQXgKsEm8MX3C5+eeTi+nkSN+U
         w/vDKSD41vtIrYPlMDe7CL/U1vwvsuDC+hZULqtBM0FLEkNoGXfTFIZPpx/V4VpZSPRM
         bRvChy0ZRecpyhg935q4UHPEn+oY2vTunTugDwo/1xDbdW9U3+ADq98yphrjpZaPSbbH
         wuKGjVk23dCZUwR15w1YyC7W3mIEQl/XQ9+WefBqlL+8rxPBr6eX048UTjqkAnfPf/cF
         Oacw==
X-Gm-Message-State: AOAM530tTHDZor9b0eGi9Rcm1nntmAiqh6Vh/IwuXmVptfBz1opp2j34
        HWHXUSMiOwhWtzPTK9SXBvyQ00KFmS5AI45g2UXVqOtv7sxt6pl1nyKpVaFh1psxkk450vSfM4u
        gC6Ntlp8igM8/pwZmTI+uGQ==
X-Received: by 2002:a05:620a:a8d:: with SMTP id v13mr6071735qkg.468.1627576594253;
        Thu, 29 Jul 2021 09:36:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnrTD1/OHkbii+EetzwAeTe2yeiaR0KQGof9csNyzw4D4QxOACApZHPviP2cdwLh7xlzut1w==
X-Received: by 2002:a05:620a:a8d:: with SMTP id v13mr6071718qkg.468.1627576594086;
        Thu, 29 Jul 2021 09:36:34 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t6sm1995462qkg.75.2021.07.29.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:36:33 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:36:33 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] dm: delay registering the gendisk
Message-ID: <YQLZEAIKbMrveJR0@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <20210725055458.29008-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> device mapper is currently the only outlier that tries to call
> register_disk after add_disk, leading to fairly inconsistent state
> of these block layer data structures.  Instead change device-mapper
> to just register the gendisk later now that the holder mechanism
> can cope with that.
> 
> Note that this introduces a user visible change: the dm kobject is
> now only visible after the initial table has been loaded.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

Jens, feel free to pick this series up once you're comfortable with it.

Thanks,
Mike


> ---
>  drivers/md/dm-rq.c |  1 -
>  drivers/md/dm.c    | 23 +++++++++++------------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 0dbd48cbdff9..5b95eea517d1 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -559,7 +559,6 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
>  	err = blk_mq_init_allocated_queue(md->tag_set, md->queue);
>  	if (err)
>  		goto out_tag_set;
> -	elevator_init_mq(md->queue);
>  	return 0;
>  
>  out_tag_set:
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index f003bd5b93ce..7981b7287628 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1693,7 +1693,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  		spin_lock(&_minor_lock);
>  		md->disk->private_data = NULL;
>  		spin_unlock(&_minor_lock);
> -		del_gendisk(md->disk);
> +		if (dm_get_md_type(md) != DM_TYPE_NONE) {
> +			dm_sysfs_exit(md);
> +			del_gendisk(md->disk);
> +		}
>  		dm_queue_destroy_keyslot_manager(md->queue);
>  		blk_cleanup_disk(md->disk);
>  	}
> @@ -1788,7 +1791,6 @@ static struct mapped_device *alloc_dev(int minor)
>  			goto bad;
>  	}
>  
> -	add_disk_no_queue_reg(md->disk);
>  	format_dev_t(md->name, MKDEV(_major, minor));
>  
>  	md->wq = alloc_workqueue("kdmflush", WQ_MEM_RECLAIM, 0);
> @@ -1989,19 +1991,12 @@ static struct dm_table *__unbind(struct mapped_device *md)
>   */
>  int dm_create(int minor, struct mapped_device **result)
>  {
> -	int r;
>  	struct mapped_device *md;
>  
>  	md = alloc_dev(minor);
>  	if (!md)
>  		return -ENXIO;
>  
> -	r = dm_sysfs_init(md);
> -	if (r) {
> -		free_dev(md);
> -		return r;
> -	}
> -
>  	*result = md;
>  	return 0;
>  }
> @@ -2081,10 +2076,15 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>  	r = dm_table_set_restrictions(t, md->queue, &limits);
>  	if (r)
>  		return r;
> -	md->type = type;
>  
> -	blk_register_queue(md->disk);
> +	add_disk(md->disk);
>  
> +	r = dm_sysfs_init(md);
> +	if (r) {
> +		del_gendisk(md->disk);
> +		return r;
> +	}
> +	md->type = type;
>  	return 0;
>  }
>  
> @@ -2190,7 +2190,6 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
>  		DMWARN("%s: Forcibly removing mapped_device still in use! (%d users)",
>  		       dm_device_name(md), atomic_read(&md->holders));
>  
> -	dm_sysfs_exit(md);
>  	dm_table_destroy(__unbind(md));
>  	free_dev(md);
>  }
> -- 
> 2.30.2
> 

