Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0A17D355
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625385; cv=none; b=N8kCIag+SS5SUnPaX37/D74WuoGdKnS/TEXTWLZKjRPshCoG3CDERpHyDK+Ngu8F+ymCQZnEu5tBc4RquaAq9tzLz5HG8cRZXjtguz9eNdJVUZCAWbGbxuIRS69XkFLf7GbbNDbqL9ZjruWQHjyiiAHUC7/YTsN6nMfvFXjX/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625385; c=relaxed/simple;
	bh=tvRwVs7C6B+pTaoY3DDJ/NHAWtnVoFz5mWPK7mepY/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC7AqWD6SHAvWvCFxOej4evxFPKk70XxI2tkXhsT85RjUrHsT0+KvOboVM36EyfN74Bd6qAxacgKuY3zMuwZmWD7N6cVm9bVAZ4xnVWrNPHMPGvn2ct+NSfb3slpZuE0w5XWDbly3fMyMD0/DeqGC986RdCDLUm6zbe/qW8LyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mCoFizkP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mCoFizkP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tvRwVs7C6B+pTaoY3DDJ/NHAWtnVoFz5mWPK7mepY/o=; b=mCoFizkPNk/kL2vO6pJ39RulgL
	+LTfGSmy71EvCvQb4T55N1KkKp9fogdjtcZ0Qcx7RVsiVZeN+O3L3OeGf6hPCXY8kOrQbyMI0hmg4
	MpQMdgZk3LamOq8O5rRVKLMDbojrM9ylH76md5Noi4QBYygM+DD5yVD0llMy41XWCMLhJpkP2hMDZ
	YQJB7eAWkrcoe+jIQxLcakWd4zVt0wwGL9d0xDpvREF2ip9awJq/5JRrb71L3n/aCDTGH8MXrrqDi
	mpFNkrUjPnjl8jANdN8uo80dFErbLCkdrvggQpFfndLt5wzIhwt+B7joRRuVSS6EWT8r5z0iU8nV3
	9qbygxIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFv0h-0000000AbOY-2FeI;
	Tue, 26 Nov 2024 12:49:43 +0000
Date: Tue, 26 Nov 2024 04:49:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0XD54wTNpI-6ahJ@infradead.org>
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <1e5a1594-a945-4302-bdf9-1a57cc140b9d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5a1594-a945-4302-bdf9-1a57cc140b9d@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 26, 2024 at 08:26:13PM +0900, Damien Le Moal wrote:
> Note that I tried qd > 1 with libaio and everything works just fine: the test
> passes. Things are strange only with io_uring.

It might be worth checking if it has something to do with REQ_NOWAIT
writes and error handling for their EAGAIN case.

