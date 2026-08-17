Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA7314B72;
	Mon, 17 Aug 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952726; cv=none; b=M4F3BFutO1q4ikNNHMSkpnoYqj7zHKHRpfrBGfKRZTkCzb6OKBJBCRCYMfmdAkf8bmUn5uQyLNm+rGxelJ5toYXPt9cqDjJACXheaCeHyL/IufInqGgm2e3Xu36JOHyB5NvZYTBbQXPljNgnemnIlx4SUAayvG7FKqGhx+aujHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952726; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z78BCH+9pqVcj+VDOkLQfQSlxuOYp8cOVq9c511OUC+jm8WYtyfauLobr9sKb1s7ovT36uhr1a6Xh+JpkDxkfEmj5s4XMU3a7h3OYR9ofdlBmcA6035F5eAx+IpdRVp9i2hWJSV8A2oKnIwBaIurxRBCAMeZnqkRlvya+qD+FLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mbTG83/K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mbTG83/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mbTG83/K2S+J5pDoicv0OcfLph
	e6nNkwuX2HaW3JOkVMOAO7ciC1MYYRtwp+wfigfBaFsSbSHNY40UsX3dheFfwZl3xViZuIcsmxL5L
	JQsSTjei5j6MazOdrcTKksf8x/NiYdCx3HV/9tGPxw7ATyRuVXl+ddYKl7rV7xUxmx73KDqdINuAQ
	1GJ1AoxxHNPTuJi2YopVCOaPA9rI27ooQr58Rtlw8GoyFxJD98VZ2AtLDhJyWHnLGfZxZUI0/hezl
	6y9USTevMzRd8y92fJ3d1w+r1AdaQXaUYteAthlwR8FrvY52sIf5OKhp0ghBLtTUXuAqJoxB/wonR
	k/IJGFbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvs27-00000005ams-27bg;
	Mon, 17 Aug 2026 07:45:23 +0000
Date: Mon, 17 Aug 2026 00:45:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bryan Boquel <boquelbryan6@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq-dma: fix typo in DMA iterator kernel-doc
Message-ID: <aoK8Eyndt5eA9m0s@infradead.org>
References: <20260816131456.16374-1-boquelbryan6@gmail.com>
 <20260816131456.16374-3-boquelbryan6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816131456.16374-3-boquelbryan6@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

