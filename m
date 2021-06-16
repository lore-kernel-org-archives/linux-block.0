Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70084C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 16:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D6261164
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 16:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhFPQHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFPQHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 12:07:23 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A207CC061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 09:05:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id k9so1792931qvu.13
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WhJvDM8RFKP8VCl/aredIhXrpJyPqDIkrwkoKNyfGPY=;
        b=CMbWXdPNM6Oo4HGCslVqFeutW4r7irgXTEY50xzGLCQ0rBgbRYRHMz2U/kECKbUwFZ
         dNJQCD4qlcH6z6esidPnrQ4pmxBLqLIfsRBsY5yDuDL97jMIbIR6pAKEuOGYT1FIgh9J
         uauJhbyrf99iq9dqXmSTB4QZ4c7uINFyyq8km52G+p3Wtk1h0ouCd4VuE+GWl88ReE5/
         UjUvU/qEbJ+P8Do9D3pp/c4+EEFFVWHT3Gr8mVa1EwBbnX39if8Zk5weShPKgFcQrae/
         QG4ZXg6BdB9EuddZmqEGSGCl9TjUfvOE511cMNp3Wh08JBAji9qPLxN9p3ibfnSAnAJV
         rY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WhJvDM8RFKP8VCl/aredIhXrpJyPqDIkrwkoKNyfGPY=;
        b=sv2Ucf09JWaiuD6i7i+VSRevLLKzwZITRWVS1S29NuAbxoYOvcEjcbws0mqUV1/95w
         BVXk6XKgHUXjEln8rAQffUOzKxq0098J20pA8uod9QfH0W/i05uAirSa87GeeYUA/YE9
         famMCqwjPdbl5vaL6kaMjrNchJKP4fGFiYK/gKYl9fSKGqUtAc+zSuhNuO4/GhBGHK/o
         vWoqnsWXbFfQ23m4LCgFChJCg5MVr72XYds8zR/wQ8Ea3WD/h5d+lf/PZXC4wcYTyWKJ
         5zcNr0urkBm8I9y6Z/vqlcbjTOo3tib/CrLuyEvpISGX6nv5mXABrHFxs9YkbGjD2wSJ
         83XQ==
X-Gm-Message-State: AOAM532Cm1qLFOByZeFqPr/hy1KK870PABLeswk2ND37b7ya7rugrALU
        pvgLs0ItrY00/GiEpmqbtDQ=
X-Google-Smtp-Source: ABdhPJxUXmQY69GLCqEPqb/S7NzJh+rYAXrKGL3LRvLp5QFl+nd9+6S5vnsro7jetvBCY527FbZ2NA==
X-Received: by 2002:a0c:c68d:: with SMTP id d13mr765778qvj.60.1623859515708;
        Wed, 16 Jun 2021 09:05:15 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t139sm1774717qka.85.2021.06.16.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:05:14 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Wed, 16 Jun 2021 12:05:13 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH 4/4] dm: support bio polling
Message-ID: <YMohOUlopTcO1Bzd@redhat.com>
References: <20210616130533.754248-1-ming.lei@redhat.com>
 <20210616130533.754248-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616130533.754248-5-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 16 2021 at  9:05P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> Support bio(REQ_POLLED) polling in the following approach:
> 
> 1) setup one list in instance of 'struct dm_io', adds every 'struct
> dm_target_io' instance cloned for current dm bio into this list;
> store the list in 1) into bio->bi_bio_drv_data
> 
> 2) hold one refcnt on io->io_count after submitting this dm bio with
> REQ_POLLED
> 
> 4) implement .poll_bio() callback, and iterate over the list in 1) and
> polled on each ->clone of 'dm_target_io' instance; call dec_pending()
> if all target ios are done in .poll_bio().
> 
> 4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> which is based on Jeffle's previous patch.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks for refreshing this DM bio polling support Ming.

In general I'm really happy to see polling switch over to using bios,
nice job Christoph! Are you hoping for all this to land in time for
5.14 merge?

Once Ming responds to my review inlined below, and I Acked-by his
set, would you be willing to fold it at the end of your patchset so
that I don't need to rebase on block to get these changes in, etc?

Mike

