Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF9AC4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7642072D
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603834646;
	bh=tjTgAO/jVWbVSigsqdFhGVYBFk1ngLg1P+Z1R+M5L7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EnMDvTxsJuIZmnmGsXgT1RLS12gmdl0qZHIW7+yK9QKP/wXcqbh3jGXRvl2A+Syhe
	 mrRm0iySmwO+Gyjrw+iGFIcr1/uDqA4pBeTDMe8Pi+IdK2XSxE4MT/BPgOVFUsIQ8m
	 76EfoYiMS+ToaszaV6ohQulvZEKwK6+Sj62UrCQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505975AbgJ0VhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505917AbgJ0VhZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 17:37:25 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0042F207E8;
        Tue, 27 Oct 2020 21:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603834313;
        bh=tjTgAO/jVWbVSigsqdFhGVYBFk1ngLg1P+Z1R+M5L7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uWvM/K+GGAMjqjB5hn2D3ZTjPAhfcZUw1LLe1zjxEFDmSTZ+xKSbqczjaQMLOnlT
         VGH36Df/UnW3ETm3CSSAkHF9Sktvzuet3nvrphN53MCJq3Yli8E+siUQc0tl5weWCP
         Vc5/NWYRh7sWtQrphV1dontBbkV7pED1YprbgLe0=
Date:   Tue, 27 Oct 2020 14:31:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2 3/4] dm: add support for passing through inline crypto
 support
Message-ID: <20201027213151.GC2416412@gmail.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015214632.41951-4-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 15, 2020 at 09:46:31PM +0000, Satya Tangirala wrote:
> Update the device-mapper core to support exposing the inline crypto
> support of the underlying device(s) through the device-mapper device.
> 
> This works by creating a "passthrough keyslot manager" for the dm
> device, which declares support for encryption settings which all
> underlying devices support.  When a supported setting is used, the bio
> cloning code handles cloning the crypto context to the bios for all the
> underlying devices.  When an unsupported setting is used, the blk-crypto
> fallback is used as usual.
> 
> Crypto support on each underlying device is ignored unless the
> corresponding dm target opts into exposing it.  This is needed because
> for inline crypto to semantically operate on the original bio, the data
> must not be transformed by the dm target.  Thus, targets like dm-linear
> can expose crypto support of the underlying device, but targets like
> dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> 
> When a key is evicted from the dm device, it is evicted from all
> underlying devices.
> 
> A DM device's table can only be changed if the "new" inline encryption
> capabilities are a superset of the "old" inline encryption capabilities.
> Attempts to make changes to the table that result in some inline encryption
> capability becoming no longer supported will be rejected.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk-crypto.c              |   1 +
>  block/keyslot-manager.c         |  89 +++++++++++++
>  drivers/md/dm-ioctl.c           |   8 ++
>  drivers/md/dm.c                 | 217 +++++++++++++++++++++++++++++++-
>  drivers/md/dm.h                 |  19 +++
>  include/linux/device-mapper.h   |   6 +
>  include/linux/keyslot-manager.h |  17 +++
>  7 files changed, 356 insertions(+), 1 deletion(-)

I'm having a hard time understanding what's going on in this patch now.  Besides
the simplifications I'm suggesting in other comments below, you should consider
splitting this into more than one patch.  The block layer changes could be a
separate patch, as could the key eviction support.

> 
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 5da43f0973b4..c2be8f15006c 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -409,3 +409,4 @@ int blk_crypto_evict_key(struct request_queue *q,
>  	 */
>  	return blk_crypto_fallback_evict_key(key);
>  }
> +EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 5ad476dafeab..e16e4a074765 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -416,6 +416,95 @@ void blk_ksm_unregister(struct request_queue *q)
>  {
>  	q->ksm = NULL;
>  }
> +EXPORT_SYMBOL_GPL(blk_ksm_unregister);

blk_ksm_unregister() doesn't seem to be necessary, since it just sets a pointer
to NULL, which the callers could easily do themselves.

> +/**
> + * blk_ksm_intersect_modes() - restrict supported modes by child device
> + * @parent: The keyslot manager for parent device
> + * @child: The keyslot manager for child device, or NULL
> + *
> + * Clear any crypto mode support bits in @parent that aren't set in @child.
> + * If @child is NULL, then all parent bits are cleared.
> + *
> + * Only use this when setting up the keyslot manager for a layered device,
> + * before it's been exposed yet.
> + */
> +void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
> +			     const struct blk_keyslot_manager *child)
> +{
> +	if (child) {
> +		unsigned int i;
> +
> +		parent->max_dun_bytes_supported =
> +			min(parent->max_dun_bytes_supported,
> +			    child->max_dun_bytes_supported);
> +		for (i = 0; i < ARRAY_SIZE(child->crypto_modes_supported);
> +		     i++) {
> +			parent->crypto_modes_supported[i] &=
> +				child->crypto_modes_supported[i];
> +		}
> +	} else {
> +		parent->max_dun_bytes_supported = 0;
> +		memset(parent->crypto_modes_supported, 0,
> +		       sizeof(parent->crypto_modes_supported));
> +	}
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_intersect_modes);
> +
> +/**
> + * blk_ksm_is_superset() - Check if a KSM supports a superset of crypto modes
> + *			   and DUN bytes that another KSM supports.
> + * @ksm_superset: The KSM that we want to verify is a superset
> + * @ksm_subset: The KSM that we want to verify is a subset
> + *
> + * Return: True if @ksm_superset supports a superset of the crypto modes and DUN
> + *	   bytes that @ksm_subset supports.
> + */
> +bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
> +			 struct blk_keyslot_manager *ksm_subset)

