Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFE1B424F
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766224436; cv=none; b=lgkdMmsP9Ckct7G6U2EtXo4+7yM+atR2BnQToZGf7pwcnn2nMWljmGPCQPecsUz4145t1i34BXl+z5z/KY6HTdH43pdK47ywlKuwBW+eC51KD0Rl5jABFALdxP5DTjTW6KB7vajdYHTlP9dztdOZF8tLGWXGP3BOmwskE7wHGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766224436; c=relaxed/simple;
	bh=cfGRIvoRFwldOIdoP4UoZl4oq7VxJAjD7tT7H2wj40g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUEA2pp8yPAQnqVAcW7qIMtPMzOZfJ8XpKlWpghIZChmC8gWdI9AkESTmZxo6wdecf50cCcUCx3UYUJgb10kqJn1ZHLbfY3BkNDAQRdA3K/LSCnM3QlQiGWMqPIo4KJ5zslGXT+5KNPz4Bitol9+/r7lJ4klqrCeBFA3SeuAFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ffr1B+3l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffr1B+3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766224432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6yvGnSigmA+pxotnbB3NwXbrMAvGRw8cK7NvycKke0=;
	b=Ffr1B+3lKJH8fPDb5PsLw0ZnQ30PyqgiYKcXjUWrFyaEPVpi9F97Ne0OaejIYaWP05KxMa
	tA4PUDqsh2f2LGpfSuRBvcP/xjJ8g2iBKsNtgHW/impTgBaRv7L5etBQ55U05DrYh6yNa8
	4kNQTG/ZR42IJuq77SDjEXb0fyN+YUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-NqMs3wjbOWSea1a9lLLpSg-1; Sat,
 20 Dec 2025 04:53:47 -0500
X-MC-Unique: NqMs3wjbOWSea1a9lLLpSg-1
X-Mimecast-MFC-AGG-ID: NqMs3wjbOWSea1a9lLLpSg_1766224426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62E441956050;
	Sat, 20 Dec 2025 09:53:46 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D099F30001A2;
	Sat, 20 Dec 2025 09:53:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
Date: Sat, 20 Dec 2025 17:53:21 +0800
Message-ID: <20251220095322.1527664-2-ming.lei@redhat.com>
In-Reply-To: <20251220095322.1527664-1-ming.lei@redhat.com>
References: <20251220095322.1527664-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppress
automatic partition scanning when starting a ublk device.

This is useful for network-backed devices where partition scanning
can cause issues:
- Partition scan triggers synchronous I/O during device startup
- If userspace server crashes during scan, recovery is problematic
- For remotely-managed devices, partition probing may not be needed

Users can manually trigger partition scanning later when appropriate
using standard tools (e.g., partprobe, blockdev --rereadpt).

Reported-by: Yoav Cohen <yoav@nvidia.com>
Link: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---

- suggest to backport to stable, which is useful for avoiding problematic
  recovery, also the change is simple enough

 drivers/block/ublk_drv.c      | 16 +++++++++++++---
 include/uapi/linux/ublk_cmd.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 78f3e22151b9..ca6ec8ed443f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -73,7 +73,8 @@
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
-		| UBLK_F_BUF_REG_OFF_DAEMON)
+		| UBLK_F_BUF_REG_OFF_DAEMON \
+		| UBLK_F_NO_AUTO_PART_SCAN)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -2930,8 +2931,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	ublk_apply_params(ub);
 
-	/* don't probe partitions if any daemon task is un-trusted */
-	if (ub->unprivileged_daemons)
+	/*
+	 * Don't probe partitions if:
+	 * - any daemon task is un-trusted, or
+	 * - user explicitly requested to suppress partition scan
+	 */
+	if (ub->unprivileged_daemons ||
+	    (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
 	ublk_get_device(ub);
@@ -2947,6 +2953,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	if (ret)
 		goto out_put_cdev;
 
+	/* allow user to probe partitions from userspace */
+	if (!ub->unprivileged_daemons &&
+	    (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
+		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 	set_bit(UB_STATE_USED, &ub->state);
 
 out_put_cdev:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ec77dabba45b..0827db14a215 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -311,6 +311,14 @@
  */
 #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
 
+/*
+ * If this feature is set, the kernel will not automatically scan for partitions
+ * when the device is started. This is useful for network-backed devices where
+ * partition scanning can cause deadlocks if the userspace server crashes during
+ * the scan. Users can manually trigger partition scanning later when appropriate.
+ */
+#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 15)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.47.0

