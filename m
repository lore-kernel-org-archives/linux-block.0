Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28300C433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26E5610CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhDOT4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234735AbhDOT4U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:56:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38D046109D;
        Thu, 15 Apr 2021 19:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618516556;
        bh=f6zX1JTHDKJY5RAHzBASAEJeJPaS4icspmPXrKvXjCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cfhiug9/6ao8U96bXhC7D7ueiWI+fUpy1bMPmJ7S2wS+TalPR86ZoMqAEUV+VQUTD
         yiNiUSvpPWb/Yrro2k4JfpM6rNaP/MDWoENWHnqolzk1ZpJ4ljJrdj62X4iryhrB0y
         UPxIyYkvzbfejidy2Nc25BFrsiscet1hzNDm9oEcUPaRdf8RAbdfTCRBHJep3qAIpW
         reNK7pKaUlZs4V/ZrNCqt0BV1bljefsfYlLKxgDvMWmiyIhHgGGqviuCX4hZtI9C3+
         hVYOjM4Nw6T2wAsrZFaZiR3UiHK9tzTq1/EmAB/tLXdzTwT1OJvwEZqo6WKkyCoUfr
         UdkuBT2WISphg==
Date:   Thu, 15 Apr 2021 12:55:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 6/8] block: keyslot-manager: introduce
 blk_ksm_restrict_dus_to_queue_limits()
Message-ID: <YHiaShR5molnCQFy@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-7-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:07PM +0000, Satya Tangirala wrote:
> Not all crypto data unit sizes might be supported by the block layer due to
> certain queue limits. This new function checks the queue limits and
> appropriately modifies the keyslot manager to reflect only the supported
> crypto data unit sizes. blk_ksm_register() runs any given ksm through this
> function before actually registering the ksm with a queue.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/keyslot-manager.c | 59 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 2a2b1a9785d2..fad6d9c4b649 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -450,12 +450,71 @@ bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
>  }
>  EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
>  
> +/*
> + * Restrict the supported data unit sizes of the ksm based on the request queue
> + * limits
> + */
> +void blk_ksm_restrict_dus_to_queue_limits(struct blk_keyslot_manager *ksm,
> +					  struct queue_limits *limits)

As the kernel test robot hinted at, this function needs to be 'static'.

> +{
> +	/* The largest possible data unit size we support is PAGE_SIZE. */
> +	unsigned long largest_dus = PAGE_SIZE;
> +	unsigned int dus_allowed_mask;
> +	int i;
> +	bool dus_was_restricted = false;
> +
> +	/*
> +	 * If the queue doesn't support SG gaps, a bio might get split in the
> +	 * middle of a data unit. So require SG gap support for inline
> +	 * encryption for any data unit size larger than a single sector.
> +	 */
> +	if (limits->virt_boundary_mask)
> +		largest_dus = SECTOR_SIZE;
> +
> +	/*
> +	 * If the queue has chunk_sectors, the bio might be split within a data
> +	 * unit if the data unit size is larger than a single sector. So only
> +	 * support a single sector data unit size in this case.
> +	 */
> +	if (limits->chunk_sectors)
> +		largest_dus = SECTOR_SIZE;

So in practice, this means that inline encryption will be disabled on any disk
that declares a virt_boundary_mask or chunk_sectors.

What are the real-world consequences of that?  Will that have any consequences
for UFS or eMMC, or are those things never applicable to UFS or eMMC?

It would also be helpful if the comments explained why these restrictions are
necessary.  They kind of do, but they don't explicitly give an example --
presumably the issue is that a crypto data unit could cross a virt_boundary_mask
or chunk_sectors boundary?

> +	/*
> +	 * Any bio sent to the queue must be allowed to contain at least a
> +	 * data_unit_size worth of data. Since each segment in a bio contains
> +	 * at least a SECTOR_SIZE worth of data, it's sufficient that
> +	 * queue_max_segments(q) * SECTOR_SIZE >= data_unit_size. So disable
> +	 * all data_unit_sizes not satisfiable.
> +	 */
> +	largest_dus = min(largest_dus,
> +			1UL << (fls(limits->max_segments) - 1 + SECTOR_SHIFT));
> +
> +	/* Clear all unsupported data unit sizes. */
> +	dus_allowed_mask = (largest_dus << 1) - 1;
> +	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
> +		if (ksm->crypto_modes_supported[i] & (~dus_allowed_mask))
> +			dus_was_restricted = true;
> +		ksm->crypto_modes_supported[i] &= dus_allowed_mask;
> +	}

So again in practice, this effectively disables inline encryption on any disk
that doesn't declare max_segments >= 8.  What are the real-world consequences of
that -- will this ever be a problem for UFS or eMMC?

Also, why is it necessary to assume the worst case of 512 bytes per segment?

> +	if (dus_was_restricted) {
> +		pr_warn("Disallowed use of encryption data unit sizes above %lu bytes with inline encryption hardware because of device request queue limits.\n",
> +			largest_dus);
> +	}

Could this message include the disk that it is talking about?

>  bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
>  {
>  	if (blk_integrity_queue_supports_integrity(q)) {
>  		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
>  		return false;
>  	}
> +
> +	blk_ksm_restrict_dus_to_queue_limits(ksm, &q->limits);
> +
> +	if (blk_ksm_is_empty(ksm))
> +		return false;
> +
>  	q->ksm = ksm;
>  	return true;
>  }

Adding a kerneldoc comment to this function would be helpful.  Especially to
explain what a return value of false means, exactly.

- Eric
