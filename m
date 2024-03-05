Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D928593E
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646046; cv=none; b=X3DtBmnSSX9uwy1jcwyNDAU+WRend76l3ucg8ZP2iGZ+saX3GOtVwCm43h9F4t2FJCzcR0eQA4jj+PbnwwLXIJ9FaXUmGsCuRh6VLAxHs6HFW9f1I/XVYVnorlKpKBEJuu7UHG+0Tq3fOOsjN6yyhdNL5BYogmV5ZSJorhdF8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646046; c=relaxed/simple;
	bh=R7n8lGHdKV1HeyZSMqFBE96bANiGE6jJY62XGwhejvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=quMFKi4ZCDiYhpeVHzqeUjPMmrTcJTwDc1/621agIwoStsbvDH4qZjpLA0+z5TMkE1AyC7oehhN5F7AsmmXKQaiUt4+2nhIdeSVt2xWgbgBNeAojaZLI4c3fZZuIzWeV0zP0b/CDcB+7FKxQ9vkwbJsSWSuUPAjgP2KCSCMmaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nlYItw/A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nlYItw/A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3uqF7GWkhm4u4EkLAwWWCLj3aw8Q/TDdp2iKlr/k3VQ=; b=nlYItw/ARjQD0Ym3tunsAtR0PQ
	0BtKSt9D5OWcmpvNr5Vy24a/UAyXSraCzj1LRc8qUoOUNyo+MVdux/4Oua9M3i//ZkXZCke8X4opY
	v7ZatTUJ+DMNUYojvD51x13beGRuB5bgpfiwiijrFJw16NH3hPI0xNYOzMlQuIBCMlIvpYkbK2xGP
	7Ei9RoahcVIwPD7zRj67szOdlmFhE0YPPS7/gLmC/yEKOmrdrLwgXKTI8qGtO5IOdY7pnLRsCHZ8p
	zMskxIZjO5RXPmdWlTt+psw9PxqAnqChUL3ogtkhTHdVV8DQkIld7Af6F8JQq9t3WO1JKgKAlGtOV
	8aeLW9QA==;
Received: from [50.219.53.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV2A-0000000DqwQ-0gqD;
	Tue, 05 Mar 2024 13:40:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: drbd atomic queue limits conversion
Date: Tue,  5 Mar 2024 06:40:34 -0700
Message-Id: <20240305134041.137006-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this is a standalone resend of the drbd queue limits conversion.
Philipp said Linbit has reviewed and tested it, and they'll hopefully
provide the formal tags for that in a bit.

Diffstat:
 drbd_main.c |   13 ++-
 drbd_nl.c   |  210 ++++++++++++++++++++++++++++--------------------------------
 2 files changed, 110 insertions(+), 113 deletions(-)
