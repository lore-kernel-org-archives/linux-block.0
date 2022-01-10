Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbiAJTXT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232564AbiAJTXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 14:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641842598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9P+7rjkuZ80brejaJnx3ZF5lwbs5E/u0HcwjDODCEs=;
        b=JDExDhgp1Zqkvre6NCDQFGeTnqLzLqFxDu810Jjk5rVQGQJeWEL5PD7d+QrTzs+w09+slG
        FSUst9EQnCSe6T5AGxxAc7IqEIE/9Q9mSmIkmjghnzJF8hvNE9SCqG/5qMgWsqBU1xmfdG
        0laLCvYW7iLPZMX7EiCnxqMqcXsxb+w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-tp3KVxMoNqurNXsVYWUIHQ-1; Mon, 10 Jan 2022 14:23:17 -0500
X-MC-Unique: tp3KVxMoNqurNXsVYWUIHQ-1
Received: by mail-qt1-f199.google.com with SMTP id f28-20020ac8015c000000b002c5ccf04258so11076588qtg.1
        for <linux-block@vger.kernel.org>; Mon, 10 Jan 2022 11:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9P+7rjkuZ80brejaJnx3ZF5lwbs5E/u0HcwjDODCEs=;
        b=qPhskZWYs/qa17Jtd7DybKT4u0Nst2A69hWBeJgmhC8rRC7CV2eS1PqxT/xnwN6Zod
         xZEboBhs+mnanWyyTs7aYNy8QbKTOxm3BQZtvGyp/QGSDqm5d85lV97Gu/Cw2OXlS4I6
         i+tTOyRxZcPGA2WPhlOMvUg/rSqJjhdHmqo0KSvaD4xhN/7ve4B9PATctz2wm90l9tCE
         gcoOVgei5dqlDapAkEBofmIjt96P6U+6xsoUh0lqSpIstMgd4FBY+7/TTF6/Rnxop1vU
         GIlTZQ0p/hRVcViKGaF3r7vQCs9EHv8cP4NISYZ0J91sokakMCKfRQFIvqmsRDsh+MOB
         19CA==
X-Gm-Message-State: AOAM5336GXOVJ5wdl4zmsO0eDs03igz0FbH+/hsMN9tIX+rf0h7I8ilr
        0us++EgcI1dpwIGaLKcb7JRTbV8L4fw7mowklKpivFAmu0wZt8JpMoM6tExNq4OEiqnQwsWLb/q
        V8D0pPQplzn7E3z3nAvmdfw==
X-Received: by 2002:a05:620a:319a:: with SMTP id bi26mr883214qkb.279.1641842596318;
        Mon, 10 Jan 2022 11:23:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJRtGjimqhjfAxjf0NKmMBPu/c2EDjyLyQ4TkmAvUQknoX8nvzYlzIQcEOBUiQjok9utiIWg==
X-Received: by 2002:a05:620a:319a:: with SMTP id bi26mr883194qkb.279.1641842596048;
        Mon, 10 Jan 2022 11:23:16 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a3sm5336559qtx.66.2022.01.10.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:23:15 -0800 (PST)
Date:   Mon, 10 Jan 2022 14:23:14 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH 3/3] dm: mark dm queue as blocking if any underlying is
 blocking
Message-ID: <YdyHoo+B7J7egE1q@redhat.com>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <20211221141459.1368176-4-ming.lei@redhat.com>
 <YdcNgw14kSg+ENVL@redhat.com>
 <YdcP/fnF5xrBnq+Y@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdcP/fnF5xrBnq+Y@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 06 2022 at 10:51P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> On Thu, Jan 06, 2022 at 10:40:51AM -0500, Mike Snitzer wrote:
