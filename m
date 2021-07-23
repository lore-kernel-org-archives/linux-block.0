Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE8C4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2F860EB1
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGWQ2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhGWQ2A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 12:28:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2795660E8F;
        Fri, 23 Jul 2021 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627060113;
        bh=pEMVaGk2rq1eXD7agrjxbGJNreoK3Lvrk9bUiB73VuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOp8SdiAl1zcfFAu3uaWBAGR7RN+6r6Z+E56fuqwmITyphj2ayKuVKAtK5dGKDws1
         H9A0xgb0k16VTIJ2qynZVpybkrIaP7KaCXvXS1AUZ6hqUp4IHjb8xdFOxArUphMJ6j
         BOuq4UbUmJNlg49vc4jVXmNL3okziy3IjJWBIYD8r0BpJZsFQ4Y7Mmyy30PNoBlJkR
         DU9lO11RFu4mIq3cDK8Ru83iyGtVs2J63mbLoe8BFTwTb7DYKsFsy8gIRbqRXmm4IE
         XrzCA/3/YugeA+TMtcJ+6BQ5k6NGbFKbsJytmjTwK47haU/V0wgMaabbKLMl8+kkZM
         Q1pApGEEelS5Q==
Date:   Fri, 23 Jul 2021 10:08:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 4/9] block: keyslot-manager: introduce
 blk_ksm_restrict_dus_to_queue_limits()
Message-ID: <YPr3j4fMTWhZfmAS@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-5-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-5-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:38PM -0700, Satya Tangirala wrote:
> +/*
> + * Restrict the supported data unit sizes of the ksm based on the request queue
> + * limits
> + */
> +static unsigned long
> +blk_ksm_largest_dus_for_queue_limits(struct blk_keyslot_manager *ksm,
> +				     struct request_queue *q)
> +{

The ksm argument to this function isn't actually used.

Also the comment should be fixed to be something like "Return the largest data
unit size that is compatible with the given request queue.".

> +/**
> + * blk_ksm_register() - Sets the queue's keyslot manager to the provided ksm, if
> + *			compatible
> + * @ksm: The ksm to register
> + * @q: The request_queue to register the ksm to
> + *
> + * Checks if the keyslot manager provided is compatible with the request queue
> + * (i.e. the queue shouldn't also support integrity). After that, the crypto
> + * capabilities of the given keyslot manager are restricted to what the queue
> + * can support based on it's limits. Note that if @ksm won't support any
> + * crypto capabilities if its capabilities are restricted, the queue's ksm is
> + * set to NULL, instead of being set to a pointer to an "empty" @ksm, and @ksm
> + * is *not* modified.
> + *
> + * Return: true if @q's ksm is set to the provided @ksm, false otherwise
> + *	   (in which case @ksm will not have been modified)
> + */

Can this comment be made more concise and less confusing?  Something like:

	Checks whether any of @ksm's crypto capabilities are compatible with the
	request_queue, and if so, clears any incompatible capabilities from @ksm
	and assigns @ksm to the request_queue.

	Return: %true if @ksm was assigned to @q, or %false if it was not (due
	        to none of @ksm's crypto capabilities being compatible with @q)

>  bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
>  {
> +	unsigned long largest_dus_allowed;
> +	unsigned int dus_allowed_mask;
> +	bool dus_was_restricted = false;
> +	int i;
> +
>  	if (blk_integrity_queue_supports_integrity(q)) {
>  		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
>  		return false;
>  	}
> +
> +	largest_dus_allowed = blk_ksm_largest_dus_for_queue_limits(ksm, q);
> +	dus_allowed_mask = (largest_dus_allowed << 1) - 1;
> +
> +	/*
> +	 * Check if ksm will become empty if we clear disallowed data unit
> +	 * sizes (in which case, don't modify the ksm)
> +	 */
> +	if (blk_ksm_is_empty_mask(ksm, dus_allowed_mask))
> +		return false;
> +
> +	/* Clear all unsupported data unit sizes. */
> +	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
> +		if (ksm->crypto_modes_supported[i] & (~dus_allowed_mask))

There's no need for the parenthesis around ~dus_allowed_mask.

> +			dus_was_restricted = true;
> +		ksm->crypto_modes_supported[i] &= dus_allowed_mask;
> +	}
> +
> +	if (dus_was_restricted) {
> +		pr_warn("Device: %s - Disallowed use of encryption data unit sizes above %lu bytes with inline encryption hardware because of device request queue limits.\n",
> +			q->backing_dev_info->dev_name, largest_dus_allowed);
> +	}

Is there a better way to get the queue/disk name?  Also, device names normally
go at the very beginning of the messages, like "%s: <message>".

This message is also very long; something more concise would be good.  Maybe:

"%s: only allowing crypto data unit sizes up to %lu bytes due to device limitations\n"

- Eric
