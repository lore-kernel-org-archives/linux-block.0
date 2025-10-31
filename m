Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF52329E64
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903361; cv=none; b=U1jIM9qYVo0ShnK7O+R6dJpPupQNzgJD+/tNba8G+R/nwyA7wRzaRiJAdKsyXQgcoCb1DkxgxHggFJIPZlkj99Hn4kk+0jHzUr5CuJ08jFNwPJjfHRN/dMUqoCy9nojD+UFsNMQEAmZ+gl298VeAoQ3PJWCiU+SQLjhi9Hipv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903361; c=relaxed/simple;
	bh=axLiaAY5+w7Dletd+wQX1BHJcWPqi4LziJ21WSkAwik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvGSF9medjLzFv3rB1XfSujzo2ddmzBfZfant1w6MLNvvfJuddR9zUT8ORk7y4mxYTDB5T/mVQhwIo7oOujsUxkV+sak3kKgGqAeKCV3KsMAP0gY/y4CK/xJmKD+Mf8FPZSa9ql+/MaVtD1TgJZIWlC4eeqzpCow8I/PTtx9qwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DZPTwvK5; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DZPTwvK5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761903360; x=1793439360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=axLiaAY5+w7Dletd+wQX1BHJcWPqi4LziJ21WSkAwik=;
  b=DZPTwvK5o+tTXWMQfh5uRPYPwpl2W3vnGw42R76BvXjtZ2eY5BGhMKw9
   8MsLLycgWHHeEMagQvZNf2M9ryxAx0jVs5S+u6pFfVswvC/axskG4AxGo
   olqsxGisRTi1RPdcX90WoPJRJri+M9zQVBehq/ERMQsa56WIxPM5hZHoe
   v1wEWs8Fl4Pk0YNWo46f1uQtHYcU2BT+aS8vwST9r3HdQ8Rg57c+uOQp7
   BOWOoq9BX1Muvi1y3TcyHuuAGZzvUTqUAsawa1eBIcYqPJcFaviHIzkuU
   3aAia4O6iztybY9SIbcVijErtNApi5vTXu4/FnTbnEltDb7IPL66S7RHZ
   g==;
X-CSE-ConnectionGUID: pkXZ+RVdTiaK3SvBs4g9+w==
X-CSE-MsgGUID: NNL80SRBRLO8TPElzpm0gw==
X-IronPort-AV: E=Sophos;i="6.19,269,1754928000"; 
   d="scan'208";a="133904006"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 17:35:53 +0800
IronPort-SDR: 690482f8_9ZGUljlAkujpCc1cT8YVCpjLf52f/CFXRWov2GRzisV5WT1
 /1IX4QPlXUVhdIIYvhE2P4NQNVJZ9UAJ3yLxGLw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2025 02:35:53 -0700
WDCIronportException: Internal
Received: from wdap-nazonkp1b2.ad.shared (HELO gcv.wdc.com) ([10.224.178.8])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Oct 2025 02:35:49 -0700
From: Hans Holmberg <hans.holmberg@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>
Subject: [PATCH v3] null_blk: set dma alignment to logical block size
Date: Fri, 31 Oct 2025 10:35:46 +0100
Message-ID: <20251031093546.134229-1-hans.holmberg@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver assumes that bio vectors are memory aligned to the logical
block size, so set the queue limit to reflect that.

Unless we set up the limit based on the logical block size, we will go
out of page bounds in copy_to_nullb / copy_from_nullb.

Apparently this wasn't noticed so far because none of the tests generate
such buffers, but since commit 851c4c96db00 ("xfs: implement
XFS_IOC_DIOINFO in terms of vfs_getattr") xfstests generates unaligned
I/O, which now lead to memory corruption when using null_blk devices
with 4k block size.

Fixes: bf8d08532bc1 ("iomap: add support for dma aligned direct-io")
Fixes: b1a000d3b8ec ("block: relax direct io memory alignment")
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---

Changes in v3:
* Improved the commit message, providing more background and hilighting
  the severty of the issue (as suggested by Christoph, thanks!)

Changes in v2:
* Added fixes tags from Christoph
* Added reviewed-bys from Keith and Christoph

v1: https://lore.kernel.org/all/20251029133956.19554-1-hans.holmberg@wdc.com/


 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f982027e8c85..0ee55f889cfd 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1949,6 +1949,7 @@ static int null_add_dev(struct nullb_device *dev)
 		.logical_block_size	= dev->blocksize,
 		.physical_block_size	= dev->blocksize,
 		.max_hw_sectors		= dev->max_sectors,
+		.dma_alignment		= dev->blocksize - 1,
 	};
 
 	struct nullb *nullb;
-- 
2.34.1

