Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278060;
	b=w0yb93e1cVSbj6KGe2W2pouWwic/HvwaFl8iPcPhovCDWKoDjjenE4DViWjc+5CHceNi
	 fDb3jCTe3/7YgElFLfryYdfEKRqXxmhuti7dRfzzDvW0BfgXFKjzKC/9c+9GhgyOOtDlh
	 J4F0eQByGxqWi2XvIYYC9KVxZde8a8OpTSdpSF90H5jwGNayAx/em2NUkbhAl+FrPq5Cp
	 edwMBV7ya0//3bBu/VKv0m/uLie38jBCdP1t6zSra5rJ5MuI+lTIkl+ULvaqGs4R7lWID
	 C3e1UJZo3k67dCayFxFuKIMP84Qw+BuFSyLukqeEEx+jZe/whRr/h4OzNUuPdgDortQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278060;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=n873N3jOQ/ijqDwcggIfhLks4CRrOjO0vBZwY1lWARw=;
	b=HE6thZiSugyqgVDWVmz0aDq5wo9oufKyxYyB12Pgm/wrZBK1kQG9XF2jPE8ZCocmyrN/
	 G7aOT1bxvbYHhJLvb2NkHlBHqkCKdJwxPlA/gtATByQSjTlqF+1kzQnLRjvaq30d48t+9
	 kOio4MnIDAhLqJOSKLv4hWm72UAo6S7VVtc6HCzxePXG1u5QmSsgXeU1Y4Wt9uOg+lGIu
	 O/fLzx/+NgE9CXZ5li8Emavjun4+0K0HQPg6bad67C2TS9S+kOpnNIOp7WNRiY6KO9o+X
	 HARL9e2Y7trZ8GtvI9K85zMVy6w1QvQ/9/dE+0sHtGL6uDNQ1L+ZFUStvY6t88AVdiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dwBdxlgr;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8B606A320
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C8B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dwBdxlgr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n873N3jOQ/ijqDwcggIfhLks4CRrOjO0vBZwY1lWARw=; b=dwBdxlgrsbkHvwbzTGpb4RaFOd
	vdXA+E/Zdxk6FzOaQria4Ix7U5tazYSd/eoNkeIOzK0CVACLnGOOWfbH4xUgVyDFVzh3A5VpGf9Ay
	3Q+B2oSl9EydtjYdI3VFpUZbP1xg0fQ/4mQqpEmVtaO0ozCAKrP9KBUTt4DyQxiCDYD5iYB8Hpdi+
	CCKzydPCaZNegiEPh/JG+GBNjoe6On0dRSaIFOoXWWZsTwjfdkrwVNpKnHvB5fnIAe2hKlZK4WLb/
	Y0n0nYQ59BY0bg37Uk3uJNFkhUsbRbSH0ADmihwDbSAlGFQp+/aIC8LXBLs7cFYGeT4KkQ3NDWuHx
	TFOLQggw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPXe-00000009Erj-3sEd;
	Thu, 29 Oct 2026 12:47:38 +0000
Date: Thu, 29 Oct 2026 05:47:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 08/98] block: keep the zone write plug of a failed write
Message-ID: <auNAalM7gc65l3aK@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-9-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-9-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:11AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When a write fails, blk_zone_write_plug_bio_endio() sets
> BLK_ZONE_WPLUG_NEED_WP_UPDATE as the write pointer offset is now wrong.
> disk_zone_wplug_unplug_bio() doesn't look at that flag, so a failed
> write that would have filled the zone makes it look full, the plug is
> freed and "full" is written to zones_cond[] for a partially written
> zone. Reports then show it as full and zone append emulation fails with
> unaligned writes, even after the zone report an error requires.

I can't parse the second half of the last sentence.  Can you explain
what is is supposed to mean?

Otherwise the change looks sensible.

