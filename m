Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846623568F4;
	Wed, 27 Aug 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300373; cv=none; b=mL1EWMYO2y9ETApgn6fUT8b9i8OMypyhQIQYP6N02ZRFEAm0KGR9ktmgRHs2S9sR6DzhFoDnqtDW9/vOIvhJvwo1nq00n83v+hLS2F2156rEsu3IOGRiNPuPS3tbLcMbKS3UyfGntVevTXyvy1DgdK0BTjFqcrCTDZGVCMcrF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300373; c=relaxed/simple;
	bh=+uv436ZvhvjOixHkoNDPdMJI97DOGCQz1dNzxx4mvXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR8xLEZ6LECSWDFdyPbTrH+d+uJEtcf1mmJnbEk/oxjoRZhP8zr3AdPBVfxNdb0QDoRR1MsFb0AkWxGg5Q4zclOabIwWa6YguNaxbsF5Q4DY/9UrQ6sxgjdom7iSGvSwsnQqEmyCsSA8FJAq7RqViD3yvE391zYFNt7whDaUMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82c61d1e834711f0b29709d653e92f7d-20250827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5482d7ce-db50-4d91-b0a5-567abaf46e3a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:6b8b5b57a0f5a140a5af0f0d041c62fe,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 82c61d1e834711f0b29709d653e92f7d-20250827
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 77905796; Wed, 27 Aug 2025 21:12:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 94D14E008FAA;
	Wed, 27 Aug 2025 21:12:40 +0800 (CST)
X-ns-mid: postfix-68AF0448-3679222
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 90FDDE008FA3;
	Wed, 27 Aug 2025 21:12:38 +0800 (CST)
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
Subject: [PATCH v3] block: mtip32xx: Remove excess code in mtip_pci_probe
Date: Wed, 27 Aug 2025 21:12:27 +0800
Message-ID: <20250827131228.2826678-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the error exit function of the iomap_err in mtip_pci_probe,
pci_set_drvdata(pdev, NULL) and return can be removed without
affecting the code execution

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
index 8fc7761397bd..2c33c1dfc39d 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3840,8 +3840,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
=20
 iomap_err:
 	kfree(dd);
-	pci_set_drvdata(pdev, NULL);
-	return rv;
 done:
 	return rv;
 }
--=20
2.47.1

