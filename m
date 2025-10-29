Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF02C027E
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745871; cv=none; b=n2EoZ+zTGTHrag903W697FOVCWrjqXJJ3xCyvEH4p/pA+P/S7c3ZHtNmlHByLMT8vPot5YPaOLV3BAE85ra9LXHTMJjKLl8wr1v06/vdvSyFfHy2sLdQjJhXoYwV44U6KrFJ4tHDXeWrlqzbxJ038uvnnABiIYQfPPM2CrTx82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745871; c=relaxed/simple;
	bh=9B4prkjw1DJmnZNoy3jjGCzl9wzDb1irt8WmZ3kR/tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGIWDzaxvdFWRSl2Z7PfX0vP1oKuWejuoBipa0ndU73Zbz8LQDoU8ptk4X2JoctN31hntT4cdvXTbTo9/2HW6YzUIgFXOBHBOpWOiSQzNtcPnUHs0Z1FhsrxmT9P5ApluY3DCL/wv2ztxfDSPxyIKpfhpVQmMdL4J4071OTp5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDEBA227A88; Wed, 29 Oct 2025 14:51:03 +0100 (CET)
Date: Wed, 29 Oct 2025 14:51:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Message-ID: <20251029135103.GA15688@lst.de>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133956.19554-1-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 02:39:56PM +0100, Hans Holmberg wrote:
> This driver assumes that bio vectors are memory aligned to the logical
> block size, so set the queue limit to reflect that.
> 
> Unless we set up the limit based on the logical block size, we will go
> out of page bounds in copy_to_nullb / copy_from_nullb.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
> 
> A fixes tag would be in order, but I have not figured out exactly when
> this became a problem.

In theory probably since day 1, and in practice since direct I/O allowed
less than lba size memory alignment:

Fixes: bf8d08532bc1 ("iomap: add support for dma aligned direct-io")
Fixes: b1a000d3b8ec ("block: relax direct io memory alignment")

