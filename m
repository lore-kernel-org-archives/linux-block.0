Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DD2DC35C
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175663; cv=none; b=ArqgwZKTmd9B2ucKdBETeYJTVrZfvTFEvqP9EdxhrdGnNLgJ/68xsemN7sr6uHRxuLvRKOBimAZgtbpCzjsl/uHRMvsbfpt3QTNGF+7UEUEGD4B4lA6AdFydsxONrJRYjDFP7zMYNUICRBm1l331SFiJU6kUlM1icFQpcBaAvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175663; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSPHO4Q3sVuX7J1w0BvCOmuU83NjfPU3JQLjPt0B0XoWSXbsEiAc1BK7iGdVMOiYoKmu0L8y5r/ot8iqFfKbbjjYbIB3RHfTkWXkUAq8nBkz8POewj1ZFgST1YTfX6TUlZ9oE+Nwyvh61aK/6Blt9Gow1OvwfFwC8sgRekToDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uRJk9cLw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uRJk9cLw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uRJk9cLwlUQHTugf4Eh/506McJ
	Tgk1ungvLPahxM5eANznnRi/4UlXRyGtBnJg9Uurdo8ykPbp4Fo2gmKl8GEAHjkbZjfXXNhEntVNw
	QvR6pGQKcXPmy43biC/ufwNU0aFPA8/nffv6lAaYN8HKnGxDN/zN78IwhuEtPAqjPeerkRpvGq9T/
	wjj1cXKCkJUN83zeQzPrkyxtcobYV1ijCOibpZ81zYs00MxHQLiQ8sIMpUJ32n1zTrWxA6AAKbg6i
	KRJCCMaNJD66/pBSeykCRHzGWBCuIK/kXRE7Wk2yLfCshYYiEW+WQjOdMnGBTBivzBsMxdumntymt
	05MS3HuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue94m-00000001xxY-0zSF;
	Tue, 22 Jul 2025 09:14:20 +0000
Date: Tue, 22 Jul 2025 02:14:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH v2] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
Message-ID: <aH9WbG-N3YfyB0xE@infradead.org>
References: <CGME20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e@epcas5p4.samsung.com>
 <20250722091303.80564-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722091303.80564-1-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