> > On Tue, Dec 21 2021 at  9:14P -0500,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > dm request based driver doesn't set BLK_MQ_F_BLOCKING, so dm_queue_rq()
> > > is supposed to not sleep.
> > > 
> > > However, blk_insert_cloned_request() is used by dm_queue_rq() for
> > > queuing underlying request, but the underlying queue may be marked as
> > > BLK_MQ_F_BLOCKING, so blk_insert_cloned_request() may become to block
> > > current context, then rcu warning is triggered.
> > > 
> > > Fixes the issue by marking dm request based queue as BLK_MQ_F_BLOCKING
> > > if any underlying queue is marked as BLK_MQ_F_BLOCKING, meantime we
> > > need to allocate srcu beforehand.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/md/dm-rq.c    |  5 ++++-
> > >  drivers/md/dm-rq.h    |  3 ++-
> > >  drivers/md/dm-table.c | 14 ++++++++++++++
> > >  drivers/md/dm.c       |  5 +++--
> > >  drivers/md/dm.h       |  1 +
> > >  5 files changed, 24 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> > > index 579ab6183d4d..2297d37c62a9 100644
> > > --- a/drivers/md/dm-rq.c
> > > +++ b/drivers/md/dm-rq.c
> > > @@ -535,7 +535,8 @@ static const struct blk_mq_ops dm_mq_ops = {
> > >  	.init_request = dm_mq_init_request,
> > >  };
> > >  
> > > -int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
> > > +int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t,
> > > +			     bool blocking)
> > >  {
> > >  	struct dm_target *immutable_tgt;
> > >  	int err;
> > > @@ -550,6 +551,8 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
> > >  	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
> > >  	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
> > >  	md->tag_set->driver_data = md;
> > > +	if (blocking)
> > > +		md->tag_set->flags |= BLK_MQ_F_BLOCKING;
> > >  
> > >  	md->tag_set->cmd_size = sizeof(struct dm_rq_target_io);
> > >  	immutable_tgt = dm_table_get_immutable_target(t);
> > 
> > As you can see, dm_table_get_immutable_target(t) is called here ^
> > 
> > Rather than pass 'blocking' in, please just call dm_table_has_blocking_dev(t);
> > 
> > But not a big deal, I can clean that up once this gets committed...
> > 
> > > diff --git a/drivers/md/dm-rq.h b/drivers/md/dm-rq.h
> > > index 1eea0da641db..5f3729f277d7 100644
> > > --- a/drivers/md/dm-rq.h
> > > +++ b/drivers/md/dm-rq.h
> > > @@ -30,7 +30,8 @@ struct dm_rq_clone_bio_info {
> > >  	struct bio clone;
> > >  };
> > >  
> > > -int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t);
> > > +int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t,
> > > +			     bool blocking);
> > >  void dm_mq_cleanup_mapped_device(struct mapped_device *md);
> > >  
> > >  void dm_start_queue(struct request_queue *q);
> > > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > > index aa173f5bdc3d..e4bdd4f757a3 100644
> > > --- a/drivers/md/dm-table.c
> > > +++ b/drivers/md/dm-table.c
> > > @@ -1875,6 +1875,20 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
> > >  	return true;
> > >  }
> > >  
> > > +/* If the device can block inside ->queue_rq */
> > > +static int device_is_io_blocking(struct dm_target *ti, struct dm_dev *dev,
> > > +			      sector_t start, sector_t len, void *data)
> > > +{
> > > +	struct request_queue *q = bdev_get_queue(dev->bdev);
> > > +
> > > +	return blk_queue_blocking(q);
> > > +}
> > > +
> > > +bool dm_table_has_blocking_dev(struct dm_table *t)
> > > +{
> > > +	return dm_table_any_dev_attr(t, device_is_io_blocking, NULL);
> > > +}
> > > +
> > >  static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
> > >  				     sector_t start, sector_t len, void *data)
> > >  {
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index 280918cdcabd..2f72877752dd 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > > @@ -1761,7 +1761,7 @@ static struct mapped_device *alloc_dev(int minor)
> > >  	 * established. If request-based table is loaded: blk-mq will
> > >  	 * override accordingly.
> > >  	 */
> > > -	md->disk = blk_alloc_disk(md->numa_node_id);
> > > +	md->disk = blk_alloc_disk_srcu(md->numa_node_id);
> > >  	if (!md->disk)
> > >  		goto bad;
> > >  	md->queue = md->disk->queue;
> > > @@ -2046,7 +2046,8 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
> > >  	switch (type) {
> > >  	case DM_TYPE_REQUEST_BASED:
> > >  		md->disk->fops = &dm_rq_blk_dops;
> > > -		r = dm_mq_init_request_queue(md, t);
> > > +		r = dm_mq_init_request_queue(md, t,
> > > +				dm_table_has_blocking_dev(t));
> > >  		if (r) {
> > >  			DMERR("Cannot initialize queue for request-based dm mapped device");
> > >  			return r;
> > > diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> > > index 742d9c80efe1..f7f92b272cce 100644
> > > --- a/drivers/md/dm.h
> > > +++ b/drivers/md/dm.h
> > > @@ -60,6 +60,7 @@ int dm_calculate_queue_limits(struct dm_table *table,
> > >  			      struct queue_limits *limits);
> > >  int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
> > >  			      struct queue_limits *limits);
> > > +bool dm_table_has_blocking_dev(struct dm_table *t);
> > >  struct list_head *dm_table_get_devices(struct dm_table *t);
> > >  void dm_table_presuspend_targets(struct dm_table *t);
> > >  void dm_table_presuspend_undo_targets(struct dm_table *t);
> > > -- 
> > > 2.31.1
> > > 
> > 
> > Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> 
> Thanks!
> 
> > 
> > Late, given holidays we know why, but this patchset is needed for 5.17
> > (maybe with added: 'Fixes: 704b914f15fb7 "blk-mq: move srcu from
> > blk_mq_hw_ctx to request_queue"' to this 3rd patch?)
> 
> It is one long-term issue, not related with commit 704b914f15fb7. The
> problem is that rcu read lock is held by blk-mq when running dm_queue_rq()
> which calls underlying blocking queue's ->queue_rq() which may sleep
> somewhere.

OK, really don't _need_ a Fixes since it isn't getting marked for stable@ anyway.