blk_ksm_is_superset() is confusing because it actually does "superset or the
same", not just "superset".  That *is* the mathematical definition of superset,
but it may not be what people expect when they read this...  Is there a better
name, or can the comment properly explain it?

> +/**
> + * blk_ksm_update_capabilities() - Update the restrictions of a KSM to those of
> + *				   another KSM
> + * @target_ksm: The KSM whose restrictions to update.
> + * @reference_ksm: The KSM to whose restrictions this function will update
> + *		   @target_ksm's restrictions to,
> + */
> +void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
> +				 struct blk_keyslot_manager *reference_ksm)
> +{
> +	memcpy(target_ksm->crypto_modes_supported,
> +	       reference_ksm->crypto_modes_supported,
> +	       sizeof(target_ksm->crypto_modes_supported));
> +
> +	target_ksm->max_dun_bytes_supported =
> +				reference_ksm->max_dun_bytes_supported;
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_update_capabilities);

Wouldn't it be easier to replace the original blk_keyslot_manager, rather than
modify it?  Then blk_ksm_update_capabilities() wouldn't be needed.

> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index cd0478d44058..2b3efa9f9fae 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1358,6 +1358,10 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
>  		goto err_unlock_md_type;
>  	}
>  
> +	r = dm_verify_inline_encryption(md, t);
> +	if (r)
> +		goto err_unlock_md_type;
> +
>  	if (dm_get_md_type(md) == DM_TYPE_NONE) {
>  		/* Initial table load: acquire type of table. */
>  		dm_set_md_type(md, dm_table_get_type(t));
> @@ -2114,6 +2118,10 @@ int __init dm_early_create(struct dm_ioctl *dmi,
>  	if (r)
>  		goto err_destroy_table;
>  
> +	r = dm_verify_inline_encryption(md, t);
> +	if (r)
> +		goto err_destroy_table;
> +
>  	md->type = dm_table_get_type(t);
>  	/* setup md->queue to reflect md's type (may block) */
>  	r = dm_setup_md_queue(md, t);

Both table_load() and dm_early_create() call dm_setup_md_queue().  Wouldn't it
be simpler to handle inline encryption in dm_setup_md_queue(), instead of doing
it in both table_load() and dm_early_create()?

> +/*
> + * Constructs and returns a keyslot manager that represents the crypto
> + * capabilities of the devices described by the dm_table. However, if the
> + * constructed keyslot manager does not support a superset of the crypto
> + * capabilities supported by the currect keyslot manager of the mapped_device,
> + * it returns an error instead, since we don't support restricting crypto
> + * capabilities on table changes.
> + */
> +static struct blk_keyslot_manager *
> +dm_init_inline_encryption(struct mapped_device *md, struct dm_table *t)
> +{
> +	struct blk_keyslot_manager *ksm;
> +	struct dm_target *ti;
> +	unsigned int i;
> +
> +	ksm = kmalloc(sizeof(*ksm), GFP_KERNEL);
> +	if (!ksm)
> +		return ERR_PTR(-EINVAL);

ENOMEM, not EINVAL.

> +	blk_ksm_init_passthrough(ksm);
> +	ksm->ksm_ll_ops = dm_ksm_ll_ops;
> +	ksm->max_dun_bytes_supported = UINT_MAX;
> +	memset(ksm->crypto_modes_supported, 0xFF,
> +	       sizeof(ksm->crypto_modes_supported));
> +	ksm->priv = md;
> +
> +	for (i = 0; i < dm_table_get_num_targets(t); i++) {
> +		ti = dm_table_get_target(t, i);
> +
> +		if (!ti->may_passthrough_inline_crypto) {
> +			blk_ksm_intersect_modes(ksm, NULL);
> +			break;
> +		}
> +		if (!ti->type->iterate_devices)
> +			continue;
> +		ti->type->iterate_devices(ti, device_intersect_crypto_modes,
> +					  ksm);
> +	}
> +
> +	if (!blk_ksm_is_superset(ksm, md->queue->ksm)) {
> +		DMWARN("Inline encryption capabilities of new DM table were more restrictive than the old table's. This is not supported!");
> +		blk_ksm_destroy(ksm);
> +		return ERR_PTR(-EOPNOTSUPP);

Missing kfree(ksm).

Also it looks like other code is using EINVAL for a bad dm table.

> +	}
> +
> +	return ksm;

How about returning NULL if no crypto modes are actually supported?

> +/**
> + * dm_verify_inline_encryption() - Verifies that the current keyslot manager of
> + *				   the mapped_device can be replaced by the
> + *				   keyslot manager of a given dm_table.
> + * @md: The mapped_device
> + * @t: The dm_table
> + *
> + * In particular, this function checks that the keyslot manager that will be
> + * constructed for the dm_table will support a superset of the capabilities that
> + * the current keyslot manager of the mapped_device supports.
> + *
> + * Return: 0 if the table's keyslot_manager can replace the current keyslot
> + *	   manager of the mapped_device. Negative value otherwise.
> + */
> +int dm_verify_inline_encryption(struct mapped_device *md, struct dm_table *t)
> +{
> +	struct blk_keyslot_manager *ksm = dm_init_inline_encryption(md, t);
> +
> +	if (IS_ERR(ksm))
> +		return PTR_ERR(ksm);
> +	blk_ksm_destroy(ksm);
> +
> +	return 0;
> +}

This function seems redundant with dm_init_inline_encryption().  Wouldn't it be
simpler to do:

- dm_setup_md_queue() and dm_swap_table() call dm_init_inline_encryption() after
  dm_calculate_queue_limits().

- ksm gets passed to dm_table_set_restrictions(), which calls
  dm_update_keyslot_manager() (maybe rename to dm_update_inline_encryption()?)
  to actually set q->ksm.

That way, the crypto capabilities would be handled similarly to how the
queue_limits are already handled.

> +static void dm_update_keyslot_manager(struct mapped_device *md,
> +				      struct blk_keyslot_manager *ksm)
> +{
> +	bool ksm_is_empty = true;
> +	int i;
> +
> +	/*
> +	 * If the new KSM doesn't actually support any crypto modes, we may as
> +	 * well set a NULL ksm.
> +	 */
> +	ksm_is_empty = true;
> +	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
> +		if (ksm->crypto_modes_supported[i]) {
> +			ksm_is_empty = false;
> +			break;
> +		}
> +	}

dm_init_inline_encryption() seems like a better place for this "are no modes
supported" logic.

> +	if (ksm_is_empty) {
> +		blk_ksm_destroy(ksm);
> +
> +		/* At this point, md->queue->ksm must also be NULL, since we're
> +		 * guaranteed that ksm is a superset of md->queue->ksm, and we
> +		 * never set md->queue->ksm to a non-null empty ksm.
> +		 */
> +		if (WARN_ON(md->queue->ksm))
> +			blk_ksm_register(NULL, md->queue);
> +		return;
> +	}
> +
> +	/* Make the ksm less restrictive */
> +	if (!md->queue->ksm) {
> +		blk_ksm_register(ksm, md->queue);
> +	} else {
> +		blk_ksm_update_capabilities(md->queue->ksm, ksm);
> +		blk_ksm_destroy(ksm);
> +	}
> +}

Wouldn't it be simpler to just destroy (and free) the existing
blk_keyslot_manager (if any), then set the new one (if it's not NULL)?

> +static void dm_destroy_inline_encryption(struct mapped_device *md)
> +{
> +	if (!md->queue->ksm)
> +		return;
> +	blk_ksm_destroy(md->queue->ksm);

Missing kfree().

> +	blk_ksm_unregister(md->queue);
> +}
> +
> +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> +
> +static inline struct blk_keyslot_manager *
> +dm_init_inline_encryption(struct mapped_device *md, struct dm_table *t)
> +{
> +	return NULL;
> +}

Seems it would be simpler for these functions to take a request_queue instead of
a mapped_device.

>  /*
>   * Returns old map, which caller must destroy.
>   */
> @@ -1959,6 +2164,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>  	struct request_queue *q = md->queue;
>  	bool request_based = dm_table_request_based(t);
>  	sector_t size;
> +	struct blk_keyslot_manager *ksm;
>  	int ret;
>  
>  	lockdep_assert_held(&md->suspend_lock);
> @@ -1994,12 +2200,21 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>  		md->immutable_target = dm_table_get_immutable_target(t);
>  	}
>  
> +	ksm = dm_init_inline_encryption(md, t);
> +	if (IS_ERR(ksm)) {
> +		old_map = ERR_PTR(PTR_ERR(ksm));
> +		goto out;
> +	}

It seems too late to fail here, since the mapped_device already started being
updated.  What I suggested above would address this.

> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +
>  /**
>   * struct blk_ksm_ll_ops - functions to manage keyslots in hardware
>   * @keyslot_program:	Program the specified key into the specified slot in the
> @@ -106,6 +108,21 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
>  
>  void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
>  
> +void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
> +			     const struct blk_keyslot_manager *child);
> +
>  void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
>  
> +bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
> +			 struct blk_keyslot_manager *ksm_subset);
> +
> +void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
> +				 struct blk_keyslot_manager *reference_ksm);
> +
> +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> +
> +static inline void blk_ksm_destroy(struct blk_keyslot_manager *ksm) { }
> +
> +#endif /* CONFIG_BLK_INLINE_ENCRYPTION */

Is the blk_ksm_destroy() stub really needed?

- Eric
