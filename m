Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7611EF08E
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435434; cv=none; b=hCcCxetRzDa7W0UnFuyGTJe9jH+0UG7zd66/wz1C4Rv2+kxi8QYlwvlvxSDxpty03lGXaSl+KHQe06gSGpxTmyWzxSL39A1I62jUAPznR+9lCUdzXVjcU7hRPRIJK19bgn1k/zCnQCHAac39i7b8PSVzZztqxyUzuOOb/sV/x2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435434; c=relaxed/simple;
	bh=H2UyLYvyCbfZIOg2h4fXD/rDZOyGP8KqkE3tHlITIFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKySNOJipabIY2DvysZVM3JRuEqT5+W+F2ZfuPHr0/TQzK4vHpULDwPE4scIFXI41nCFCiWEvkrKOl83Q9q7oNs3nZ/BB1p3FFZbRZxJe62Y012l21gdhlr7e5MpWRDYsHSnY1psRFH/9HVwwGKAHIW2LyI2/i42GioHmZ6Pp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IpfPVuz2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IpfPVuz2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OGVcJ+/olKhJu88boi4fUoxdocDbGO3hcLbcb/om2m4=; b=IpfPVuz2DV1OxtyZVa1rd8xVAU
	8OVP1FUfyxbLBw3qjjcE3R/81FZIRevlwLYc1qHlVU1+wIoj3JpGVyQSQsCMq5qelRLTxXbXDcPzE
	OknseX2PGsk137gA17DDq+NK1+4ZJBCzPTB4o6yHIR/fNYxHE3NasOV2o24MMCYUrnR+L8VK4eeiV
	VvljsblVcQ+hPdzA/BFwNWOYOGmTrZI2pLWQf5zrWJmObQ8u/Ukcz4k6De3IaIR3tOlhccCtWZ8H6
	hAVxK9fQhArnWALrCnoKXt1BoDFD3HnZxJoHWY0jCv/z+4MinnWIFueZsumzXLDJKlyBYR9UfzlQk
	+ftc9uBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiUc9-0000000AHVD-4AsO;
	Thu, 13 Feb 2025 08:30:30 +0000
Date: Thu, 13 Feb 2025 00:30:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z62tpanLQgFK8j0i@infradead.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <Z6peww6d3EP5-B8n@bombadil.infradead.org>
 <Z6qxnAEMeTVW-wK-@fedora>
 <t2o3dadb744eyzy7v6jta3gdjgscpttf4s3abqm2mndk5mvwjl@hbvl7vzv6foj>
 <Z62nJqXu_et99D02@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z62nJqXu_et99D02@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 13, 2025 at 04:02:46PM +0800, Ming Lei wrote:
> The problem[1] is that this kind of mmc card fails to be recognized as
> block disk. Block layer io split code can handle this case actually.

When we still had bio_add_pc_page it would break the assumption that
you could always add a full page.  With that gone and everything going
through the split machinery we might be fine now, but backporting it
to 6.13 and earlier will cause breakage.

