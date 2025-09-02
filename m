Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7513C8FF;
	Tue,  2 Sep 2025 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756783977; cv=none; b=EIWO1WQOCjzXoLs+Mn3c/97kGa0xkxXccAfcSNVzq9rgmPmJR7y3bIT8egk9aTu+YPKHtJCKmKR3TqL5GXdxy+8SBILei5fwAvbULCSGqEe8+PJVSTDgu7A61gcGrIN6+QLZNH+Xw7DSakFqq34IqQ3apDR4AFMgjqgsCP/dhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756783977; c=relaxed/simple;
	bh=0AUPVbyZgQ086SwU3pfFF8N2NJhmvSQgXI7v3qTUopg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n827EHbCz78M1vmYdiie0qpXX5uHchk+Ld6dl8V0Z6oHmJLRVHd28hwnrUBo1GJ1OIE8ARr9mdjTKQGKfCeEtMGHFK5Qus/jo2k3y1ktwgZnLK+vKLtDFvMkEvvWUCBBqQ4bsaUVsFo1TDXabJ8AOPY8VKPKgRu6Uqa/KjgWJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7d442f7e87ad11f0b29709d653e92f7d-20250902
X-CID-CACHE: Type:Local,Time:202509021131+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8c61dc62-c0eb-4a70-b755-b5943d52c268,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:d63090f7b8c91a3f8a12057911d3d0dd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7d442f7e87ad11f0b29709d653e92f7d-20250902
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1972323458; Tue, 02 Sep 2025 11:32:44 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id A96D1160038C0;
	Tue,  2 Sep 2025 11:32:44 +0800 (CST)
X-ns-mid: postfix-68B6655B-4298601773
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 2942416001A03;
	Tue,  2 Sep 2025 03:32:42 +0000 (UTC)
From: Longlong Xia <xialonglong@kylinos.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] block: use KMEM_CACHE instead of kmem_cache_create
Date: Tue,  2 Sep 2025 11:32:41 +0800
Message-ID: <20250902033241.1623330-1-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use KMEM_CACHE() instead of kmem_cache_create() to simplify the code.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 block/bio-integrity-auto.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 687952f63bbb..167cdc6f5920 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -203,9 +203,7 @@ void blk_flush_integrity(void)
=20
 static int __init blk_integrity_auto_init(void)
 {
-	bid_slab =3D kmem_cache_create("bio_integrity_data",
-			sizeof(struct bio_integrity_data), 0,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+	bid_slab =3D KMEM_CACHE(bio_integrity_data, SLAB_HWCACHE_ALIGN | SLAB_P=
ANIC);
=20
 	if (mempool_init_slab_pool(&bid_pool, BIO_POOL_SIZE, bid_slab))
 		panic("bio: can't create integrity pool\n");
--=20
2.43.0

