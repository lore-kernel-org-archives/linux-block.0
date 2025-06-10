Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4029C34E
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561618; cv=none; b=jG0VbhiWTJDfipSaFQIRuuV6SJN21Umjt2ZuhkHKoymDH0ErOj2bKeYxNGXaahyvvXIPj6hl8ozo5yyfTGTDBXFdOHSEwWz5NnoKv9ZPFDq4Rxjloa9pAUe2rSLtWbdSY1k7DQsHW0nahd35/2DlJRDOx6ycDpi+tT1PKV70avM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561618; c=relaxed/simple;
	bh=cyz4Q7V5s/h6THVop6oSMlps3g7tfgbA8Q0ScJkllSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8WyN74kw2FdmNxZHwuSpCfWxECUnReMVSYXkiryOxeKUhLHua5Tq3KfT6J7l9c/8KEPbePiEYJlBw3zwtGH2sGdzLoYREwuX71Y7PYbeq1S9pNGa3FsUgARYTAPBf4rkhFuGr1H9u5XsPvZnyEJjx0TFpR7iT5ftzlWH/2dmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNWcAeez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNWcAeez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88410C4CEED;
	Tue, 10 Jun 2025 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561618;
	bh=cyz4Q7V5s/h6THVop6oSMlps3g7tfgbA8Q0ScJkllSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNWcAeezOrk7UcMXq5T3efkzGkdJUVHyKsdlRWhDEZDdC8bpoOCdiA10tFUNyJ7Kk
	 NswjNg649rAhMkwICZrpTPke+QUMa0c75o4NC4D1obuL7P4/3A8e2hn2hxIqH5kxTg
	 0/gv3yOaJ/8LxxQnJhBawEEqdg9cIA4SUyas7kR5o0r0wuQcfCvaBFg/DDEI4gBlXY
	 Slbq6SAA+GexgpTkjCChOpKTzxXPrDTrUV8mJLJH0gQ+kdpzTmbApwoD+sloSuGsPP
	 5KYy5LzoRmp8cvWbEAlgltppsIEOj5BcHR90MSe9OMMA/I5vjfT+tVfFDCOyAcTIFz
	 aouMid3e0J70g==
Date: Tue, 10 Jun 2025 16:20:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/9] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
Message-ID: <20250610132013.GJ10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-9-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:46AM +0200, Christoph Hellwig wrote:
> Having a define in kiB units is a bit weird.  Also update the
> comment now that there is not scatterlist limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
