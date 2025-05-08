Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4D8C1E
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681159; cv=none; b=ck5Z3FtbHrzzzp9n7NnOd+sfqSTXh4h8p0/pTn1dbQ/mLb2l1Vb+F9DRIXQRk9uBTHDyU1G/AeRx+/AN6yKnJCAa4tMHLC3KgUaN2dRNWfCqToH3YsnFWv4eSLd76vPsZLV+msho0qtU+ltmL3BsSfJ+ziF0JR4+LCJZxYLxWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681159; c=relaxed/simple;
	bh=7Bz+hXqYm1RS3kvdPmxxKU9IRXPsIqoS0TeFc8I1z8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS4Dc5kogxqqBaDd55XEYQyRjdI18xOgVKprkwd2OM0+W9+7E6ytSqZJnWojSEXmRxPPaF6sjrhJb19bW+P7WS7d/rsuizYm+2BLWNdHvJxAbLY+nrJ/TGIND0i2O2M925auo4bimBHUGb+oykV0PWjyIikjzXjVhgBCYDpNuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B679D68B05; Thu,  8 May 2025 07:12:33 +0200 (CEST)
Date: Thu, 8 May 2025 07:12:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <20250508051233.GA27118@lst.de>
References: <20250507191424.2436350-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507191424.2436350-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 12:14:24PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The integrity buffer, whether or not you want it generated or verified, is
> mandatory for nvme formats that have metadata. The block integrity attributes
> read_verify and write_generate had been stopping the metadata buffer from being

This commit log exceeds the 73 characters allocated to it, please reformat
it.

> allocated and attached to the bio entirely. We only want to suppress the
> protection checks on the device and host, but we still need the buffer.
> 
> Otherwise, reads and writes will just get IO errors and this nvme warning:

But to a point - the metadata buffer is only required for non-PI
metadata.  I think from looking at the code that is exactly what
this patch does, but the commit log sounds different.

Also this should probably have a fixes tag.

> -	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status && bi->csum_type) {
> +	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
> +	    bip->bip_flags & BIP_CHECK_GUARD) {

While Martin correctly points out we currently always do both guard
and reftag checking, we really should check for either, especially as
some code below is written in a way to allow for formats that only
have one of them.

> +static inline void bio_set_bip_flags(struct blk_integrity *bi, u16 *bip_flags)
> +{
> +	if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
> +		*bip_flags |= BIP_IP_CHECKSUM;
> +	if (bi->csum_type)
> +		*bip_flags |= BIP_CHECK_GUARD;
> +	if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +		*bip_flags |= BIP_CHECK_REFTAG;
> +

Just return the flags here instead of the somewhat odd output by
pointer return?

> +			break;
> +		bio_set_bip_flags(bi, &bip_flags);
>  		break;
>  	case REQ_OP_WRITE:

...

> +		bio_set_bip_flags(bi, &bip_flags);
>  		break;
>  	default:
>  		return true;
> @@ -134,22 +148,15 @@ bool bio_integrity_prep(struct bio *bio)

Just move this after the switch to have a single callsite.  And maybe
don't even bother with the helper then?

