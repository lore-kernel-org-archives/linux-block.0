Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E2DC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 13:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiFCNJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFCNJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 09:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5C5A33E00
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654261750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9qpSZJO9QNr00nSiNhNTRyY6iA7MBvjATWpDOR1h3Y=;
        b=Xdub2lkbakA8a9aRfo996B+fAEvrxA0+GekODjtZYC7HUJOrMrJ0fwtB2XFBkPIkdAfX32
        AO7i7L4EJwSs6hejnfMqNX5MwyisHgiVqMP1p+wq157jUUkSIvzZCN8f28vE3xrpbKPWnI
        xRfeKQSdeUtAU8OVHyx4AnhSWHuKRNs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-pfb5skUyOt2L0EVNiMKqew-1; Fri, 03 Jun 2022 09:09:10 -0400
X-MC-Unique: pfb5skUyOt2L0EVNiMKqew-1
Received: by mail-qt1-f197.google.com with SMTP id u17-20020a05622a199100b002fbc827c739so5843598qtc.8
        for <linux-block@vger.kernel.org>; Fri, 03 Jun 2022 06:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k9qpSZJO9QNr00nSiNhNTRyY6iA7MBvjATWpDOR1h3Y=;
        b=2v47OgaFN6e1p/NtSN0+fJzghKaj/hTzfkdFzvHL7Q84L/ApGQnx9NebkmQMCmw9xG
         5wPQIQ9ww1QumiQKow6FFTBoZJWICQ3VOXrSiQB8IQG6x++nTNkBLKc7DuxDQzT2qgPq
         NbakkmRNmwZZAZCf36YGbdDJDD4tTE55jF4QXGSmCyP8g4/JLysctAa2BoG6Dc8YNChO
         6mEwmPPsId4b93TizFkNagVqVrwID6Slo5w8wuMLdLVOj41mWrTtTj4XysEL8C2ManaW
         dHhIOfI+nKbZo+OUv9yrBfK7XXaZbhzpO1JYweNzM3b2fQNbiq1vpDRGNBju1GJ37Bzz
         WtHw==
X-Gm-Message-State: AOAM530FF20YRByXiLEI/66zCBWrSzYu0Qelf/S4fMbnmpYY5HvpAaKc
        qPfvCZxxC+H38iVcuy16UY1qP8sy9Y+CVPMQ49mvZ4GkIZ3HWoZPYQ3W6PnJi98OsExDAkZIrVZ
        33YRAE2n7YpJDxtCJRwsiwA==
X-Received: by 2002:a0c:9028:0:b0:461:c7b9:5ae0 with SMTP id o37-20020a0c9028000000b00461c7b95ae0mr6945146qvo.18.1654261748671;
        Fri, 03 Jun 2022 06:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn4CIfrQftrTvlTQ3/tkaymnrRbr9EEjHzpZI3Nsdq7t59Ck5vfTVhtPC1/YTfxNvwLlRIBg==
X-Received: by 2002:a0c:9028:0:b0:461:c7b9:5ae0 with SMTP id o37-20020a0c9028000000b00461c7b95ae0mr6945117qvo.18.1654261748258;
        Fri, 03 Jun 2022 06:09:08 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a010700b00302ee555a18sm5213570qtw.5.2022.06.03.06.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:09:07 -0700 (PDT)
Date:   Fri, 3 Jun 2022 09:09:06 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <YpoH8uYWf38QkAJU@redhat.com>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
 <YpcBgY9MMgumEjTL@infradead.org>
 <Ypd0DnmjvCoWj+1P@redhat.com>
 <Yphw2n3ERoFsWgEe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yphw2n3ERoFsWgEe@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 02 2022 at  4:12P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 01, 2022 at 10:13:34AM -0400, Mike Snitzer wrote:
