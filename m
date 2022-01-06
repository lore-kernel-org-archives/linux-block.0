Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91783C433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Jan 2022 15:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiAFPk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:40:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229726AbiAFPk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jan 2022 10:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641483656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkCTbr45iy5PICy3oH+srONgdc+wbihvOVMyc+AgjdQ=;
        b=MdeCbCaTvv8JhS6ryRatpuN5yHIUnLlnOpdrtebHbjwRnweaI3K+r1waLRWgrz7DNas/oj
        DSrV0MXOQ1XEc95/KHbVgCAKN6Ek4nmbJz7DBchELyhyvHiBs+eMtO8biCDRjrf83zvVh1
        NdOd28TqGeWL9RKDmkuS7OgE5NTWOMQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-01nzXsavM-WW_a0ukcBlrw-1; Thu, 06 Jan 2022 10:40:53 -0500
X-MC-Unique: 01nzXsavM-WW_a0ukcBlrw-1
Received: by mail-qv1-f70.google.com with SMTP id kd7-20020a056214400700b0041195fd2977so2420374qvb.5
        for <linux-block@vger.kernel.org>; Thu, 06 Jan 2022 07:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkCTbr45iy5PICy3oH+srONgdc+wbihvOVMyc+AgjdQ=;
        b=SBPtVjePMeKEaAe7nQpU/3NZkDByriUMBW7KZIJjWgGSJxYQ35MGaXGTu2gLJKTFO5
         /V4pZq0EtSMusRlkZsc/ZRgZHy233KSB4tapaXaB85bmO9bh/HyZWiXa2EVqeZS5fXRo
         Mq1CaLbR8cdyidXKhOAnbTtNQg15Sx60kju/RQQiEBljNTvYTY9x5AjNRc1Hy8uKPNb5
         +E2NF9BN1J36hldXg7f+85DMJ72F0voQIrZ5ZTD5UR1+R9gJ0+tB0UcKx92Sp0j1u0S8
         Laoi8Wy0aZkTvzyFA346CNpnvE0yMPQ8wkHW9mfHhh42Lom5kD0gzDwc8qKVRjko9xTn
         gZjA==
X-Gm-Message-State: AOAM5313TgoZ71b5QKD7sHfwg/QCJeuzjkcO5tbEvDQz/X5JfQ/KV4Au
        78R7GT8NsEd0t0GzsWOJWzV1RCyJDbMdUyc/zT0zXR/IouIleZAGRmKiGT0RjEY9Y5aPvIOOa9+
        zUxJ6gq9A02suD/66rqI6mg==
X-Received: by 2002:a05:620a:2588:: with SMTP id x8mr42205361qko.292.1641483653340;
        Thu, 06 Jan 2022 07:40:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysRc1hv4FjhYX+z2oI9RRSophDyzvxsJdTfukvL3cJ65H4Rx1G6pOt0qNkzLCN3ysMpQ+VKw==
X-Received: by 2002:a05:620a:2588:: with SMTP id x8mr42205346qko.292.1641483653083;
        Thu, 06 Jan 2022 07:40:53 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bk25sm1675861qkb.13.2022.01.06.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 07:40:52 -0800 (PST)
Date:   Thu, 6 Jan 2022 10:40:51 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 3/3] dm: mark dm queue as blocking if any underlying is
 blocking
