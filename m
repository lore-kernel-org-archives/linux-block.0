Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844374BE0
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782432; cv=none; b=OVDOY0rpzGt9WwWCEac+/3LFDxmV3rzdIycd6edGmKJyWifRNm0csCny3iT+ZoTV8UP8igGXrB7FQIzAhaQwwJYzmmb8KfiHGvsTKnlVqIWGYYyB7zuxonGNfGu7oT6RgAFFwIFzU2OauLp2em9iDUvrY5Yhv1rQy+TfXuHVyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782432; c=relaxed/simple;
	bh=ZZSNOm4HGvu76JOYyw4T2DI+91MN2NyKIOB4zCl3sKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpgWWHSqzows0jBfKlsLFMClMfMNLx8g7KdEuJvY8s7WhXEFz0o+uwvRSOU4mm7dGpiLdqNYDeAPGaJatv5GRHGvbPcgRUgOTOyApdvs9UcnzwqA19sEvscxtOs8tmb9SkJdYK8da8UztBcrKVDMhqrJKilQLzV2PdrSUMi6+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iqCAc76A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqCAc76A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6sQS0LzXRXt6ViRydGpyYH1J8lgsRb1inZFjPQqDMJ0=; b=iqCAc76Avy66yhukPOZaJNFiZ+
	4FdJedvJiNIDcrGz6l9Kd64O5Xbv2NnxMRm5hnihpwmmASnAwKrNlnREVs5TSE58iHK2kFKxg/N+y
	GSY+YpdCLg2vWf2RmhnU1G/6NjdxioTlUTed0/rHN6QpSDxzPyyqjLZ6zsOnSly4p00Q1j1mfNqWn
	SZYN4j/zI4vPB24sGwI2vLkFS0uiI91Yqw+c2COscwdKk5CQ5mvxTbRlWnSrb/3FTTTwk31x6YgGL
	c+/RUqKVCgVlviaVHUQ1OhdkSy3t3AY+O/ul+e6xSaZUPnWWQy+WuC/cb84jUJig7REr0UXHs/1mF
	qORm2k1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJppF-00000000DkG-0AbC;
	Wed, 19 Jun 2024 07:33:51 +0000
Date: Wed, 19 Jun 2024 00:33:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKJ3d-18rzl32j2@infradead.org>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
 <355cc36f-e771-4f00-bfb0-0095674d5d49@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355cc36f-e771-4f00-bfb0-0095674d5d49@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 01:22:27PM +0900, Damien Le Moal wrote:
> static bool bio_unaligned(const struct bio *bio,
> 		          const struct request_queue *q)
> {
> 	unsigned int bs_mask = queue_logical_block_size(q) - 1;

Please avoid use of the queue helpers.  This should be:

	unsigned int bs_mask = bdev_logical_block_size(bio->bi_bdev);

