Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC793189
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329022; cv=none; b=bQFq/patIoSyPHBII0SmMwvzeDO3mlzkRBEAfpyqnMWifRbybS1RuEeZvKjAI/W1uv4l2/hQLI6E0YzK6JjKeeHt0Z/n+Dz40y3aikEbmnjrldSiKipg8h6Sav4LEx5C6wU898DI27fkDRjrIwvA6M54rP9TymnDJYVfNJ/sM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329022; c=relaxed/simple;
	bh=rGUsp9DXR8jCUsi9oRukU2Kpzzik+4PF9SuCIqCwRb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uuk8G7g58Yf3Ti5kIMQZRdWhGu2NsImTsF0vzNshxxY/sYNydSDFdfCqyJAQwBjf8JRYI03/LnDZQCfPrIxU8SVjHRZLxSGtsnGa7z/S8VINLXeI+kyuQ1ly9Gi0si4KOLJOiSikV9tI5NiRsudy8fPlFsUZVQ+3DQDM67qjdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Upt6XZ93; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Upt6XZ93"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mvL2vaVQ9kvUo2nLmCYddpY+My+WiKN7ex0R5ohPtsw=; b=Upt6XZ93sw0szqycpBtXp88SJE
	yLkmP7SjcYlgnjAao6X+BDnT9CEPPedIR50K4XAtBh1oSh/OzZoLHw9b4As9+0/hGrqkAw4yPtXaY
	tGCSnbilWy9SY3rIPFNd6StIxp7V4+HyU2lDDJJiioZA//XnR75dT8rkkSJ2xw1tyg6AfXq37VVYr
	SJINu7nZyj07wsAamsxD8POCvNmfr9Uw/7fTWIGMimDYrHi2w+vgD5pljI4LaJ1C5bP1EDm5PPGu0
	pDTZIadl2Fdsr9FaKJZZf/THAwRNKGL8icGyBGukPLqAqTgQwfPu8QRM2nETTRniAwuVOjIH19vM0
	1pARIyvw==;
Received: from 85-127-105-228.dsl.dynamic.surfer.at ([85.127.105.228] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvZYP-0000000GVEP-2I8N;
	Mon, 08 Sep 2025 10:56:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: remove the bi_inline_vecs field struct bio
Date: Mon,  8 Sep 2025 12:56:37 +0200
Message-ID: <20250908105653.4079264-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

the bi_inline_vecs causes sparse to warn when a bio is embedded into a
structure, but not the last member.   This is a bit annoying but
probably not a big.  But it can be easily fixed by just removing the
member and doing pointer arithmetics in a helper, so do that.

Diffstat:
 block/bio.c                        |   10 +++++++---
 block/blk-crypto-fallback.c        |    3 +--
 block/blk-map.c                    |    8 ++++----
 drivers/md/bcache/debug.c          |    3 +--
 drivers/md/bcache/io.c             |    3 +--
 drivers/md/bcache/journal.c        |    2 +-
 drivers/md/bcache/movinggc.c       |    8 ++++----
 drivers/md/bcache/super.c          |    2 +-
 drivers/md/bcache/writeback.c      |    8 ++++----
 drivers/md/dm-bufio.c              |    2 +-
 drivers/md/dm-flakey.c             |    2 +-
 drivers/md/dm-vdo/vio.c            |    2 +-
 drivers/md/raid1.c                 |    2 +-
 drivers/md/raid10.c                |    4 ++--
 drivers/target/target_core_pscsi.c |    2 +-
 fs/bcachefs/btree_io.c             |    2 +-
 fs/bcachefs/data_update.h          |    1 -
 fs/bcachefs/journal.c              |    6 +++---
 fs/bcachefs/journal_io.c           |    2 +-
 fs/bcachefs/super-io.c             |    2 +-
 fs/squashfs/block.c                |    2 +-
 include/linux/bio.h                |    5 +++++
 include/linux/blk_types.h          |   12 +++++-------
 23 files changed, 48 insertions(+), 45 deletions(-)
