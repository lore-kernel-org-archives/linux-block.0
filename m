Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580F36D4F1
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751632; cv=none; b=FtioYgmSM4LdX3izNqYQZDZL35v3PXYGd2Inl2O4tZi4Jza+bxoNsFGFqQvc52CO2qSPA7sbzipJycA9aQudPY0MHYvs0ZKGBWt3s88OkI1VnLFEvv0WoeegRYeJ1E52Dgs+NHSOeVGg6YqwqdAJ6xtRpoj6hbHHlUvVmPygtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751632; c=relaxed/simple;
	bh=rrkSzZXkm0pyxTbiRY/pOcfu+MnOuk9KPHUn42ZW8Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgeGzt66FFn+D9hcmh58SuOJWmw79FF1rVkxtfgnb5bxercwYUq4xbzhqxyCZOk8HfmOFf/9HbEujcz6HZn2MOdpwVGGDMvbBHMamK8CG4qPzxtOzejKXyPSljjdZttVG2+ni0Qd/JFV0fDzFxV3YNVy6Yjfdl5QBm+876R1HyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2nGiWQOH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2nGiWQOH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rrkSzZXkm0pyxTbiRY/pOcfu+MnOuk9KPHUn42ZW8Hs=; b=2nGiWQOHncsXBOa5UMEX5zJjXW
	H/HuWVaT27NfxhYx/r4T51g4x3VQjphLzmqjy4Ga5DuFH+TWdQJMlQcdYCjGXoz6W3StLhn49VpBL
	DCFcWtYRYIR5VQ2WhghcDhFp9fZhyGoo69AwbljS50vkR753lebMIBEuUiRIi4F79MqogDi61IL4l
	5OkzteazSpN+Ghvso0o/9ZAUGISsV6UL1q6Pd9IY0qEx/2YvtlWEKTJFiNzZk0JiBFYFgcM7oDMvA
	M0lHw8SzQ0qLCEbJl20TJTHP3tb0qA4wZfR4sIeZpEHoO8gu2OzZnGN/YZg0H7itkxYRWrwTr7uij
	PArpUEHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlhF8-000000013rJ-44gt;
	Fri, 30 Jan 2026 05:40:30 +0000
Date: Thu, 29 Jan 2026 21:40:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: cleanup queue limit features definition
Message-ID: <aXxETgRfDqXqL6xs@infradead.org>
References: <20260129072715.1107336-1-dlemoal@kernel.org>
 <20260129072715.1107336-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129072715.1107336-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 29, 2026 at 04:27:14PM +0900, Damien Le Moal wrote:
> Unwrap the definition of BLK_FEAT_ATOMIC_WRITES and
> renumber this feature to be sequential with BLK_FEAT_SKIP_TAGSET_QUIESCE.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

