Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A1CC48BE5
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 02:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1466A613DF
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 02:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFQCRB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 22:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231299AbhFQCRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 22:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623896093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcaEt3VGqaxiyNX3YB1xEWmrae8B2JBQvere3PrXaGE=;
        b=SHxk5hCFnDrmDV88ARgqRzcTcytL4aHpFf/VjPRJXlE2sRNguRr+CEx3xqObkP5lUkWEd9
        Cfn0xOaidAKmqTvdHkZ0Tb5FSj4jTlH/KOtzPGwbR49GKMDIGJUNIF15xzKREvcWcIl08n
        rW0OnHxIfuBFiEvjzVlpWcvRm0tRPAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-nQ1xfdPbNOm3LluKfTjclQ-1; Wed, 16 Jun 2021 22:14:52 -0400
X-MC-Unique: nQ1xfdPbNOm3LluKfTjclQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF3F801B14;
        Thu, 17 Jun 2021 02:14:51 +0000 (UTC)
Received: from T590 (ovpn-12-121.pek2.redhat.com [10.72.12.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E38F960C05;
        Thu, 17 Jun 2021 02:14:34 +0000 (UTC)
Date:   Thu, 17 Jun 2021 10:14:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH 4/4] dm: support bio polling
Message-ID: <YMqwBtjx7M+uzlg2@T590>
References: <20210616130533.754248-1-ming.lei@redhat.com>
 <20210616130533.754248-5-ming.lei@redhat.com>
 <YMohOUlopTcO1Bzd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMohOUlopTcO1Bzd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 16, 2021 at 12:05:13PM -0400, Mike Snitzer wrote:
> On Wed, Jun 16 2021 at  9:05P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Support bio(REQ_POLLED) polling in the following approach:
> > 
> > 1) setup one list in instance of 'struct dm_io', adds every 'struct
> > dm_target_io' instance cloned for current dm bio into this list;
> > store the list in 1) into bio->bi_bio_drv_data
> > 
> > 2) hold one refcnt on io->io_count after submitting this dm bio with
> > REQ_POLLED
> > 
> > 4) implement .poll_bio() callback, and iterate over the list in 1) and
> > polled on each ->clone of 'dm_target_io' instance; call dec_pending()
> > if all target ios are done in .poll_bio().
> > 
> > 4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> > which is based on Jeffle's previous patch.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Thanks for refreshing this DM bio polling support Ming.
> 
> In general I'm really happy to see polling switch over to using bios,
> nice job Christoph! Are you hoping for all this to land in time for
> 5.14 merge?
> 
> Once Ming responds to my review inlined below, and I Acked-by his
> set, would you be willing to fold it at the end of your patchset so
> that I don't need to rebase on block to get these changes in, etc?
> 
> Mike
> 
> > ---
> >  drivers/md/dm-table.c | 24 ++++++++++++++++++
> >  drivers/md/dm.c       | 59 ++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 79 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index ee47a332b462..b14b379442d2 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -1491,6 +1491,12 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
> >  	return &t->targets[(KEYS_PER_NODE * n) + k];
> >  }
> >  
> > +static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
> > +				   sector_t start, sector_t len, void *data)
> > +{
> > +	return !blk_queue_poll(bdev_get_queue(dev->bdev));
> > +}
> > +
> >  /*
> >   * type->iterate_devices() should be called when the sanity check needs to
> >   * iterate and check all underlying data devices. iterate_devices() will
> > @@ -1541,6 +1547,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
> >  	return 0;
> >  }
> >  
> > +static int dm_table_supports_poll(struct dm_table *t)
> > +{
> > +	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
> > +}
> > +
> >  /*
> >   * Check whether a table has no data devices attached using each
> >   * target's iterate_devices method.
> > @@ -2078,6 +2089,19 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
> >  
> >  	dm_update_keyslot_manager(q, t);
> >  	blk_queue_update_readahead(q);
> > +
> > +	/*
> > +	 * Check for request-based device is remained to
> > +	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
> > +	 * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
> > +	 * devices supporting polling.
> > +	 */
> > +	if (__table_type_bio_based(t->type)) {
> > +		if (dm_table_supports_poll(t))
> > +			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> > +		else
> > +			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> > +	}
> >  }
> >  
> >  unsigned int dm_table_get_num_targets(struct dm_table *t)
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 363f12a285ce..0a0e4a38f435 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -84,6 +84,7 @@ struct dm_target_io {
> >  	struct dm_target *ti;
> >  	unsigned target_bio_nr;
> >  	unsigned *len_ptr;
> > +	struct list_head list;
> >  	bool inside_dm_io;
> >  	struct bio clone;
> >  };
> > @@ -99,6 +100,7 @@ struct dm_io {
> >  	blk_status_t status;
> >  	atomic_t io_count;
> >  	struct bio *orig_bio;
> > +	struct list_head poll_head;
> >  	unsigned long start_time;
> >  	spinlock_t endio_lock;
> >  	struct dm_stats_aux stats_aux;
> > @@ -655,6 +657,11 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
> >  	io->md = md;
> >  	spin_lock_init(&io->endio_lock);
> >  
> > +	if (bio->bi_opf & REQ_POLLED) {
> > +		bio->bi_bio_drv_data = io;
> > +		INIT_LIST_HEAD(&io->poll_head);
> > +	}
> > +
> >  	start_io_acct(io);
> >  
> >  	return io;
> > @@ -692,6 +699,8 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
> >  
> >  static void free_tio(struct dm_target_io *tio)
> >  {
> > +	list_del_init(&tio->list);
> > +
> >  	if (tio->inside_dm_io)
> >  		return;
> >  	bio_put(&tio->clone);
> > @@ -936,10 +945,15 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
> >  		io_error = io->status;
> >  		bio = io->orig_bio;
> >  		end_io_acct(io);
> > +
> >  		free_io(md, io);
> >  
> > -		if (io_error == BLK_STS_DM_REQUEUE)
> > +		if (io_error == BLK_STS_DM_REQUEUE) {
> > +			/* not poll any more in case of requeue */
> > +			if (bio->bi_opf & REQ_POLLED)
> > +				bio->bi_opf &= ~REQ_POLLED;
> >  			return;
> > +		}
> >  
> >  		if ((bio->bi_opf & REQ_PREFLUSH) && bio->bi_iter.bi_size) {
> >  			/*
> > @@ -1043,7 +1057,9 @@ static void clone_endio(struct bio *bio)
> >  		up(&md->swap_bios_semaphore);
> >  	}
> >  
> > -	free_tio(tio);
> > +	/* Any cloned bio submitted as POLLED, free them all after dm_io is done */
> > +	if (list_empty(&tio->list))
> > +		free_tio(tio);
> >  	dec_pending(io, error);
> >  }
> >  
> > @@ -1300,6 +1316,11 @@ static void __map_bio(struct dm_target_io *tio)
> >  	struct dm_io *io = tio->io;
> >  	struct dm_target *ti = tio->ti;
> >  
> > +	if (clone->bi_opf & REQ_POLLED)
> > +		list_add_tail(&tio->list, &io->poll_head);
> > +	else
> > +		INIT_LIST_HEAD(&tio->list);
> > +
> 
> Why not INIT_LIST_HEAD() at end of alloc_tio()? Shouldn't that be done
> even if you have this else claue here because you can clear REQ_POLLED
> on BLK_STS_DM_REQUEUE? (otherwise you're calling list_add_tail on list
> that wasn't ever INIT_LIST_HEAD).

It is fine to add one un-initialized list node via list_add_tail(), just
the list itself has to be initialized well.

> 
> >  	clone->bi_end_io = clone_endio;
> >  
> >  	/*
> > @@ -1666,8 +1687,9 @@ static void __split_and_process_bio(struct mapped_device *md,
> >  		}
> >  	}
> >  
> > -	/* drop the extra reference count */
> > -	dec_pending(ci.io, errno_to_blk_status(error));
> > +	/* drop the extra reference count for non-POLLED bio */
> > +	if (!(bio->bi_opf & REQ_POLLED))
> > +		dec_pending(ci.io, errno_to_blk_status(error));
> >  }
> >  
> >  static void dm_submit_bio(struct bio *bio)
> > @@ -1707,6 +1729,34 @@ static void dm_submit_bio(struct bio *bio)
> >  	dm_put_live_table(md, srcu_idx);
> >  }
> >  
> > +static int dm_poll_bio(struct bio *bio, unsigned int flags)
> > +{
> > +	struct dm_io *io = bio->bi_bio_drv_data;
> > +	struct dm_target_io *tio;
> > +
> > +	if (!(bio->bi_opf & REQ_POLLED) || !io)
> > +		return 0;
> 
> Should this be a WARN_ON()? Cannot see why this would ever happen
> other than a bug?  Or is there some race that makes it more likely?

REQ_POLLED can be cleared in case of requeue or blk_queue_split(), however
the upper layer still keeps polling. And we need to return simply for
bios which will be completed via IRQ.


Thanks,
Ming

