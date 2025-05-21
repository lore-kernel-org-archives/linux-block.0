Received: from outbound.pv.icloud.com (p-west1-cluster5-host8-snip4-10.eps.apple.com [57.103.66.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61558DDA9
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830635; cv=none; b=FI5DWPrA06csrzCq0vE1c5V4572kyKiMskxHN7L+OhuW7hBID0258Yx2dVayinzp2e+QuZB/86Tyjs2/WORVl23USJNdIUJR1CK6s6iHdKjOce8kSH3iG69i5CT/PxPuWy99bPb+cGI5mHUCfUhrw2qCuYdvR3rxFtvNqtjcXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830635; c=relaxed/simple;
	bh=o4msJtHuI88NTf6DLepgkkdX2NwMw7G2Zk/h3i7/Dfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5wrlw0xv846ZE5wjxCthAZ4KZAFTZXV5Z9hqWNPGTlGQ68iug3QNL6LXMxkunH0fxjVd+hqFscBS+bbSIDtB6E6IyBwW1rBv/2nPytrxjMzCq1S2d/xs+/qwW8UxUdco+Bca4/oO1LEpJqnQRrZMJeCzjhxG7r32SW+O+gwog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com; spf=pass smtp.mailfrom=ai-sast.com; dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b=XEmufy7Q; arc=none smtp.client-ip=57.103.66.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b="XEmufy7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ai-sast.com; s=sig1;
	bh=bNSiRj1eUkNujppJrKk/bfep76ko79kEheL7OOsgozo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=XEmufy7Q/a2Ih45AYFEaW92KttMjGClhp/VZKHb58L2AUm7EqbJ/vszsn3wmaqTxa
	 UKrW2Z0CDcT4RCFpdOfNen7G/yRTWP5Lzg1shhweTRsxnk3MNy9neyfVWAAPkHX2GH
	 dF1Not/kuRHUB3PkFaUyWy/+ZURdl1oNsVK7EiPRhvjxG64YLyAP+4glRFyu6cab6+
	 BnIncYOnCTFGbD7Daej6JVMtHIe6Tewf0USeEGkqwgCUAmrIHx9Jbad7sBLx/g2w6W
	 c1bcb7edydepj7AfMGyuStgQ51vxSPRuV7lBa99RrVPYZGDw3Oxz0FiYWlIYfeFKFs
	 fPOVgNx1T73gg==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id BC8ED18004F5;
	Wed, 21 May 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id DFF7418001E9;
	Wed, 21 May 2025 12:30:27 +0000 (UTC)
From: Ye Chey <yechey@ai-sast.com>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: Ye Chey <yechey@ai-sast.com>
Subject: [PATCH] pktcdvd: fix missing bio_alloc_clone NULL check in pkt_make_request_read
Date: Wed, 21 May 2025 20:30:19 +0800
Message-ID: <20250521123019.25282-1-yechey@ai-sast.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8DGf7W4gqjfAqwLep_wGnKGvjMjKEKcM
X-Proofpoint-GUID: 8DGf7W4gqjfAqwLep_wGnKGvjMjKEKcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1030
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505210121

The bio_alloc_clone() call in pkt_make_request_read() lacks NULL check,
which could lead to NULL pointer dereference. Add NULL check and handle
allocation failure by calling bio_io_error().

Signed-off-by: Ye Chey <yechey@ai-sast.com>
---
 drivers/block/pktcdvd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 65b96c083..68d1f43a7 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2323,6 +2323,10 @@ static void pkt_make_request_read(struct pktcdvd_device *pd, struct bio *bio)
 {
 	struct bio *cloned_bio = bio_alloc_clone(file_bdev(pd->bdev_file), bio,
 		GFP_NOIO, &pkt_bio_set);
+	if (!cloned_bio) {
+		bio_io_error(bio);
+		return;
+	}
 	struct packet_stacked_data *psd = mempool_alloc(&psd_pool, GFP_NOIO);
 
 	psd->pd = pd;
-- 
2.44.0

