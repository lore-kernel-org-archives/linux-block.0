Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0B18BC1D;
	Sun, 16 Feb 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739717062; cv=none; b=IYUN+8bvEC23qvNkGo565GczPFRaq3NokQSJdXfuJ+GsLtpM84G4IwdMPqGEmu404G69D37gWWEhiZ1nXHkzxTJIifg+Kioh/RyBye1g0dAzFdEtBOv10bj0oq+m8rR02a2wTt14YfMHVN18pId6zwu/aCMQEHHK+pUkxDqFvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739717062; c=relaxed/simple;
	bh=eEXisePiItVInqXP8r8mz0G1g91CunOEy+VSQmiT/sw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K0rPXsZ/pXIeNFe1BAboPpBOoqTyYeOOb7mjzbQ+yCsDVKOeIGbl8QHXjezR0W5A1uVu0Ntbi7+WSMjfSPoBzojB/UY/Ueg7sbG2wYI3DNbYldyJsLE+teq3XcxBJelOHXW2hP27oG+sWCF8slbiZx2Bl8Kz1Eb+mBHuGxqT1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GHS+PHwD; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GHS+PHwD"
X-UUID: 7a31ec88ec7411ef8eb9c36241bbb6fb-20250216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=k/dEYJoO4Qk0W2/aYoTFiGpV/VHj1MHfhfjKfCBVoWg=;
	b=GHS+PHwDdBkVw5ixuvT5jV7YqGuYx+/Y6VBHs2HaZ6d6CMolbwLE9Fx7nNyIM9+cGTDSbklVU5y9z/wr5siYOBozK+7MwxcvXDYAwAAdVENzIt4e7d4V/3Qjz+dADfR1mGhF2Yt3aD2u56DQ6lUEDs8q6yHiGbsoMNKSSI6YYzA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:f77fecc7-e59b-4c26-a5ba-d6462e77df15,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:b711d524-96bd-4ac5-8f2e-15aa1ef9defa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a31ec88ec7411ef8eb9c36241bbb6fb-20250216
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 574062639; Sun, 16 Feb 2025 22:44:08 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 16 Feb 2025 22:44:06 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sun, 16 Feb 2025 22:44:06 +0800
From: <ed.tsai@mediatek.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<chun-hung.wu@mediatek.com>, Ed Tsai <ed.tsai@mediatek.com>,
	<dm-devel@lists.linux.dev>
Subject: [PATCH 1/1] dm: Enable inline crypto passthrough for striped target
Date: Sun, 16 Feb 2025 22:42:21 +0800
Message-ID: <20250216144224.1702385-2-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ed Tsai <ed.tsai@mediatek.com>

Added DM_TARGET_PASSES_CRYPTO feature to the striped target to utilize
the hardware encryption of the underlying storage devices, preventing
fallback to the crypto API.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 drivers/md/dm-stripe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 3786ac67cefe..a1b7535c508a 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -467,7 +467,7 @@ static struct target_type stripe_target = {
 	.name   = "striped",
 	.version = {1, 7, 0},
 	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
-		    DM_TARGET_ATOMIC_WRITES,
+		    DM_TARGET_ATOMIC_WRITES | DM_TARGET_PASSES_CRYPTO,
 	.module = THIS_MODULE,
 	.ctr    = stripe_ctr,
 	.dtr    = stripe_dtr,
-- 
2.45.2

