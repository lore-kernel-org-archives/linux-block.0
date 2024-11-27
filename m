Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327CE145FE4
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688508; cv=none; b=Rr2pDWsck4S9G1fRjn4bdVIhACmyGDfhFjdNHIWOoC0JpT/aMj3d+F2bH9pDKfrbVggozQ9S7jG4QTZJoL6aGmrOHrrbQvGCM801jX0LSnLBPzcFWl4wljdwO6W6nubmBaEimwleP0B7iKeS4JvsFVFkuyxdsbmTArfKCKqV2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688508; c=relaxed/simple;
	bh=qwvFJvzUm46CclAP1i7/YGoRnQMrlajM2M6zRYl/eRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY1wkjsipfajfMwoRU3lAa36I2GWmydZIpaKt8fBfaVOcmKMVB1JWf/IT3r4cf+4zGJfp75hLiH9uYwvntChwifon4mn+I8yTkN4oo52IsoZ3bHlb2/hpMTE6VFftX8opaLgWzyFYhzbKUJ12FcgOdKPBfs+e0tXh57bzqggNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NMjaZu2/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NMjaZu2/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gS1ZgyqgW/Wgkz8S1a6B7BY+UNLEbiaij9gai5Xe2eY=; b=NMjaZu2/Mzwch53KhSW0cJ+tUx
	OBe4mV+gtI+Y1hsPrZBx3DtjShSuBfPmzSaU/EtdSYxEwR1DobeYSvRq2FZEqV/Ci2VgabcbUjpOM
	UP2zE+JXl7Q3zCXcutDqQffUK1uDPmpWhfFUuDRjcB9onDkcgAJDP60pRXOcLwIBvBRAhpbjvgTWc
	97EUb4NweIn0WnnqOyjkXL9BHJ8deKVGoXv/Xsk6aO2ireV0iIY1JlCzTSnuZDm8/dAREDfEcJJ8G
	WO0x/K9k3scAeLai3SFmcnfTisRev+bXeg9UjWNrdBDfcE4JGLH6ReQ+DsusSlF6xL4PJjUWLDrvg
	Jlxyre1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGBQo-0000000CK1S-2sxq;
	Wed, 27 Nov 2024 06:21:46 +0000
Date: Tue, 26 Nov 2024 22:21:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0a6ehUQ0tqPPsfn@infradead.org>
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0a5Mjqhrvw6DxyM@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 26, 2024 at 10:16:18PM -0800, Christoph Hellwig wrote:
> Did you trace where the bio_wouldblock_error is coming from?  Probably
> a failing request allocation?  Can we call the guts of blk_zone_plug_bio
> after allocating the request to avoid this?

The easier option might be to simply to "unprepare" the bio
(i.e. undo the append op rewrite and sector adjustment), decrement
wp_offset and retun.  Given that no one else could issue I/O
while we were trying to allocate the bio this should work just fine.

