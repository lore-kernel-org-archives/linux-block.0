Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772C33CEB7
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751730; cv=none; b=OLdpjNPBE6twTp351O8UzU+hFBoN5Xw9qY1h9SpI/60KioZIUiBzWubZg7Ye5v+Mv55rGWKtphYK6H4FHZHRmRGFQGWPTPlvK6pZIBELbbOGiW1vuk+fgEB5GC2O4UxRxsCqJYaHFyfWYC1rF7S3Inp4dSAtfeISKpxSmwHN5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751730; c=relaxed/simple;
	bh=ktXetS+XCd1UIcVbGPI+qQ57QQTh7QPDre810STOVuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7bq4ZgZmglQAlU1VIjjruGYrK4tjKMNL9HidRQh/mIM00AOmI8TYfdRcNY0qhZKB3ieUy2Yt+MMsGEoQM++6DDBdZ7W/l0oTo9S1vEWRKzG8L0XXR1d3YsGSNwwbT7R5yHbkDoW6pz2ZtaIjNn/eYBcYtE434f6CGOy2xUZVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xaBPtiiP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xaBPtiiP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktXetS+XCd1UIcVbGPI+qQ57QQTh7QPDre810STOVuY=; b=xaBPtiiPVkoZxH/XDTJx0vDmq5
	ExIkaf4j8Ay5nJjjT4Zayo5cpJ7PLlB9lIA5ENITTJal0xB3A9+JTDwFwiJUyClazk5xNQbqYr9J+
	aDvhsq0WHnc9Vo5d/lG1xzhokC7RGUzhLma2iYRW5fxILas/9nQ7l/U8YJ3DN+11gjT2Wn/gcFBjb
	T0qlK8xIyyDzQiPCn2m0ycRb18EkWNa8pJ3fl4ojz4yr0SHpWXhZ2WFk+0SjcqsZw/gcSxcKoklM9
	5LV8sDfrqTLKiqXGGa/ONzKwdCP9OcA0qyzd2MNb+XDZRwyyMDB69tPkfcz4RWM+iU8MNUCQCRdH1
	/TWouEVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlhGi-000000013wC-0z5t;
	Fri, 30 Jan 2026 05:42:08 +0000
Date: Thu, 29 Jan 2026 21:42:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: introduce blk_queue_rot()
Message-ID: <aXxEsA_HMLxLORZV@infradead.org>
References: <20260129072715.1107336-1-dlemoal@kernel.org>
 <20260129072715.1107336-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129072715.1107336-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 29, 2026 at 04:27:15PM +0900, Damien Le Moal wrote:
> To check if a request queue is for a rotational device, a double
> negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
> this with the introduction of the helper blk_queue_rot() which tests
> if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
> All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
> and blk_queue_nonrot() definition removed.

Looks good, and I should have done that soon after inverting the
underlying flag:

Reviewed-by: Christoph Hellwig <hch@lst.de>

We should also do the same with bdev_nonrot, maybe staged because
of a lot of callers outside the block code.

