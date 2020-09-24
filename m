Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DCC4727E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 01:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8275221D20
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 01:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLH0RrUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIXBXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 21:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725272AbgIXBXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 21:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600910581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9WO4qQNqPNvxeAmCHyDKaeS+OQCXdDkVSudf43hciY=;
        b=GLH0RrUq53M+3Bcp74jeuzTlk7X+Kyf+L8NZLFJoLYpLQBaXxtpFGMe1YY0CAt54foeUpW
        8Wmd2Oyx4+2sX/9gh5q785C3Puq0Ea+Y/0E/CBjM1RKltt6VYdl4u+cRz3Sp7e5RRWECg9
        pUarrgarnVGeblUiXtBH0nHka4GZPn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-_QOUAg3aNFeQnO8SChft0w-1; Wed, 23 Sep 2020 21:21:08 -0400
X-MC-Unique: _QOUAg3aNFeQnO8SChft0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E221801AF7;
        Thu, 24 Sep 2020 01:21:07 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3649810027AB;
        Thu, 24 Sep 2020 01:21:04 +0000 (UTC)
Date:   Wed, 23 Sep 2020 21:21:03 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924012103.GE10500@redhat.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909234422.76194-3-satyat@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 09 2020 at  7:44pm -0400,
Satya Tangirala <satyat@google.com> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
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
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk-crypto.c              |  1 +
>  block/keyslot-manager.c         | 34 ++++++++++++
>  drivers/md/dm-core.h            |  4 ++
>  drivers/md/dm-table.c           | 52 +++++++++++++++++++
>  drivers/md/dm.c                 | 92 ++++++++++++++++++++++++++++++++-
>  include/linux/device-mapper.h   |  6 +++
>  include/linux/keyslot-manager.h |  7 +++
>  7 files changed, 195 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 2d5e60023b08..33555cf0e3e7 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -402,3 +402,4 @@ int blk_crypto_evict_key(struct request_queue *q,
>  	 */
>  	return blk_crypto_fallback_evict_key(key);
>  }
> +EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 60ac406d54b9..e0f776c38d8a 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -416,6 +416,40 @@ void blk_ksm_unregister(struct request_queue *q)
>  {
>  	q->ksm = NULL;
>  }
> +EXPORT_SYMBOL_GPL(blk_ksm_unregister);
> +
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
>  
>  /**
>   * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index c4ef1fceead6..4542050eebfc 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -12,6 +12,7 @@
>  #include <linux/kthread.h>
>  #include <linux/ktime.h>
>  #include <linux/blk-mq.h>
> +#include <linux/keyslot-manager.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -49,6 +50,9 @@ struct mapped_device {
>  
>  	int numa_node_id;
>  	struct request_queue *queue;
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	struct blk_keyslot_manager ksm;
> +#endif
>  
>  	atomic_t holders;
>  	atomic_t open_count;

Any reason you placed the ksm member where you did?

Looking at 'struct blk_keyslot_manager' I'm really hating adding that
bloat to every DM device for a feature that really won't see much broad
use (AFAIK).

Any chance you could allocate 'struct blk_keyslot_manager' as needed so
that most users of DM would only be carrying 1 extra pointer (set to
NULL)?

Thanks,
Mike

