Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FB175B0;
	Mon, 22 Jan 2024 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908871; cv=none; b=maPQ7icgXi+5rg1X2rS5nLrRprR68cVyBB0amAJvGmQnCEZKk/Upm3NYlclByHIe17J9QnyFgYfPVBE/wIeKen+/mqRy3wyLPSK/dTWb4Ck65DT07KZNYmCdyD58J2RsQq8H/hOJDdu2n/Wdrg2LlSC9QHtmzntQQamYjVvwOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908871; c=relaxed/simple;
	bh=m8c/1bcEcp6mfBMonS4CM9yFd3xSx/LZIzq7d4Zj1co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPHCck8r8xZzYz3h/+vecPdnoRNvM1YMwDP/V5kDzZoVFZW/vc3+5iaNozKh48uYVAIKruZN764VE7rA0lvVJpRQMspQBZxK3hLHjOnGkrANgIch2On1tgGX+UHj+JBlnDQB8QnbvHTvxIc+VjlmwEURaRy528mdLJcW03a+gWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9114C68B05; Mon, 22 Jan 2024 08:34:23 +0100 (CET)
Date: Mon, 22 Jan 2024 08:34:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a
 q_usage_counter reference is held when splitting bios
Message-ID: <20240122073423.GA25859@lst.de>
References: <20240112054449.GA6829@lst.de> <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk> <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 15, 2024 at 12:20:50PM +0100, Ulf Hansson wrote:
> Not sure exactly what problem you are trying to solve here, but I am
> certainly happy to help, if I can.
> 
> Can you perhaps point me to a couple of drivers that need to be converted?

Sure.

mmc_alloc_disk sets BLK_BOUNCE_HIGH for any mmc host that doesn't have a
DMA mask set, which is a bit odd as all proper devices should have a
valid DMA mask.  I suspect platform devices might sometimes not have
one, which historically was the wild west.

A better indicator might be the use of page_address in the I/O path,
which usually comes in the form of using the sg_virt() helper.
For drivers/mmc/ that seems to be: davinci_mmc, moxart-mmc, mvsdio,
mxcmmc, omap, sdhci-esdhc-mcf and sh_mmcif.

tmio_mmc_core on the other hand seems to have code properly kmapping
a scatterlist, which might be worth lifting into a common helper to
help the above drivers.

> 
> Kind regards
> Uffe
---end quoted text---
