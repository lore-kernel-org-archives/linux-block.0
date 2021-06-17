Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31CC49361
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 01:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A1061245
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 01:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFQCAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 22:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhFQCAn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 22:00:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3D8E611AE;
        Thu, 17 Jun 2021 01:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623895116;
        bh=LkxoxsV2uINtsMRapfS1F+4SusO/sYiAFsTPioDWf6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNP1+W3p4MLCD0PatOpsw1yqpHlTAzEfaAhNgKxPalX/iz8e1tW0A2CUHwFsbKsGx
         lif1teVMxMoyKPfo0NIPZGtza+g0uJ3KPrw59xVa8NVugS3da9qgTJ+35miL0TJbpi
         qGT1oYgWjsuad4f89AhsxhidTuH5Yz4oP8TbdrhrKIceh+OHwH7WFbbx4IbklXqUGc
         Eu6n+225l3N6vQT/qd7NPyWx4E3p7+7gtSCnP9Fk2TPj/jiSIrwMHvRPmnpApup+uY
         7EPidXZP1KNhwU9aLjzmtLjon1KEI5GtvSakQuYN9iaQgbedLoET6jwf2JrrUl9w6T
         PppZlN1oB4/bw==
Date:   Wed, 16 Jun 2021 18:58:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 05/10] block: keyslot-manager: introduce
 blk_ksm_restrict_dus_to_queue_limits()
Message-ID: <YMqsS0ehsVlyySOQ@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-6-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:55PM +0000, Satya Tangirala wrote:
> Not all crypto data unit sizes might be supported by the block layer due to
> certain queue limits. This new function checks the queue limits and
> appropriately modifies the keyslot manager to reflect only the supported
> crypto data unit sizes. blk_ksm_register() runs any given ksm through this
> function before actually registering the ksm with a queue.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/keyslot-manager.c | 91 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 88211581141a..6a355867be59 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -458,12 +458,103 @@ bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
>  }
>  EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
>  
> +/*
> + * Restrict the supported data unit sizes of the ksm based on the request queue
> + * limits
> + */
> +static void
> +blk_ksm_restrict_dus_to_queue_limits(struct blk_keyslot_manager *ksm,
> +				     struct request_queue *q)
> +{
> +	/* The largest possible data unit size we support is PAGE_SIZE. */
> +	unsigned long largest_dus = PAGE_SIZE;
> +	unsigned int dus_allowed_mask;
> +	int i;
> +	bool dus_was_restricted = false;
> +	struct queue_limits *limits = &q->limits;
> +
> +	/*
> +	 * If the queue doesn't support SG gaps, a bio might get split in the
> +	 * middle of a data unit. So require SG gap support for inline
> +	 * encryption for any data unit size larger than a single sector.
> +	 *
> +	 * A crypto data unit might straddle an SG gap, and only a single sector
> +	 * of that data unit might be before the gap - the block layer will need
> +	 * to split that bio at the gap, which will result in an incomplete
> +	 * crypto data unit unless the crypto data unit size is a single sector.
> +	 */
> +	if (limits->virt_boundary_mask)
> +		largest_dus = SECTOR_SIZE;

This seems unnecessarily pessimistic, as the length of each bio_vec will still
be aligned to logical_block_size.  virt_boundary_mask only causes splits between
bio_vec's, not within a bio_vec.

I think we want something like:

	/*
	 * If the queue doesn't support SG gaps, then a bio may have to be split
	 * between any two bio_vecs.  Since the size of each bio_vec is only
	 * guaranteed to be a multiple of logical_block_size, logical_block_size
	 * is also the maximum crypto data unit size that can be supported in
	 * this case, as bios must not be split in the middle of a data unit.
	 */
	if (limits->virt_boundary_mask)
		largest_dus = queue_logical_block_size(q);

> +	/*
> +	 * If the queue has chunk_sectors, the bio might be split within a data
> +	 * unit if the data unit size is larger than a single sector. So only
> +	 * support a single sector data unit size in this case.
> +	 *
> +	 * Just like the SG gap case above, a crypto data unit might straddle a
> +	 * chunk sector boundary, and in the worst case, only a single sector of
> +	 * the data unit might be before/after the boundary.
> +	 */
> +	if (limits->chunk_sectors)
> +		largest_dus = SECTOR_SIZE;

I think the same applies here.  As I understand it, chunk_sectors has to be a
multiple of logical_block_size.  Here's what I'm thinking:

	/*
	 * Similarly, if chunk_sectors is set and a bio is submitted that
	 * crosses a chunk boundary, then that bio may have to be split at a
	 * boundary that is only logical_block_size aligned.  So that limits the
	 * crypto data unit size to logical_block_size as well.
	 */
	if (limits->chunk_sectors)
		largest_dus = queue_logical_block_size(q);

Although, that also raises the question of whether we should require that
'bi_sector' be crypto_data_size aligned for inline encryption to be used.  Then
I think we could remove the above limitation.

I suppose the main concern with that is that if someone was to e.g. create a
filesystem on a partition which starts at a location that isn't 4K aligned, they
wouldn't be able to use inline encryption on that filesystem...  I'm not sure
how much of a problem that would be in practice.

> +
> +	/*
> +	 * Any bio sent to the queue must be allowed to contain at least a
> +	 * data_unit_size worth of data. Since each segment in a bio contains
> +	 * at least a SECTOR_SIZE worth of data, it's sufficient that
> +	 * queue_max_segments(q) * SECTOR_SIZE >= data_unit_size. So disable
> +	 * all data_unit_sizes not satisfiable.
> +	 *
> +	 * We assume the worst case of only SECTOR_SIZE bytes of data in each
> +	 * segment since users of the block layer are free to construct bios
> +	 * with such segments.
> +	 */
> +	largest_dus = min(largest_dus,
> +			1UL << (fls(limits->max_segments) - 1 + SECTOR_SHIFT));

And similarly here too.  As far as I can tell, the minimum size of a segment is
logical_block_size, which is not necessarily SECTOR_SIZE.

We can also make use of rounddown_pow_of_two() here.

Here is what I'm thinking:

	/*
	 * Each bio_vec can be as small as logical_block_size.  Therefore the
	 * crypto data unit size can't be greater than 'max_segments *
	 * logical_block_size', as otherwise in the worst case there would be no
	 * way to process the first data unit without exceeding max_segments.
	 */
	largest_dus = min(largest_dus,
			  rounddown_pow_of_two(limits->max_segments) *
			  queue_logical_block_size(q));

> +	/* Clear all unsupported data unit sizes. */
> +	dus_allowed_mask = (largest_dus << 1) - 1;
> +	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
> +		if (ksm->crypto_modes_supported[i] & (~dus_allowed_mask))
> +			dus_was_restricted = true;
> +		ksm->crypto_modes_supported[i] &= dus_allowed_mask;
> +	}
> +
> +	if (dus_was_restricted) {
> +		pr_warn("Disallowed use of encryption data unit sizes above %lu bytes with inline encryption hardware because of device request queue limits on device %s.\n",
> +			largest_dus, q->backing_dev_info->dev_name);
> +	}

