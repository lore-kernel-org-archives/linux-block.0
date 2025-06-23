Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30C2777E5
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693461; cv=none; b=n9xMeeZJQkfdlvC0fKf9TSaRMxBoXD2lP/xdoNa6XjTju+ZIETETFwKeML+4mJuf2nvhdxU1sK65ljasVBC17Zx9nQbakIHZ0uJ53jbBDHadwnJ8CSLoKceYrqb77L06k7MjgDmv4kqdJmGIQ5TSNKDfShBZBNekVKjwmeAsHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693461; c=relaxed/simple;
	bh=9BQ1ioDiMBHUQu+2sHzZIu1nET0FBJI3rflpGZEATno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYG/9ZpQboI2CowRGsYz31E/PDpC8KW5Py4E1lH6S/+YCvRPVdpxYXpLUZx3y3zlMMPwIrdox8FgYOEQo5nA13H9N3OOi/E2deUegJQRyZtmtr8gF39zud++gpKwpriGSSi7r4E+9cBPs627CqwGWPO5laBm+ZHn+Tp8Ct1uUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDxvg3jD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDxvg3jD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6729C4CEEA;
	Mon, 23 Jun 2025 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693460;
	bh=9BQ1ioDiMBHUQu+2sHzZIu1nET0FBJI3rflpGZEATno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDxvg3jDPtEphFw4T6z/BN7F+rE3LR5IecdJODREv8obGTCh6KkPExbRzgdnDjkGS
	 Glxr8XV0cFaXTSaPtQbZ5yezGR/t5J3kBBZW95Pddm97TiFLWSEM3Uif/07xAChLws
	 M9q8v4o9J+1BOb29H55jYMYUYHMEvXnFL21I6FWOpsZRzPI0GH3q396trfzt78JBo9
	 oMSIoSoEBkGdzqnA8WjNzZE/PbKLR2/P0QzQQ444QjI2ZWsEWjrRqwUApo9WR77Swt
	 gw4Vvr/AOChadx8fxdyYbP7MrBdyx8zKlQJj6l0DyWljmaIGSGNRN9Bq3HaAhgELEN
	 aFSgw1+06Zysg==
Date: Mon, 23 Jun 2025 09:44:18 -0600
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
Subject: Re: [PATCH 7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
Message-ID: <aFl2Uvlskbt7iXiZ@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-8-hch@lst.de>

On Mon, Jun 23, 2025 at 04:12:29PM +0200, Christoph Hellwig wrote:
> Having a define in kiB units is a bit weird.  Also update the
> comment now that there is not scatterlist limit.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
