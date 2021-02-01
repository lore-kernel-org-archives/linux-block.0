Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3539C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9E464E27
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBAF1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 00:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBAFY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 00:24:57 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45674C06178C
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:22:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r38so11257689pgk.13
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kgau3vxD8lx86uHt+rDSQhFn7BPMBlqOkVLQlLIj5pY=;
        b=E0dX55dFwLe0ofA+LT9j9+T08UjHrlEbOLfgGuAv7EyLDiq2YeeW1hJSbo7N/aSmTy
         G8PCeDDz20p7F3pMIhMUJny/SVnlvJKNxRDfrnvA7xP5epO8b0+yobYkUK6/k04oyAlb
         WUedR5jZ/SDHnO5h2N7zo3aqEOEOWTgAGEwbVqer0DecGGMfBhkXcxwMMPngCNKUsQym
         2KYmVkxv7f9xmd+KuI8/dgBqOA0ncw/LV9ApXdHAt9huWn1ByWuavONzlWf3Es3HO9UP
         Xsbjdz6agC4otenePgX8Q86huBvMuE3uNu9GfDX/0Hfh2f41nxomEQhKI61V2/yhTIbb
         Rndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kgau3vxD8lx86uHt+rDSQhFn7BPMBlqOkVLQlLIj5pY=;
        b=KLZN2yQAJFN8aGd7zuFYGqwnvhWcw7gLTL0w30M717Zzohv+z+LJIVxwVSlNgBtH+j
         NukmBZsi6rS7g9NxPMt8I+O6G575FKb7iwKqGS37vG+uOBQWuUKNBA6O3Tcwgbl5+1DM
         sybtzF8N0NscbzyPoVGnST2JtqRWehA+EuBS0NRexohIq9kjAkYU3zrP/5v48LV5Nz7S
         Q6hLUm0v8UXQxuw06DhOySjhZuLQb1+lo9yK2wM8dbTr0bSShJcRtnJoDakjrSnGhTMh
         UQN2OFjecdUvm1vzSFZEg9meRKp1vMmTQ/0/+Xj3cEzjcBIihwosutwz98dTlC/uoG5t
         +KEQ==
X-Gm-Message-State: AOAM531/az3nC9pAzjpng6cT/MNpCYnp+uR63NeCvllbMq+y/z6bgxHw
        jZEHg+/9XmbFrkXNlJwhNtSk/A==
X-Google-Smtp-Source: ABdhPJzV2RP9A/EmsI7hXrZqOHEnU/D0OmLDKcG3R+Cv254+gXsKoYOpc4nzSh5j3QdbxQYPd0MCsA==
X-Received: by 2002:a63:dd42:: with SMTP id g2mr15585498pgj.285.1612156961509;
        Sun, 31 Jan 2021 21:22:41 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id f71sm16041506pfa.138.2021.01.31.21.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 21:22:40 -0800 (PST)
Date:   Mon, 1 Feb 2021 05:22:37 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v3 3/6] dm: add support for passing through inline crypto
 support
Message-ID: <YBeQHd6whGayp5WV@google.com>
References: <20201229085524.2795331-1-satyat@google.com>
 <20201229085524.2795331-4-satyat@google.com>
 <20210114180049.GA26410@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114180049.GA26410@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 14, 2021 at 01:00:49PM -0500, Mike Snitzer wrote:
