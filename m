Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D7189BB6
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677516; cv=none; b=OEJM8o9YRcRfOlfqxqvfS1JXDhyX83eplcDsfXtz+IVHs74BXg7TIjmp+PGYDTt04N0idbYYUiKskhH7BMOVx8LgAHC4DCFiXmLZxSTk01B63sPgy0WWFZZuZpdgc4ezaVr9xAu7Ns3DzYoMqeVPspu9SpMeRMU1IePBpkAAGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677516; c=relaxed/simple;
	bh=WGo7BoBzsdLZxsVuyOQgRWFUPn/UgdgxpfaYaDyEgFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCwHx+13uFZ2ZcWDkLVeBaVG2rNKfx0NnEE67QsyVZtJcX35KuzlDCEqOfTaYzUCeqvW38PpTSsQUn/pxzIcdNgrexHX0orXNBYDKeHDS29sABsRo9iEC0SU6ir7C5r9sfUiyNFvjHRk7HA4lyT3WAseqqauqks7gqi5QCqzXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0YFJOeR8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0YFJOeR8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rb8SzZguhVSGykjcmwrxJbhOVoP+ITDKUOuqY+Avr3g=; b=0YFJOeR8S/v/UjYdttysA2jIjM
	NsmDcsxXPBcj8mb0zbPFwywhr2lygluF/KVbFidLawSm/7t5jTmk32kPeZeJ3oGR7g4bDhrbmZNgu
	qbZK24TeuGiTUK42xqUPLlGMBHr6He0Yy9lUBPEINvxNPQvulZcedFdqxAf8YwNi4NUw+79WsnX9O
	tVmatSrZAtets2y9cfx6TiGoU7vqeqPXURSMaNdj7lUJSnJwu9S7GCNfnRtsZj8f3b75IVOGM6y7S
	7c5qjLAVMM3NHXfJ9rBP1ljOMsfYkwZp9cIDk2I9SuRae0HjyMLUPsl4+QZQ3naPh19gdHmnfzqWQ
	bC3+dbZw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AXq-00000004Q5Q-159r;
	Mon, 16 Mar 2026 16:11:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: bio allocation cleanups
Date: Mon, 16 Mar 2026 17:11:28 +0100
Message-ID: <20260316161144.1607877-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I recently looked into a batch bio allocator for a project I'm working on,
and notice how convoluted the bio allocator has become.

This series unwinds it so that the the fast-path slab allocation is
better separated from the mempool fallback, which reduces the code
complexity a lot, and avoids indirect calls for common cases.

Note that we could also avoid the indirect calls for the free path by
using mempool_free_bulk.  Should I give this a spin or wait for a
workload where we can actually see a difference?

Diffstat:
 block/bio.c         |  199 +++++++++++++++++++++-------------------------------
 block/blk.h         |    5 -
 include/linux/bio.h |    3 
 3 files changed, 82 insertions(+), 125 deletions(-)
