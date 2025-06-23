Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4081741
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688219; cv=none; b=P65QABln55HhhyqKMSfSkwS8sZAxjlggJm8ayUSCrpFlnnHEUEc/p9ZGLPJuT+v686w8dr+76ImV9Pe/o9mAdhkUCwajy9iFqtwOfFdk1ORyOnCRdK1eBVjKhD7yKrYHYjS/9/qbsyneklyKa1ndp1E0OIrg9Ftv5JpkrdGeNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688219; c=relaxed/simple;
	bh=I0AfeWQcC3GUaz5pYaA5G5RpqFt1KMHKWG+jONXINCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKio0XINcIiUctmEShhov9TajkeqGmDC2HPXRGjvv3N/N1Pf4v+Kp8vKySb7rkI0XqOkMgWP9GaFvveboXkDCsQ7xhfeR8CoIFR9p91EZgjmN+e0IjgmpP492WB5uNtYdmaK5v+6EcYFzpkvE0vM+y07lsF6SEEccGoe41D0VmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=29egg6Kw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="29egg6Kw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I0AfeWQcC3GUaz5pYaA5G5RpqFt1KMHKWG+jONXINCc=; b=29egg6Kwfpzr/C2PYg0J6pR+W1
	kK10MdTb6mpE/08lQFhLMJMrmjebv0Ffq8hWBUcLVcejG7GBsYlDsEcNteQebYjAKhZ0kH6C2sHOe
	y4uJnyg6eKcAa+f752vWm+xqxDAoPVAQ8pwHlJXUP9p2D3Wa1Ak7KgIXUK6Ezl0xiwOWMp+HZyB1l
	v+U1Z0AOs6NLeuKQvCsZQC0uer0RJwc33RTCpr6cat0tztvOu751x5A3V1c1fVPUKUUA0iRM5TQB0
	JxUHLmPwKaxeqUNLmLA87bzdtIKyKwOQrGWLl4viFsh72BBdft1932VmMBkefiyOnLlATsINUJT+J
	IVNH4o1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThyj-000000030er-3l0F;
	Mon, 23 Jun 2025 14:16:57 +0000
Date: Mon, 23 Jun 2025 07:16:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] block: Add a workaround for the miss wakeup problem
Message-ID: <aFlh2Ya8qWsV5LCB@infradead.org>
References: <20250623111021.64094-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623111021.64094-1-changfengnan@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 23, 2025 at 07:10:21PM +0800, Fengnan Chang wrote:
> Some io hang problems are caused by miss wakeup,

Please fix the missing wakeup instead.

