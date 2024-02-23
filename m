Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5484A4B
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705169; cv=none; b=cmUxjGP8M6Avg8oLxIu26cRPzFhovCmA5Jrn0LM93IBy4goywUedMX3Kzn7xXUHoO+JLU52ETYXwE08pKST7pzrzg7ypFdan7FQ3sx5meoDttx98lMQ9K18i16WcD8EMDRgaFsmDbb8SLhhcDnTi9KWjobwhD9kez/qlGzVtPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705169; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnDT2qUg1O1yWVRvNsTb/j0GC+n3/WPyI0jo8/WIwN60AQe9KHWwiIHIlaBinchF62j6zWSWU1h8kVkJwTF0P9cB/Po2P34Xs+hDwLblm3vhjseogZF4JN3WsxEAlzF+BfxfqrQDBYWB3szPJe+n423G8wWFNfdVRoDJ1geLvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X/Y9tfCt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/Y9tfCt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=X/Y9tfCt1kgwe6iLQc4PG0UptY
	0NV06OIrKMjPiCD2lxBQ1GpFAVKw00WylGHE+S3+KLF7EPBR6dIPV4+aJa1wCgUf/w+R0gnJqUXu9
	/+bTreJK9l0AF/9DXR5Bkh3krG421Srm5O/Kf3boU8p0d3PeY1lU+mWxsq/Oqeo6yJcfTjppB9Ioz
	luTNqAhA0lglTsYOF84O9hQJRNdtZKhii2VsTDsVywh7S9czAHejIoX1vfsSP8pvZlKaDmLLT/gNc
	3xRaIrLb8Wjwph0ssQyc4o2W3OAmcMJNlK3QQ58BBa1zMA1H08OD0bab0beyp1xQji7PftrTF7udl
	RWFDMHsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdYGZ-0000000ACNg-1tYe;
	Fri, 23 Feb 2024 16:19:16 +0000
Date: Fri, 23 Feb 2024 08:19:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, ming.lei@redhat.com,
	nilay@linux.ibm.com, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 2/4] block: cleanup __blkdev_issue_write_zeroes
Message-ID: <ZdjFgwi1xsK6Svnf@infradead.org>
References: <20240223155910.3622666-1-kbusch@meta.com>
 <20240223155910.3622666-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223155910.3622666-3-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
