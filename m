Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393CD3D3336
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674805; cv=none; b=qPiv1fYAZoy8eoSJ8PAe9oiy/E1FBaDiCmd6rdEihBqHhjQzu/qsdp1+CLsmHvNa9TA9viTu5c3r8/hb7Xj3OpLFHDcwjyZgU9gDcD//q/6hbINERZRoqVtQ3OKJdxlIeagXi5EYxwt/8bXpIfOY8YA8M765vDqGXElqjD++9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674805; c=relaxed/simple;
	bh=G5t4iLugVufc+u9xJZTyFGJ03+N0qtGJ7AIjPEq46nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5dCDpS6rNPD2m1a4bP3VY9gME9L8DuoimlqZMDmJS8PfSeNAky1UekiOWOMy2cQhO5Clxiz1Llwu7a+dz6vwbBbkkCmy7+dDCejIVGOsuCN6dkhWfchwykXv/Con9ypN0rJCMFiEjw3Ljog4cXghtNlVaXVZQZ71/rUewBtFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7e3b1aaa978811f1aa26b74ffac11d73-20260814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2821c2a8-fb7a-47a8-8994-33a281718ce9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:2821c2a8-fb7a-47a8-8994-33a281718ce9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:360c0210094130894025d291b7c82378,BulkI
	D:260814103313YQ1VNXC0,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7e3b1aaa978811f1aa26b74ffac11d73-20260814
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1173905541; Fri, 14 Aug 2026 10:33:11 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v1 1/3] ublk: reject non-power-of-2 zone sizes in SET_PARAMS
Date: Fri, 14 Aug 2026 10:32:24 +0800
Message-Id: <20260814023226.354288-2-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814023226.354288-1-sangyao@kylinos.cn>
References: <20260814023226.354288-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBLK_F_ZONED uses params.basic.chunk_sectors as zone size. ublk uses
ilog2(chunk_sectors) to get number of zones, so the value must be power
of 2.

If chunk_sectors is 96 and dev_sectors is 96 * 16, userspace asks for
16 zones. But the shift calculation gets 24 zones.

Block layer rejects such zone size when the disk is started. But
SET_PARAMS has already returned success, which is confusing for
userspace. Reject it in SET_PARAMS with other zoned parameter checks.

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 853cd40a3403..193f6ebc3b37 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -980,7 +980,7 @@ static int ublk_validate_params(const struct ublk_device *ub)
 		if (p->max_sectors < PAGE_SECTORS)
 			return -EINVAL;
 
-		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
+		if (ublk_dev_is_zoned(ub) && !is_power_of_2(p->chunk_sectors))
 			return -EINVAL;
 	} else
 		return -EINVAL;
-- 
2.25.1

