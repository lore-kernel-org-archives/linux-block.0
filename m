Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126431D9663;
	Mon,  6 Jan 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152579; cv=none; b=a4hms7RFs4RFWZuvgo0o/R5DrcR6vcWQZ5kdr2N1bkjAfz8uQf79VZwEjmhnaDP/CUlkPVMqNRSjEamAbVqgItHQwz3EcwA2IfxE1bVrrSw9wItiyon1JfIxEJuywzgtYw5XRySstCFEDjm3s0cAJ628Qf0bn4+S5lUN8kWwUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152579; c=relaxed/simple;
	bh=T+O9Cad4+PgDFhjzsagdxW623ZFI2LJgn1bO9HihC8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxJlMfjIdFqTXtxGlXsWIJgbz0kF3tfae1g4aDPVUBaEXNnMCgPGHX5Dr/7dt+lfhdgMn+z3rYPzVZhM9Mnm9GrsV2KhtNTb8tj4nQYnGj1l4dSWA9+FpgyNW5JBg0oLVb4DivxZpBT+RAoTYnb72UW17OyxWnj4KSpwyh2sKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CX7BaA2+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CX7BaA2+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T+O9Cad4+PgDFhjzsagdxW623ZFI2LJgn1bO9HihC8g=; b=CX7BaA2+gJkGAXLN3Dd2sZ+pCR
	qGCXRj/hbfSOMmMzaFWVUo9huShafteZcPCkIrhjUj0jrSo9Njivc4UqLqh4gGobgfSbsKPYFqOae
	6yQzbnBLULhnZQESYwiBIlkWhX/HF8jL0/0tw+znLmAeBKInpUNDLAf0O2e4FpzgYYQ0jdpXid/b6
	+twOrY1ggNrHg7+c17dbdlI0yspN4Ga2MFhekxh0EEG3Z4TAZwhPqeLNUyNK1rxbV5bFdZUzYkEVF
	MAgF3L56cNtrVfCF/4CmuEjfxs/5CDYuD++WvCMu9VXwimQjV5/lu03DYuP/wicFvFGjsbwPaph1F
	X/USsOFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiau-00000000XQn-3nmu;
	Mon, 06 Jan 2025 08:36:16 +0000
Date: Mon, 6 Jan 2025 00:36:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	nbd@other.debian.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] nbd: don't allow reconnect after disconnect
Message-ID: <Z3uWAGWV_kpBZ3Pn@infradead.org>
References: <20250103092859.3574648-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103092859.3574648-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you wire up the reproduce to blktests?