> > Please take the time to look at the code and save your judgement until
> > you do.  That said, I'm not in love with the complexity of how DM
> > handles bioset initialization.  But both you and Jens keep taking
> > shots at DM for doing things wrong without actually looking.
> 
> I'm not taking shots.  I'm just saying we should kill this API.  In
> the worse case the caller can keep track of if a bioset is initialized,
> but in most cases we should be able to deduct it in a nicer way.
> 
> > DM uses bioset_init_from_src().  Yet you've both assumed double frees
> > and such (while not entirely wrong your glossing over the detail that
> > there is intervening reinitialization of DM's biosets between the
> > bioset_exit()s)
> 
> And looking at the code, that use of bioset_init_from_src is completely
> broken.  It does not actually preallocated anything as intended by
> dm (maybe that isn't actually needed) but just uses the biosets in
> dm_md_mempools as an awkward way to carry parameters.

I think the point was to keep the biosets embedded in struct
mapped_device to avoid any possible cacheline bouncing due to the
bioset memory being disjoint.

But preserving that micro-optimization isn't something I've ever
quantified (at least not with focus).

> And completely loses bringing over the integrity allocations.

Good catch.
 
> This is what I think should fix this, and will allow us to remove
> bioset_init_from_src which was a bad idea from the start:

Looks fine, did you want to send an official patch with a proper
header and Signed-off-by?

Thanks,
Mike

> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index d21648a923ea9..54c0473a51dde 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -33,6 +33,14 @@ struct dm_kobject_holder {
>   * access their members!
>   */
>  
> +/*
> + * For mempools pre-allocation at the table loading time.
> + */
> +struct dm_md_mempools {
> +	struct bio_set bs;
> +	struct bio_set io_bs;
> +};
> +
>  struct mapped_device {
>  	struct mutex suspend_lock;
>  
> @@ -110,8 +118,7 @@ struct mapped_device {
>  	/*
>  	 * io objects are allocated from here.
>  	 */
> -	struct bio_set io_bs;
> -	struct bio_set bs;
> +	struct dm_md_mempools *mempools;
>  
>  	/* kobject and completion */
>  	struct dm_kobject_holder kobj_holder;
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 6087cdcaad46d..a83b98a8d2a99 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -319,7 +319,7 @@ static int setup_clone(struct request *clone, struct request *rq,
>  {
>  	int r;
>  
> -	r = blk_rq_prep_clone(clone, rq, &tio->md->bs, gfp_mask,
> +	r = blk_rq_prep_clone(clone, rq, &tio->md->mempools->bs, gfp_mask,
>  			      dm_rq_bio_constructor, tio);
>  	if (r)
>  		return r;
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 0e833a154b31d..a8b016d6bf16e 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1044,11 +1044,6 @@ void dm_table_free_md_mempools(struct dm_table *t)
>  	t->mempools = NULL;
>  }
>  
> -struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t)
> -{
> -	return t->mempools;
> -}
> -
>  static int setup_indexes(struct dm_table *t)
>  {
>  	int i;
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index dfb0a551bd880..8b21155d3c4f5 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -136,14 +136,6 @@ static int get_swap_bios(void)
>  	return latch;
>  }
>  
> -/*
> - * For mempools pre-allocation at the table loading time.
> - */
> -struct dm_md_mempools {
> -	struct bio_set bs;
> -	struct bio_set io_bs;
> -};
> -
>  struct table_device {
>  	struct list_head list;
>  	refcount_t count;
> @@ -581,7 +573,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
>  	struct dm_target_io *tio;
>  	struct bio *clone;
>  
> -	clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->io_bs);
> +	clone = bio_alloc_clone(NULL, bio, GFP_NOIO, &md->mempools->io_bs);
>  	/* Set default bdev, but target must bio_set_dev() before issuing IO */
>  	clone->bi_bdev = md->disk->part0;
>  
> @@ -628,7 +620,8 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
>  	} else {
>  		struct mapped_device *md = ci->io->md;
>  
> -		clone = bio_alloc_clone(NULL, ci->bio, gfp_mask, &md->bs);
> +		clone = bio_alloc_clone(NULL, ci->bio, gfp_mask,
> +					&md->mempools->bs);
>  		if (!clone)
>  			return NULL;
>  		/* Set default bdev, but target must bio_set_dev() before issuing IO */
> @@ -1876,8 +1869,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  {
>  	if (md->wq)
>  		destroy_workqueue(md->wq);
> -	bioset_exit(&md->bs);
> -	bioset_exit(&md->io_bs);
> +	dm_free_md_mempools(md->mempools);
>  
>  	if (md->dax_dev) {
>  		dax_remove_host(md->disk);
> @@ -2049,48 +2041,6 @@ static void free_dev(struct mapped_device *md)
>  	kvfree(md);
>  }
>  
> -static int __bind_mempools(struct mapped_device *md, struct dm_table *t)
> -{
> -	struct dm_md_mempools *p = dm_table_get_md_mempools(t);
> -	int ret = 0;
> -
> -	if (dm_table_bio_based(t)) {
> -		/*
> -		 * The md may already have mempools that need changing.
> -		 * If so, reload bioset because front_pad may have changed
> -		 * because a different table was loaded.
> -		 */
> -		bioset_exit(&md->bs);
> -		bioset_exit(&md->io_bs);
> -
> -	} else if (bioset_initialized(&md->bs)) {
> -		/*
> -		 * There's no need to reload with request-based dm
> -		 * because the size of front_pad doesn't change.
> -		 * Note for future: If you are to reload bioset,
> -		 * prep-ed requests in the queue may refer
> -		 * to bio from the old bioset, so you must walk
> -		 * through the queue to unprep.
> -		 */
> -		goto out;
> -	}
> -
> -	BUG_ON(!p ||
> -	       bioset_initialized(&md->bs) ||
> -	       bioset_initialized(&md->io_bs));
> -
> -	ret = bioset_init_from_src(&md->bs, &p->bs);
> -	if (ret)
> -		goto out;
> -	ret = bioset_init_from_src(&md->io_bs, &p->io_bs);
> -	if (ret)
> -		bioset_exit(&md->bs);
> -out:
> -	/* mempool bind completed, no longer need any mempools in the table */
> -	dm_table_free_md_mempools(t);
> -	return ret;
> -}
> -
>  /*
>   * Bind a table to the device.
>   */
> @@ -2144,12 +2094,28 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>  		 * immutable singletons - used to optimize dm_mq_queue_rq.
>  		 */
>  		md->immutable_target = dm_table_get_immutable_target(t);
> -	}
>  
> -	ret = __bind_mempools(md, t);
> -	if (ret) {
> -		old_map = ERR_PTR(ret);
> -		goto out;
> +		/*
> +		 * There is no need to reload with request-based dm because the
> +		 * size of front_pad doesn't change.
> +		 *
> +		 * Note for future: If you are to reload bioset, prep-ed
> +		 * requests in the queue may refer to bio from the old bioset,
> +		 * so you must walk through the queue to unprep.
> +		 */
> +		if (!md->mempools) {
> +			md->mempools = t->mempools;
> +			t->mempools = NULL;
> +		}
> +	} else {
> +		/*
> +		 * The md may already have mempools that need changing.
> +		 * If so, reload bioset because front_pad may have changed
> +		 * because a different table was loaded.
> +		 */
> +		dm_free_md_mempools(md->mempools);
> +		md->mempools = t->mempools;
> +		t->mempools = NULL;
>  	}
>  
>  	ret = dm_table_set_restrictions(t, md->queue, limits);
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index 3f89664fea010..86642234d4adb 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -72,7 +72,6 @@ struct dm_target *dm_table_get_wildcard_target(struct dm_table *t);
>  bool dm_table_bio_based(struct dm_table *t);
>  bool dm_table_request_based(struct dm_table *t);
>  void dm_table_free_md_mempools(struct dm_table *t);
> -struct dm_md_mempools *dm_table_get_md_mempools(struct dm_table *t);
>  
>  void dm_lock_md_type(struct mapped_device *md);
>  void dm_unlock_md_type(struct mapped_device *md);
> 

