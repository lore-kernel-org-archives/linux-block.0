Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB01DF994;
	Sun,  9 Nov 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762674815; cv=none; b=mTJ0JqfFYaLs37QBkDmzUpH92qNoSD6LyYk5s1sZJzYqGpwjp/tR+d/6fEgIQr/+1Kjp6tBLqWKn2jZ6WO67zk5c4oanISUtXIpBAG6RB8fMeJ8bFNg8xn2/Vjd2zqKPTSh/JrVeWmpgsmdgDW7or57bLi4DDcKaEJVeYpswcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762674815; c=relaxed/simple;
	bh=8/s0g3/HR6w0jvIa3DYIzWrYnWPBXTPU6zLnENISR1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6HbtisYE0P7kezlZRh9zsOWtynkP8fId3GAYQL4rUfj3CmirEEq3FI/IcpwHLpt3LOeOZpcdeqIOYd1uvoTMhTt1uQdIz0lV6CzdBVtnkiaHiI5/05e+n/DgcD3lFX45MWQ+Wk2PUdpFU9iT27IBz6O9aTSH+8n2/HNKCAkGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amHhB4Cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amHhB4Cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6352C116B1;
	Sun,  9 Nov 2025 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762674815;
	bh=8/s0g3/HR6w0jvIa3DYIzWrYnWPBXTPU6zLnENISR1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amHhB4CueYIvHhewZqF9CMedmqR3/FLxgK0n679eJcYLyjy2og1DU2Fa9if1ZPpuX
	 m1aaw+NDQ42PBEWcq63tL2dnznVOe6eTA9cIiHo1llS83SFZFj1RV0QTKfZHCT+2a6
	 s1K7AJ4reeDOe1pGDDA03wZgJIzX89AlNpMIcFUeuOTZpcC0DerXKkNLudGZq9FRSn
	 XwMTHB/msWU8j31CpqLF6Yl2NwXmbBub3f0vZlyTFwBfgp53P7sMI6y+TFHHnCDFFL
	 BnubK15RAgs99bag6IIDB928jxCOx4KEyymw/iH4Gil7wSZlV/T6HUARYBEjvQXbny
	 txVbjFFjQX8Tw==
Date: Sun, 9 Nov 2025 09:53:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <20251109075331.GA376289@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>

On Mon, Oct 27, 2025 at 09:30:19AM +0200, Leon Romanovsky wrote:

<...>

> ----------------------------------------------------------------------
> 
> This patch series improves block layer and NVMe driver support for MMIO
> memory regions, particularly for peer-to-peer (P2P) DMA transfers that
> go through the host bridge.
> 
> The series addresses a critical gap where P2P transfers through the host
> bridge (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) were not properly marked as
> MMIO memory, leading to potential issues with:
> 
> - Inappropriate CPU cache synchronization operations on MMIO regions
> - Incorrect DMA mapping/unmapping that doesn't respect MMIO semantics  
> - Missing IOMMU configuration for MMIO memory handling
> 
> This work is extracted from the larger DMA physical API improvement
> series [1] and focuses specifically on block layer and NVMe requirements
> for MMIO memory support.
> 
> Thanks
> 
> [1] https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com/
> 
> Leon Romanovsky (2):
>       nvme-pci: migrate to dma_map_phys instead of map_page
>       block-dma: properly take MMIO path

Hi,

Kind reminder.

Thanks
