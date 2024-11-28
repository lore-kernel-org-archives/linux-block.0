Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82B13D891
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 04:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768777; cv=none; b=uf3y97X6XkDWB9ao2uxGOxs2+3Am0UEq/UmlW5vGSGqtOZtUF4TXrvCkhgqcHWgRoRs5mlHlBCSbCu/l6pUdElQqCdN49ws6qf+opRyjad2q0PEmsSy6C6YB5PH534HLWqlfA1uu96nLf27z9oOPbIiZ4uvp9uGG7F6VDKYNgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768777; c=relaxed/simple;
	bh=bZ9fsJqi35jaklR/GF5BTYI2kpeiGYQnBYGF86g+Cf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf8JLuUY3FzR3eZX4s5mlaK5CoKd5Ul71W4OrqTesR5q99x+Lrj7KxsPtVDl4LJ03CKLleMZdNkP+LGzNl+NGn5jZMWjwXIgYCqDNTLzthDqbknf/Hqam3EAUB1LLXCzP2V+laMjcq6QHKvV2EjRX8E/q4K+UJX/Fo0thZb+dGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M+ko0saO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M+ko0saO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cgHDojRLiCUMzIJaoHk3euH9LoHltUsthyU2Wxv+4/Q=; b=M+ko0saObkxVNISnAtSFiw2Wpg
	uet3VpbBDpZdIlLh0xfAUEIIIlJwHDUmZ02DCUnem9r0joOn6luqC/wss9jEClCo7l5dlXq9RXaBp
	Q7uha70Qv6EwJzo+qwtqDUOJ+WbfUVszZ9OhrS53RtSweeaaqEzB2TDoLCzcaEXKwbmUfXN8lKR9j
	cTXa1jUZ8nVK/pP7YV5uHtRM1oNKACPUIjDr0OdEsyEdA0kPD/4Fv/IcAiVs6zK5vZbYuXlwPBoCz
	u2uZ0HUSK3OZeSPRktyW0erv2HZYI3IWDdNUsyNvj2XrHdTBE1q4MILCGwMzwXbOFFXjcsSoHbogL
	6yghCVdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGWJT-0000000EgtH-2Fjq;
	Thu, 28 Nov 2024 04:39:35 +0000
Date: Wed, 27 Nov 2024 20:39:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0f0B6Xf-jdc_fx-@infradead.org>
References: <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 28, 2024 at 01:37:46PM +0900, Damien Le Moal wrote:
> suggested: a BLK_ZONE_WPLUG_NEED_WP_UPDATE flag that is set on error and an
> automatic update of the zone write plug to the start sector of a bio when we
> start seeing writes again for that zone. The idea is that well-behaved users
> will do a report zone after a failed write and restart writing at the correct
> position.
> 
> And for good measures, I modified report zones to also automatically update the
> wp of zones that have BLK_ZONE_WPLUG_NEED_WP_UPDATE. So the user doing a report
> zones clears everything up.
> 
> Overall, that removes *a lot* of code and makes things a lot simpler. Starting
> test runs with that now.

How does that work for zone append emulation?

