Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553934CFC5
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745218; cv=none; b=SUYU1dWMJZhDrAJuMQjX0Src3Po6e9XBexOAIhZZ5mg44W6IHlXXOAw2O7QOChw5WQz+PyuGIugrBd1uqz20svppW90DyqmWSnu3peAjhfyJntP6WL3+KQIgqNMeHD546YrjeZvIw9bYBq1y44nhZPvoCvfZ2G7qiyFBgytYL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745218; c=relaxed/simple;
	bh=WRvDJwrxBS2qVE3lF/ZaBQ/jjn15vGmmM9IHJKxrFMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWCtukgdr5psHnSDX4TzB4vsGlZOSRDXw8Vr3sga+6C5JO33+wHfzO6u0/Cgz4dn/5EpT/0fhVymdz34f9WMzgBA7WzoSTxNnmuwEK0z1H/dgi1TRVYrcY1dYuFN+RuZ+aRg4EqH+WUGTubAtlNdCYObPz6J9zcQ3lKYcsNvcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U97lS5yM; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U97lS5yM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761745216; x=1793281216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WRvDJwrxBS2qVE3lF/ZaBQ/jjn15vGmmM9IHJKxrFMA=;
  b=U97lS5yM0L2+S/MGWPBifyfCaWCa724zfo52Yd20jpnFkumwJj4RVkhN
   hMPMi7oU8ISCQlrTU8eyIXnyIZnB/j7D5480jjMSBLABmoIXk0Xe6qwwt
   SFT2fgs3iw5G6rWbgIIEtIHcRMIW/8HTiGUrJZHebYKXBIfY1gyKGD3/G
   reRQeYTveM/zAfByeLEaytzFmZmKG140HoGICcXJsvB4rvv+t+ejlL+QE
   lbY+Oh1EBYp3smbW2KpU7MDtKwcD2m2jSgBCVueYR4gJMS2scciqIjd9r
   3K/GBjQguqyVsGjkkQMThYRl1JiyjBVFqxOj/l3DH6vsr52dmkQW1GUGc
   A==;
X-CSE-ConnectionGUID: I9zccb6+QMWFVXghzQUQJg==
X-CSE-MsgGUID: snVJ+hr8TSylEgXCnfMc4w==
X-IronPort-AV: E=Sophos;i="6.19,264,1754928000"; 
   d="scan'208";a="131119073"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2025 21:40:10 +0800
IronPort-SDR: 6902193a_VpdgAOd0Q5+97eiLVFHv8zR9ID9DuVgUli0FQl3s9nNT3f4
 dxP0Zzq9RjKxjS+j852CZG6Unhy1WWNlYyNJ6Iw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2025 06:40:11 -0700
WDCIronportException: Internal
Received: from 5cg1443ry6.ad.shared (HELO gcv.wdc.com) ([10.224.178.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2025 06:40:08 -0700
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
Subject: [PATCH] null_blk: set dma alignment to logical block size
Date: Wed, 29 Oct 2025 14:39:56 +0100
Message-ID: <20251029133956.19554-1-hans.holmberg@wdc.com>
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

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---

A fixes tag would be in order, but I have not figured out exactly when
this became a problem.

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