> ---
>  drivers/md/dm-table.c | 24 ++++++++++++++++++
>  drivers/md/dm.c       | 59 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 79 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index ee47a332b462..b14b379442d2 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1491,6 +1491,12 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
>  	return &t->targets[(KEYS_PER_NODE * n) + k];
>  }
>  
> +static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
> +				   sector_t start, sector_t len, void *data)
> +{
> +	return !blk_queue_poll(bdev_get_queue(dev->bdev));
> +}
> +
>  /*
>   * type->iterate_devices() should be called when the sanity check needs to
>   * iterate and check all underlying data devices. iterate_devices() will
> @@ -1541,6 +1547,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
>  	return 0;
>  }
>  
> +static int dm_table_supports_poll(struct dm_table *t)
> +{
> +	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
> +}
> +
>  /*
>   * Check whether a table has no data devices attached using each
>   * target's iterate_devices method.
> @@ -2078,6 +2089,19 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  
>  	dm_update_keyslot_manager(q, t);
>  	blk_queue_update_readahead(q);
> +
> +	/*
> +	 * Check for request-based device is remained to
> +	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
> +	 * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
> +	 * devices supporting polling.
> +	 */
> +	if (__table_type_bio_based(t->type)) {
> +		if (dm_table_supports_poll(t))
> +			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> +		else
> +			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> +	}
>  }
>  
>  unsigned int dm_table_get_num_targets(struct dm_table *t)
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 363f12a285ce..0a0e4a38f435 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -84,6 +84,7 @@ struct dm_target_io {
>  	struct dm_target *ti;
>  	unsigned target_bio_nr;
>  	unsigned *len_ptr;
> +	struct list_head list;
>  	bool inside_dm_io;
>  	struct bio clone;
>  };
> @@ -99,6 +100,7 @@ struct dm_io {
>  	blk_status_t status;
>  	atomic_t io_count;
>  	struct bio *orig_bio;
> +	struct list_head poll_head;
>  	unsigned long start_time;
>  	spinlock_t endio_lock;
>  	struct dm_stats_aux stats_aux;
> @@ -655,6 +657,11 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
>  	io->md = md;
>  	spin_lock_init(&io->endio_lock);
>  
> +	if (bio->bi_opf & REQ_POLLED) {
> +		bio->bi_bio_drv_data = io;
> +		INIT_LIST_HEAD(&io->poll_head);
> +	}
> +
>  	start_io_acct(io);
>  
>  	return io;
> @@ -692,6 +699,8 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
>  
>  static void free_tio(struct dm_target_io *tio)
>  {
> +	list_del_init(&tio->list);
> +
>  	if (tio->inside_dm_io)
>  		return;
>  	bio_put(&tio->clone);
> @@ -936,10 +945,15 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
>  		io_error = io->status;
>  		bio = io->orig_bio;
>  		end_io_acct(io);
> +
>  		free_io(md, io);
>  
> -		if (io_error == BLK_STS_DM_REQUEUE)
> +		if (io_error == BLK_STS_DM_REQUEUE) {
> +			/* not poll any more in case of requeue */
> +			if (bio->bi_opf & REQ_POLLED)
> +				bio->bi_opf &= ~REQ_POLLED;
>  			return;
> +		}
>  
>  		if ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size) {
>  			/*
> @@ -1043,7 +1057,9 @@ static void clone_endio(struct bio *bio)
>  		up(&md->swap_bios_semaphore);
>  	}
>  
> -	free_tio(tio);
> +	/* Any cloned bio submitted as POLLED, free them all after dm_io is done */
> +	if (list_empty(&tio->list))
> +		free_tio(tio);
>  	dec_pending(io, error);
>  }
>  
> @@ -1300,6 +1316,11 @@ static void __map_bio(struct dm_target_io *tio)
>  	struct dm_io *io = tio->io;
>  	struct dm_target *ti = tio->ti;
>  
> +	if (clone->bi_opf & REQ_POLLED)
> +		list_add_tail(&tio->list, &io->poll_head);
> +	else
> +		INIT_LIST_HEAD(&tio->list);
> +

Why not INIT_LIST_HEAD() at end of alloc_tio()? Shouldn't that be done
even if you have this else claue here because you can clear REQ_POLLED
on BLK_STS_DM_REQUEUE? (otherwise you're calling list_add_tail on list
that wasn't ever INIT_LIST_HEAD).

>  	clone->bi_end_io = clone_endio;
>  
>  	/*
> @@ -1666,8 +1687,9 @@ static void __split_and_process_bio(struct mapped_device *md,
>  		}
>  	}
>  
> -	/* drop the extra reference count */
> -	dec_pending(ci.io, errno_to_blk_status(error));
> +	/* drop the extra reference count for non-POLLED bio */
> +	if (!(bio->bi_opf & REQ_POLLED))
> +		dec_pending(ci.io, errno_to_blk_status(error));
>  }
>  
>  static void dm_submit_bio(struct bio *bio)
> @@ -1707,6 +1729,34 @@ static void dm_submit_bio(struct bio *bio)
>  	dm_put_live_table(md, srcu_idx);
>  }
>  
> +static int dm_poll_bio(struct bio *bio, unsigned int flags)
> +{
> +	struct dm_io *io = bio->bi_bio_drv_data;
> +	struct dm_target_io *tio;
> +
> +	if (!(bio->bi_opf & REQ_POLLED) || !io)
> +		return 0;

Should this be a WARN_ON()? Cannot see why this would ever happen
other than a bug?  Or is there some race that makes it more likely?

> +	list_for_each_entry(tio, &io->poll_head, list)
> +		bio_poll(&tio->clone, flags);
> +
> +	/* bio_poll holds the last reference */
> +	if (atomic_read(&io->io_count) == 1) {
> +		/* free all target IOs submitted as POLLED */
> +		while (!list_empty(&io->poll_head)) {
> +			struct dm_target_io *tio =
> +				list_entry(io->poll_head.next,
> +					struct dm_target_io, list);
> +			free_tio(tio);
> +		}
> +		bio->bi_bio_drv_data = NULL;
> +		dec_pending(io, 0);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /*-----------------------------------------------------------------
>   * An IDR is used to keep track of allocated minor numbers.
>   *---------------------------------------------------------------*/
> @@ -3121,6 +3171,7 @@ static const struct pr_ops dm_pr_ops = {
>  
>  static const struct block_device_operations dm_blk_dops = {
>  	.submit_bio = dm_submit_bio,
> +	.poll_bio = dm_poll_bio,
>  	.open = dm_blk_open,
>  	.release = dm_blk_close,
>  	.ioctl = dm_blk_ioctl,
> -- 
> 2.31.1
> 

