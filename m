Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCB194A73;
	Mon, 13 Oct 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382080; cv=none; b=QqQA8Z+nd4Zp8GSDrI7oxbJJYWJQ6MOKpgONcIuV3fbR9sp4SK2uj829UiLo1J77SLmoV5zlnRqsEz5Wn/LiIBSga2V1pFOZlfeymsgWCTFT9SKEy5fdAgrzm+QnZfbxYFNIkVqbwx9l/EshWnFk7+PkN8xjrUvTStnX8iQupgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382080; c=relaxed/simple;
	bh=XQDkE/8tBk6nehhOH0iQzIUwEp3GEInWpkiI99TIOQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkGsGU8QDygWZ3eyvgI6020B0jdybJ8rSekxJgfuygp9HQm76GXBTXbYIr8chx+9q99N+FyhqjGbIhpSGuHgVwyeV2B0xHG6uXgKVtx0Mei0RJj7O93+g/6tKNrc/nM63aGjn6dr4aIhGXLnbdG0dZ+uBhcCu9yzvOLF6F4D2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhaz/Tnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhaz/Tnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C89C4CEE7;
	Mon, 13 Oct 2025 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382080;
	bh=XQDkE/8tBk6nehhOH0iQzIUwEp3GEInWpkiI99TIOQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qhaz/TnwVyoz6uNWfuBZZDGSDBBQT6YiFDSTiw6kj9qLlFOT5yPCC3xtvMC1oXAK+
	 CntVwTbpTyhaLvipsZtw0+6KlWL0FHX5K1/R3VcP38joXFPoXKLLlag80ONETCfTjY
	 09I8r/dX4oNga1FjMvtD6c64E9nTjuF2naqiXX/IXQb0Xp68Q2n8M+nNr4mysTueJU
	 vLgiUWhc/QVS9cuquDY4/nQ/Erv9bPgkja5lOUhvO37poGzsK0+J793cIGg85RqJ/X
	 keI5PZM5HeXEtGD2dk9F1bOioWxlrxIQstXRzaGt9t1SfdcZntRWMXzcbnlMzvLtDE
	 tCLNIpfS2yW0A==
Date: Mon, 13 Oct 2025 13:01:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <aO1MfsuWeteOsBve@kbusch-mbp>
References: <cover.1760369219.git.leon@kernel.org>
 <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>

On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
> +	unsigned int attrs = 0;
> +
> +	if (req->cmd_flags & REQ_MMIO)
> +		attrs |= DMA_ATTR_MMIO;

Since data and integrity paylods use these same functions and may point
to different kinds of memory, I think you'd have to pass the 'attrs'
from the caller since it knows which flags to check for MMIO dma.
