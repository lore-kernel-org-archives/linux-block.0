Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D126E703;
	Thu, 13 Nov 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063413; cv=none; b=PUK8W3kiQupxI+oLmeL8D0DdTA+FM83feg602v8KWICqnIprjRCfpGWHaTu6NgQ9WqXSIW/mL/iuc7FLojdueu+HcivCZXZUsrbk+uKT41WIJHb1j9NuW0ZoMkUBlN4diRRjE5Sav6HGvWymcgooZtKdHydCFAhC2enRtvpOwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063413; c=relaxed/simple;
	bh=eNPNodYFApHec4BDGgRX72NqGnTqhOIXzUg3LwyKAvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+B4Ov6BMNq4TPbGc1dNyuiClufrrNz4cITtzWqvqmy4CXEXMzsMJQiLTg7uNiJRUfrlTLZm3JNv3C0KdrexXTeFPnPLPL5ek7ekI9/WzyVNHGUV/RxMVfl3zy5UcZ9MkcgHEbMTiYsBvomijp+NDxV4viCEcY18/DJTZ177V8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWOLPTU+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWOLPTU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BC5C19421;
	Thu, 13 Nov 2025 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063413;
	bh=eNPNodYFApHec4BDGgRX72NqGnTqhOIXzUg3LwyKAvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWOLPTU+ygLA1y9HjBcJPjoK57J8PhzWfCnQpIMFFOPi7DzPC2B/gi5EFSdDhwxLE
	 RlRP05htNACFS3kqFDgAdi23EmUmQpgW6NtLufRsvmj1VZDroAeiD4vBsCMTBf0YlY
	 sw8qOhGcGYdkg12hmVx+SevZWNuR6FOJ4PcjUL+T5NKwg9priPejxFyOzhqN6pBGx6
	 GRO4uSTe4/G6r/iAzLrVjQezOtL6VaDSygwkr3R5puwNJjfGZh9QLnEx571k1S/hhn
	 Cob+LPFN5m3cpPwjsPe9MWrV9VVusRuM1VjtiD+BRL4YnqcaCB61jPlmdrETq2wpUT
	 ThgJ9LYAa+6MA==
Date: Thu, 13 Nov 2025 21:50:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <20251113195008.GA111768@unreal>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>

On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
> On 11/13/25 10:12 AM, Jens Axboe wrote:
> > On 11/13/25 9:39 AM, Jens Axboe wrote:
> >>
> >> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
> >>> Changelog:
> >>> v4:
> >>>  * Changed double "if" to be "else if".
> >>>  * Added missed PCI_P2PDMA_MAP_NONE case.
> >>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
> >>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
> >>>  * Removed REQ_P2PDMA flag from block layer.
> >>>  * Simplified map_phys conversion patch.
> >>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
> >>>  * Added Chirstoph's Reviewed-by tag for first patch.
> >>>  * Squashed patches
> >>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
> >>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
> >>>  * Reordered patches.
> >>>  * Dropped patch which tried to unify unmap flow.
> >>>  * Set MMIO flag separately for data and integrity payloads.
> >>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
> >>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
> >> [2/2] block-dma: properly take MMIO path
> >>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb
> > 
> > And now dropped again - this doesn't boot on neither my big test box
> > with 33 nvme drives, nor even on my local test vm. Two different archs,
> > and very different setups. Which begs the question, how on earth was
> > this tested, if it doesn't boot on anything I have here?!
> 
> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
> be a fatal error. And secondly, this just further backs up that there's
> ZERO testing done on this patchset at all. WTF?
> 
> FWIW, the below makes it boot just fine, as expected, as a default zero
> filled iter then matches the UNKNOWN case.
> 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..4cce69226773 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1087,6 +1087,7 @@ static blk_status_t nvme_map_data(struct request *req)
>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>  		iod->flags |= IOD_DATA_MMIO;
>  		break;
> +	case PCI_P2PDMA_MAP_UNKNOWN:
>  	case PCI_P2PDMA_MAP_NONE:
>  		break;
>  	default:
> @@ -1122,6 +1123,7 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>  		iod->flags |= IOD_META_MMIO;
>  		break;
> +	case PCI_P2PDMA_MAP_UNKNOWN:
>  	case PCI_P2PDMA_MAP_NONE:
>  		break;
>  	default:

Sorry for troubles.

Can you please squash this fixup instead?
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 98554929507a..807048644f2e 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -172,6 +172,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 
        memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
        iter->status = BLK_STS_OK;
+       iter->p2pdma.map = PCI_P2PDMA_MAP_NONE;
 
        /*
         * Grab the first segment ASAP because we'll need it to check for P2P




> 
> -- 
> Jens Axboe
