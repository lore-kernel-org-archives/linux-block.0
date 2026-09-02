Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B038DC4F;
	Wed,  2 Sep 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331517; cv=none; b=dXnXt21HzL67qQspDYGXDTWEjVeiI6F1zfWMboGpjr0KMpRZk7vKN9p6kao59M40JI8EFAmcupm90nGrVwexL8NJkIt26r10cnVj4MK0+6Pa6QV5I6cRBwf0Tr9GH2jAyxj/jwt97OA9Om5+T3WZBD37HYmIQLGwJ840a0pWJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331517; c=relaxed/simple;
	bh=TNlvMcn2opUIZTn4FXeb0xIoY6Mzbcw6rngdJp2JHmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULF/8unowjxlKbDRUlQFRWFN8Dyb3VguAvXZaGymi23WvnahljdXG9pHhKO+t3930bTFtnl9750cDOnhLZ6jfh3BuR1kC17Drtx5r6ljy8QFYdzwX4F5D6HH6d7osw164LQPiw7ZTMVANu/S8gAgvlYMvHU4p3slgkTZSeK2F44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d3fb30aea69911f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b4c36449-f8cf-410c-9271-750cd821b6bc,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:d6542c26a7db73212b26c141168b5048,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d3fb30aea69911f19a56ed5b684f684d-20260902
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1984752943; Wed, 02 Sep 2026 14:45:04 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: tom.leiming@gmail.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] selftests/ublk: add NULL check after calloc()
Date: Wed,  2 Sep 2026 14:44:36 +0800
Message-ID: <20260902064437.1376-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three calloc() calls in the ublk selftests lack NULL return checks,
leading to potential NULL pointer dereferences on allocation failure:

1. kublk.c ublk_ctrl_init(): the allocated `dev` is dereferenced
   immediately via `info = &dev->dev_info` without checking for NULL.

2. batch.c alloc_batch_commit_buf(): the allocated `t->commit` is
   dereferenced in the following for-loop without checking for NULL.

3. batch.c alloc_batch_fetch_buf(): the allocated `t->fetch` is
   dereferenced in the following for-loop without checking for NULL.

Add NULL checks after each calloc(), returning NULL or -ENOMEM consistent
with existing error handling in the same functions.

Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/testing/selftests/ublk/batch.c  | 4 ++++
 tools/testing/selftests/ublk/kublk.c | 9 +++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index d8d9ebed5979..5dd6bdfaf9c1 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -88,6 +88,8 @@ static int alloc_batch_commit_buf(struct ublk_thread *t)
 	int i, ret, j = 0;
 
 	t->commit = calloc(t->nr_queues, sizeof(*t->commit));
+	if (!t->commit)
+		return -ENOMEM;
 	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++) {
 		if (t->q_map[i])
 			t->commit[j++].q_id = i;
@@ -184,6 +186,8 @@ static int alloc_batch_fetch_buf(struct ublk_thread *t)
 	/* double fetch buffer for each queue */
 	t->nr_fetch_bufs = t->nr_queues * 2;
 	t->fetch = calloc(t->nr_fetch_bufs, sizeof(*t->fetch));
+	if (!t->fetch)
+		return -ENOMEM;
 
 	/* allocate one buffer for each queue */
 	for (i = 0; i < t->nr_fetch_bufs; i++) {
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2400b4615766..f7ddbb4c5582 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -435,9 +435,14 @@ static void ublk_ctrl_deinit(struct ublk_dev *dev)
 static struct ublk_dev *ublk_ctrl_init(void)
 {
 	struct ublk_dev *dev = (struct ublk_dev *)calloc(1, sizeof(*dev));
-	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	struct ublksrv_ctrl_dev_info *info;
 	int ret;
 
+	if (!dev)
+		return NULL;
+
+	info = &dev->dev_info;
+
 	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
 	if (dev->ctrl_fd < 0) {
 		free(dev);
-- 
2.43.0

