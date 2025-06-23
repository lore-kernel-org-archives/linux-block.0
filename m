Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820C276024
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693388; cv=none; b=PrJgy2kdtzNfjOD5EH0AjCWFyGQ+QX6CthsV6OY4y+97dkCFT+HWxcfChVwU8BDFRwQ6Wb65ZRl2f4TsozaveMn0fZsNkcuirfymrYwtlcnt1HN5SAXa4vEJmLZ9xriOMN3WwbgU/ADyYzXyH7SkMyVM/NIqLmGgG70Kzf4g8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693388; c=relaxed/simple;
	bh=0eaGEA1wt6jq4T6sIubQFT2smAr+omb1CgShoBvET0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEvnhnu+2LT3KZTE7i/z5koh68rQreSDBOuxTvZBxg2OJSFP17F+rnVYKZG/Ob0Z6MltWB/K6JdjD85lYslT2iLjbVBFPSnQVqlp3BXwX3wuj/lMP/q+tIb89A/r3ONZ3sunmyfQCchBc51jxf4Z6QZnvZtFiGeNaEE7Ptd1px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfbMtAAn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfbMtAAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B700AC4CEEA;
	Mon, 23 Jun 2025 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693388;
	bh=0eaGEA1wt6jq4T6sIubQFT2smAr+omb1CgShoBvET0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfbMtAAn4mryyrMA98mi6BHTTiOmVBjiy5mXbLojnyny316jTf4WItkT0Sdzd804g
	 F9f3kKvBsw3zipxgJMBB8RNGrbLulaXQMAsC0TBezd/Ep+pxF57KQMOcTQpY/51Jai
	 Dg8NicADXWuL0pZY+kTyqoLOVH5rbzYcBxj0p2gr9kMb48Q5ZfKSj1E4Aje7PszuML
	 l1GX/tHjPSoi6FavmikH1ewuwtzK5PByjDdXLcVdZrA9FcCjEyK/G5LLtxmrGQQPTX
	 tJZyO6ZIGBlfJ5eutJRQSr/vf915nb3K92zf3dowEYG4kwzNa2jXaQS/USqX57qLsW
	 0WoI6ARIyfADQ==
Date: Mon, 23 Jun 2025 09:43:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 1/8] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aFl2CT8rIC-MgvK3@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-2-hch@lst.de>

On Mon, Jun 23, 2025 at 04:12:23PM +0200, Christoph Hellwig wrote:
> To get out of the DMA mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.
> 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
