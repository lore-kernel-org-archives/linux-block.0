Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14B221727
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493340; cv=none; b=fZyU9EeL/K2EyWZR7Uk01lz+hnoE+UbyNj8ej/dTuzUIvAFJ110olPd5HbQJcp8IwZAqdqp4ifxFQwkHhkq8xM7Xi4oa7ZXzimA0WoyCe2rVCc2QTeF+MOoGj4orx2EXs3LbR9Xyh0dKc7/ulecYldXKrAexuAYz/x0euh7ePaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493340; c=relaxed/simple;
	bh=FZ0Usw8k6y/En8tMkCLhUDye58irBWsqGLthxCn3t3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf/Z1pqT85aKCPL6lWMYK4aFku2hu0Qd69nSwhFYXSvedcoj9Yb+ofxb7icQo4CHWmjB6PuFY8BEKl/PizoGsySkOJfWjUKeVRG5HoJUX/tHqLgeojFCmercwgC5+SuzzZ5UsLFO0OuK6yE/oyz8TGefz6ygcjl/wETiFECeTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D396227A87; Mon, 14 Jul 2025 13:42:14 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:42:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
Message-ID: <20250714114213.GA1998@lst.de>
References: <20250711112250.633269-1-hch@lst.de> <3ec40c94-ad7f-4985-bb40-275ebc6427bd@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec40c94-ad7f-4985-bb40-275ebc6427bd@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 11, 2025 at 07:46:08AM -0600, Jens Axboe wrote:
> On 7/11/25 5:22 AM, Christoph Hellwig wrote:
> > Not only do IOVA mappings no need the separate dma_vec tracking, it
> > also won't free it and thus leak the allocations.
> > 
> > Fixes: 10f50d4127e2 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
>          ^^^^^^^^^^^^
> 
> b8b7570a7ec872f2a27b775c4f8710ca8a357adf

Ah, sorry.  That was the commit ID in my tree before I sent the original
patch out.

