Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143A37C0E0
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649181; cv=none; b=EIq7UPnTjw0D+vs71yojf9bWtIuYDQkOgP+jcMVBEKjYFgTw3Zf/dS3Cq/CK0LsBJWQKK7z1rSElCxT6ecLPHGNtvwVjozmcPh29qmLYjmgrA5THwZwZkchbSLhnHdLUCf7WrgU8ZvOG7FVm0khfmAbRaj1yjjC8ULd5RcsUHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649181; c=relaxed/simple;
	bh=JDCS5HXgcreTMQXaQIrB3a6A3R6ctjSgROCZHzyENdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlrzcYivTI5TEOPrlacs+Tiu2/zuWy2qvG5C8Kn/AS4yYOwQ7BhDKHfz7PTPq0qzhm3IDmyIevvFDCsHVSKazZJ5ecxK5HJNV1GDCzwyOTxnTvBw6PMBuqsFO3VbNCkMVjcVdd8JcG7Hqoth5HWJg8VLdZlaAN4h7h/EBVQnAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74A5268D05; Mon,  9 Feb 2026 15:59:39 +0100 (CET)
Date: Mon, 9 Feb 2026 15:59:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect
 debugfs file creation
Message-ID: <20260209145938.GD18315@lst.de>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-5-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209082953.3053721-5-yukuai@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 09, 2026 at 04:29:53PM +0800, Yu Kuai wrote:
> +	/*
> +	 * Avoid creating debugfs files while the queue is frozen, wait for
> +	 * the queue to be unfrozen and prevent new freeze while creating

I'd say "prevent concurrent freezes" here, but I'm not a native
speaker either.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

