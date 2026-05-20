Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A73AF64B
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268362; cv=none; b=Q171AOsXLi2t5Dmmu2iLCCqxfqK4K6g2z/PtLaBeN1jzcC9cRm9eP1Qap543cEMoMXMEggB5RYHts5hvE6878qvxWMSKdlCodzhHgAjevms5n+UxJpeI+s+Ibi51KzSaJxAPiC2K/NamO0DManHXHmQqREYoJ2mPUuejSwfVMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268362; c=relaxed/simple;
	bh=MvpCBtKPSZ6w0M1+uH7kbxa8AV9lizCgS1zkpaGPh30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEGF2eMaPIqRlo83p+rAvikr8QUVsBdULODnKoE1+0qokO4FBrHU8c5DNIrk0mWOiA7i16o+1dXZEKG4rvXZN9QJuSDRwSc61NY+lioZflWlbRp72P+Mj7u5J22jdXqzDNnMegxKnDPUGkQY2ePpZ7vf4O2EfPV2e+aCzgAk6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0acb3978542c11f1aa26b74ffac11d73-20260520
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202605201706+08,HitQuantity:2
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:07200570-9d2d-4351-8746-85dec8651cf5,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-50,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-65
X-CID-INFO: VERSION:1.3.12,REQID:07200570-9d2d-4351-8746-85dec8651cf5,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-50,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,AC
	TION:release,TS:-65
X-CID-META: VersionHash:e7bac3a,CLOUDID:920c002179874b6c021f6793f994dcc1,BulkI
	D:260520170624KO738B3G,BulkQuantity:0,Recheck:0,SF:13|16|19|66|78|102|127|
	307|308|316|324|332|342|344|347|350|351|850|865|898|10047|15047|20030|2500
	0|26021,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_RUA,TF_CID_SPAM_SUA,
	TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0acb3978542c11f1aa26b74ffac11d73-20260520
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1108699617; Wed, 20 May 2026 17:12:36 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH] block: stack zoned resource limits
Date: Wed, 20 May 2026 17:12:37 +0800
Message-Id: <20260520091237.392802-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was found while debugging a zoned NVMe multipath setup, where the
namespace head reported 0/0 for max_open_zones and max_active_zones
while the live path still reported finite limits.

blk_stack_limits() already combines several zoned queue limits, but it
leaves max_open_zones and max_active_zones unchanged. Since 0 means "no
limit" for both values, stacked zoned devices can preserve bogus 0/0
limits even when the underlying queue advertises finite values.

Stack max_open_zones and max_active_zones with min_not_zero(), and
clear them when the resulting queue is not zoned.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 78c83817b9d3..88b6c3703101 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -814,6 +814,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->max_hw_zone_append_sectors = min(t->max_hw_zone_append_sectors,
 					b->max_hw_zone_append_sectors);
+	t->max_open_zones = min_not_zero(t->max_open_zones,
+				       b->max_open_zones);
+	t->max_active_zones = min_not_zero(t->max_active_zones,
+					 b->max_active_zones);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
 					    b->seg_boundary_mask);
@@ -921,6 +925,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->zone_write_granularity = max(t->zone_write_granularity,
 					b->zone_write_granularity);
 	if (!(t->features & BLK_FEAT_ZONED)) {
+		t->max_open_zones = 0;
+		t->max_active_zones = 0;
 		t->zone_write_granularity = 0;
 		t->max_zone_append_sectors = 0;
 	}
-- 
2.25.1

