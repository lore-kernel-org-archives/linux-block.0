Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4183495E5
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629577; cv=none; b=CWh1IxU1QRqbcle311dKNlMprzibPIwqgItioz2sSiAEDQQcRnpDKfT7Rr0AsMZWi9uVYLeYTfTbg5i6ZZnFInRZNlel3QiCcr79afgNKgWQCgqSqLnshv9I38EftYXVdn9Ap78VXcu9FQ9yjtweMKKgd29ZvOKFIQt+QdJr9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629577; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpDiPwd5D4yd9xokNltd9B8ei9TAeoORG5pFEIaEvvSqL+lRaR5WFNAmrJsxD4DWCb/AbI6wydHsxXLVlN1qaV50P+iw6E/FnEPCevSfNNjG8RwJJ7CuAMltfQMi5OY1rQfpkBq1Oa8pkbMn3utouU8doX1eUtq2V83R9i21G34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SiBFryjP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SiBFryjP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SiBFryjPhhrI+tQAzEF8yhIP8r
	JHGJiX/rQR7RHLJ5wxVmZiacfrlWUQdzYCkdpI4v4xWCv+tW4Z+htHwT9d1eUXHntykFHS6FjV8+R
	QJphAZi4916a4tdqaF8PsqoES4H4zXKOx8Az57WDpt5hGfz7BgkvIGZb4zl2xUE4SC559SXOS5j6d
	IaQQ83428h8y3sI3MdOblazrdm0IQ7ERckI4qBsRyXvXXWMBIcs72uCzxveeJygba9UR+XOv8m9ae
	li2XyuMYbxBWRdDhccQOZrG2U5Ogo+P+OYFs1toDCz/Dr5F/9lM4Bm7BIZX9q7ZPl0qUhXZegL4Tk
	IUgCw4qA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxlva-0000000HDmh-36vI;
	Wed, 04 Mar 2026 13:06:14 +0000
Date: Wed, 4 Mar 2026 05:06:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: axboe@kernel.dk, hch@infradead.org, kch@nvidia.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: use __bio_add_page in bio_copy_kern
Message-ID: <aaguRudEKxWJ5x0O@infradead.org>
References: <20260304025335.225965-1-yangxiuwei@kylinos.cn>
 <20260304045119.396832-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304045119.396832-1-yangxiuwei@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

