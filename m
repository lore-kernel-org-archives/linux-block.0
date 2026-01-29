Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C41DC997
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703629; cv=none; b=mkl3VPLIscisxMgdoVSuHAkttRYGLE9p1+7znoEkWiF3i3Tt8bz68dlXcGdJYUNXlMqvCUqRooP6mrTqpA9KRQ16Yo0ZJPrOfQNLxOMtPISyW7vKFlkX4Mp+q1GWAQJYfI69BNTnjiFBBhC6l1y980IgVPHCqMverES+mfSxRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703629; c=relaxed/simple;
	bh=ueEVl/7KNSG3qDdrZQ1VzyQBQlw9XFLwOP9GvkUPCqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRYJCsZ2VNjnWwlzzzMmK1fKV6PmDl292O/58252ShM2wXs4MXQDxbVYOW79kTTVpTANjLAePObyYppz3j8vAVLSijH9+Vta4qb9Ok5FHn7Fr+wtx8kJszoo4SaR5fhYPKRB8zzt0HUn6KhnTr4s2Jcs9+IcjX6lWPwilSFdm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOwwbQF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOwwbQF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx2BI7MhJ/jSh1DfVlEZZvBCJrYUcMzHcne5RWOElVA=;
	b=WOwwbQF7vwcpuj0bnhNEQXoL24MKt1/M7ybc5MIVmywnRKwqHy77VlXy10FvvrQuRoNIlT
	QbHbuXuUxBMPP15Q8TM9BIpqs5kgptWLUe6cna9CrJNUqAHKW9DRPww80E3PmAfnYzsn0L
	78g8GEurHcqiWGaYVBb8EILrYcZ/nBs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-b-a7-qkKO5a5FtuRzeuuGQ-1; Thu,
 29 Jan 2026 11:20:23 -0500
X-MC-Unique: b-a7-qkKO5a5FtuRzeuuGQ-1
X-Mimecast-MFC-AGG-ID: b-a7-qkKO5a5FtuRzeuuGQ_1769703617
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 538271800365;
	Thu, 29 Jan 2026 16:20:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71D4F1956056;
	Thu, 29 Jan 2026 16:20:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH V2 2/9] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
Date: Fri, 30 Jan 2026 00:19:51 +0800
Message-ID: <20260129162001.3532311-3-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppress
automatic partition scanning when starting a ublk device.

This is useful for some cases in which user don't want to scan
partitions.

Users still can manually trigger partition scanning later when appropriate
using standard tools (e.g., partprobe, blockdev --rereadpt).

Reported-by: Yoav Cohen <yoav@nvidia.com>
Link: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 14 ++++++++++----
 include/uapi/linux/ublk_cmd.h |  3 +++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 94470a2ec05e..aa9ea39249b0 100644
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
@@ -4430,9 +4431,14 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	set_bit(UB_STATE_USED, &ub->state);
 
-	/* Schedule async partition scan for trusted daemons */
-	if (!ub->unprivileged_daemons)
-		schedule_work(&ub->partition_scan_work);
+	/* Skip partition scan if disabled by user */
+	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
+		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+	} else {
+		/* Schedule async partition scan for trusted daemons */
+		if (!ub->unprivileged_daemons)
+			schedule_work(&ub->partition_scan_work);
+	}
 
 out_put_cdev:
 	if (ret) {
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

