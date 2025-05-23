Received: from outbound.pv.icloud.com (p-west1-cluster1-host5-snip4-4.eps.apple.com [57.103.64.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2591A01C6
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990585; cv=none; b=Ey2nFZyrbhWMbcZOp9CkcLqpcVlpQNpXAUobYA4qZEkI1UUuio4jEQswkzEWa2YKnne2mcbwbPqPAeWVSkcqbdeQVlZ/V0iaeO7Pb1vDXOuttOQeS8HH8ozqpcZo34LtQlOz4c2eJYyaMaF+CEPcARebPma/ciM0y7h++pbbYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990585; c=relaxed/simple;
	bh=1iTWbYs077VKyvs3vZv19qAfY6J3LzqMV+LLxQJYbag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1J2HlwibATazgitTvs2bbZ/ikBzIBeLhn2dUx1z7n6NGiNnrmDuhppRKlRp3+29I2NOrjXsAJspWyw7Wxxq2q/BT/clpaRhIWX1H489tnWEqysze79VrCA8UN4edEihXu7AghoCJpP2M4pmiSlKAvZ5/ONMa5H9Z6nNQxFsKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com; spf=pass smtp.mailfrom=ai-sast.com; dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b=D09E9oQj; arc=none smtp.client-ip=57.103.64.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b="D09E9oQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ai-sast.com; s=sig1;
	bh=BykeWOFG8Ty7ohO6Jd2gflf8OkLQ78fEPhw+xt4LCjE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=D09E9oQjj2/ot+d5WMgfQJb7ft36rJTXB2iRCzuZL51TYto/Z+c/N0+RPyk9odiKa
	 50gbdu8v8ulFh/uRvQ+/qEUJwHU/urW7Edixgro8fA7Hc7JavVa011EsZi1KYN2sEl
	 GpeDstRQz4HmkSWPbtEZgJZYfPMjzNJnZsRYRlhWlzyULgaoC0XM1vVdLTw258se3r
	 18myxUPSbxSDGnYWWgXSHQpCcEOg6muxlYrLHO4mzEP4FQknqwgGPltYl/jE3N2ckq
	 KNKrzMfYT+5EcvSN0B19IBPA6mVZAsKVs/oQZL9zACK0+MQK1FVxO9QtZAeAlx2M3B
	 841FR6tsSZBfA==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 1B1151801EE2;
	Fri, 23 May 2025 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 50FDA1801EC1;
	Fri, 23 May 2025 08:56:17 +0000 (UTC)
From: Ye Chey <yechey@ai-sast.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ye Chey <yechey@ai-sast.com>
Subject: [PATCH] drbd: fix potential NULL pointer dereference in drbd_md_sync_page_io
Date: Fri, 23 May 2025 16:55:29 +0800
Message-ID: <20250523085529.85368-1-yechey@ai-sast.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AyTumcuuQawnp_KXmgcN_gJ6zBcgBl3o
X-Proofpoint-GUID: AyTumcuuQawnp_KXmgcN_gJ6zBcgBl3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1030 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505230079

Under memory pressure, bio_alloc_bioset() may fail and return NULL. Add a
check to handle this case gracefully by returning -ENOMEM instead of
dereferencing a NULL pointer.

Signed-off-by: Ye Chey <yechey@ai-sast.com>
---
 drivers/block/drbd/drbd_actlog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 742b2908f..68b925b49 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -141,6 +141,10 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 
 	bio = bio_alloc_bioset(bdev->md_bdev, 1, op | op_flags, GFP_NOIO,
 			       &drbd_md_io_bio_set);
+	if (!bio) {
+		err = -ENOMEM;
+		goto out;
+	}
 	bio->bi_iter.bi_sector = sector;
 	err = -EIO;
 	if (bio_add_page(bio, device->md_io.page, size, 0) != size)
-- 
2.44.0

