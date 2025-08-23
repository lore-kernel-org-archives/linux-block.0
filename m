Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EF135A53;
	Sat, 23 Aug 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755937978; cv=none; b=cLzgPUw1huvC0w479XfZuy/tPmkcCNmUcEmJIleCvAX/3WQKn7QWn2zogpLafF0lyk31jznA2Re7gtKI9UBEErdmURD8Nvnd7z9U9tvaR9++3j7nsGuW0Z1WIVcBPQFFbiWknqkiieWJyF6Zywe7AmUwVXxQiaBNx09vttyk+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755937978; c=relaxed/simple;
	bh=Ugjn4Lpvu+JzfFVcCIU50/tdQt6nLBDXn6e0GybTKIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RD+z784/JJm/76qC2FDSvy17RqWAmmpdeWQQI4tc5upfdhwOEGiPCbCZf1oihjsmlAI6+FjZoV1e/ta6bpLSgyEBiZDfI18F6s9UvXvCAmFQyQ6M/UrkGEGXayhzGlqt5G9OAXNk2X3dL9B25MB0U5IiijueeZUPvkRT7RkD0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc3d72da7ffb11f0b29709d653e92f7d-20250823
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:25c9ebe4-10e1-4441-b7eb-d4278b7d564a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:ebf846b9e86e1aa2c93147aeafaab428,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bc3d72da7ffb11f0b29709d653e92f7d-20250823
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1940115896; Sat, 23 Aug 2025 16:32:42 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id BC67CE008FA3;
	Sat, 23 Aug 2025 16:32:41 +0800 (CST)
X-ns-mid: postfix-68A97CA9-48109459
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id D38F3E008FA2;
	Sat, 23 Aug 2025 16:32:39 +0800 (CST)
From: Zhang Heng <zhangheng@kylinos.cn>
To: axboe@kernel.dk,
	phasta@kernel.org,
	andriy.shevchenko@linux.intel.com,
	broonie@kernel.org,
	lizetao1@huawei.com,
	viro@zeniv.linux.org.uk,
	fourier.thomas@gmail.com,
	anuj20.g@samsung.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>
Subject: [PATCH v2] block: mtip32xx: Prioritize state cleanup over memory freeing in the mtip_pci_probe error path.
Date: Sat, 23 Aug 2025 16:32:22 +0800
Message-ID: <20250823083222.3137817-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The original sequence kfree(dd); pci_set_drvdata(pdev, NULL); creates a
theoretical race condition window. Between these two calls, the pci_dev
structure retains a dangling pointer to the already-freed device private
data (dd). Any concurrent access to the drvdata (e.g., from an interrupt
handler or an unexpected call to remove) would lead to a use-after-free
kernel oops.

Changes made:
1. `pci_set_drvdata(pdev, NULL);` - First, atomically sever the link
from the pci_dev.
2. `kfree(dd);` - Then, safely free the private memory.

This ensures the kernel state is always consistent before resources
are released, adhering to defensive programming principles.

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 drivers/block/mtip32xx/mtip32xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
index 8fc7761397bd..f228363e6b1c 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3839,9 +3839,8 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	}
=20
 iomap_err:
-	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
-	return rv;
+	kfree(dd);
 done:
 	return rv;
 }
--=20
2.47.1

