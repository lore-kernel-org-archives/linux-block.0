Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43D144D13;
	Fri,  5 Jul 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167314; cv=none; b=rPL4ziReVx/jb47P7LXjlIL6H0tbkX7DEMdD6v4f9uqRZCZiMR1Ajip2+wZ6HD6zAp6fp5ERAuAnb+mmWsVs6bj0MD88+PGSzafP8hVYcCsv+1bvUjxkhf7YlvSHrktZgyGhLviZ5jrxf4ht/RFM4GC/dGvyIRCNDRsSNwQfxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167314; c=relaxed/simple;
	bh=tmfKrUTK8OwY7+cms3i/ZqwOuRctQAhVhhYOMFeOjgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1Qt6viNvWZGl28vCYdjHoNsIPpGkY2Z4RsXOZKqz2LYftGkIKUw28Q+lv1VgzU04Y6I9h3DUymw06NOs+Jogf4dKvluWkmqaQyPDAtnTGy/fnwmwgrmTnEpHhqz0aPpwxOs4InhC59n0mYPsVBncP2aPfgf4g9u6zuz1djUsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zjFNDyy+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zjFNDyy+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EZvTTmHWJEKWCK6ldUt++NnPDgMUM47tyEwF5M9ipjg=; b=zjFNDyy+GUW+uR7xhPbAlZeE/0
	VTUQeux9/i5BqUyQiRk69bGHvGAjdMi6Bx8jiKVQDF/caETgiRrh0i1cZxxF/Dd49r0qwYz1ewwEj
	a787oiwt7rBUMIXbaEEO7WvMmGxu9WTVQPuw4cE1IuMqkAGpu0OS4Bv5wf3JF5b2MkZoVydsHj4fM
	4vSZyY3ry0T5iA+jg19r06SWlsATGCW3YHXKFhx3V/LwP0H3DwQ+9zGdQ3SCHVKC3shqVm8t3mWyX
	G7ZOKaWV/0M70U0++eXQ15u5K2BbrvbSts2gAkBBABdvDr9JONjo+A6T//JDpYceaqqlWmlO8tMMR
	3NxYUYoQ==;
Received: from 2a02-8389-2341-5b80-7f6c-d254-a41c-2a9c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7f6c:d254:a41c:2a9c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe63-0000000FFKF-2ePf;
	Fri, 05 Jul 2024 08:15:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: add a bvec_phys helper
Date: Fri,  5 Jul 2024 10:14:32 +0200
Message-ID: <20240705081508.2110169-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series adds a bvec_phys helper to get the physical address
of a bio_vec so that callers don't have to poke into bvec internals.
There aren't a whole lot of user of it yet, but with the new proposed
DMA mapping API we might grow a lot more soon.

Diffstat:
 arch/m68k/emu/nfblock.c |    2 +-
 block/bio.c             |    2 +-
 block/blk-merge.c       |   22 +++++++++-------------
 block/blk.h             |    4 ++--
 include/linux/bvec.h    |   15 +++++++++++++++
 5 files changed, 28 insertions(+), 17 deletions(-)
