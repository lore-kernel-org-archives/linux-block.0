Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E966246BD8
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561679; cv=none; b=t4Grae2Owe9yL9ZjlINy68xPXH42f2iX4cWMelXiW9Lawi8g30R919BM3sMX7rPXLlJVDtBlTnGWfSQr2kQwMrIIaIUYXOGjJEa4siNaW7gICDsrJSogOgpboKqmjvPMTppolQAmWpgtiNEr2hucWoRCLgUtcf3JZQAt9DNCY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561679; c=relaxed/simple;
	bh=10S+xVvF16s9qvOEZyyoDZfF61hAPS63yI0C8ViAS/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk+KPLgSjyImfM7FkHqbRBfte2cDU2b7IoWRGGplTfLid0JRIxC4SgFsQpgm3qTfRdsutdSHDxBzXjPPzP0fDTOgXolVuAsWD4GQkV/J6f+YpfvbN7zk6cFXjsFURob3NkOhnuqBv9tHNI57uETDliDOkx8thgYncYrUTjDIcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8DpxI9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8DpxI9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C678AC4CEED;
	Tue, 10 Jun 2025 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561676;
	bh=10S+xVvF16s9qvOEZyyoDZfF61hAPS63yI0C8ViAS/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8DpxI9t+f6J/GNMwvUtbAixFN0Q3e9z/iWrXBeJ2qx015Bfqxu6EpKz/G9pbKxTR
	 0DO7pQKkFV0be6bU5t1pzx4irn/Z0wtRuYB92KWxJ+WmDLdn2hMI1Us47qyoq+tHk/
	 xavKBJ+cWU7Po/f9+E/wSfctRtchQR5MZtcBQctcGHqsltWkhVIToNaoO4KEwqzdo7
	 Pn5H3I0gmQiCc+j3H7NX8Lyiqhf3/ajhn81c+NQqYldQzb6tUOA8Y78/QfmBLotId8
	 uHU5Gmeo6HsEAsvcdiXsnb3ugS/LjBMVoRbRrnVvGF+gbc1p/9P4it3gplqJg7Vkix
	 SexWPcfpybh4A==
Date: Tue, 10 Jun 2025 16:21:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme-pci: rework the build time assert for
 NVME_MAX_NR_DESCRIPTORS
Message-ID: <20250610132112.GK10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-10-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:47AM +0200, Christoph Hellwig wrote:
> The current use of an always_inline helper is a bit convoluted.
> Instead use macros that represent the arithmerics used for building
> up the PRP chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
