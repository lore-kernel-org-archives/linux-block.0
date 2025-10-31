Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06732E133
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901354; cv=none; b=PsAlcIC3frdx+r8fbrXu3zmSphjhtPipJchPSycsORSm7fZZuDrRuHJ90gZexK7oR1DXnFdnY73XHG/rvLdIqNwa8VnN22W0zUWpRgZhP4rWs1KsVb61QevLOaDDY46UNxkvoypxFEp2q29DmQhvStTbamf/hg20tGXZgd4N52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901354; c=relaxed/simple;
	bh=qvTH+s2hzImvj9rYuW7ukqPIqx3wlk0dtCpzrIXJlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqzhclZuBdEY/seh35/h9sHuO6mLIpFDwg7Bdhd90H+kXHOqPf7UMblWY8AsAvgrw8BKO1b3fzKzcvmGpfwbrZnOj5PYyAoKvf/Bu5roYUHTL3dw8Jm23j8FT+RGHby4Mav3km/4HUfwaGcRqO3XppC5+3vScuaNFFwBXoipLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KJ9iSlK/; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KJ9iSlK/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761901352; x=1793437352;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qvTH+s2hzImvj9rYuW7ukqPIqx3wlk0dtCpzrIXJlYk=;
  b=KJ9iSlK/6i+W98m//VTsQVSd7sLa6monPOwYcDuvTqyWoZnLPZ3OwE3W
   lXQuuCduLsXafValBHqramsq/BDHqk5+j26KwZ3Z4T4MubUFFNssMEHPc
   ZwXk6Ur0m6ia8MphruaublFnPNNDd5T9sIKvGtuK0kind9vytuedNziWX
   i2O9dltRYaMWV2SXpH0tXH1MYcRmeTd5dk167NdLOiIFRtNb+cio3b239
   Vi+DJGCciHP9mrQX8Qdq2fqX1+1yjGRIVx8nJHGxCazzj4dT+i7t34WkG
   7mkuwlDWH7zF8xbGyXbm4pLO5TT3MXodFYiSKkWTZo4YETH+O4HNFaPAj
   A==;
X-CSE-ConnectionGUID: hk9GHBR8ToywzR7KaBpCyg==
X-CSE-MsgGUID: VhWvhansTt2Y3g1KZrfDWw==
X-IronPort-AV: E=Sophos;i="6.19,269,1754928000"; 
   d="scan'208";a="134262464"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 17:02:32 +0800
IronPort-SDR: 69047b28_TyHv73rz0l7MLDviB1C2TXPdaPygk0J6r+i6R21iRQNmHna
 k0HhZDL4AWxkf+EpMwd1LEpw/xu4e916tIYzZ5g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2025 02:02:32 -0700
WDCIronportException: Internal
Received: from wdap-nazonkp1b2.ad.shared (HELO gcv.wdc.com) ([10.224.178.8])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Oct 2025 02:02:29 -0700
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
Subject: [PATCH v2] null_blk: set dma alignment to logical block size
Date: Fri, 31 Oct 2025 10:02:09 +0100
Message-ID: <20251031090209.131536-1-hans.holmberg@wdc.com>
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

Fixes: bf8d08532bc1 ("iomap: add support for dma aligned direct-io")
Fixes: b1a000d3b8ec ("block: relax direct io memory alignment")
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---

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

