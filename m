Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5433991
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886255; cv=none; b=qFf5EKfHRto0yRUXWh29jeWvCXbP+eXtxA1r+cyUnEl4o3gJoMvmj/yARUoVWFruk1lwTfCn2INbAy9LWrVsPkvGF92LU+gL4+GFyqr2uTndVgWYIvDnrG8EiQD9yTacAipQugwSX+r1EnmliS6aLc83AvIP2Vm1uBjeT/QMILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886255; c=relaxed/simple;
	bh=/GbWgGFy/4UaA1oIHKYxQLkUqTlpsKOvBqDSqUnS9rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJCYcNiupfR6uL89xG5UM0WehpGcBposffJMJ0CGkoNFy8sZQtHPWsAs2hG6oDvusLoMNSTTIwCLs7XQcMy2fkGxCXPdTcguW9al7i9DfJ3EsM44oQmuEUD2mnUaTbH9qqhUJerTsaC2GKECZWkp1LqVPGUsVFshrBRoGd8C2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spbh67Pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spbh67Pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8F9C4CEEA;
	Wed, 25 Jun 2025 21:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750886254;
	bh=/GbWgGFy/4UaA1oIHKYxQLkUqTlpsKOvBqDSqUnS9rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Spbh67PflRJfffO5ipXEZGsoHFLy3fk39PgunrwZhCw1D6DEn8HZKx4+itfLLKQGh
	 V7DdF+n1kdcxM98DZj72zTjkKPZeELGeOLDtufXPeW6MgDIE2m2HG0lOqxwn7AIIab
	 22muKsSgpLmESLGtqRa5ZHgll523P1QUEGrWGEMNg+4uDdL3Jc4S34HF+agPZnlE0u
	 gmfmzh1FWEQoUyPQBc2+E2FCgaQBR4X/aNS7zil6pE5WHx2i70Dl0OS1YaglkF8HVu
	 HeQv832gEclSR5qpbQn/W+Z3VwjyrxAmmJD5FK40dVqcY9uHiTF+7vgmynZtMzJT4U
	 QG+IQY58UyIOA==
Date: Wed, 25 Jun 2025 15:17:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me
Subject: Re: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Message-ID: <aFxnbP68tZj6zQyb@kbusch-mbp>
References: <20250625204445.1802483-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-1-kbusch@meta.com>

On Wed, Jun 25, 2025 at 01:44:44PM -0700, Keith Busch wrote:
> +	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
> +		struct bio_vec next;
> +
> +		if (!iter->iter.bi_size) {
> +			if (!iter->bio->bi_next)
> +				break;
> +			iter->bio = iter->bio->bi_next;
> +			iter->iter = iter->bio->bi_iter;

Ugh, this should have been:

			bip = bio_integrity(iter->bio);
			iter->iter = bip->bip_iter;


> +		}
> +
> +		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);

And then this should be:

		next = mp_bvec_iter_bvec(bip->bip_vec, iter->iter);

Obviously I didn't test merging bio's into plugged requests...

> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev, struct blk_dma_iter *iter)
> +{
...
> +}
> +EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);

And while I'm pointing out my mistakes, this last second name change was
pretty stupid... The export symbol needs the "_dma_" part.
