Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C07246BC5
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561233; cv=none; b=RXNaqK0rPkLDQ8ktOOJ9jl5RvP+2CMeouqprZhKPBFb+KIotgIbxPYjNRDf/CdYK7+p0/TrY/lri2WlfpPP2QKLW8eCPOkvzzArs0y4+bE4bC1bvmsUeA3cZE8jQM9Z6wNaScpkKgK8kQD3Jffy1ZNNN3Ml5niVajijQyIR1P9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561233; c=relaxed/simple;
	bh=BEKmVOJhz3jVgKIjJ4SjRW6f210g6LHQHx7qt6c4/hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh/kTH3NlhVmaStRzQNg6YdHoXCzlkqXK9V/WqyL7ivjJ9N1NdtOmoMnYdTTG2HKq7pCfVe6uQnUJmp7ol7376Rpg8NbJh3E0AL32+CIgEUIXTNTmHTNyUe97uWqcezZOoVP45+kNoSKAy/w2XsAlcDX3WJKiYgtgAZ92aOdo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO6Lupjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO6Lupjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F364C4CEED;
	Tue, 10 Jun 2025 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561232;
	bh=BEKmVOJhz3jVgKIjJ4SjRW6f210g6LHQHx7qt6c4/hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HO6LupjrFqtua7wTLd53oFX1/vAPlI16Umc89yLJWaTZA/+4vXgANoaX0KoMRFQBR
	 8VMU7UMhcODsxnI5u357rZWbJCI7n9fymzDT3DzEEug7d0ONTSs0ax6KgaKjWfV7Ss
	 A8mSkSWIKQxfIg+7WXqsdgrEzwaC2nXEJ+6GcY0zMR3lix9/80It1MigwEDx5A92BY
	 eb4eqpTetUgK62WZQrWc+5tUIjNsBvE9BU9QFjYI9/60x6PVB3WFhrFhDqFhxYu8nH
	 fSzwjw3DmrSI4cMbWTWHGvLBwI2AIaaqM3Ns0tYYKX9PglDsOYgYwV/ylxHg3A2jRN
	 yK2B5ALlyVNFA==
Date: Tue, 10 Jun 2025 16:13:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into a
 common helper
Message-ID: <20250610131348.GG10669@unreal>
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
> nvme_setup_prp_simple and nvme_setup_sgl_simple share a lot of logic.
> Merge them into a single helper that makes use of the previously added
> use_sgl tristate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 77 +++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0b85c11d3c96..50bb1ebe6810 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -814,42 +814,41 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
>  	return BLK_STS_OK;
>  }

<...>

> -static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
> -		struct request *req, struct nvme_rw_command *cmnd,
> -		struct bio_vec *bv)
> +static blk_status_t nvme_pci_setup_data_simple(struct request *req,
> +		enum nvme_use_sgl use_sgl)

<...>

> +	if (!use_sgl && !prp_possible)

use_sgl  is tristate, the better check will be use_sgl == SGL_UNSUPPORTED.

Thanks
