Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7325743E
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693472; cv=none; b=Q5jNq56OiZu3enPNPugMo6ugmD1E1Mb1ArSj1zQGYQnp6mt26lVK5p85izJY99dU5HS72eZUILCT1v95r3Jb8ckWklo8smPWBFEGwq8Xgc/ZxwbZEeixA3ijtjmNgMXi8PS4Z2DSCfpRVu2aizROiOgRai6V2RxwFJ2FQw1sV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693472; c=relaxed/simple;
	bh=wEOM+TmvTrIf3suVRJrtlnqs3mGM92+thLmftKDH/8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek8ewXlvudYT99f3VIbglxgHgF7qJKn+0NAqvd2bFYHdFEQobHkY0LjHBK12g3gqYgetRm1smwE2qJcCyFgzh0j4lch0ijds4rBq7keuRzICpF7CoqkCM/5vVHyODobYKwfjnVhhkgQs+chIFb1w+Gx7aFweCjSsQysqAZEw8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUMvRJey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUMvRJey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A2AC4CEEA;
	Mon, 23 Jun 2025 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693471;
	bh=wEOM+TmvTrIf3suVRJrtlnqs3mGM92+thLmftKDH/8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUMvRJey8q/fv3kBiwWAMs95nc7+muqAcGgcngXOLgVe0ZOHkbN+nKtu+J7TusPxw
	 aWjq8MMEKeDiqhtWWIqI6Kk+RUuoT9Z5wk3iSgERnkJwkDz5JKnegZZblVhVSU4f0J
	 THyyTxU1B7PxtAGLus6Hj4AzC7umFTg8cbO/KC4tx7RhlQf/smd+7A/zxGiZPxLUDN
	 dPrLd9GYfffEvRRK+Db5C8GaIW+D3gJ/PQ4bQn694Etd1KUy3o1/cl8s1yCGDH78G6
	 LAkoBAZBIHYNTt6V6JbvolwSAE2QqKFLxST8s+9MZr9CrlX1iHi/fnDqLvFSqO5s88
	 y3n3z126nCPZA==
Date: Mon, 23 Jun 2025 09:44:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Daniel Gomez <da.gomez@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 8/8] nvme-pci: rework the build time assert for
 NVME_MAX_NR_DESCRIPTORS
Message-ID: <aFl2XTGwBbPSiU9p@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-9-hch@lst.de>

On Mon, Jun 23, 2025 at 04:12:30PM +0200, Christoph Hellwig wrote:
> The current use of an always_inline helper is a bit convoluted.
> Instead use macros that represent the arithmetics used for building
> up the PRP chain.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
