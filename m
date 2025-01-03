Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50601CEE8D;
	Fri,  3 Jan 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735894620; cv=none; b=O7NDw2HwPX4kNcOQmw3RePZu7hofUTTLTGm5GLbv4NW8yShKTn4/vwqcH6bAugW/125gDRNGC5VS1yAzCkPTF30/QF0LeDDVds7RTczdP4gW+VZsLFr3NcXvMRPpRhF7PbGq6SL42WsYmcjphVsDM8gk1yrF0/EwiNhQb5lW4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735894620; c=relaxed/simple;
	bh=8vzxhfy56M5QIkcrrO6j9scG6nIWHfl1N6S8L+oOkk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPnzeWRt/7+iuFMkTXxvxgOwqKMUEIRCTuek1Cdxqwc/bxJ1BCmI+LNzReGP7ixP/DMsKYPaaRe9W8Py02P5sLbDrFgusdlf1UabeAyTbtyo4j3D2OfrW4V26/Cv3zvGcbhQ2nAfWVhZiFDA1p4kU21qiMNI75+FsV331g2pPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BEB7668BFE; Fri,  3 Jan 2025 09:56:52 +0100 (CET)
Date: Fri, 3 Jan 2025 09:56:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Christoph Hellwig <hch@lst.de>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ps3disk: Do not use dev->bounce_size before it is set
Message-ID: <20250103085652.GA31691@lst.de>
References: <06988f959ea6885b8bd7fb3b9059dd54bc6bbad7.1735894216.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06988f959ea6885b8bd7fb3b9059dd54bc6bbad7.1735894216.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 03, 2025 at 09:51:25AM +0100, Geert Uytterhoeven wrote:
> dev->bounce_size is only initialized after it is used to set the queue
> limits.  Fix this by using BOUNCE_SIZE instead.
> 
> Fixes: a7f18b74dbe17162 ("ps3disk: pass queue_limits to blk_mq_alloc_disk")
> Reported-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> Closes: https://lore.kernel.org/39256db9-3d73-4e86-a49b-300dfd670212@gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But looking at the report it seems like no one cares about ps3 upstream,
and in fact the only person caring at all rather rants on youtube than
helping upstream, so maybe we should just remove the ps3 support entirely?
