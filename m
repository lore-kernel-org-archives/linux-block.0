Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A028E10
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KqAjdIFF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Eff81gtO+mu7iRRX0HvkKbuApq0HenOFTG40b2NQD9c=; b=KqAjdIFF1+nU4wdpvYxQEBYbZL
	o24CXB0QNYibhBJQ5Gnx5OuE1Pm+PbBdHhiabAjHZcbUGZz3/T3SrJWmgF8teL8mPKWJBBiMvabDj
	6k1bwnhvCf3SEc2YIelNZfOTWLrMnaeuvKO7xWPc3sgWtITYo0bzUkygUvwwFCXjZFN5zBU6QcYfI
	atMBYWaM1ldgln/5NOZ1ser0xXiFR7AJ9KB86cca/U9svPJzdwnLWwV5bDUZNW3FKyv2kRS30Yy5o
	rFxanoLCGR3MbJTxSW2rzPaLieu8CD7suKebAGHOk89QfbeEnEEYaGzVjsJHr0U/P6uBUxq1cYzNU
	rE2RIhJA==;
Received: from 128.red-83-57-75.dynamicip.rima-tde.net ([83.57.75.128] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIQ8A-00EI31-2Z;
	Wed, 27 Dec 2023 09:23:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: make BLK_DEF_MAX_SECTORS less confusing
Date: Wed, 27 Dec 2023 09:23:01 +0000
Message-Id: <20231227092305.279567-1-hch@lst.de>
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

this series removes a few abuses of BLK_DEF_MAX_SECTORS and then renames
and documents that constant to make it's use clear.

Diffstat:
 block/blk-settings.c          |    2 +-
 block/blk-sysfs.c             |    2 +-
 drivers/block/aoe/aoeblk.c    |    3 ++-
 drivers/block/loop.c          |    3 ++-
 drivers/block/null_blk/main.c |   12 ++----------
 drivers/scsi/sd.c             |    2 +-
 include/linux/blkdev.h        |    9 ++++++++-
 7 files changed, 17 insertions(+), 16 deletions(-)
