Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333DC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FCD64E63
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 20:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhBJUSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhBJUSN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 15:18:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFADF64EDA;
        Wed, 10 Feb 2021 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988252;
        bh=duG8pcJD/SQDOexeoDS0AUNveV9rZeSlys1CA4SiQKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9Xq5CmGvyh/FHBiLWee94tGEaUkh8NEJhVFvFOphV6Xme2C6lLt4AIDMealmukNf
         WzPatCdYxLbBYXnDp+Mfns4uwVin07t2GfOtwKLAk92j+3IVgFdf65F1/Yrc6jDexm
         NknDEsChSyI1DrVwk8UpxjMT/XUdAxsaFwYQogdTNyleTiNOF4UU9PhbiAB5Z+IZsa
         gi1el5PAW1+ZYQmzfqcafBI9dUvRQ1vpQDBUI9/ZMgj16Y1v0tAmjh7pwxdXN30MiY
         vBq3MrUCn+PFQR2x/kGC1UUYIoSPfDXKFDWWdK2ywftRAdCeXd375Sb0xdu5Kuip2v
         UlwSZvsSPsV4Q==
Date:   Wed, 10 Feb 2021 12:17:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 3/5] dm: add support for passing through inline crypto
 support
Message-ID: <YCQ/WjAsVA2gdb7d@gmail.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210201051019.1174983-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201051019.1174983-4-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 01, 2021 at 05:10:17AM +0000, Satya Tangirala wrote:
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
> A DM device's table can only be changed if the "new" inline encryption
> capabilities are a (*not* necessarily strict) superset of the "old" inline
> encryption capabilities.  Attempts to make changes to the table that result
> in some inline encryption capability becoming no longer supported will be
> rejected.
> 
> For the sake of clarity, key eviction from underlying devices will be
> handled in a future patch.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

I don't see any obvious issues with this latest version.  I assume you've tested
it on real hardware?

If it's needed despite my Co-developed-by, feel free to add:

Reviewed-by: Eric Biggers <ebiggers@google.com>

A few nits about comments, in case you resend:

> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index 086d293c2b03..bf3e66f39a4a 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -13,6 +13,7 @@
>  #include <linux/ktime.h>
>  #include <linux/genhd.h>
>  #include <linux/blk-mq.h>
> +#include <linux/keyslot-manager.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -162,6 +163,10 @@ struct dm_table {
>  	void *event_context;
>  
>  	struct dm_md_mempools *mempools;
> +
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	struct blk_keyslot_manager *ksm;
> +#endif
>  };

It might be helpful if there was a brief comment here that explained that this
field is only set temporarily while the table is being set up, and it gets set
to NULL after the capabilities have been transferred to the request_queue.
I.e., it's not something that stays around here while the dm device is active.

> +/*
> + * Constructs and returns a keyslot manager that represents the crypto
> + * capabilities of the devices described by the dm_table. However, if the
> + * constructed keyslot manager does not support a superset of the crypto
> + * capabilities supported by the current keyslot manager of the mapped_device,
> + * it returns an error instead, since we don't support restricting crypto
> + * capabilities on table changes. Finally, if the constructed keyslot manager
> + * doesn't actually support any crypto modes at all, it just returns NULL.
> + */
> +static int
> +dm_table_construct_keyslot_manager(struct dm_table *t)

This doesn't "return" the keyslot manager anymore, but rather assigns it to
t->ksm.  It would also be helpful if the comment explicitly mentioned that the
goal is to find the capabilities that all the devices have in common.

E.g. "Initializes t->ksm with a keyslot manager that represents the common set
of crypto capabilities of the devices described by the dm_table.".

> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 61a66fb8ebb3..d2142f5a82a7 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -257,6 +257,12 @@ struct target_type {
>  #define DM_TARGET_NOWAIT		0x00000080
>  #define dm_target_supports_nowait(type) ((type)->features & DM_TARGET_NOWAIT)
>  
> +/*
> + *
> + */
> +#define DM_TARGET_PASSES_CRYPTO		0x00000100
> +#define dm_target_passes_crypto(type) ((type)->features & DM_TARGET_PASSES_CRYPTO)

The above comment isn't very useful :-)

- Eric
