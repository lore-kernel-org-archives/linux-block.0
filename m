Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36830DD32;
	Mon, 17 Nov 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408144; cv=none; b=EpwKAQFE/ZnLvXF7oBIqP7oOhwDgQSqOUMwxKIi5c8uxT+89oVgZz+bTzorO3eEF99HVi5B6Crv6f1vL3yYbeq9As4XeWWkgtvTSp7SvvQ7CzNzTUdS8IFf69Tw044kcLdptgzSiIGKYs+U8lNOfHDimEWvD39tkLyTecriSCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408144; c=relaxed/simple;
	bh=aYstDzOU6itMkIGh7zOf1T4EpGAvHxMXBR+DR3zss+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJc26zu1RgkuDLubzSfwpAanleS4LOt7F5Cv40C94s+yKgcEjNxyRDRGwj6iIpClbiTL9YJ8OppzN2HT+DSDCbqCaBxPpBFCepixrw3uUFXF4uaCp2S/Kpr5D9B2qI99rmY4l59AeO7P8ekGxhzogXfsa0Q2XIkY8TdB/9rpDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxXuRDPH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxXuRDPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7C1C2BC9E;
	Mon, 17 Nov 2025 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763408143;
	bh=aYstDzOU6itMkIGh7zOf1T4EpGAvHxMXBR+DR3zss+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxXuRDPH0D9B/KbZiIuHuQ90VpbgFEGi+j7EmYkBgrLdjQ0tdi4xnvc7+/fiE/xnZ
	 2448UK7VlgSbw/az7lrSnq53ofNmRRismckpxSt/N3DUsNWQF1yi0P4ezfcAnnHeIb
	 PEHLrbJ7h3YTopCfSpv2i44PySDZMfrE73DqngCweLzgcahOGdFQo6sVJPraa7kK3K
	 Zt9B5/oKP1abb2ch2Q9Gjy0vgQHN0FTaWGiiYwelsltU37ZKkmKDyViFV/gtI9HhEE
	 CmH6BWHIFB1SRrBQpZxtMmWB2lZtmZTqqF2F+Hyk1cTOqDguWPC006IUZ8agTS5PrW
	 ioFNAADxoIkYQ==
Date: Mon, 17 Nov 2025 12:35:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <aRt5DPnMwzDw8_dF@kbusch-mbp>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>

On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..b61ec62b0ec6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -290,14 +290,14 @@ struct nvme_iod {
>  	u8 flags;
>  	u8 nr_descriptors;
>  
> -	unsigned int total_len;
> +	size_t total_len;

Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
limitation on how large an IO can be, so I don't think the driver's
length needs to match the phys_vec type.
