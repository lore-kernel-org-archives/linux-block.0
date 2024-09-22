Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1A29A2
	for <linux-block@vger.kernel.org>; Sun, 22 Sep 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727015573; cv=none; b=gOUZg7ckojM3XpNkqJzysnm04goaZY+bW0Ulml/2jaBEWpOVl9f1Sw5YcufRpOuQp/asQ3DSMUSSE9EJNPsw+oZ64u4Kaye2tVW++gCFX1F1/ZyeMWxunjRa2UHhpVK8Fg9MFFJinLceZlfThfIPzqlwsWU4YJZ2YnlaOhZyZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727015573; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmbvOC3wwrNb1DTM8yYFGNGipsPCIRPZOtWTpt4C3feHOFX52G6gKOCxPlttDqgb0FKRcxNa1ZM+lh7HA5PtuZcmh6MFt/d9rWfYO5vzjkW+vNam+Z6vbvT9T/n6ipmweq8LUmiXOqYIrLwBPcLwR0Lv7YVWOFR9Fqlvkc6jLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4nuSC99z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4nuSC99z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4nuSC99zmjcr9owSUurHo8xLMz
	txjfy938ZPW5Hmq1K7G/2WZujsAUSwdNlTg99m4Lua6eaqNWuo7YXO51kY+53KhZS63yf33Nb4RIp
	nt6uYFScJdo0t0gSXLHpLJhONucmmWoj9RYTH56d0rK2xw58qy5PEApUfAg7Q3XRHaQ8GvgiGDfL6
	FKCnaFQ7RpnACBUQGuixCJOLVGSr2Y6mFDGTS/AKz7Lf7ov2V1VB+svWHov2EFrvxdYb9DqxY65t3
	6ZFRAJPOP7zZPGF6BKQ8rkUnZhSs/Dgjg3sFiB/bRpOczy4CMihrFLPNeJybrrLx/Qx+T5fJ9/9H1
	NGV+e06Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssNdr-0000000FGfT-25Sv;
	Sun, 22 Sep 2024 14:32:51 +0000
Date: Sun, 22 Sep 2024 07:32:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: fix blk_rq_map_integrity_sg kernel-doc
Message-ID: <ZvAqk3Kpoo2ufwiF@infradead.org>
References: <20240922141800.3622319-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922141800.3622319-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
