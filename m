Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355D476CD3
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307192; cv=none; b=nF9myMJw/wJc/mfGx3IgALpzR5+lQtbKl49afYT9UV9rkBb6igVAWfDLUPTPPJ29QU4FF2XenfegIC1CDRYNGtzEkZLJoTO6CcEDXdoyJmK5Hmlnf73+BP1CDLBBdFMf6qIp8BlW8Cqgffyqjtwr3f2hLenBRDIEgXqOnTejT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307192; c=relaxed/simple;
	bh=t2L7W8tOl4NoBqg2nMgutpWkUKj1RwGdhNTfpZAPX2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7UqS9j/tJ9wS4XqI3qlvRk+R/u/vwJzS9G4d7D9Rm6XIYlzFMiI1h1ImoQRp4/9WSeeRI+hgBZJwiEnz2Zb+Kzs37xRJ/yRJ3jzbdLrofz8Vay+1M0sxhDw2G4nGfkrPtNO+bLynHoH8vJXC2dpRsr9+MI6ZX+WFV+/TADcvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ded58aba9d4811f19a56ed5b684f684d-20260821
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:32119a8a-272c-4da0-ab41-31aefa5e52e4,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:32119a8a-272c-4da0-ab41-31aefa5e52e4,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:1cf5d50f4d202c183102c635821d49ec,BulkI
	D:2608211812559TCYB9ES,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ded58aba9d4811f19a56ed5b684f684d-20260821
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1910751995; Fri, 21 Aug 2026 18:12:52 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3 4/5] block: factor atomic write hardware limit stacking
Date: Fri, 21 Aug 2026 18:10:49 +0800
Message-Id: <20260821101050.1464087-5-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821101050.1464087-1-sangyao@kylinos.cn>
References: <20260821101050.1464087-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_stack_atomic_writes_limits() stacks atomic write hardware limits and
checks whether @start meets the bottom-device alignment. Only the start
check depends on the top-to-bottom mapping.

Factor hardware limit stacking into blk_stack_atomic_writes_hw_limits()
so same-LBA multipath can stack atomic write limits without checking a
mapped start sector.

There is no behavior change for existing callers.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f1a2e4fe4e77..eaba38370657 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -653,6 +653,14 @@ static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lb
 	return sectors;
 }
 
+static void blk_clear_atomic_write_limits(struct queue_limits *lim)
+{
+	lim->atomic_write_hw_max = 0;
+	lim->atomic_write_hw_unit_max = 0;
+	lim->atomic_write_hw_unit_min = 0;
+	lim->atomic_write_hw_boundary = 0;
+}
+
 /* Check if second and later bottom devices are compliant */
 static bool blk_stack_atomic_writes_tail(struct queue_limits *t,
 				struct queue_limits *b)
@@ -726,8 +734,8 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 	return true;
 }
 
-static void blk_stack_atomic_writes_limits(struct queue_limits *t,
-				struct queue_limits *b, sector_t start)
+static bool blk_stack_atomic_writes_hw_limits(struct queue_limits *t,
+				struct queue_limits *b)
 {
 	if (!(b->features & BLK_FEAT_ATOMIC_WRITES))
 		goto unsupported;
@@ -735,9 +743,6 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	if (!b->atomic_write_hw_unit_min)
 		goto unsupported;
 
-	if (!blk_atomic_write_start_sect_aligned(start, b))
-		goto unsupported;
-
 	/* UINT_MAX indicates no stacking of bottom devices yet */
 	if (t->atomic_write_hw_max == UINT_MAX) {
 		if (!blk_stack_atomic_writes_head(t, b))
@@ -747,13 +752,19 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 			goto unsupported;
 	}
 	blk_stack_atomic_writes_chunk_sectors(t);
-	return;
+	return true;
 
 unsupported:
-	t->atomic_write_hw_max = 0;
-	t->atomic_write_hw_unit_max = 0;
-	t->atomic_write_hw_unit_min = 0;
-	t->atomic_write_hw_boundary = 0;
+	blk_clear_atomic_write_limits(t);
+	return false;
+}
+
+static void blk_stack_atomic_writes_limits(struct queue_limits *t,
+				struct queue_limits *b, sector_t start)
+{
+	if (blk_stack_atomic_writes_hw_limits(t, b) &&
+	    !blk_atomic_write_start_sect_aligned(start, b))
+		blk_clear_atomic_write_limits(t);
 }
 
 #define STACK_MIN_NOT_ZERO(t, b, field) \
-- 
2.25.1
