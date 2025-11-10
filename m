Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6F2798F8;
	Mon, 10 Nov 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791890; cv=none; b=h14mNpXtMiuwngdpvpqvf+EBG5oTZc3GKgJ2SFAsb39UlguKw4nYHUHRbwjD6g6hpPZv83ly7I5uAvKQK45CFW1ZaOavdVoCDnOUuCacL5LTy9oppwrloNx3k81kwEwqOv+CQcO2NWJB5DJ3atODvYA55ixi/GbDE4MmVsJUOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791890; c=relaxed/simple;
	bh=Nu40uPXSob4vITvNDOyn/Bd8AXmkS6y6Mz+mgkqSj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjTWDLLexzk2i8ms7aSmYx2x8W11GzL/putWbwHPLDdmPKxWvpZVFbDLdRy3DZbAnbln2sx89OBK7qc8GaQnUImx04vKufglZ0MmJxHdZe+4e60Kje+goZU1wrSijBzTFCxFTeqCAlSRq1oI+nKdI0/vLAVtgwrf7G6I60ZoKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TL5Ccumm; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TL5Ccumm"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d4w3t2QCqzm0c5M;
	Mon, 10 Nov 2025 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1762791879; x=1765383880; bh=LIolwOxiTgqZvk1Ba8Fs9YAB7HKOR8ysPrd
	7bHZjrZo=; b=TL5CcummpHdNuKEFJd8hWYqdyFy4vDrBleNEYEyXH5kWXcHlJCX
	/X/YPGHB+ZbH2mDXuuvkKq5EUPCMrVL/3Ozp/mO68Mm6YP0ZTZkLxNDhf0LKVQaZ
	Bcn02mP8G8KtHAh9IWd4ZZdQ6mouInTAZ0ipLfdZ0aDW6NK0rN7Fv5d655j0uYtE
	DxlDw2lllQXDp4drW29moVnN/mRx8jeNjxM7HDn68PZNxb0dPtChjbjxwQVok8S/
	04vBg501rfyr0OjLlgNnIwgz7eNrm79fKOwO37efqbremdLAWDlIzPjdIOzomq06
	tSKJ2T8S74tFkbvmm+DUByuj528W1vMdr3w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id w1j-c0W67Pqi; Mon, 10 Nov 2025 16:24:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d4w3f4KZBzm1Hcj;
	Mon, 10 Nov 2025 16:24:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	stable@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v5] block: Remove queue freezing from several sysfs store callbacks
Date: Mon, 10 Nov 2025 08:24:18 -0800
Message-ID: <20251110162418.2915157-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Freezing the request queue from inside sysfs store callbacks may cause a
deadlock in combination with the dm-multipath driver and the
queue_if_no_path option. Additionally, freezing the request queue slows
down system boot on systems where sysfs attributes are set synchronously.

Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
calls from the store callbacks that do not strictly need these callbacks.
This patch may cause a small delay in applying the new settings.

This patch affects the following sysfs attributes:
* io_poll_delay
* io_timeout
* nomerges
* read_ahead_kb
* rq_affinity

Here is an example of a deadlock triggered by running test srp/002:

task:multipathd
Call Trace:
 <TASK>
 __schedule+0x8c1/0x1bf0
 schedule+0xdd/0x270
 schedule_preempt_disabled+0x1c/0x30
 __mutex_lock+0xb89/0x1650
 mutex_lock_nested+0x1f/0x30
 dm_table_set_restrictions+0x823/0xdf0
 __bind+0x166/0x590
 dm_swap_table+0x2a7/0x490
 do_resume+0x1b1/0x610
 dev_suspend+0x55/0x1a0
 ctl_ioctl+0x3a5/0x7e0
 dm_ctl_ioctl+0x12/0x20
 __x64_sys_ioctl+0x127/0x1a0
 x64_sys_call+0xe2b/0x17d0
 do_syscall_64+0x96/0x3a0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>
task:(udev-worker)
Call Trace:
 <TASK>
 __schedule+0x8c1/0x1bf0
 schedule+0xdd/0x270
 blk_mq_freeze_queue_wait+0xf2/0x140
 blk_mq_freeze_queue_nomemsave+0x23/0x30
 queue_ra_store+0x14e/0x290
 queue_attr_store+0x23e/0x2c0
 sysfs_kf_write+0xde/0x140
 kernfs_fop_write_iter+0x3b2/0x630
 vfs_write+0x4fd/0x1390
 ksys_write+0xfd/0x230
 __x64_sys_write+0x76/0xc0
 x64_sys_call+0x276/0x17d0
 do_syscall_64+0x96/0x3a0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: stable@vger.kernel.org
Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v4:
 - Use WRITE_ONCE() to update bdi->ra_pages.
 - Move a data_race() annotation from queue_io_timeout_store() into
   blk_queue_rq_timeout().

Changes compared to v3:
 - Added two data_race() annotations.

Changes compared to v2:
 - Dropped the controversial patch "block: Restrict the duration of sysfs
   attribute changes".

