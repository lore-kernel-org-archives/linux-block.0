Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E611405C4F
	for <linux-block@vger.kernel.org>; Sat, 16 May 2026 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778906896; cv=none; b=QnZE44sLCKp4VZAzC705qpyeaTUD6aQjTEQLLHW6Xzi55j0lDGxfrCEx3RfkYBx3/SDURsFHMNTC2/elAGUcx474k8DMK6//vOj54SIPdcFhZvZPs+UlbrM2BCE8EWdbVH39GkFwjbhSazfJKjQ4La0u0EWLAq6js6KGjMzjTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778906896; c=relaxed/simple;
	bh=eY0/sy/AHteXjScDdO83m4EgMYav4lYwsPoRldKl0BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiaqDe27GfBsOfxJyJm5wMXkwjwG+HLjgckYk2pZZNG0nOQgEnpmxV4atKvzWzqH1LTBU0a1IbG/kQ+JYFcP3+0lBXjicBb38B8SKY0xJ46I/ppxgdVcgPeqdOPXOo+tqyNLw1lmgn55NQ2vKseNGn+qFWXY2GcvuV50QmzRePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6cfae58250e211f1aa26b74ffac11d73-20260516
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fcce1643-68c4-4fbb-9ec1-57b82da0d05f,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:21
X-CID-INFO: VERSION:1.3.12,REQID:fcce1643-68c4-4fbb-9ec1-57b82da0d05f,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:21
X-CID-META: VersionHash:e7bac3a,CLOUDID:cbbb27f1609db03693983c27b9310d03,BulkI
	D:26051612480526JNQ0ED,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6cfae58250e211f1aa26b74ffac11d73-20260516
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 915564797; Sat, 16 May 2026 12:48:04 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] blk-cgroup-rwstat: add missing DISCARD counter in blkg_rwstat_total()
Date: Sat, 16 May 2026 12:47:52 +0800
Message-ID: <20260516044752.446995-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 636620b66d5d ("blkcg: Track DISCARD statistics and output
them in cgroup io.stat"), blkg_rwstat_add() routes discard IOs into
BLKG_RWSTAT_DISCARD, but blkg_rwstat_total() still only sums READ and
WRITE.  This makes the total inconsistent with the per-type counters
whenever discard IOs are present.

On mixed read/write/discard workloads, the total undercounts the
actual IO activity.  If only discard requests are queued, the total
returns 0 outright.  In BFQ this causes avg_queue_size to be
underestimated and the group to be incorrectly marked empty.

The affected BFQ code paths are all gated by CONFIG_BFQ_CGROUP_DEBUG
and used only for statistics display (bfq.sectors, bfq.avg_queue_size,
bfq.empty_time).  No scheduling decisions depend on these values.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-cgroup-rwstat.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup-rwstat.h b/block/blk-cgroup-rwstat.h
index 703a16fe1404..b7908d877e2b 100644
--- a/block/blk-cgroup-rwstat.h
+++ b/block/blk-cgroup-rwstat.h
@@ -110,7 +110,8 @@ static inline uint64_t blkg_rwstat_total(struct blkg_rwstat *rwstat)
 	struct blkg_rwstat_sample tmp = { };
 
 	blkg_rwstat_read(rwstat, &tmp);
-	return tmp.cnt[BLKG_RWSTAT_READ] + tmp.cnt[BLKG_RWSTAT_WRITE];
+	return tmp.cnt[BLKG_RWSTAT_READ] + tmp.cnt[BLKG_RWSTAT_WRITE] +
+	       tmp.cnt[BLKG_RWSTAT_DISCARD];
 }
 
 /**
-- 
2.43.0

