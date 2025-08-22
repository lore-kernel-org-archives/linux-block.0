Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C823D7DA;
	Fri, 22 Aug 2025 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830493; cv=none; b=TLKyKyzhhdzZroJ8mPlxwRwuJL5eCKZpxxkwCKPQAHpvCn9+6a4Fk6Yjp1RZwqwTT08weDVB+XfLvqZ0OXMqwhPj3mlcqML60GtE+PoR2X/0BuGyPSs6E6Zn+GcwVcEL7tLBUAH4kKJ+ZwL+fgdN753x+6zMYJgJf3hZTVGUkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830493; c=relaxed/simple;
	bh=Amgx2KIYidrt27I99pMPCCxycDM6hsZDLDlsSBav3mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDXrGZnsFmMpy2yqEf2W7jl3Ij+i/BCAoUYiGXhCHMkcWbNcabZFZZ0U6vJPtIw95DYpzETYEaf3GbixXWoUDfiIszuPrMfhuC9Wo6xJENDwgnMK0H4tFyl7ASgG18R25pOeGeBKGlwVWY7kAi/hIY/8lh0dnFUCFf361xEFrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 79bc8ebe7f0111f0b29709d653e92f7d-20250822
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:432c0b1b-219d-41f3-bfc6-a7687221fb09,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:35a45e030f0c8ce03749be5732741d30,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 79bc8ebe7f0111f0b29709d653e92f7d-20250822
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 888365627; Fri, 22 Aug 2025 10:41:16 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id EA912E008FA3;
	Fri, 22 Aug 2025 10:41:15 +0800 (CST)
X-ns-mid: postfix-68A7D8CB-724670333
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8613AE008FA2;
	Fri, 22 Aug 2025 10:41:13 +0800 (CST)
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
Subject: [PATCH] block: mtip32xx: Remove the redundant return
Date: Fri, 22 Aug 2025 10:41:00 +0800
Message-ID: <20250822024100.991144-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove the redundant return

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 drivers/block/mtip32xx/mtip32xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
index 8fc7761397bd..b0c4d1c92da5 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3841,7 +3841,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
-	return rv;
 done:
 	return rv;
 }
--=20
2.47.1

