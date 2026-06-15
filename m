Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5440855
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518559; cv=none; b=KqJvj+XeC2EHU+GA4oTI1dT5CLM49x0NU8F/tbkwmoXxI9NFrPsPGQ7reWJgOk4GbGmJWZaZWzYqDujAmO/thYD466TUM+Ol92i5R8GVlQ3dFnQFOHRp8OMZi1hJpwfLe5G+faedJWZxOSPE4GqDqawZ12Wzk3OpmfrS0Lbqgy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518559; c=relaxed/simple;
	bh=NpsdyRmK3L8M0XC046O1IxlMJfcISnJG/M5eT8pjs3c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qJCW5rAEILKI9oOP+b3HePckj6PLgKohFMz0fLUAxlIQaNQQCVi1Xxt248RB84MsI6S2bzpcmU2VsCEOeCShrt6yW5NI3n+XgEcBthgABI5sv4SBmc5UArkF/Wa7rRC0nSqcFbiJjaf1AlAAPMQoxZXGsPq4sHcDyv1VqwEMCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2ed4743468a311f1aa26b74ffac11d73-20260615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fbc60c4a-90f5-45b1-ab59-a4ecef250638,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:9b942d939dfe923db547b91326ff20a1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ed4743468a311f1aa26b74ffac11d73-20260615
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 772248616; Mon, 15 Jun 2026 18:15:49 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: [PATCH] block: genhd: Add NULL check for kobject_create_and_add in genhd_device_init
Date: Mon, 15 Jun 2026 18:15:41 +0800
Message-Id: <20260615101541.1094509-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kobject_create_and_add() call in genhd_device_init() may return NULL
if memory allocation fails, but the return value was not being checked.
This could lead to NULL pointer dereferences in subsequent calls to
sysfs_create_link() and sysfs_remove_link() which use block_depr.

Add proper error checking and cleanup path to handle the case when
kobject_create_and_add() fails.

Fixes: 721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED
	and CONFIG_SYSFS_DEPRECATED_V2")
Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 block/genhd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 7d4ee5972338..60569d59cd53 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1005,7 +1005,15 @@ static int __init genhd_device_init(void)
 
 	/* create top-level block dir */
 	block_depr = kobject_create_and_add("block", NULL);
+	if (!block_depr) {
+		error = -ENOMEM;
+		goto out_class_unregister;
+	}
 	return 0;
+
+out_class_unregister:
+	class_unregister(&block_class);
+	return error;
 }
 
 subsys_initcall(genhd_device_init);
-- 
2.25.1