Changes compared to v1:
 - Added patch "block: Restrict the duration of sysfs attribute changes".
 - Remove queue freezing from more sysfs callbacks.
=20
 block/blk-settings.c |  9 ++++++++-
 block/blk-sysfs.c    | 30 ++++++++++++------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 78dfef117623..b5587cc535e5 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -23,7 +23,14 @@
=20
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
-	WRITE_ONCE(q->rq_timeout, timeout);
+	/*
+	 * Use WRITE_ONCE() to write q->rq_timeout once. Use data_race() to
+	 * suppress KCSAN race reports against the write below.
+	 */
+	data_race(({
+		WRITE_ONCE(q->rq_timeout, timeout);
+		0;
+	}));
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
=20
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 76c47fe9b8d6..99e78d907c1c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -143,21 +143,26 @@ queue_ra_store(struct gendisk *disk, const char *pa=
ge, size_t count)
 {
 	unsigned long ra_kb;
 	ssize_t ret;
-	unsigned int memflags;
 	struct request_queue *q =3D disk->queue;
=20
 	ret =3D queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
 	/*
-	 * ->ra_pages is protected by ->limits_lock because it is usually
-	 * calculated from the queue limits by queue_limits_commit_update.
+	 * The ->ra_pages change below is protected by ->limits_lock because it
+	 * is usually calculated from the queue limits by
+	 * queue_limits_commit_update().
+	 *
+	 * bdi->ra_pages reads are not serialized against bdi->ra_pages writes.
+	 * Use WRITE_ONCE() to write bdi->ra_pages once. Use data_race() to
+	 * suppress KCSAN race reports against the write below.
 	 */
 	mutex_lock(&q->limits_lock);
-	memflags =3D blk_mq_freeze_queue(q);
-	disk->bdi->ra_pages =3D ra_kb >> (PAGE_SHIFT - 10);
+	data_race(({
+		WRITE_ONCE(disk->bdi->ra_pages, ra_kb >> (PAGE_SHIFT - 10));
+		0;
+	}));
 	mutex_unlock(&q->limits_lock);
-	blk_mq_unfreeze_queue(q, memflags);
=20
 	return ret;
 }
@@ -375,21 +380,18 @@ static ssize_t queue_nomerges_store(struct gendisk =
*disk, const char *page,
 				    size_t count)
 {
 	unsigned long nm;
-	unsigned int memflags;
 	struct request_queue *q =3D disk->queue;
 	ssize_t ret =3D queue_var_store(&nm, page, count);
=20
 	if (ret < 0)
 		return ret;
=20
-	memflags =3D blk_mq_freeze_queue(q);
 	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_clear(QUEUE_FLAG_NOXMERGES, q);
 	if (nm =3D=3D 2)
 		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	else if (nm)
 		blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-	blk_mq_unfreeze_queue(q, memflags);
=20
 	return ret;
 }
@@ -409,7 +411,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 #ifdef CONFIG_SMP
 	struct request_queue *q =3D disk->queue;
 	unsigned long val;
-	unsigned int memflags;
=20
 	ret =3D queue_var_store(&val, page, count);
 	if (ret < 0)
@@ -421,7 +422,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 	 * are accessed individually using atomic test_bit operation. So we
 	 * don't grab any lock while updating these flags.
 	 */
-	memflags =3D blk_mq_freeze_queue(q);
 	if (val =3D=3D 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
@@ -432,7 +432,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
 	}
-	blk_mq_unfreeze_queue(q, memflags);
 #endif
 	return ret;
 }
@@ -446,11 +445,9 @@ static ssize_t queue_poll_delay_store(struct gendisk=
 *disk, const char *page,
 static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 				size_t count)
 {
-	unsigned int memflags;
 	ssize_t ret =3D count;
 	struct request_queue *q =3D disk->queue;
=20
-	memflags =3D blk_mq_freeze_queue(q);
 	if (!(q->limits.features & BLK_FEAT_POLL)) {
 		ret =3D -EINVAL;
 		goto out;
@@ -459,7 +456,6 @@ static ssize_t queue_poll_store(struct gendisk *disk,=
 const char *page,
 	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
 	pr_info_ratelimited("please use driver specific parameters instead.\n")=
;
 out:
-	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
 }
=20
@@ -472,7 +468,7 @@ static ssize_t queue_io_timeout_show(struct gendisk *=
disk, char *page)
 static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *=
page,
 				  size_t count)
 {
-	unsigned int val, memflags;
+	unsigned int val;
 	int err;
 	struct request_queue *q =3D disk->queue;
=20
@@ -480,9 +476,7 @@ static ssize_t queue_io_timeout_store(struct gendisk =
*disk, const char *page,
 	if (err || val =3D=3D 0)
 		return -EINVAL;
=20
-	memflags =3D blk_mq_freeze_queue(q);
 	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
-	blk_mq_unfreeze_queue(q, memflags);
=20
 	return count;
 }
