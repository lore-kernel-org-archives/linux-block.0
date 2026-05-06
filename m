Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7742EAD15;
	Wed,  6 May 2026 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778047093; cv=none; b=ASRJo8sDpcroeBvG3HwrELfRzAXxaBbB0NQYrtvOXj/EW5revhv//BEltE83IUcuqwbhJ5QF+UQLMEOs33Hi6C/hPgdR8D/HnlWvNbTvOlk8Gr61njJA4Zy/ogfHVEoMep2zkthBCuxfkjps8D7K1qukccaIUV8izTlMXZXEwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778047093; c=relaxed/simple;
	bh=SJUbqtZNZz2pBYu/cIwv77mVnQorYqUdiS2mm9Im2hY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CQm1RSxAAAmBcWKPuRacwwo4iqOahOJtMl9RB5iAJNpPQ8cDtyK+CheCPB/+TjHFgqi7drVixQHrz3hkd+xJca2sphln1x9XNjqbPOOwZBRHc7xytHEDUQkuU/rkdHK3KDx+VpD16tlzNAUVuOme7DLPBKhQjjR8N9kPZup13Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 855d1bd8491011f1aa26b74ffac11d73-20260506
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0ce67127-95b3-4c80-9b09-030f2e2b656b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.12,REQID:0ce67127-95b3-4c80-9b09-030f2e2b656b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:3308ae2ac72b6d80ec9ead5bd9e668d7,BulkI
	D:260506135756MUKKROK6,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 855d1bd8491011f1aa26b74ffac11d73-20260506
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 226104818; Wed, 06 May 2026 13:57:53 +0800
From: yanlonglong <yanlonglong@kylinos.cn>
To: yukuai@fnnas.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yanlonglong <yanlonglong@kylinos.cn>
Subject: [PATCH] block: bic maybe null pointer dereference
Date: Wed,  6 May 2026 13:56:55 +0800
Message-Id: <20260506055655.32276-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: yanlonglong <yanlonglong@kylinos.cn>
---
 block/bfq-iosched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 141c602d5e85..27ef736085b1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3035,9 +3035,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 {
 	struct bfq_io_cq *bic = bfqq->bic;
-	unsigned int a_idx = bfqq->actuator_idx;
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
-
 	/*
 	 * If !bfqq->bic, the queue is already shared or its requests
 	 * have already been redirected to a shared queue; both idle window
@@ -3046,6 +3043,9 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
+	unsigned int a_idx = bfqq->actuator_idx;
+	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
+
 	bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
 	bfqq_data->saved_inject_limit =	bfqq->inject_limit;
 	bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
-- 
2.43.0

