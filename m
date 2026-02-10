Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FF22F388
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741483; cv=none; b=cZrclE+O8F7/8CGrAX31enwJR4DqofTO4/8DJqkuJNlNuimjtE3vQObUxhHTEPL8P+Qo7fO8M1gfeUeYcTM9XeR7gYsbjBL9qly+DvlYfafvEcYoRYJ9zXe2/vk+6IgQFgzZdvJdPfJXfsIEskdp6EXIiP/o3HFuXKl7gh9Nip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741483; c=relaxed/simple;
	bh=naOq9zt4BYqb8oi/j4+zUOP4P/M+psDY05W0cStV6I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwASXA53G5Mbi2ULHoqEHxn6MkvUYzu2385Zj4318nhuwzzwB6ZifD5alux4fC6D025lSA1oFC7X5hKjYHOjH8Ps1Lm45OgAfRm100AyaFOIqOX7z3bIKHs+2uXqnGu/WLxs4gHPluH8AwtC7U+P4R8F5iDvSXHJAi3bsG74BuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3TnSgvp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3TnSgvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770741481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wQ4w7TUNhvmGRR094/wdhZnzztkYQptsZhG4t5guo2A=;
	b=P3TnSgvpQgJWdaafD8TmRzwaVrcWZB6qg/eueeUjYLIPiFcNvUHvxLPEi5Pp8QZyyYTzHG
	pWA/z582/snkKqrDqTdpILlqdUrzSuGGHDVcD+DOGuQKZXW4YE4Ux4sjNMiXsc9hGkyCpT
	qieDQFgQFtxfu3iF/D5svBg380bN6ok=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-j5dT-Pz0N660120MpT6Q1A-1; Tue,
 10 Feb 2026 11:36:27 -0500
X-MC-Unique: j5dT-Pz0N660120MpT6Q1A-1
X-Mimecast-MFC-AGG-ID: j5dT-Pz0N660120MpT6Q1A_1770741386
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0B6E1944B0A;
	Tue, 10 Feb 2026 16:36:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0E59300DDBE;
	Tue, 10 Feb 2026 16:36:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] block: allow IOC_PR_READ_* ioctls with BLK_OPEN_READ
Date: Tue, 10 Feb 2026 11:36:17 -0500
Message-ID: <20260210163617.144359-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The recently added IOC_PR_READ_* ioctls require the same BLK_OPEN_WRITE
permission as the older persistent reservation ioctls. This has the
drawback that udev triggers when the file descriptor is closed,
resulting in unnecessary activity like scanning partitions even though
these read-only ioctls do not modify the device.

Change IOC_PR_READ_KEYS and IOC_PR_READ_RESERVATION to require
BLK_OPEN_READ. This prevents unnecessary activity every time `blkpr
--read-keys` or `blkpr --read-reservation` is invoked by shell scripts,
for example.

It is safe to reduce the permission requirement from BLK_OPEN_WRITE to
BLK_OPEN_READ since these two ioctls do not modify the persistent
reservation state. Userspace cannot use the information fetched by these
ioctls to make changes to the device unless it later opens the device
with BLK_OPEN_WRITE.

Fixes: 3e2cb9ee76c2 ("block: add IOC_PR_READ_RESERVATION ioctl")
Fixes: 22a1ffea5f80 ("block: add IOC_PR_READ_KEYS ioctl")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/ioctl.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 344478348a54e..337e4c3b65b2c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -318,7 +318,13 @@ int blkdev_compat_ptr_ioctl(struct block_device *bdev, blk_mode_t mode,
 EXPORT_SYMBOL(blkdev_compat_ptr_ioctl);
 #endif
 
-static bool blkdev_pr_allowed(struct block_device *bdev, blk_mode_t mode)
+enum pr_direction {
+	PR_IN,  /* read from device */
+	PR_OUT, /* write to device */
+};
+
+static bool blkdev_pr_allowed(struct block_device *bdev, blk_mode_t mode,
+		enum pr_direction dir)
 {
 	/* no sense to make reservations for partitions */
 	if (bdev_is_partition(bdev))
@@ -326,11 +332,17 @@ static bool blkdev_pr_allowed(struct block_device *bdev, blk_mode_t mode)
 
 	if (capable(CAP_SYS_ADMIN))
 		return true;
+
 	/*
-	 * Only allow unprivileged reservations if the file descriptor is open
-	 * for writing.
+	 * Only allow unprivileged reservation _out_ commands if the file
+	 * descriptor is open for writing. Allow reservation _in_ commands if
+	 * the file descriptor is open for reading since they do not modify the
+	 * device.
 	 */
-	return mode & BLK_OPEN_WRITE;
+	if (dir == PR_IN)
+		return mode & BLK_OPEN_READ;
+	else
+		return mode & BLK_OPEN_WRITE;
 }
 
 static int blkdev_pr_register(struct block_device *bdev, blk_mode_t mode,
@@ -339,7 +351,7 @@ static int blkdev_pr_register(struct block_device *bdev, blk_mode_t mode,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_registration reg;
 
-	if (!blkdev_pr_allowed(bdev, mode))
+	if (!blkdev_pr_allowed(bdev, mode, PR_OUT))
 		return -EPERM;
 	if (!ops || !ops->pr_register)
 		return -EOPNOTSUPP;
@@ -357,7 +369,7 @@ static int blkdev_pr_reserve(struct block_device *bdev, blk_mode_t mode,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!blkdev_pr_allowed(bdev, mode))
+	if (!blkdev_pr_allowed(bdev, mode, PR_OUT))
 		return -EPERM;
 	if (!ops || !ops->pr_reserve)
 		return -EOPNOTSUPP;
@@ -375,7 +387,7 @@ static int blkdev_pr_release(struct block_device *bdev, blk_mode_t mode,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_reservation rsv;
 
-	if (!blkdev_pr_allowed(bdev, mode))
+	if (!blkdev_pr_allowed(bdev, mode, PR_OUT))
 		return -EPERM;
 	if (!ops || !ops->pr_release)
 		return -EOPNOTSUPP;
@@ -393,7 +405,7 @@ static int blkdev_pr_preempt(struct block_device *bdev, blk_mode_t mode,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_preempt p;
 
-	if (!blkdev_pr_allowed(bdev, mode))
+	if (!blkdev_pr_allowed(bdev, mode, PR_OUT))
 		return -EPERM;
 	if (!ops || !ops->pr_preempt)
 		return -EOPNOTSUPP;
@@ -411,7 +423,7 @@ static int blkdev_pr_clear(struct block_device *bdev, blk_mode_t mode,
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	struct pr_clear c;
 
-	if (!blkdev_pr_allowed(bdev, mode))
+	if (!blkdev_pr_allowed(bdev, mode, PR_OUT))
 		return -EPERM;
 	if (!ops || !ops->pr_clear)
 		return -EOPNOTSUPP;
@@ -434,7 +446,7 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 	size_t keys_copy_len;
 	int ret;
 
-	if (!blkdev_pr_allowed(bdev, mode))
+	if (!blkdev_pr_allowed(bdev, mode, PR_IN))
 		return -EPERM;
 	if (!ops || !ops->pr_read_keys)
 		return -EOPNOTSUPP;
@@ -486,7 +498,7 @@ static int blkdev_pr_read_reservation(struct block_device *bdev,
 	struct pr_read_reservation out = {};
 	int ret;
 
-	if (!blkdev_pr_allowed(bdev, mode))
+	if (!blkdev_pr_allowed(bdev, mode, PR_IN))
 		return -EPERM;
 	if (!ops || !ops->pr_read_reservation)
 		return -EOPNOTSUPP;
-- 
2.52.0

