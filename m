Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC9264638;
	Fri, 13 Feb 2026 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962759; cv=none; b=CZrF51q3v0O0kuA8ce0Ujfz2CToj9kBDSUB2wPAi8gi0MoN3veP5KKia2XQQrosky6Uf2bDNgV5blxSnZp8jqfji63sVbtUwWiDgtyq+QINbLjC9u8wip7C0ISceTgGTfNMZY3PoZj06YEEckt9obqvhnxn6IyCEoFGxnIjY0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962759; c=relaxed/simple;
	bh=t0ATrk0joZXMp/XpctJ5VdxjPgIC1hcX+JPHGmC4VvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ3VyS1ccPHK3S1cfrmjwduV8CKYSgFDI8UEmPrTunU8ntFsA+lz80AA2d8bdmf8/KNODeWZNnUWyYJfPKR86q0i6GC/sjqbetUI28j8B94Jv5uGdOauih6MRi1Ae5UfzopNyPHdFw1VX+iUUDr4bjr525rOJf8NmG1TuGYehOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jK6FbZ40; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jK6FbZ40"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PZUSXqE0G9A6YIVtMGcb/ILxAy5ED9bTFTJF56eUpSA=; b=jK6FbZ40StO4DgcPKg6ynS9q3d
	gxfdkgbRWWgKKKlxzlqfhngzUJkYgfuG6ojrcIlwYr9AgnaOOmSbay+WaOnMciYC8ZqeVOoHRIC9z
	L5LbQH7VlR1wnBoL+wCYSI+NrcSRYdGNGnWMG1JMu9Ydgqez8nittbDXwWdgb6c0hObDbWdI0YdYI
	N0BuCV3Sma3qP7RNbu4z80chU/IG1ItwLjFSEQN+kvBN25mfBBRsakr2mwN0JTOt+TdPDgKyq+4IO
	W0pt4iaDXKXBvT/e2GPgqpwKPNEJdPU7zCc33paWIeojVaeukIRy+rMT+gBxS2U60gA88VLAHhmAN
	RnjZvLGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqmJO-000000033Fm-2AIN;
	Fri, 13 Feb 2026 06:05:54 +0000
Date: Thu, 12 Feb 2026 22:05:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
Message-ID: <aY6_Qg3gPKBPdttw@infradead.org>
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
 <aYWNhtixUGuj3hat@infradead.org>
 <eaa83421-a07a-4ee7-81ad-f32d4a237ff8@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaa83421-a07a-4ee7-81ad-f32d4a237ff8@linbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 12, 2026 at 04:01:43PM +0100, Christoph Böhmwalder wrote:
> The current block layer logic actually seems correct to me. The
> underlying device may or may not require stable writes, but regardless
> of that, DRBD itself definitely does need it. In blk_stack_limits, DRBD
> is the top device, and DRBD's backing disk is the bottom device. If the
> backing disk happens to require stable writes, this would indeed be
> correctly inherited.
> 
> So the only missing logic is that DRBD still wants to enable stable
> writes for itself even if the backing disk does *not* request it.
> So it seems to me that this patch is the correct fix for DRBD's special
> case.
> 
> Is it not supposed to work like that?

No, I guess I just misunderstood your report.

