Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0B7478
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656530; cv=none; b=HlBHF/nLQrkALiusFcTXH/4SLMbQO5J8MBTMHBMvHFqFr0hU8WSgKFeyWQpxfn1GNltH0WdBN2akSr5SmlN5sBohIk9twJZwmQj0RSeA6FHE6SaKxKWHLrNwN6lu17BUMYWhzZgtxjlp2Q96DrlONDUAaqSP9QxNMg8QvPLjPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656530; c=relaxed/simple;
	bh=kTYuc0X343NJGf7lEugys80W3RDAC04i0CfvF7RJaJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgNwOi648bZ/0o5osLCFmOQJT1n2oHoeu1/NrmtTeg2cSfYOgC2o5fsmIKMpTdnnpCn3l2jQ4l9tCRe7gO8Us6pw7vZ0UO7O6Q/1M9bHGLrwqn4gb0R8yHQJmuExIr4odWctWuhWhU/jZvkFEDcaPDiV4I7ZfDNWLLKCB6wtpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izvH3ZYl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izvH3ZYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769656527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6r16hbl+WUJssToK2ctu51W9MhcPgmPcbvBTdJOpGgQ=;
	b=izvH3ZYl/euwikk/Ta8JGghf1+y7KDbfS6KwtVJdx08z0KwadLAQrkGCbbHUGFNdj4uHzf
	HNz3hlUK1EkM5m9kfVibMwaIu31Ge9P5uGvQ0YnPv599CPS9E82pim4lfudoYpO9onFqFF
	LYI19pvigkrF+kpfcxg2i7SY57L0xc0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-0PmFpnQYP7uEOBtsCg_d3A-1; Wed,
 28 Jan 2026 22:15:23 -0500
X-MC-Unique: 0PmFpnQYP7uEOBtsCg_d3A-1
X-Mimecast-MFC-AGG-ID: 0PmFpnQYP7uEOBtsCg_d3A_1769656522
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B2631955D84;
	Thu, 29 Jan 2026 03:15:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A48B1800285;
	Thu, 29 Jan 2026 03:15:20 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH 2/5] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
Date: Thu, 29 Jan 2026 11:14:56 +0800
Message-ID: <20260129031501.3403688-3-ming.lei@redhat.com>
In-Reply-To: <20260129031501.3403688-1-ming.lei@redhat.com>
References: <20260129031501.3403688-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppress
automatic partition scanning when starting a ublk device.

This is useful for some cases in which use don't want to scan
partitions.

Users still can manually trigger partition scanning later when appropriate
using standard tools (e.g., partprobe, blockdev --rereadpt).

Reported-by: Yoav Cohen <yoav@nvidia.com>
Link: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 7 ++++++-
 include/uapi/linux/ublk_cmd.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 94470a2ec05e..0b98ab0f8257 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -80,7 +80,8 @@
 		| UBLK_F_BUF_REG_OFF_DAEMON \
 		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
 		| UBLK_F_SAFE_STOP_DEV \
-		| UBLK_F_BATCH_IO)
+		| UBLK_F_BATCH_IO \
+		| UBLK_F_NO_AUTO_PART_SCAN)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -2364,6 +2365,10 @@ static void ublk_partition_scan_work(struct work_struct *work)
 					     &disk->state)))
 		goto out;
 
+	/* Skip partition scan if disabled by user */
+	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN)
+		goto out;
+
 	mutex_lock(&disk->open_mutex);
 	bdev_disk_changed(disk, false);
 	mutex_unlock(&disk->open_mutex);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 743d31491387..a88876756805 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -367,6 +367,9 @@
  */
 #define UBLK_F_SAFE_STOP_DEV	(1ULL << 17)
 
+/* Disable automatic partition scanning when device is started */
+#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.47.0