Message-ID: <YdcNgw14kSg+ENVL@redhat.com>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <20211221141459.1368176-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221141459.1368176-4-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21 2021 at  9:14P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> dm request based driver doesn't set BLK_MQ_F_BLOCKING, so dm_queue_rq()
> is supposed to not sleep.
> 
> However, blk_insert_cloned_request() is used by dm_queue_rq() for
> queuing underlying request, but the underlying queue may be marked as
> BLK_MQ_F_BLOCKING, so blk_insert_cloned_request() may become to block
> current context, then rcu warning is triggered.
> 
> Fixes the issue by marking dm request based queue as BLK_MQ_F_BLOCKING
> if any underlying queue is marked as BLK_MQ_F_BLOCKING, meantime we
> need to allocate srcu beforehand.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/md/dm-rq.c    |  5 ++++-
>  drivers/md/dm-rq.h    |  3 ++-
>  drivers/md/dm-table.c | 14 ++++++++++++++
>  drivers/md/dm.c       |  5 +++--
>  drivers/md/dm.h       |  1 +
>  5 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 579ab6183d4d..2297d37c62a9 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -535,7 +535,8 @@ static const struct blk_mq_ops dm_mq_ops = {
>  	.init_request = dm_mq_init_request,
>  };
>  
> -int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
> +int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t,
> +			     bool blocking)
>  {
>  	struct dm_target *immutable_tgt;
>  	int err;
> @@ -550,6 +551,8 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
>  	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
>  	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
>  	md->tag_set->driver_data = md;
> +	if (blocking)
> +		md->tag_set->flags |= BLK_MQ_F_BLOCKING;
>  
>  	md->tag_set->cmd_size = sizeof(struct dm_rq_target_io);
>  	immutable_tgt = dm_table_get_immutable_target(t);

As you can see, dm_table_get_immutable_target(t) is called here ^

Rather than pass 'blocking' in, please just call dm_table_has_blocking_dev(t);

But not a big deal, I can clean that up once this gets committed...

> diff --git a/drivers/md/dm-rq.h b/drivers/md/dm-rq.h
> index 1eea0da641db..5f3729f277d7 100644
> --- a/drivers/md/dm-rq.h
> +++ b/drivers/md/dm-rq.h
> @@ -30,7 +30,8 @@ struct dm_rq_clone_bio_info {
>  	struct bio clone;
>  };
>  
> -int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t);
> +int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t,
> +			     bool blocking);
>  void dm_mq_cleanup_mapped_device(struct mapped_device *md);
>  
>  void dm_start_queue(struct request_queue *q);
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index aa173f5bdc3d..e4bdd4f757a3 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1875,6 +1875,20 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
>  	return true;
>  }
>  
> +/* If the device can block inside ->queue_rq */
> +static int device_is_io_blocking(struct dm_target *ti, struct dm_dev *dev,
> +			      sector_t start, sector_t len, void *data)
> +{
> +	struct request_queue *q = bdev_get_queue(dev->bdev);
> +
> +	return blk_queue_blocking(q);
> +}
> +
> +bool dm_table_has_blocking_dev(struct dm_table *t)
> +{
> +	return dm_table_any_dev_attr(t, device_is_io_blocking, NULL);
> +}
> +
>  static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
>  				     sector_t start, sector_t len, void *data)
>  {
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 280918cdcabd..2f72877752dd 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1761,7 +1761,7 @@ static struct mapped_device *alloc_dev(int minor)
>  	 * established. If request-based table is loaded: blk-mq will
>  	 * override accordingly.
>  	 */
> -	md->disk = blk_alloc_disk(md->numa_node_id);
> +	md->disk = blk_alloc_disk_srcu(md->numa_node_id);
>  	if (!md->disk)
>  		goto bad;
>  	md->queue = md->disk->queue;
> @@ -2046,7 +2046,8 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>  	switch (type) {
>  	case DM_TYPE_REQUEST_BASED:
>  		md->disk->fops = &dm_rq_blk_dops;
> -		r = dm_mq_init_request_queue(md, t);
> +		r = dm_mq_init_request_queue(md, t,
> +				dm_table_has_blocking_dev(t));
>  		if (r) {
>  			DMERR("Cannot initialize queue for request-based dm mapped device");
>  			return r;
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index 742d9c80efe1..f7f92b272cce 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -60,6 +60,7 @@ int dm_calculate_queue_limits(struct dm_table *table,
>  			      struct queue_limits *limits);
>  int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  			      struct queue_limits *limits);
> +bool dm_table_has_blocking_dev(struct dm_table *t);
>  struct list_head *dm_table_get_devices(struct dm_table *t);
>  void dm_table_presuspend_targets(struct dm_table *t);
>  void dm_table_presuspend_undo_targets(struct dm_table *t);
> -- 
> 2.31.1
> 

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

Late, given holidays we know why, but this patchset is needed for 5.17
(maybe with added: 'Fixes: 704b914f15fb7 "blk-mq: move srcu from
blk_mq_hw_ctx to request_queue"' to this 3rd patch?)

Jens, can you please pick this patchset up for 5.17?

Thanks,
Mike