> On Tue, Dec 29 2020 at  3:55am -0500,
> Satya Tangirala <satyat@google.com> wrote:
> 
> > Update the device-mapper core to support exposing the inline crypto
> > support of the underlying device(s) through the device-mapper device.
> > 
> > This works by creating a "passthrough keyslot manager" for the dm
> > device, which declares support for encryption settings which all
> > underlying devices support.  When a supported setting is used, the bio
> > cloning code handles cloning the crypto context to the bios for all the
> > underlying devices.  When an unsupported setting is used, the blk-crypto
> > fallback is used as usual.
> > 
> > Crypto support on each underlying device is ignored unless the
> > corresponding dm target opts into exposing it.  This is needed because
> > for inline crypto to semantically operate on the original bio, the data
> > must not be transformed by the dm target.  Thus, targets like dm-linear
> > can expose crypto support of the underlying device, but targets like
> > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > 
> > A DM device's table can only be changed if the "new" inline encryption
> > capabilities are a (*not* necessarily strict) superset of the "old" inline
> > encryption capabilities.  Attempts to make changes to the table that result
> > in some inline encryption capability becoming no longer supported will be
> > rejected.
> > 
> > For the sake of clarity, key eviction from underlying devices will be
> > handled in a future patch.
> > 
> > Co-developed-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> > ---
> >  drivers/md/dm.c                 | 164 +++++++++++++++++++++++++++++++-
> >  include/linux/device-mapper.h   |   6 ++
> >  include/linux/keyslot-manager.h |   8 ++
> >  3 files changed, 177 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index b3c3c8b4cb42..13b9c8e2e21b 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/refcount.h>
> >  #include <linux/part_stat.h>
> >  #include <linux/blk-crypto.h>
> > +#include <linux/keyslot-manager.h>
> >  
> >  #define DM_MSG_PREFIX "core"
> >  
> > @@ -1718,6 +1719,8 @@ static const struct dax_operations dm_dax_ops;
> >  
> >  static void dm_wq_work(struct work_struct *work);
> >  
> > +static void dm_destroy_inline_encryption(struct request_queue *q);
> > +
> >  static void cleanup_mapped_device(struct mapped_device *md)
> >  {
> >  	if (md->wq)
> > @@ -1739,8 +1742,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
> >  		put_disk(md->disk);
> >  	}
> >  
> > -	if (md->queue)
> > +	if (md->queue) {
> > +		dm_destroy_inline_encryption(md->queue);
> >  		blk_cleanup_queue(md->queue);
> > +	}
> >  
> >  	cleanup_srcu_struct(&md->io_barrier);
> >  
> > @@ -1937,6 +1942,150 @@ static void event_callback(void *context)
> >  	dm_issue_global_event();
> >  }
> >  
> > +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> > +
> > +struct dm_keyslot_manager {
> > +	struct blk_keyslot_manager ksm;
> > +	struct mapped_device *md;
> > +};
> > +
> > +static int device_intersect_crypto_modes(struct dm_target *ti,
> > +					 struct dm_dev *dev, sector_t start,
> > +					 sector_t len, void *data)
> > +{
> > +	struct blk_keyslot_manager *parent = data;
> > +	struct blk_keyslot_manager *child = bdev_get_queue(dev->bdev)->ksm;
> > +
> > +	blk_ksm_intersect_modes(parent, child);
> > +	return 0;
> > +}
> > +
> > +static void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
> > +{
> > +	struct dm_keyslot_manager *dksm = container_of(ksm,
> > +						       struct dm_keyslot_manager,
> > +						       ksm);
> > +
> > +	if (!ksm)
> > +		return;
> > +
> > +	blk_ksm_destroy(ksm);
> > +	kfree(dksm);
> > +}
> > +
> > +/*
> > + * Constructs and returns a keyslot manager that represents the crypto
> > + * capabilities of the devices described by the dm_table. However, if the
> > + * constructed keyslot manager does not support a superset of the crypto
> > + * capabilities supported by the current keyslot manager of the mapped_device,
> > + * it returns an error instead, since we don't support restricting crypto
> > + * capabilities on table changes. Finally, if the constructed keyslot manager
> > + * doesn't actually support any crypto modes at all, it just returns NULL.
> > + */
> > +static struct blk_keyslot_manager *
> > +dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
> > +{
> > +	struct dm_keyslot_manager *dksm;
> > +	struct blk_keyslot_manager *ksm;
> > +	struct dm_target *ti;
> > +	unsigned int i;
> > +	bool ksm_is_empty = true;
> > +
> > +	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
> > +	if (!dksm)
> > +		return ERR_PTR(-ENOMEM);
> > +	dksm->md = md;
> > +
> > +	ksm = &dksm->ksm;
> > +	blk_ksm_init_passthrough(ksm);
> > +	ksm->max_dun_bytes_supported = UINT_MAX;
> > +	memset(ksm->crypto_modes_supported, 0xFF,
> > +	       sizeof(ksm->crypto_modes_supported));
> > +
> > +	for (i = 0; i < dm_table_get_num_targets(t); i++) {
> > +		ti = dm_table_get_target(t, i);
> > +
> > +		if (!dm_target_passes_crypto(ti->type)) {
> > +			blk_ksm_intersect_modes(ksm, NULL);
> > +			break;
> > +		}
> > +		if (!ti->type->iterate_devices)
> > +			continue;
> > +		ti->type->iterate_devices(ti, device_intersect_crypto_modes,
> > +					  ksm);
> > +	}
> > +
> > +	if (!blk_ksm_is_superset(ksm, md->queue->ksm)) {
> > +		DMWARN("Inline encryption capabilities of new DM table were more restrictive than the old table's. This is not supported!");
> > +		dm_destroy_keyslot_manager(ksm);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	/*
> > +	 * If the new KSM doesn't actually support any crypto modes, we may as
> > +	 * well represent it with a NULL ksm.
> > +	 */
> > +	ksm_is_empty = true;
> > +	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
> > +		if (ksm->crypto_modes_supported[i]) {
> > +			ksm_is_empty = false;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (ksm_is_empty) {
> > +		dm_destroy_keyslot_manager(ksm);
> > +		ksm = NULL;
> > +	}
> > +
> > +	return ksm;
> > +}
> > +
> > +static void dm_update_keyslot_manager(struct request_queue *q,
> > +				      struct blk_keyslot_manager *ksm)
> > +{
> > +	if (!ksm)
> > +		return;
> > +
> > +	/* Make the ksm less restrictive */
> > +	if (!q->ksm) {
> > +		blk_ksm_register(ksm, q);
> > +	} else {
> > +		blk_ksm_update_capabilities(q->ksm, ksm);
> > +		dm_destroy_keyslot_manager(ksm);
> > +	}
> > +}
> > +
> > +static void dm_destroy_inline_encryption(struct request_queue *q)
> > +{
> > +	if (!q->ksm)
> > +		return;
> > +	dm_destroy_keyslot_manager(q->ksm);
> > +}
> > +
> > +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> > +
> > +static inline struct blk_keyslot_manager *
> > +dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static void dm_update_keyslot_manager(struct request_queue *q,
> > +				      struct blk_keyslot_manager *ksm)
> > +{
> > +}
> > +
> > +static void dm_destroy_keyslot_manager(struct blk_keyslot_manager *ksm)
> > +{
> > +}
> > +
> > +static inline void dm_destroy_inline_encryption(struct request_queue *q)
> > +{
> > +}
> > +
> > +#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
> > +
> >  /*
> >   * Returns old map, which caller must destroy.
> >   */
> > @@ -2332,6 +2481,7 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
> >  {
> >  	struct dm_table *live_map = NULL, *map = ERR_PTR(-EINVAL);
> >  	struct queue_limits limits;
> > +	struct blk_keyslot_manager *ksm;
> >  	int r;
> >  
> >  	mutex_lock(&md->suspend_lock);
> > @@ -2361,7 +2511,19 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
> >  		}
> >  	}
> >  
> > +	ksm = dm_construct_keyslot_manager(md, table);
> > +	if (IS_ERR(ksm)) {
> > +		map = ERR_CAST(ksm);
> > +		goto out;
> > +	}
> > +
> 
> The work done in dm_construct_keyslot_manager() is inappropriate to do
> at this point in the DM core code.
> 
> This should be split into 2 phases:
> 1) allocation/setup of ksm in dm-table.c:dm_table_complete()
> 2) quick install of ksm in dm.c:__bind()
> 
> Memory allocation should be done as part of dm_table_complete().
> Meaning I think the ksm should be allocated on demand as part of
> dm_table creation. Then if in dm_swap_table()'s __bind() table->ksm
> isn't NULL, dm_update_keyslot_manager() is called.
> dm_update_keyslot_manager() should be updated to take dm_table rather
> than ksm (and table->ksm is set to NULL at end).
> 
> But if DM table creation's validation of ksm fails, then any newly
> allocated ksm (stored in table->ksm) should be destroyed as part of
> dm_table_destroy().
I followed your suggestion for v4 (which I just sent out at
https://lore.kernel.org/dm-devel/20210201051019.1174983-1-satyat@google.com/)

> This should also eliminate the need for an
> intermediate 'struct dm_keyslot_manager'
> 
> Mike
> 

I'd have liked to remove the struct dm_keyslot_manager too, but I think
it's still necessary because of the key eviction support introduced in
the next patch. dm_keyslot_evict() needs to know the mapped device given
the ksm. In an earlier version of the series, I tried introducing a
private data field to struct blk_keyslot_manager, but that was objected
to (and this approach was suggested instead).

> >  	map = __bind(md, table, &limits);
> > +
> > +	if (IS_ERR(map))
> > +		dm_destroy_keyslot_manager(ksm);
> > +	else
> > +		dm_update_keyslot_manager(md->queue, ksm);
> > +
> >  	dm_issue_global_event();
> >  
> >  out:
> > diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> > index 61a66fb8ebb3..0d5794a0a89a 100644
> > --- a/include/linux/device-mapper.h
> > +++ b/include/linux/device-mapper.h
> > @@ -257,6 +257,12 @@ struct target_type {
> >  #define DM_TARGET_NOWAIT		0x00000080
> >  #define dm_target_supports_nowait(type) ((type)->features & DM_TARGET_NOWAIT)
> >  
> > +/*
> > + *
> > + */
> > +#define DM_TARGET_PASSES_CRYPTO		0x00000100
> > +#define dm_target_passes_crypto(type) ((type)->features & DM_TARGET_PASSES_CRYPTO)
> > +
> >  struct dm_target {
> >  	struct dm_table *table;
> >  	struct target_type *type;
> > diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
> > index 164568f52be7..9164c1c72288 100644
> > --- a/include/linux/keyslot-manager.h
> > +++ b/include/linux/keyslot-manager.h
> > @@ -11,6 +11,8 @@
> >  
> >  struct blk_keyslot_manager;
> >  
> > +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> > +
> >  /**
> >   * struct blk_ksm_ll_ops - functions to manage keyslots in hardware
> >   * @keyslot_program:	Program the specified key into the specified slot in the
> > @@ -114,4 +116,10 @@ bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
> >  void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
> >  				 struct blk_keyslot_manager *reference_ksm);
> >  
> > +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> > +
> > +static inline void blk_ksm_destroy(struct blk_keyslot_manager *ksm) { }
> > +
> > +#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
> > +
> >  #endif /* __LINUX_KEYSLOT_MANAGER_H */
> > -- 
> > 2.29.2.729.g45daf8777d-goog
> > 
> 
