Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D09AC55179
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E3620720
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603849654;
	bh=64WD8N3Jdh0k9s8/dbTgUj57aRyxZOU1EhEW52HUC0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mk3ajcVod3CwyRb0wiRbTXrTJyUIOdjTRqKGC5jr/X2O+Hj7h6akuynKQYXdrXl/d
	 DRLfMeajJhY/dEd7OLYxUp2kJ4dUMEdXCyfchF15qPk6DXwqrAnrG98KIGLoY2YQou
	 qMsydWCrzEKCOaqP+lRK1R/cnKn4g/VZIqt86F8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgJ1Bip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1833090AbgJ1ARd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 20:17:33 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3ED820754;
        Wed, 28 Oct 2020 00:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603844253;
        bh=64WD8N3Jdh0k9s8/dbTgUj57aRyxZOU1EhEW52HUC0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lanomw3ylBChPo8GRHJEQOBALRuohS/PfE/Pii/cS0XBnUJQpo+QL2wI2WfB9scJq
         Z0QO0W4t97hRqY8bYCAhxoeBOO5FdYmgQ+DuprVmvAeZ9keW8iRD9MMBD7VCsMQAVN
         +qMIEtMM+eS6Pzd033RJLAOdMO/VWE/140DqRWjo=
Date:   Tue, 27 Oct 2020 17:17:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2 3/4] dm: add support for passing through inline crypto
 support
Message-ID: <20201028001731.GA2578048@gmail.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-4-satyat@google.com>
 <20201027213151.GC2416412@gmail.com>
 <20201027235847.GA913775@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027235847.GA913775@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 27, 2020 at 11:58:47PM +0000, Satya Tangirala wrote:
> > > +/**
> > > + * blk_ksm_update_capabilities() - Update the restrictions of a KSM to those of
> > > + *				   another KSM
> > > + * @target_ksm: The KSM whose restrictions to update.
> > > + * @reference_ksm: The KSM to whose restrictions this function will update
> > > + *		   @target_ksm's restrictions to,
> > > + */
> > > +void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
> > > +				 struct blk_keyslot_manager *reference_ksm)
> > > +{
> > > +	memcpy(target_ksm->crypto_modes_supported,
> > > +	       reference_ksm->crypto_modes_supported,
> > > +	       sizeof(target_ksm->crypto_modes_supported));
> > > +
> > > +	target_ksm->max_dun_bytes_supported =
> > > +				reference_ksm->max_dun_bytes_supported;
> > > +}
> > > +EXPORT_SYMBOL_GPL(blk_ksm_update_capabilities);
> > 
> > Wouldn't it be easier to replace the original blk_keyslot_manager, rather than
> > modify it?  Then blk_ksm_update_capabilities() wouldn't be needed.
> > 
> I didn't want to replace the original blk_keyslot_manager because it's
> possible that e.g. fscrypt is checking for crypto capabilities support
> via blk_ksm_crypto_cfg_supported() when DM wants to replace the
> blk_keyslot_manager. DM would have to free the memory used by the
> blk_keyslot_manager, but blk_ksm_crypto_cfg_supported() might still
> be trying to access that memory. I did it this way to avoid having to
> add refcounts or something else to the blk_keyslot_manager...(And I
> didn't bother adding any synchronization code since the capabilities
> only ever expand, and never contract).

Are you sure that's possible?  That would imply that there is no synchronization
between limits/capabilities in the request_queue being changed and the
request_queue being used.  That's already buggy.  Maybe it's the sort of thing
that is gotten away with in practice, in which case avoiding a free() would
indeed be a good idea, but it's worth explicitly clarifying whether all this
code is indeed racy by design...

> > > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > > index cd0478d44058..2b3efa9f9fae 100644
> > > --- a/drivers/md/dm-ioctl.c
> > > +++ b/drivers/md/dm-ioctl.c
> > > @@ -1358,6 +1358,10 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
> > >  		goto err_unlock_md_type;
> > >  	}
> > >  
> > > +	r = dm_verify_inline_encryption(md, t);
> > > +	if (r)
> > > +		goto err_unlock_md_type;
> > > +
> > >  	if (dm_get_md_type(md) == DM_TYPE_NONE) {
> > >  		/* Initial table load: acquire type of table. */
> > >  		dm_set_md_type(md, dm_table_get_type(t));
> > > @@ -2114,6 +2118,10 @@ int __init dm_early_create(struct dm_ioctl *dmi,
> > >  	if (r)
> > >  		goto err_destroy_table;
> > >  
> > > +	r = dm_verify_inline_encryption(md, t);
> > > +	if (r)
> > > +		goto err_destroy_table;
> > > +
> > >  	md->type = dm_table_get_type(t);
> > >  	/* setup md->queue to reflect md's type (may block) */
> > >  	r = dm_setup_md_queue(md, t);
> > 
> > Both table_load() and dm_early_create() call dm_setup_md_queue().  Wouldn't it
> > be simpler to handle inline encryption in dm_setup_md_queue(), instead of doing
> > it in both table_load() and dm_early_create()?
> > 
> table_load() only calls dm_setup_md_queue() on initial table load (when
> the md_type is DM_TYPE_NONE), so I can't call
> dm_verify_inline_encryption() in only dm_setup_md_queue(), because
> dm_verify_inline_encryption() needs to run on every table load.

Where do all the other limitations and capabilities of the request_queue get
updated on non-initial table loads, then?

> > > +/**
> > > + * dm_verify_inline_encryption() - Verifies that the current keyslot manager of
> > > + *				   the mapped_device can be replaced by the
> > > + *				   keyslot manager of a given dm_table.
> > > + * @md: The mapped_device
> > > + * @t: The dm_table
> > > + *
> > > + * In particular, this function checks that the keyslot manager that will be
> > > + * constructed for the dm_table will support a superset of the capabilities that
> > > + * the current keyslot manager of the mapped_device supports.
> > > + *
> > > + * Return: 0 if the table's keyslot_manager can replace the current keyslot
> > > + *	   manager of the mapped_device. Negative value otherwise.
> > > + */
> > > +int dm_verify_inline_encryption(struct mapped_device *md, struct dm_table *t)
> > > +{
> > > +	struct blk_keyslot_manager *ksm = dm_init_inline_encryption(md, t);
> > > +
> > > +	if (IS_ERR(ksm))
> > > +		return PTR_ERR(ksm);
> > > +	blk_ksm_destroy(ksm);
> > > +
> > > +	return 0;
> > > +}
> > 
> > This function seems redundant with dm_init_inline_encryption().  Wouldn't it be
> > simpler to do:
> > 
> > - dm_setup_md_queue() and dm_swap_table() call dm_init_inline_encryption() after
> >   dm_calculate_queue_limits().
> > 
> > - ksm gets passed to dm_table_set_restrictions(), which calls
> >   dm_update_keyslot_manager() (maybe rename to dm_update_inline_encryption()?)
> >   to actually set q->ksm.
> > 
> > That way, the crypto capabilities would be handled similarly to how the
> > queue_limits are already handled.
> > 
> If we call it from dm_swap_table(), we could have it pass the returned
> ksm to __bind(), either as a new argument, or by adding the ksm to the
> queue_limits (I'll have to check if that's ok/a good idea in the first
> place), and __bind() could send the argument to
> dm_table_set_restrictions()
> 
> But the real issue is, I think we should check whether a new table is
> valid (from the ksm capabilities support perspective) at the time that
> table is loaded (as opposed to only checking it when DM attempts to swap
> it in, which might be a lot later, when the user resumes the device) - so
> I can't only call it from dm_setup_md_queue(), and I'd have to call it
> from table_load() anyway. And the returned ksm that table_load() obtains
> from dm_init_inline_encryption() can't really be used - because
> 1) the ksm constructed at dm_swap_table() might actually support more
> capabilities than the ksm constructed in table_load(), because
> underlying devices might get resumed, and have new tables swapped in,
> and might support more capabilities than before
> 2) a subsequent dm_swap_table() call could fail for whatever reason, and
> we'll need to revert to the current ksm.
> 
> What I'm doing right now is simply freeing the ksm returned by
> dm_init_inline_encryption() whenever it's called from table_load()
> (and I'm trying to make that process a little nicer by wrapping it in a
> function called dm_verify_inline_encryption()) - so if we're going to
> have to call dm_init_inline_encryption() and then freeing the returned
> ksm in table_load(), I think it might be better to continue to have
> dm_verify_inline_encryption(), unless you'd prefer just open coding the
> function directly.

I don't understand why this needs to be so complicated.  Doesn't the dm layer
have the same problem for all the other queue limits and capabilities?  What
makes inline encryption different?

- Eric
