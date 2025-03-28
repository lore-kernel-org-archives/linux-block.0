Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADF20E6E1;
	Fri, 28 Mar 2025 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131652; cv=none; b=ds+/dTg4FGgTMxHtGmzErq0qjHN1KvDP5DkR2PkxKBmcnEmRrJb2EWm41EMtesARK2FKvyu1n/j95CXN0tFx9+L0CCiNVt1GS2bAbpknxaRiSqAXO30VkfD8OhPsdSrxGVTZbix/x39BKXe9xI8HsxC7u6Rsusjzm+WFTDmKPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131652; c=relaxed/simple;
	bh=rBMsWiA2pZBvIaltd4qWK1KWQDxu+ahvA/UoTSUrvkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/xHtuNut42j99ZUGZC/jpj7oiRiXt1pGYyAXiIJbioLeJhMr9WGj92XNIJbR9JZGPkOOMlngznWeRCk0P04QYl1Tq0yBdBz/Mw7H/sklwaNDlaxk7vQUM9TSK65WjXHHbynFc5VAbjWT101lDYYNTpJa8JvIWiXf8brE60woZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ae63a9380b8211f0a216b1d71e6e1362-20250328
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a4d6fad6-2069-46d4-81e5-5d26a6ee981c,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:a4d6fad6-2069-46d4-81e5-5d26a6ee981c,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:53113545733072cdacc7f23f72a854f5,BulkI
	D:25032811135706UIZMSZ,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ae63a9380b8211f0a216b1d71e6e1362-20250328
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1560634430; Fri, 28 Mar 2025 11:13:54 +0800
From: Fanhui Meng <mengfanhui@kylinos.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mengfanhui@kylinos.cn
Subject: [PATCH] block: optimize sq_hctx assignment
Date: Fri, 28 Mar 2025 11:13:21 +0800
Message-Id: <20250328031321.790317-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimizing code for greater standardization.

Signed-off-by: Fanhui Meng <mengfanhui@kylinos.cn>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40490ac88045..182557019832 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2384,10 +2384,9 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
  */
 void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 {
-	struct blk_mq_hw_ctx *hctx, *sq_hctx;
+	struct blk_mq_hw_ctx *hctx, *sq_hctx = NULL;
 	unsigned long i;
 
-	sq_hctx = NULL;
 	if (blk_queue_sq_sched(q))
 		sq_hctx = blk_mq_get_sq_hctx(q);
 	queue_for_each_hw_ctx(q, hctx, i) {
-- 
2.25.1

