Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390C1E9B3D
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904120; cv=none; b=c6p22UJ8TV+GWSqk981YnsL3cnWBj8QQyPyTrQ42iXNM1DLRrkiyXjES6JkE3YBTeTtH/U/iTFwKjpfTbOco8AMNtSPvIhou+z2CBT6hGm0JLDJh8TZMc67rPMi7KPcyR+dqtQ3UsL/0GG1FwRrtNdjEHgMvYyDBRa9xXeEF7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904120; c=relaxed/simple;
	bh=0mNbRhx8u01jf+XfQAw7DPovqZYaU2rWCN8PAUy00jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggoBkFfnfs2tvyIZM6xhTn566ec0FYfsJC/onvg4ewX1Aje0ldLo+fbaU/E/mA/nID0Ni4hrtfNppZkzqVxTnIdUMeqKJvHVFufA6zJ6S7VFbVvb1zA/W+LVYRQ8CQY7AuUbR4MH23HyEnPptjmaPnugpXb9hEQCm/HZroFMrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LHwU4Lom; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LHwU4Lom"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761904118; x=1793440118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0mNbRhx8u01jf+XfQAw7DPovqZYaU2rWCN8PAUy00jI=;
  b=LHwU4LombJmqSAjFGMKjs+FyQJoSJ2DcbIWvkVxktDEcKipZaowOiqvz
   TUHqdJx8zfur0E9DWkgHRrp60F3Ko//B3TEw8O3wL1fOFHMQdJpAp/qk4
   u3UJsNFhdMDvzkyxHHsrweWHdv4mPrawmits0z/TibwbW3h8oMz7SkfEe
   ywjBotRR1p80u7CPSwUAC0MlrqvxN4My/PoqspCo64piaivSVD2z9Q2DI
   ZxttYjRknawKAORUj2HqQhKLLF67VOBrhJ6Yg7Qnz+Y0VJq912/0EH7n0
   p8K0Mj2Wb3V7rfU7J7ceP9aHXsLkAXSCPs7wMqcNwsKjR0kVJ3+TO532F
   w==;
X-CSE-ConnectionGUID: bBxZNjCpQPmBEhZpi4sw6g==
X-CSE-MsgGUID: s1ouymmITa2rTmd/3OmGmg==
X-IronPort-AV: E=Sophos;i="6.19,269,1754928000"; 
   d="scan'208";a="131251689"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 17:48:32 +0800
IronPort-SDR: 690485f0_wtw7ijPnq4o2beJnA2HDfkPL8T9VGkjmEYc0ENcVSc1G+Zm
 6DBSkiS5Izt+ZUyT/WhOVsRybH+dnAdWS9eqKOQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2025 02:48:32 -0700
WDCIronportException: Internal
Received: from wdap-nazonkp1b2.ad.shared (HELO gcv.wdc.com) ([10.224.178.8])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Oct 2025 02:48:29 -0700
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
Subject: [PATCH v4] null_blk: set dma alignment to logical block size
Date: Fri, 31 Oct 2025 10:48:26 +0100
Message-ID: <20251031094826.135296-1-hans.holmberg@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---

Pardon the churn.

Changes in v4:
* Added reviewed-bys from Keith and Christoph

Changes in v3:
* Improved the commit message, providing more background and hilighting
  the severty of the issue (as suggested by Christoph, thanks!)

Changes in v2:
* Added fixes tags from Christoph

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

