Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA43377A98;
	Mon, 17 Aug 2026 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952716; cv=none; b=BhyAvR0Gvs10eK7A+VLaM2ws6wZUTMu0DJ35feIpGQhJW633Ud9B1/UJN35Aqj99riWYKgx21oDxc0B+uRpHp5T7w6baBuXGGwmbu5hdJF0MlbZR/+s6qpbRGGB5qfeZeqZOXPdNKUQ0buHHT6v1QXm1zmM/JMHxJ2xwiKJFS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952716; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/tE7nb9S8bf+FB0QJAG4rEXIFiIPUVow9JafYsX8NXPKJhbWahSHIMP4lIkqn/tKKzFmDR7IVY6JndBY8vsAAjnsO7duwlrvRRrFj7/eOH+8JnuwYdC9C9AeTgXaSPh7zQFm4Kk2ONZp7obaps7eKVXYM2PCBeH7r3OivKJ5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ImJcJgt/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ImJcJgt/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ImJcJgt/vX0E1MLai2chZOt6ZD
	w/wKZkxvdcCLToQ3z8tcWdmhztx/5qx36+2EpKTQa57tyyRLpxQvjB4bhAmutSkVAuEMm5c5lY28e
	sMI1J2qeFJcFWAOyiUC2j2o2w5MJnvlOCbYgpszneTzatE1FGOdqxMMYnKgKjg7/tJEza/RdEgSkg
	mSZNuDKBmORGMTc6UKvgLMJUmvnZdMuYZgKf2M/ga/XPan2AfBrWWNwpbDq1tEw1ttzTF9LjApxXR
	ie+N8AR4thE9yff/wGVFlwtSg/AG0Od4D0Dhh1BFR4FdNLSJArJ16oFXCS0O1jYztikKLyeP5xvLo
	N5JC8ffg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvs1q-00000005am8-24lg;
	Mon, 17 Aug 2026 07:45:06 +0000
Date: Mon, 17 Aug 2026 00:45:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bryan Boquel <boquelbryan6@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq-dma: fix kernel-doc for integrity DMA
 iterators
Message-ID: <aoK8AqGMaXq2jCFt@infradead.org>
References: <20260816131456.16374-1-boquelbryan6@gmail.com>
 <20260816131456.16374-2-boquelbryan6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816131456.16374-2-boquelbryan6@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

