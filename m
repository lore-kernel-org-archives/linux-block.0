Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3439C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9EC23B28
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 16:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbhANQHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbhANQHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 11:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610640397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Ue2oTqzUauGiC3/nXqCxLeCghBHyE2PI1REDvBNOnM=;
        b=EsoD1pH9I/Tw2np4RSgfFebNz9bpfBKtbS+PEyBMmjWlK2LpQ2XypDgXTSMaCPjqe/k6KP
        TXHJhq5LqgKFA68rlh7LpAqOsq5lrFOH1cL5tvubZ93IoC7VvxpnNIZuNGaKlOnSVBVbd0
        2/+7Ea482iY1bY1sUlqkNEeVPAZugAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-qW59LuyIN7uytaAATVUk6w-1; Thu, 14 Jan 2021 11:06:35 -0500
X-MC-Unique: qW59LuyIN7uytaAATVUk6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E88E806662;
        Thu, 14 Jan 2021 16:06:33 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A286A5D734;
        Thu, 14 Jan 2021 16:06:29 +0000 (UTC)
Date:   Thu, 14 Jan 2021 11:06:29 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v3 2/6] block: keyslot-manager: Introduce functions for
 device mapper support
Message-ID: <20210114160628.GA26178@redhat.com>
References: <20201229085524.2795331-1-satyat@google.com>
 <20201229085524.2795331-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229085524.2795331-3-satyat@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 29 2020 at  3:55am -0500,
Satya Tangirala <satyat@google.com> wrote:

> Introduce blk_ksm_update_capabilities() to update the capabilities of
> a keyslot manager (ksm) in-place. The pointer to a ksm in a device's
> request queue may not be easily replaced, because upper layers like
> the filesystem might access it (e.g. for programming keys/checking
> capabilities) at the same time the device wants to replace that
> request queue's ksm (and free the old ksm's memory). This function
> allows the device to update the capabilities of the ksm in its request
> queue directly.
> 
> Also introduce blk_ksm_is_superset() which checks whether one ksm's
> capabilities are a (not necessarily strict) superset of another ksm's.
> The blk-crypto framework requires that crypto capabilities that were
> advertised when a bio was created continue to be supported by the
> device until that bio is ended - in practice this probably means that
> a device's advertised crypto capabilities can *never* "shrink" (since
> there's no synchronization between bio creation and when a device may
> want to change its advertised capabilities) - so a previously
> advertised crypto capability must always continue to be supported.
> This function can be used to check that a new ksm is a valid
> replacement for an old ksm.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/keyslot-manager.c         | 91 +++++++++++++++++++++++++++++++++
>  include/linux/keyslot-manager.h |  9 ++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index ac7ce83a76e8..f13ab7410eca 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -424,6 +424,97 @@ void blk_ksm_unregister(struct request_queue *q)
>  	q->ksm = NULL;
>  }
>  
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
> + *			   and DUN bytes that another KSM supports. Here,
> + *			   "superset" refers to the mathematical meaning of the
> + *			   word - i.e. if two KSMs have the *same* capabilities,
> + *			   they *are* considered supersets of each other.
> + * @ksm_superset: The KSM that we want to verify is a superset
> + * @ksm_subset: The KSM that we want to verify is a subset
> + *
> + * Return: True if @ksm_superset supports a superset of the crypto modes and DUN
> + *	   bytes that @ksm_subset supports.
> + */
> +bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
> +			 struct blk_keyslot_manager *ksm_subset)
> +{
> +	int i;
> +
> +	if (!ksm_subset)
> +		return true;
> +
> +	if (!ksm_superset)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(ksm_superset->crypto_modes_supported); i++) {
> +		if (ksm_subset->crypto_modes_supported[i] &
> +		    (~ksm_superset->crypto_modes_supported[i])) {
> +			return false;
> +		}
> +	}
> +
> +	if (ksm_subset->max_dun_bytes_supported >
> +	    ksm_superset->max_dun_bytes_supported) {
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_is_superset);
> +
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
> +

Given the patch header's preamble about FS possibly accessing/checking
the existing ksm: without any locking or other coordination how is
blk_ksm_update_capabilities() safe?

Please document any assumptions about the caller (e.g. DM) that enables
blk_ksm_update_capabilities() to be used safely.

Mike

>  /**
>   * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
>   * @ksm: The keyslot manager to init
> diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
> index 323e15dd6fa7..164568f52be7 100644
> --- a/include/linux/keyslot-manager.h
> +++ b/include/linux/keyslot-manager.h
> @@ -103,6 +103,15 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
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
>  #endif /* __LINUX_KEYSLOT_MANAGER_H */
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

