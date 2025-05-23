Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F431FDD
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004419; cv=none; b=AWXKChzcWnbHDPgnaB01OlgRcbZOga00lMmH18/I1ku1DH+8zMPkO4bHeVFpY32XHY15DrFR1mY90ktdiIxlawAB3GD+yTSwSiR5b9oVAAPCLlEPEdZ6b/80TVdvg0U49aRoJ6YuKrTIaT93b77mPQS7X9QEr2M7L6rEHna/eYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004419; c=relaxed/simple;
	bh=XSMTqmzHBfEe/utDPYMSQ/LsI5rw989hcAQSKxmHPKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh6p+gPZLWeHR6MdAgbnkHmu3Cuy+m4EsTYc2JD/YvWenLD87KIRuXBeYfnk1b7QbpyGRskCkCPVT9/uHGc7PLhadXuY4CriEPefwMODm1QMV3P5GErzmblDfU10Zibw0iSrEUNUdQ8KEBBuyKY6HQ0n2c78V0U3gzZFSP1FBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bc+8bFBH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bc+8bFBH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h1KpPzL1dWxSEeKlxImuzJ8AVw4Y8yO1E36HDTirAaI=; b=bc+8bFBHmVYGldys0wYK6MUEmD
	jvYLe00Uy3mpmCBJF8UFELZ5sFhW23PKa4FaQWjrIWqJmLaxHOPY7uZGGbBC+PJRr2BC98yVRTFNK
	K4vyt9H1UgWeXUxpT0rY3xpeipAASz0+wyfSEWEO1MuPy8z1zSC77s/p2q2ze4ecqvYL38R83LFNG
	kHlG7FRMFrdbwPHwwAqXJ8LflABSAGx8l1A3tXyZ1d+tAKBLjrPMrDtM0JAY2Dtju363W4h1RNboX
	ywcix5hms4D++xuu0SCuJ74nJ3CyoiQKaJDBOLDZALfkCh5Ky3KCi9ZqBWXgr409Y9zwE88e98RlD
	LCmljSZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRnd-00000003qds-49uF;
	Fri, 23 May 2025 12:46:58 +0000
Date: Fri, 23 May 2025 05:46:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDBuQbsBRVjOc5wU@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-3-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 21, 2025 at 03:31:04PM -0700, Keith Busch wrote:
>  struct bio_vec {
> -	struct page	*bv_page;
> -	unsigned int	bv_len;
> -	unsigned int	bv_offset;
> +	union {
> +		struct {
> +			struct page	*bv_page;
> +			unsigned int	bv_len;
> +			unsigned int	bv_offset;
> +		};
> +		struct {
> +			sector_t	bv_sector;
> +			sector_t	bv_sectors;
> +		};
> +	};

Urrgg.  Please don't overload the bio_vec. We've been working hard to
generalize it and share the data structures with more users in the
block layer.  If having a bio for each source range is too much overhead
for your user case (but I'd like to numbers for that), we'll need to
find a way to do that without overloading the actual bio_vec structure.

