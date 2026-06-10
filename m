Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BF257452
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068695; cv=none; b=L7enOPaqFCYDHusywP/Efl+aMXsXTnxEeBIvpQMAULUWdjjzZ6f0bP9hlMMS1ogdXMg+KYpcaVjyk/HQqbDaHwO4s4A0gm6PjpAOBaKUSM1zvr71LRVqf2CNwVFe93s256ZvN17iPeSEvfLui5ZcNNXquhZVsUafVBwdkzhnBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068695; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH/IF6bu/HojglSOVPPAnK3Rcsdk4/ytEfvOHmvexhElMlEsBv5S2xSvER1vSAXCJeBRqQ3PSMdddxfoDuKEainVbGCgFu90VGt3wOon8jZAhRuxYV1UEpBMmL0orxvVH3ZriYEUqHoKCYD7H6ghFlK3KvIIvLTQlOldS/d/XLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oP2bPE/L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oP2bPE/L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oP2bPE/LOwV8EKKQHVUMlmfgT+
	mYNSutHu0Fhl/jre3TY7egMsVRV8KjU97udh80hNd15gYF1UOTSuot9yrnhMvbkPwZt5L9e/do9O2
	hFgxupHEMxYSvj1/QJIKkA76h75R4IGB8hwggZ0JuKq7NIPaKmrvpPo9p5ZLsgRdKxs/7drgSwZy6
	8PbOzLsR79YXVXLhuB7hjtkE7vZg+fR08JTBs2tJDys4SeNlIxiXTsxez1/rZYj7n/SjWYsf93Ufg
	9GNxlEqlstVLnuefHmZ0GNT2A0iXQo0IyqKKn4/erpsHc1OVvD5ZSl7TSx+oC1g4AbXMJLPyd57X6
	JWtTA1qA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBKP-00000006ojA-3vN7;
	Wed, 10 Jun 2026 05:18:13 +0000
Date: Tue, 9 Jun 2026 22:18:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 03/27] drbd: Retain one _get_ldev_if_state()
 implementation
Message-ID: <aijzlU6tOArJ-bjx@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <3777c00c7a6e8bf807ac9133cc9b89540c19bac1.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3777c00c7a6e8bf807ac9133cc9b89540c19bac1.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

