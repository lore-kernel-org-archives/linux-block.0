Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B7208D7D
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086545; cv=none; b=u9D1rFde+1nIwks4UJLHxhFzeDcEnBzk1FPD/yrSGWXzjOseXSGm8v/v/VvX627qEixeeyfCJDYZycO+zBL2LGkOsYi/ySm6clBlvV4J4zzLgCQqYG1Q681QEwBflztbzR9ldfyQpNPtOSQio5rIi98yd/MgBeR11f/8e4Pw0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086545; c=relaxed/simple;
	bh=oeDMAKC9K17Dkws8Wmds1B1c5PpAg/GWWVAtPWWiVLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CT9icQc8GLkt1DxjBLfvXFHpLhemWHFLg2dMeRrs3vwgeg3w/kTTvgzWLzLnOfMUSlAaRaNGpFRelIPK5OaLT4j37S+ALGpt1qI4rAqjizaJZIYZHFk/2NhVTfCIsO8FNyf+yMj11N6HcBwZJ0x8wlOEft6Dlwbhe9bURHCE76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckAfSsDA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckAfSsDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729086543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cN8i7MhL5vKtmx1nhy8lQZRTC/jV6NMqewcc5fjiG/4=;
	b=ckAfSsDAWKbhDSsI0OZl/ZkQ0KeBar0nU3HC/Yi7hvzDt2hHWNd33ygMHPL8SYk4BcMoW2
	FCEM2geyjju0Zw+MRRD3bPuHwflDoTljeeRplS0h7eD9I0sx7fV4YsP822a+6B6309Vu0R
	tVZydIU7L/jrsQHB3QZwE5egwzdNV5w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-RYGtCcWFMyiBFNnll1x2wA-1; Wed,
 16 Oct 2024 09:49:00 -0400
X-MC-Unique: RYGtCcWFMyiBFNnll1x2wA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2E87195608B;
	Wed, 16 Oct 2024 13:48:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D8101956086;
	Wed, 16 Oct 2024 13:48:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: don't allow user copy for unprivileged device
Date: Wed, 16 Oct 2024 21:48:47 +0800
Message-ID: <20241016134847.2911721-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

UBLK_F_USER_COPY requires userspace to call write() on ublk char
device for filling request buffer, and unprivileged device can't
be trusted.

So don't allow user copy for unprivileged device.

Fixes: 1172d5b8beca ("ublk: support user copy")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 11 ++++++++++-
 include/uapi/linux/ublk_cmd.h |  8 +++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cd509126e152..f812cd271573 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2519,10 +2519,19 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	 * TODO: provide forward progress for RECOVERY handler, so that
 	 * unprivileged device can benefit from it
 	 */
-	if (info.flags & UBLK_F_UNPRIVILEGED_DEV)
+	if (info.flags & UBLK_F_UNPRIVILEGED_DEV) {
 		info.flags &= ~(UBLK_F_USER_RECOVERY_REISSUE |
 				UBLK_F_USER_RECOVERY);
 
+		/*
+		 * For USER_COPY, we depends on userspace to fill request
+		 * buffer by pwrite() to ublk char device, which can't be
+		 * used for unprivileged device
+		 */
+		if (info.flags & UBLK_F_USER_COPY)
+			return -EINVAL;
+	}
+
 	/* the created device is always owned by current user */
 	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 897ace0794c2..cbe53c980cbc 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -174,7 +174,13 @@
 /* use ioctl encoding for uring command */
 #define UBLK_F_CMD_IOCTL_ENCODE	(1UL << 6)
 
-/* Copy between request and user buffer by pread()/pwrite() */
+/*
+ *  Copy between request and user buffer by pread()/pwrite()
+ *
+ *  Not available for UBLK_F_UNPRIVILEGED_DEV, otherwise userspace may
+ *  deceive us by not filling request buffer, then kernel uninitialized
+ *  data may be leaked.
+ */
 #define UBLK_F_USER_COPY	(1UL << 7)
 
 /*
-- 
2.46.0

