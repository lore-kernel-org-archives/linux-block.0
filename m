Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC802367DC
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675818; cv=none; b=Y4FbQkzSNIku8uch3QpE2XRoW1Kr11EDcBXXFYKjIB9YdHhCJSCWAkrGQ8KiCrS22ZCwht79ubtKFKxuzI0YPvev8yYdfuMZcH4oKB/wWI2w3IhJdQm57C/LMgbEmujZsXkXkbxpIyvxjp+2QLkOFmay1OlEIPGkVGrsZOEpt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675818; c=relaxed/simple;
	bh=lOkgvtgj9sy7GnMiuVwjhGZzIQR4ZlGrFnLJICxuZS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukdfkbfAKgYj6CSIw1XZ7/a2k+dD0FVX6tkgM7DRv4ychBG2KbT7kNv388cgayvu0uSDATghXUv4MSwSom+YmEZMS4c9tKXF1gj90guGjNFXUSon57kTSWQtMEDRvIuGzbNndB5AhtPL1wx6jkqPe1Trp2tMoA9Eu2wf3myk8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq7bofy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq7bofy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90164C4CEE3;
	Wed, 11 Jun 2025 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675818;
	bh=lOkgvtgj9sy7GnMiuVwjhGZzIQR4ZlGrFnLJICxuZS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq7bofy8svtSKuIOBunBaBGs1FW4TTIxY9w7MBLNAWILfVtutt55431YMfkrxs1jT
	 Yk4nj8qlWtay9tanIsEuIdFgbuiHOaBl26f0itnnICfEiVyQIJd0uJp+3QjAJQ5ZoF
	 wwKObOTHz1iAX9qThkQCWwwu1cSml1vKapXx5gWCgnHbU61I0JsU5cH/UNEtnDAG/H
	 k8ffCNeQhDIQhliNvu1qQkg235KVO09IB4TDLPLPJiEJXgK3YJeyug9iaV1+D/2W5I
	 dtJeF6dXwqQl8pMyqy/H0wqYhsMpGKOqm1YsBpokrU/ZD4W8JVxf4VcBZFXse+ILzi
	 ts+A7DfmSYiEw==
Date: Wed, 11 Jun 2025 15:03:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into a
 common helper
Message-ID: <aEnvJ6V3F0Z_pO1U@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-6-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:43AM +0200, Christoph Hellwig wrote:
> -	iod->dma_len = bv->bv_len;
> +		iod->cmd.common.dptr.prp1 = cpu_to_le64(dma_addr);
> +		iod->cmd.common.dptr.prp2 = 0;
> +		if (bv.bv_len > first_prp_len)
> +			iod->cmd.common.dptr.prp2 =
> +				cpu_to_le64(dma_addr + first_prp_len);

Nit, set prp2 to 0 in an 'else' case instead of unconditionally before
overwriting it?

Otherwise looks good.
