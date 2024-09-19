Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F719C57B;
	Thu, 19 Sep 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745420; cv=none; b=sdZomHUwvcz20K9sm9eqML0h5SMyYzprgvV5Q76+KteVbfweyHMguMu0xX+NksXjUGdyosdKDJJ64W679N10bMWWrANd1r8ffi8Fl9KUWO0QPxMgmqdW5vLX7TOwCwlh4ZcHUW3nvOAub4hR+RKXomIR2bDr+Esn3Eb7ai7loqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745420; c=relaxed/simple;
	bh=J1GEz64zOAykYyU2Ze0gwkYqGXSiOeUoc/zpNCbTw14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFlzVzBtpcXyemTRtufqQdV92JbC+3WRN4Y4Vo0GolVV681R94HaTAjk008u8Whs0QSOI0xNbIkcdRjr3MEuKxJ8eRm/YNP0edlPMv4ee1fCLtxrIrco9YOSOsWhdMKUEmXDi3MNTk/7Py7q0m778XkQDG1DUyMp0JXYCShrbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H+UYOB/j; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H+UYOB/j"
X-UUID: 88ab4856767a11efb66947d174671e26-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Z1SfHddMinVKqBnBm88AjNHZXXoOonLGMKU9hBryUwg=;
	b=H+UYOB/jxS26nMcyuJNX2vQjHqqwM6HxZ5BlhzQRcFpBxpne/WVLeOzAqB170VtJyLlanVhtUyyqOgZHg/xJu5+9PD4F8Zv6VmCpWAAhHXOe/6I5x7uLDIr+HgbSEqQx9SWSgLGe/vQwfex726o+bnECzCrwiUeEFDDQTmPucCk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7db61870-6a3c-4165-856e-308dc4b2799e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:89ee71d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 88ab4856767a11efb66947d174671e26-20240919
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2091604281; Thu, 19 Sep 2024 19:30:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 19:30:10 +0800
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
Subject: [PATCH 2/2] mm, swap: introduce SWP_READ_SYNCHRONOUS_IO
Date: Thu, 19 Sep 2024 19:29:52 +0800
Message-ID: <20240919112952.981-3-qun-wei.lin@mediatek.com>
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

The existing SWP_SYNCHRONOUS_IO flag is not enough for certain swap
devices that support synchronous read operations but asynchronous write
operations, so we need to introduce a new flag SWP_READ_SYNCHRONOUS_IO.

Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
---
 include/linux/swap.h | 31 ++++++++++++++++---------------
 mm/memory.c          |  3 ++-
 mm/page_io.c         |  2 +-
 mm/swapfile.c        |  3 +++
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ba7ea95d1c57..f595050f431b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -205,21 +205,22 @@ struct swap_extent {
 	  offsetof(union swap_header, info.badpages)) / sizeof(int))
 
 enum {
-	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
-	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
-	SWP_DISCARDABLE = (1 << 2),	/* blkdev support discard */
-	SWP_DISCARDING	= (1 << 3),	/* now discarding a free cluster */
-	SWP_SOLIDSTATE	= (1 << 4),	/* blkdev seeks are cheap */
-	SWP_CONTINUED	= (1 << 5),	/* swap_map has count continuation */
-	SWP_BLKDEV	= (1 << 6),	/* its a block device */
-	SWP_ACTIVATED	= (1 << 7),	/* set after swap_activate success */
-	SWP_FS_OPS	= (1 << 8),	/* swapfile operations go through fs */
-	SWP_AREA_DISCARD = (1 << 9),	/* single-time swap area discards */
-	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
-	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
-	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
-					/* add others here before... */
-	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
+	SWP_USED	= (1 << 0),		/* is slot in swap_info[] used? */
+	SWP_WRITEOK	= (1 << 1),		/* ok to write to this swap?	*/
+	SWP_DISCARDABLE = (1 << 2),		/* blkdev support discard */
+	SWP_DISCARDING	= (1 << 3),		/* now discarding a free cluster */
+	SWP_SOLIDSTATE	= (1 << 4),		/* blkdev seeks are cheap */
+	SWP_CONTINUED	= (1 << 5),		/* swap_map has count continuation */
+	SWP_BLKDEV	= (1 << 6),		/* its a block device */
+	SWP_ACTIVATED	= (1 << 7),		/* set after swap_activate success */
+	SWP_FS_OPS	= (1 << 8),		/* swapfile operations go through fs */
+	SWP_AREA_DISCARD = (1 << 9),		/* single-time swap area discards */
+	SWP_PAGE_DISCARD = (1 << 10),		/* freed swap page-cluster discards */
+	SWP_STABLE_WRITES = (1 << 11),		/* no overwrite PG_writeback pages */
+	SWP_SYNCHRONOUS_IO = (1 << 12),		/* synchronous IO is efficient */
+	SWP_READ_SYNCHRONOUS_IO = (1 << 13),	/* synchronous IO is efficient */
+						/* add others here before... */
+	SWP_SCANNING	= (1 << 14),		/* refcount in scan_swap_map */
 };
 
 #define SWAP_CLUSTER_MAX 32UL
diff --git a/mm/memory.c b/mm/memory.c
index ebfc9768f801..f531a6bfea5b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4089,7 +4089,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
+		if ((data_race(si->flags & (SWP_SYNCHRONOUS_IO |
+		    SWP_READ_SYNCHRONOUS_IO))) &&
 		    __swap_count(entry) == 1) {
 			/*
 			 * Prevent parallel swapin from proceeding with
diff --git a/mm/page_io.c b/mm/page_io.c
index ff8c99ee3af7..98a00709e98c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -499,7 +499,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
-	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
+	bool synchronous = sis->flags & (SWP_SYNCHRONOUS_IO | SWP_READ_SYNCHRONOUS_IO);
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 38bdc439651a..7b8feb235aab 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3177,6 +3177,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (p->bdev && bdev_synchronous(p->bdev))
 		p->flags |= SWP_SYNCHRONOUS_IO;
 
+	if (p->bdev && bdev_read_synchronous(p->bdev))
+		p->flags |= SWP_READ_SYNCHRONOUS_IO;
+
 	if (p->bdev && bdev_nonrot(p->bdev)) {
 		int cpu, i;
 		unsigned long ci, nr_cluster;
-- 
2.45.2

