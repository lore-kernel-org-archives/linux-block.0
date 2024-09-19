Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259919D8B8;
	Thu, 19 Sep 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745419; cv=none; b=T2YiE70ob6m2JIm8NHnncbL5AvdARiZQdkgT336jjsD3OnLRTnhCjOJkGeDvWq86Xhabs+AkPJhmfPp3igMc6Aal0dQgDnTIKv1OvteR5bUL3oxXK2fJZpuwV90oUv9dK9GQgVxYv3hALmHb1/bkZv3oqviN2L/DbNhr/fjXAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745419; c=relaxed/simple;
	bh=+89dKN4d5aRf3aFHH3X58aSJ7RXf3wwnCnvhVI/4yCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAhHxOrhnq3kP8t1CsR6YbOIVvVTOhfkxSwOOgaLhS6ElS1dbeU1tMRhiH8xHdOmjpF3LflgJUPvDGRME5cfDdKj4Tmk8Sg0Uxkhs/FoMmAqfDq5PUSKH7wixh5OjGQ0R6mJGCZlKyRfg1OOAO4u9Bj/ojyZwUusKY5+7rRE3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JpoSK834; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JpoSK834"
X-UUID: 88891bbe767a11efb66947d174671e26-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oyX6ix+Ca+kuBSd2zaDcetxDLf8fGfj/eEE4RWU8lsQ=;
	b=JpoSK834JdxhsMfYUVK1hDaZCq9YE9044w41Yle4h+LdHzSZKymPykj3vRiV6sdKKCTI6a2M9wG4FdtbtC0miLERvDSZvB+DrqjcwApRRTVJ8A19FvchOE0OFsjr7+o27ewfgwElCnbx9byDn8Bpn6g/ksHWagblqNHn+IhcXzo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2e4d5e19-085a-49ed-8291-229231b2e562,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:87ee71d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 88891bbe767a11efb66947d174671e26-20240919
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 656702091; Thu, 19 Sep 2024 19:30:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 04:30:10 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Sep 2024 19:30:10 +0800
From: Qun-Wei Lin <qun-wei.lin@mediatek.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryan Roberts
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, David
 Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Dan
 Schatzberg <schatzberg.dan@gmail.com>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-block@vger.kernel.org>, Casper Li <casper.li@mediatek.com>, Chinwen
 Chang <chinwen.chang@mediatek.com>, Andrew Yang <andrew.yang@mediatek.com>,
	John Hsu <john.hsu@mediatek.com>, <wsd_upstream@mediatek.com>, Qun-Wei Lin
	<qun-wei.lin@mediatek.com>
Subject: [PATCH 1/2] block: add BLK_FEAT_READ_SYNCHRONOUS feature for synchronous read
Date: Thu, 19 Sep 2024 19:29:51 +0800
Message-ID: <20240919112952.981-2-qun-wei.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240919112952.981-1-qun-wei.lin@mediatek.com>
References: <20240919112952.981-1-qun-wei.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

This commit introduces a new feature flag, BLK_FEAT_READ_SYNCHRONOUS,
which ensures that read operations always complete in the submit context.
This is useful for scenarios where synchronous read operations are required
while allowing write operations to remain asynchronous.

This patch is preparation for optimizing of the operation of the swap
device with next patch.

Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
---
 include/linux/blkdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 643c9020a35a..a697db11d91c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -332,6 +332,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
 	((__force blk_features_t)(1u << 15))
 
+/* read operations always completes in submit context */
+#define BLK_FEAT_READ_SYNCHRONOUS	((__force blk_features_t)(1u << 16))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
@@ -1310,6 +1313,11 @@ static inline bool bdev_synchronous(struct block_device *bdev)
 	return bdev->bd_disk->queue->limits.features & BLK_FEAT_SYNCHRONOUS;
 }
 
+static inline bool bdev_read_synchronous(struct block_device *bdev)
+{
+	return bdev->bd_disk->queue->limits.features & BLK_FEAT_READ_SYNCHRONOUS;
+}
+
 static inline bool bdev_stable_writes(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.45.2

