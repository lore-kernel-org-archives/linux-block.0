Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4457175A9F;
	Thu,  7 May 2026 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778117346; cv=none; b=iucRF9fatGLzDjS+L9HznRA0ECOUwKQSJPrJHcHtpYsFJDAiJ8eD5ZlUQYuo2DVoZTeL8DjXeMD35+jB8Rtlqv0IBxW6LA0vDn1bZK34cZOZrO4Y0FWm7S9o1V2KXi8FynTsDUWFAN2euhbL9Gm6ZH29ZI2eNxN+PE26UDdDfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778117346; c=relaxed/simple;
	bh=zGVDwaGzTTtM4iqEj8gFUZDGWOtL0unAkHTZL2LRrYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owd2uuw0mZgxng20CCJAxX0aWY7PG4CcJ8Wzm8ro3S8IAqpB2MYc5rqiMbLRolMyFV6kgNzhEXCT3ppzTKYp0F4BTS1V3NlMPnE9gd/iXzpcMElg3n+skjmgqN/3AdDhc7gGIoudSsNO0FbkcgNmt9qJVNTUYbcSk2haCkKhZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1cf262e849b411f1aa26b74ffac11d73-20260507
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4e8e331c-712b-466b-9665-40438af11549,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:3afcfde5172380540cc4f2207bc67a04,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1cf262e849b411f1aa26b74ffac11d73-20260507
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 535383488; Thu, 07 May 2026 09:28:55 +0800
From: yanlonglong <yanlonglong@kylinos.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yanlonglong@kylinos.cn,
	yukuai@fnnas.com
Subject: [PATCH v3] block: add NULL checks for bic in bfq_bfqq_save_state function
Date: Thu,  7 May 2026 09:28:26 +0800
Message-ID: <20260507012826.1535-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <9face7b3-d4de-474f-8948-d8efde02bfc8@kernel.dk>
References: <9face7b3-d4de-474f-8948-d8efde02bfc8@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the `bic` variable is null, referencing `bfqq_data` through `bic` will
cause the program to crash. Therefore, the null check for `bic` should be
moved to the beginning of the function to prevent referencing a null pointer.

Fixes:fd571df0ac5b("block, bfq: turn bfqq_data into an array in bfq_io_cq")
Signed-off-by: yanlonglong <yanlonglong@kylinos.cn>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 141c602d5e85..c8cf8764d48d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3036,7 +3036,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 {
 	struct bfq_io_cq *bic = bfqq->bic;
 	unsigned int a_idx = bfqq->actuator_idx;
-	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
+	struct bfq_iocq_bfqq_data *bfqq_data = NULL;
 
 	/*
 	 * If !bfqq->bic, the queue is already shared or its requests
@@ -3046,6 +3046,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
+	bfqq_data = &bic->bfqq_data[a_idx];
 	bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
 	bfqq_data->saved_inject_limit =	bfqq->inject_limit;
 	bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
-- 
2.43.0

