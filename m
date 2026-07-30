Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247403B8412
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396501; cv=none; b=Siz+Y5KNhA+Sz5Kns1XRbutg0oV+Dcc/bmYXugaYReMLda4ZjXGVNdNySZrjXz7hocjLfpd0E+FCW+av7SjticXhfnO6EsE+RgtK0wjQBH7Qc/JH/dfGciU+p5XwL7kDWCw4YA+bW0uOAeAItER2J6yapFe8M/G8s2U1lyP7l8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396501; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcrl3Vo9dzGLMCKrszyiNKKnsMgIpyIy7+IP3XBsHoXiqRSiRLHpFFt035GJJOkL7Q8PHNJM+CDB+FeoZ+kHgbkolcV8K2q87ZVNJ8ErbhVu75lZ7MWOZPEwhw/QVrFYMHVV4vMTtedBVH4zu6axvAo6w57ncmZGskCHLyQN+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cyk7Ulb5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cyk7Ulb5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=cyk7Ulb5OBe5G0IDcSsqbjnK/p
	H9t1Jd1pXWl4aTem6utnuOeOn9ODVGLxDCq/gAtSC06OGJKJiKCdCW+oVtmF+e+E7X3KF97FKN7PX
	Ic4v3brVyJXtBsCW1/UahsBP/iKl7VRK9RUFvaSIiUUK1pII3esmCQWTIDk+Xw/nH+gRJfk/i2xBC
	Zxj0q0aov/WbT3KomqoBA/bKyiR0BtklkdUPlkHVJp/V0Sjdde6Bo3kZQkKpBvss+VMZMxUlGpb/1
	KAhaVV1vagb1nlfy0BRV12virDjZxV3y0XJLipEMsGYHNWeJsSK1TByD0KZaVP5w2E9oDOTXNN3GH
	iHL6KxYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpLBe-00000009kKC-30o4;
	Thu, 30 Jul 2026 07:28:14 +0000
Date: Thu, 30 Jul 2026 00:28:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] zloop: zero out only the unread tail of short reads
Message-ID: <amr9DuivWrnZNoLC@infradead.org>
References: <20260730072633.1831826-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730072633.1831826-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
