Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F821EE7B9
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114227; cv=none; b=YdixinC96MCtU2QBHTv3A4ySK1jKOmZTo2kFubLmqdm/8XgnKJ16M63A3/7IUEhKodz5DIdqovFoiNMiGktCuprXoTmxDkBGZ3Z6dUwldtt9QSQXWZPHp/JEpX1BkBB4mcubCVkhnkloTdrrx+7aHmTJkfWyGygmwD4B4+zVA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114227; c=relaxed/simple;
	bh=OU7VDv3Ik5OquhYHOS8hDGWMbyIjdDAMocFMVEM+aeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBahk2zHRTTt5oQCcBgmX37EJ3q1mQX5HVQ+Z62Jb6NDenPJ7DE1LlbPntwKzKhBicSRdD8oAIx/vzDk/hsiIEFa1jPii2RvnG3KK9ZcaRX921EURn4UUze4eYVWPiktUUrAYQetm8F8eeUkWbHRLwLblwZbR90fc3eXrmzsyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YjPK4Vwt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YjPK4Vwt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tIy6NvyzpEVL57IiRP/CxCN/mr82a9jUaywBE6NxTH0=; b=YjPK4VwtPEQGIYTEjehOYplBl3
	5lPKqdrvu5xD2BrGXHfbv10YVTlrOYO4yPVkDz3NArcjdq3AsIbcwDVYHla4tnm4L2maSUOjllbe+
	PvyaiA6JpvEwooAs0jPYqW4ekBFO9L9QfEcHYr3KoaDgkGztlS/99u4CCqyBDIHW/4+TfOxXZvJg1
	xrT1m0FoKq2c04cheQ2Z4U8IHnBMXs2WeFxEpUlJ3Ctxx2MR6EzA43pxvF2ILdJnUdPhumVbJcg+o
	81tk2XP1F9hY7dk1B64aQY+BS3DZbhTQhxGhukPX0oPO74yLTYW32MzIW/sppOU+bKgaSSOW4S/3x
	MnIaTyFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTWz-00000007VXi-1Z87;
	Mon, 25 Aug 2025 09:30:25 +0000
Date: Mon, 25 Aug 2025 02:30:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: rename min_segment_size
Message-ID: <aKwtMbB0LQGURNMF@infradead.org>
References: <20250822171038.1847867-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822171038.1847867-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 22, 2025 at 10:10:38AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Despite its name, the block layer is fine with segments smaller that the
> "min_segment_size" limit. The value is an optimization limit indicating
> the largest aligned segment that can be used without considering segment
> boundary limits, so give it a name that reflects that.

But max_aligned_segment also feels wrong for that.  It's not really
the maximum alignmnet, it is the fast path alignment.  Maybe something
like fast_segment_granularity or nosplit_segment_granularity?

