Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83549620
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004786; cv=none; b=WacYAMqKPX4gp/lrf2HhjXSP7+aFGz8tDT5onzvyfE8/fnTAV3imRaxf1/h/x4jwhceU/T85s62FfC0t6j7sxcQAc6Bj1mkGKf/yNbbb/GwT+Y+7nJ018r1suvC2E0acnmGM1vTW3JW3mSE0uZLmqhi2hzH+IP2t6Lv2MN8V2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004786; c=relaxed/simple;
	bh=ZGKTgC7L/XjurUQ1b2cDuvyj2tiXNKWr4yJpbr2P+eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4vo4BuOXZUn4km9pU9AHogfSusf792Be+NniTSpybyATf1Wbpmv+kyLy2maqyA4Au497CN7R3Y4sgthHpncjK4evY0Gs87MKinx/uHnKnHRKpjfXCfTeqyxzGZitJrkc39AFekdt12tyi6BpXUVKSmwV4UZxuYt9NMw6Oq9fdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CWH+0cXa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CWH+0cXa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gv+Cu1VNu8jkjXHy0G/6SVAtV7Y+ResFYJBAHJAmNpY=; b=CWH+0cXarJAE8EDe2kvQZokE1P
	lUR7LjSxTeauPS7owop6RnGpaxRT0GRJa77DY8i3dCvolLVAu5BTxpDNO8gtiz8L5g6urDYbrbGdF
	pNo4T0FXD9QTvqtHvLze/mAltAl+F3eKSG3SUXunvdm/SqSg0okmHa4Z7kA4lDgdMGGfYWlxM/qVz
	1tHwVoTkBCSsULqflBQNAFOrnDSXcHfXMWsh0eHMxDkza1+7LhE05s91EbX9EjmvlJY+io9xj646K
	FShoH8E7aAkRnwCPbq4EXiPdFc5U/LzR9ksBmckCTGwJmWY3fubz9cLRSeUY1GUv3h9jBN3s26Doz
	FCOEM6yA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRtY-00000003rVJ-3GKW;
	Fri, 23 May 2025 12:53:04 +0000
Date: Fri, 23 May 2025 05:53:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/5] block: another block copy offload
Message-ID: <aDBvsMYTqoRnxa0f@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <2243538c-ca19-4576-af94-ed6e1790c82d@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2243538c-ca19-4576-af94-ed6e1790c82d@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 22, 2025 at 08:52:19AM -0700, Bart Van Assche wrote:
> Before any copy offloading code is merged in the upstream kernel, a plan
> should be presented for how this partial implementation will evolve into
> a generic solution. As Hannes already pointed out, support for
> copying between block devices is missing. SCSI support is missing.
> Device mapper support is missing. What is the plan for evolving this
> patch series into a generic solution? Is it even possible to evolve this
> patch series into a generic solution?

While I agree with some of this, please keep cross-device copies
out of the picture here.  The cross-namepace copies and cross LUN
copies in SCSI are a horrible misfeature that is almost impossible
to implement in an I/O stack.  If someone ever manages to get them
to work they most certainly would have to use a very different
infrastructure outside the block layer.

