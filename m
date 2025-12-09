Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056722405E1
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765262420; cv=none; b=Fdzpt8NBpnb2uo+CkmJvHY9Zp6nJCMxAR4EZoCDzLyPhXhujFS9EYpaHPOh8a1Xr7oUVnPVDWNV87hECiY917CUJ+A6PBPx/2QQEK+rFN/cLiwzi+P4/bsKTyeUmXNITPA985+g23r+Ddo0AyaTqO3w+vW1m61UkBBmgUhRfJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765262420; c=relaxed/simple;
	bh=DiO4dArmxiw4HN/qJPtYOijhWePYEcgloboNnphOl9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMKtUcfElvwhkti8Tfp5D0PHa606eFLMsnHd7b+a2tV1APs7MediEdgx400WrXDtH34NK0n2/KlL6KA5eeEL5Z+o54zQaOgQvvxi8owmi4teXZBX4oBpkVp7SpRuVgNJoeXXt6kfSf0/S1kcdJPNG4sIn4Jp7ypBW/YdChm6oHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0972768AFE; Tue,  9 Dec 2025 07:40:16 +0100 (CET)
Date: Tue, 9 Dec 2025 07:40:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	hch@lst.de, kch@nvidia.com, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: set virt boundary according to capability
Message-ID: <20251209064015.GC27728@lst.de>
References: <20251208222620.13882-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208222620.13882-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 09, 2025 at 12:26:20AM +0200, Max Gurtovoy wrote:
> Some controllers advertise DWORD alignment for SGLs, so configure the
> virtual boundary correctly for those devices.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/nvme/host/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..eacc89cd25eb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3326,7 +3326,9 @@ static unsigned long nvme_pci_get_virt_boundary(struct nvme_ctrl *ctrl,
>  {
>  	if (!nvme_ctrl_sgl_supported(ctrl) || is_admin)
>  		return NVME_CTRL_PAGE_SIZE - 1;
> -	return 0;
> +	else if (ctrl->sgls & NVME_CTRL_SGLS_BYTE_ALIGNED)
> +		return 0;
> +	return 3;

I don't think this is correct.  NVME_CTRL_SGLS_BYTE_ALIGNED requires
each SGL to be aligned, but is not a virt boundary.  The dma_alignment
value in the queue_limits already takes care of that.

