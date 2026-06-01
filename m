Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA32571A9;
	Mon,  1 Jun 2026 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299633; cv=none; b=Rpc4Wezv+ssGB222VaakcbQEtA1glykO/QoYMpP/2La15r6Lr/KjS1BKu8JqAAWJnQr1Bc2iqfHdQwc0IxrXKbddQsARdmDhejs7FUUrNlDyL0JaRDqlq53l0haJM+ojjQkIGllWWY+P6UnTZO5443IcgXDu6QTnkp1M1UZ4PLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299633; c=relaxed/simple;
	bh=2NUqkBKZIBEKtFYQlbYXZN+cP7Ty1k3uBLuFOSJPDA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uywVSj3AuGRRYkmNbwg1edEr6hl/RRicRGqJ8iJXWXvXOU1dVgHRRyhMBfi8f2jDut7XPQ01EX8Mk7C9M7BzQgXO9te83Mh6XlZR0KuCAwZonqRi8AaA5Lnuw20N8lnlO2Py/JfQNMO+2BzYWqq0KUwqqmfbO88PqHKhqyx2ySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w0S6i0cK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w0S6i0cK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A0l/Hg1rHu8fG9AHg8MT1/3S4lKlU9QwR9ILMyHqGmM=; b=w0S6i0cKh05uSwKsHugqkYzncw
	EEhZqh9V2mwOar6uyyyFKDsizm5N+iaCy891zmaUCHaFXrlBniM9sgccXDIpPtYYLa4H4Pion3Uub
	DG/Zfcar9pHt66vrFM2z9DYs1veJ2QaTN/VPssRc4l1dxC9rcz3nzXRegiOvg5wyuO8OA/uS4EOCf
	+0FVJL6YyQS69VqCpnWQGcyjfMsbWVQKuezDIVuzzsNFY5AagdoAapGPk5cLCivKyeT7eZMPnGseB
	6aSgsmfL/ehWhA8ugupWRB2FSStWpZHA6iwkQB1MYMOA/nhXZCDZI287e2kFLKGW3wOeEO3KqslC0
	cKDzVkOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTxG9-0000000AJX4-1kcX;
	Mon, 01 Jun 2026 07:40:29 +0000
Date: Mon, 1 Jun 2026 00:40:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: samin_c@outlook.com
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>,
	Ruimin Sun <rsun@fiu.edu>
Subject: Re: [PATCH RFC] blk-integrity: fix slab-out-of-bounds in
 t10_pi_verify on namespace revalidation
Message-ID: <ah03bXpgFLQjOUt8@infradead.org>
References: <20260531-blk-integrity-fix-v1-1-cc7084f42cf1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-blk-integrity-fix-v1-1-cc7084f42cf1@outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, May 31, 2026 at 06:45:07PM -0400, Samin Y. Chowdhury via B4 Relay wrote:
> When a namespace is revalidated between bio_integrity_prep() and
> bio_integrity_verify_fn(), the integrity profile's metadata_size may
> change under the in-flight bio. bio_integrity_verify_fn() re-reads the
> live blk_integrity via blk_get_integrity(), so blk_integrity_iterate()
> uses the new metadata_size as the per-interval step size against a
> buffer sized for the old one, advancing iter->prot_buf past the end of
> the allocation.

I don't think changing fundamental device properies such as the LBA
or integrity tag size under a live device is a good model.  So instead
of coming up with bandaids like this, we should probably just fail
any such revalidation when there are openers instead of trying to deal
with the fallout.

