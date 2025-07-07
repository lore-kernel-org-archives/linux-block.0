Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC802BDC0B
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900483; cv=none; b=sGHQTDhJYcQQRc/I0xSgRurKpZ7kcbXsI8AEjSV18auuQMV+oV4EGGQrbgjGaaVfM2la7O832mx6docqGyuu4KRJ/gMjGDpi745S4XpvvZKDRIS8VDtm2IY9hD/mqbfXvXGx6nWhNAvRLUQP/PgwU84RLgwpkLt99LDdpzKlUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900483; c=relaxed/simple;
	bh=zh845HLfEfmDzFavXD+TwwTgUig9Bc93q2D5lWSZ5Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvG210FdH+RA6uLeKz5Vc6X1gf4Uhx43SWemIc6PvB5Bc7dS2/g/noc3yYyYlJy/j9OAc9UPviTKJ4mEGAjne+IpafVlX9j35dZdGp9zfKvmt5Lzfzatuat3xUzpTjWrOMLpGL3WqOXgQHMLnjFgdXYFj1VgHTBfKWWRaLH9UJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B54C68C7B; Mon,  7 Jul 2025 17:01:17 +0200 (CEST)
Date: Mon, 7 Jul 2025 17:01:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	ben.copeland@linaro.org, leon@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <20250707150116.GA1939@lst.de>
References: <20250707125223.3022531-1-hch@lst.de> <aGvZ5Xk5L66sNWJL@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvZ5Xk5L66sNWJL@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 07, 2025 at 08:29:57AM -0600, Keith Busch wrote:
> Given it works fine for SGL, how do you feel about unconditionally
> creating an NVMe SGL, and then call some "nvme_sgl_to_prp()" helper only
> when needed? This means we only have one teardown path that matches the
> setup.

I briefly thought about it and discard it because:

  1) I thought it was too complex
  2) the need to allocate relatively expensive data dma coherent
     memory for something that is never DMAed to.

> This is something I hacked up over the weekend. It's only lightly
> tested, and I know there's a bug somewhere here with the chainging, but
> it's a start.

This looks a lot less complex than I feared.  I still don't think having
to allocate DMA memory for storing the ranges is all that great, mostly
because this is exactly the path we're going to hit for non-coherent
attachment where the DMA coherent memory will have a performance impact
because it is marked uncachable.

