Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F12D8766;
	Tue, 18 Nov 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446145; cv=none; b=G+dRUnApFi4oc5UEgOxdSIQqwjI9oubLz4Unw0yTJiw0vzPQZVAR/Jobfvjsz9anN9+KhP9iVtYzMxwJnR5YgZ0Ek/SEexyXRBv/ic4iwQD2qmL2IUkmzOVVALt5cMqys3JBg3ccMKCGUUODKPCjU1gFd3z4CTFke16Al3c4RzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446145; c=relaxed/simple;
	bh=R/ep9/2wj7jRpmNXpNVSnR4sBnBhhZB9fN+TKBN7LM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLP5QwtpRODMwAEyKzoK+Az6Bj6SllPgsXw4aqqtiviQvIAKqXCbg4fXun+3jDHKDvVIDvcHLwyoPxi9biy/fLVibS04qccqFXvOiPPdxnvtKz+9/aBIuNh5XbP7N1VxF6QjfVN+78YMkQnmaYp8gKU1UDCvAve1p6+6zUQlLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tpIvhqFY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tpIvhqFY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UOVltvm8AEcc6pbXpl9Km0eDgkPooIIKrT0WA4zquc0=; b=tpIvhqFYTmwBmhBMeAtKifC3BW
	afWLzBuM8IMWkqEsNb0IzuvCgyExOFzN60rt3PV90iLZYJekwFTEFua5jq6tweNq7urMoOMegOxeX
	WS+U8yUxIdwUTGKqTwIzboAmwPvovDuzhx8ycnqRUOmnKqRMXlrpI01TcsWqjjmisIiCZk1ihJxyV
	hrvfK9gvaun7AewDQT7ceYVU5861HV7J/K09Fw0/Li+evS9YJRa1LcgUrAKNwlYn+L7ac9L0aNGXI
	lDuu/Ej0E20aKShS9IFbl6Ia6DeB98ZWM1i6TanrHhCkEUKCp6QXNHU9qNnKTEBGsH0fWiUW1Trtf
	U030YVwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLEti-0000000HTFr-0qii;
	Tue, 18 Nov 2025 06:09:02 +0000
Date: Mon, 17 Nov 2025 22:09:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, shuah@kernel.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] drbd: add missing kernel-doc for peer_device parameter
Message-ID: <aRwNfiIWUVl5G0eX@infradead.org>
References: <20251117172557.355797-1-hsukrut3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117172557.355797-1-hsukrut3@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 17, 2025 at 10:55:56PM +0530, Sukrut Heroorkar wrote:
> W=1 build warns that peer_device is undocumented in the bitmap I/O
> handlers. This parameter was introduced in commit 8164dd6c8ae1
> ("drbd: Add peer device parameter to whole-bitmap I/O handlers"), but
> the kernel-doc was not updated.
> 
> Add the missing @peer_device entry.

Or just make it a non-kerneldoc comment as it doesn't document an
external API to start with.

