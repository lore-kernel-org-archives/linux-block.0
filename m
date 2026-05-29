Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF81374178;
	Fri, 29 May 2026 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032676; cv=none; b=JtojYJhE5UbaAEUnqvfKa54FeuAYRjaYTRWX6Aj2JfXvGXH/288kZj6J4ONnZWtF0s6DsELLNiyrtJ7irlaMH6g1ErWtm+5y1wsFJYiCdLbMczH90oMXoLoO6VJP8HbTV598+M4RmPHg+1NbelHsEilHHGNoxwv53Ah7DsrEmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032676; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBzDpB2oef0RZNasSr80S61q9ENEWbWH4t1G4F/692ByQvw5EookCdJPf6OKubS24i1qXW+Gy18+vYV12Md9RHtx/xeot++fbSZrpZY38twqrhhvSAZFEYTwsPdhqIqbSD5aXwq9i/npoSAEI+tqaaT9IkA1XgGf/oIzXEwSzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ozbubiXB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozbubiXB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ozbubiXBJPbur4vr+f3GbV/Dd4
	5ktHSdzBO+bwAWD893P6W88nAULCSeZmKMm0bNkmXjMiJPNX9Pa3/UWgcIodfHGX9EUJW0hQKit3F
	UXbNDYpntkfUqdDWve/JctGgxD1Si0QZ93vCHAu8TAAJG/HnDnixlSmX5HOi3x+eXUXI5lT6ck2c2
	WxfnorP/bJjFLQJvxcTRN87mWwwF3m3+KiJTMwTmZBiGDfcqybHRFPcRTgTl5YQCkfIVojdzGdaP2
	cvXEgn0XyMWqOf7nk6UB+am3nRuBY5gTien0i4HomEo8wYzuk7S7AwtnZ9P3T/x/QjcvPXrYYzJlD
	OpDSITBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSpoQ-00000006lVM-0IRZ;
	Fri, 29 May 2026 05:31:14 +0000
Date: Thu, 28 May 2026 22:31:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-mm@kvack.org, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] block: Include bvec.h kernel-doc in the htmldocs
Message-ID: <ahkkomkZJDvwbShO@infradead.org>
References: <20260528175905.1102280-1-willy@infradead.org>
 <20260528175905.1102280-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528175905.1102280-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

