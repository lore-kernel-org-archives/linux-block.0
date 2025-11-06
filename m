Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94425C70D
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404054; cv=none; b=ZBRgT/aTiUvjhvXxW9ohyeihrfV/TESR75V1QMN8hvT4ccm08RWuZyAMAyg8imO+ckz12q1GgMZtBPXRSifQWzifH3Nu3aomi1WbN08t5Gy45mSxaxnu78+uUtuDRE+PNJj504zfsOINdGKTE6GuKCwhY+66oMpktxFnht9puWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404054; c=relaxed/simple;
	bh=Z2r7PThb4hJGpMVbTJZ/QgwyTAvBU/r2M3NW6kyUu/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkxyV9toMTvpuc1i920LGF7FyhiFdgd360MrR0PeSauihUbtLQ3DXwylym2KrtOMnAu2Lg2SfqyeiSuFjRx4nkXYibIJzfiWzMR7U+WDm0m5PHmv/4eHI5Gi4wHPo4iQGkNCbXZkpG4IXSXftKsPJNsZz1WcTxx8OuW2rKOqJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVDOIT3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVDOIT3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E36CC4CEF7;
	Thu,  6 Nov 2025 04:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762404053;
	bh=Z2r7PThb4hJGpMVbTJZ/QgwyTAvBU/r2M3NW6kyUu/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVDOIT3Q99QCsurV4cHsZGtbSorfHvdw3k6CPLG3eVnVxy9SFd4gYXJZo9QjCdZmV
	 NLylgL+kavruRjkigDNXsCFRyHAT7sHjTWEpfGdjucL3v2inSK9PEJqx9Y2wdyzg4J
	 jBDUmiWR3Z5qli4/ih4vqItCSwN1ZS5KpYuziqcx2sRL8hOjq9yzvfpnLFP1AzLCyT
	 d4nSBmB/nkUpik1cTAXsYoBBPTs7q3y7s1hVy/jxsa6l+hrHFn7wij2Spl8auKtnZJ
	 0ggeuhVLL6RzdxoTl5qdqm7OgYTi+bfuRlH8Vyyr0GvmyMIECgskvtUtEbf/wmKEPc
	 CpunI120KKjGg==
Date: Wed, 5 Nov 2025 21:40:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, hans.holmberg@wdc.com
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Message-ID: <aQwm04sLFcOvKV4Y@kbusch-mbp>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-5-kbusch@meta.com>
 <57db9d0f-299b-4043-82ec-55d502642631@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57db9d0f-299b-4043-82ec-55d502642631@kernel.org>

On Thu, Nov 06, 2025 at 01:31:24PM +0900, Damien Le Moal wrote:
> 
> Note: on top of this, for testing, I think it would be nice to add a config
> parameter to allow changing dma_alignment to higher values, and check requests
> when processing them against that alignment. That could allow testing corner
> cases or emulate devices with weird DMA alignment constraints.

Yeah, that sounds like it fits in with this limit: there are other
similar limits paramaterized by null_blk, like the virtual boundary, so
user defined dma alignment makes sense.
