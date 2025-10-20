Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DA2EB873;
	Mon, 20 Oct 2025 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950357; cv=none; b=l69A9XLX105/YKKX9EuzZSfSs7J2VBl4xe++wubjObvmLpzqQrffac9IPydZL/fyFooqmsG3LfVmi2K6UkYGFWfzJCAI5ddU59MdSQpO7vrvZ4AL100rHUapzbwshxesnFojbK3ePv8OpJ2R8KrA1Mc8PrEW012I2TzfSeHoxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950357; c=relaxed/simple;
	bh=XctXBijRc2JDDIlhKVK5AdZ/zUsO7k+Gdyg6LFp/1/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL5mnWUxsvFKjcUGl8tNT+T/kL/jTnrvudWOJDVfvNMb69ce9M9wEDHnU2KdmKuCx1riydTEpiA9tVNkyhGjoEC2jZGysYCQzMywwAaxbGsLMR8uvSYP9VhJvn5G0Be5+7NmEroEFjGs/7iAWhq81A8FSH2pTCaHdWQWYKeLSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdAz6XsE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdAz6XsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580E3C113D0;
	Mon, 20 Oct 2025 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760950357;
	bh=XctXBijRc2JDDIlhKVK5AdZ/zUsO7k+Gdyg6LFp/1/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdAz6XsE9T5PJ0dRt5Z4ZTU7tNu7N2NW3W3508ZVu8eEwMR7FT+qFqRcJ7F5bvZkT
	 zghrNdurS3+fiBKPa4JpeEPnsW8r3m/K1/4N3o/s+Te6D8MBQhaAAdq2D6fgocUUs7
	 3UWUGGQdF4MS1UiCGXB/oU9KlTOkWE4qOmkqUyAhulP0mWm7Nl/u84HM0JBK7p14kP
	 dhuPVdyKO1+oHJLI1BeiSDsmmsG5dVc+QyOOPYa+TSUfqKXgql5L1ebgSa8E7nMLat
	 deG2jAjmXcyKp47DOJ4aHRWEkpsv3y5FOdQO1P5pddNxEK2crDixaJk/6Sm9JHcddk
	 uVBvLq0qEPR/A==
Date: Mon, 20 Oct 2025 11:52:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020085231.GM6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
 <20251017062519.GC402@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017062519.GC402@lst.de>

On Fri, Oct 17, 2025 at 08:25:19AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:32:00AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Make sure that CPU is not synced and IOMMU is configured to take
> > MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.
> 
> Please write a commit log that explains this.  Where was DMA_ATTR_MMIO
> recently introduced?  Why?  What does this actually fix or improve?

What about this commit message?

Author: Leon Romanovsky <leonro@nvidia.com>
Date:   Mon Oct 13 18:34:12 2025 +0300

    block-dma: properly take MMIO path

    In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
    indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
    MMIO addresses, which requite to avoid any memory cache flushing, as
    an outcome of the discussion pointed in Link tag below.

    In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
    treated this as regular page and relied on "struct page" DMA flow.
    That flow performs CPU cache flushing, which shouldn't be done here,
    and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.

    Link: https://lore.kernel.org/all/f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com/
    Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

