Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAB2C3266;
	Fri, 14 Aug 2026 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689770; cv=none; b=VXz2rTUrvooaXL0jJ3Q784y6XDRPjYrijXZHczu2+UgjI731i4E/WJJaoHi3nVBjtdEcsxBG8di5WFR9vyQjXLoRFAHl5QxskzWqBMN15dl2cuTL2YsJaE+0PDkcLX24sgnwr2JwU7+0dUOQ7hk/X4ZOj/14X0NXY5cfpw4La/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689770; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0BMod0oL0osXWECe4fwIu5cvOy8yJpoRJa1ytgTjqSYDtpet+FAYRLZRMRPN1v8TvX/jBCo5TA/qBDjd/GIsaX37wPS2zAbdlyqxwuk4FPPv0VD8FY33lIc2jNmUP/MD/xqp4QLfy9kgOKSjmrHU53gtiuC1L+um87PpEmfucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UMoHrzjR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UMoHrzjR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=UMoHrzjRKU0qjwIJJaVSYwVuIA
	/q4BtYIuUEHvBDvwPKgK5DFaP4CMshWGZ5bx72W615VNWGoxhdXpqnAa8+pq9VyepNnTIUDfrhWY4
	WGVJH7Bf6VBLSGDrydJ9PvvLKtPBSMwz9bRVHeoto4o2XVO2Ah11RU3kAp3dr5EO1OhuSmFxsIDk6
	dosfNOj3KyohPE5sVcpvhBWIhJWdfCBxWe6OUCZSgJzkGNVdJMer0a/E+GjGPeqzZebki8lnc6D5e
	bGctDqFpDdwDfyzPUPb2orMGBa2zsO2RggPIX4VVH5JAV0kBd5xzxClzvT/TXBxS24JqHn1OboPTe
	DU0vNMQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulcu-000000023JS-2FOe;
	Fri, 14 Aug 2026 06:42:48 +0000
Date: Thu, 13 Aug 2026 23:42:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swim3: Add missing MODULE_DESCRIPTION
Message-ID: <an646OIrDnne3-2t@infradead.org>
References: <20260811-swim3-module-description-v1-1-28398c5a0e32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-swim3-module-description-v1-1-28398c5a0e32@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

