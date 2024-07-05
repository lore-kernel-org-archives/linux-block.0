Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2E81E;
	Fri,  5 Jul 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182763; cv=none; b=MyAgWJQz8zgpAlomggF+9GGRN8JTODY2mXwcBqyJ9Ibah+0WsWOGz6kQ4jxKqFS9OXei7sYECRD6PydQxllUl77HLOqH+SPH9xmtFdBkJSvAohNmrx9MRbQe8dbHjelpbAxS5UMrUZ0gTLXDpvAOtGMHG0r81caMN/kkEjpZJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182763; c=relaxed/simple;
	bh=20VamIGOWNDd45z8bPwyvnBLUcbVtemyPhPBUqPor8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcrbdLOsw0wnsyupfvswz2q0Dvthx3lill2Je++CMQzqQiN0ujueUgPqgv/qgdFCRtdV0KskxUpQ5fPdsG/Lzc+QCBYIuV9uUZwsGQGTWRN6mSsjrhDFxKxJmrQCWoNw9AAY9NN7Fuk/aqsP0BSmSURqqagFKZbHRdMKk9L/jEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KXFSt70i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KXFSt70i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=43MEASmZE9ZiQ/60CpzwScLZdOUBJPtVRkoLS/UONm4=; b=KXFSt70iqMOn1KwmMmwEjD/4Xe
	HcBCHB+A3s88mA2Pj6gbtCi/XYigMMdKM9lgj/xJYZEslp13OxQOz8XEZ16c9doFZUZCWkoWUYDgE
	65bXYRpmzLojG5bJz/yc0ggjQwojF1piBf9uqTFMMGrDJu9m+HK1KkY+kFMpn+nzC4zojtQMRKoWu
	zJ+gizPsa6fK+STmIvRMpiB1cQj4CJRDnELDT63pNN8KJUzbMJQcolhsxBlyDNjXdWs4/jed93kv2
	2cLaVDEcf/cUJ6HAwsZS2v2YEmxrczhQnp20bsaN7rOa6/zYx9Ddbh/SrOEOGYVCRqiYjcTULEH9T
	c+QQ0YwQ==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPi7A-0000000FuvT-2j1h;
	Fri, 05 Jul 2024 12:32:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: add a bvec_phys helper v2
Date: Fri,  5 Jul 2024 14:32:18 +0200
Message-ID: <20240705123232.2165187-1-hch@lst.de>
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

Changes since v1:
 - reorder the two patches as suggested by Geert
 - fix a comment typo
 - use PFN_PHYS instead of open coding it
 - also pass a len argument to get_max_segment_size instead of open
   coding a min in both callers

Diffstat:
 arch/m68k/emu/nfblock.c |    2 +-
 block/bio.c             |    2 +-
 block/blk-merge.c       |   27 ++++++++++++---------------
 block/blk.h             |    4 ++--
 include/linux/bvec.h    |   14 ++++++++++++++
 5 files changed, 30 insertions(+), 19 deletions(-)