The disk name should go at the beginning of the log message.

> +/**
> + * blk_ksm_register() - Sets the queue's keyslot manager to the provided ksm, if
> + *			compatible
> + * @ksm: The ksm to register
> + * @q: The request_queue to register the ksm to
> + *
> + * Checks if the keyslot manager provided is compatible with the request queue
> + * (i.e. the queue shouldn't also support integrity). After that, the crypto
> + * capabilities of the given keyslot manager are restricted to what the queue
> + * can support based on it's limits. Note that if @ksm doesn't support any
> + * crypto capabilities after the capability restriction, the queue's ksm is
> + * set to NULL, instead of being set to a pointer to the now "empty" @ksm.
> + *
> + * Return: true if @q's ksm is set to the provided @ksm, false otherwise
> + *	   (including the case when @ksm becomes "empty" due to crypto
> + *	    capability restrictions)
> + */
>  bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
>  {
>  	if (blk_integrity_queue_supports_integrity(q)) {
>  		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
>  		return false;
>  	}
> +
> +	blk_ksm_restrict_dus_to_queue_limits(ksm, q);
> +
> +	if (blk_ksm_is_empty(ksm))
> +		return false;
> +
>  	q->ksm = ksm;
>  	return true;
>  }

The behavior of this function is a bit odd.  If no crypto capabilities can be
registered, it returns false, but it may or may not modify @ksm.  It should
probably leave @ksm unmodified in that case (which we could do by turning
blk_ksm_restrict_dus_to_queue_limits() into something that just calculates the
largest supported data unit size, and making blk_ksm_register() do the rest).

- Eric
