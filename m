Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43476AB8
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915774; cv=none; b=EqVs2YT+hPJm7rWadOaTg5AlBM+z6V4/OmAq8qdTtjLCMWz/6ycmaoDRiRctijijSDBswjuGSwYOlimSVx4XJ1x91p+vwem7Hv4A+yeXxxjTS04iKTs9mR/F8XsKBbHwUyc4upwoHYpeX5NefjmpE1yW3sDQj4UtSH/j4ZYp8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915774; c=relaxed/simple;
	bh=wMrdorjr1Q8nyYGSuYLc5ze13EJ9sdiO4DDYiUK9s8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIGbsuiQzX+fUnlQ/S/fCTmtyB2j1pC2lGQIOEs9AxSSKtX2mMiBcG/4+C912Bm3dseEoFxX82fxMCyhwHJ0AW3MzbsfZmOzNn+XPzEGKcuai2e/rKh3UvfxqYDEjHor8H6u7RpLet2yymsN5+wn5dIGsxy3zFmhzGZnNdwXzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AL2DNb6x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AL2DNb6x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VV0/FP6vB4wY53ba8SCzegOfGrOzdE8J0p2BTAzIeDw=; b=AL2DNb6xDzmOldXR4beVacHuPi
	6Kdt8tqCL5wx583Zk1l51WcRmP+SpdrtDsJ2ucbYRYUBmEar1OVWwdgbxzBtCIqDIaDZXr2popE0H
	cFHs4A9aCjn3yR2OQyrKXNUCXhlxZUkO3KCu13qju6xJ4JuB3WljEQvFK1hu5mlKXfmD6eqXeF+U8
	Fb78ocvWxiA7T5FA5Q0xuZAr+VICvA+78S7LvGjVRjBbJEKCm4G4wn+eghzQuzeBUlStV/XRTHTBX
	0VcDnM03WoLQYZ7csPjnkxKOPKO+yR3Pnnbzk25N/R6o7s9bdAwWXdWgzBxPA0Z3ySuLWRm8Wd0Bj
	sdfRV5Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snlX6-0000000HTg3-2Kuj;
	Mon, 09 Sep 2024 21:02:48 +0000
Date: Mon, 9 Sep 2024 22:02:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v9 1/4] block: Added folio-ized version of
 bio_add_hw_page()
Message-ID: <Zt9iePAZs57s1H7m@casper.infradead.org>
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
 <CGME20240830080048epcas5p24013512a19c099ed51930f4ab0736ff0@epcas5p2.samsung.com>
 <20240830075257.186834-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830075257.186834-2-kundan.kumar@samsung.com>

On Fri, Aug 30, 2024 at 01:22:54PM +0530, Kundan Kumar wrote:
> Added new bio_add_hw_folio() function as a wrapper around
> bio_add_hw_page(). This is a prep patch.
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
