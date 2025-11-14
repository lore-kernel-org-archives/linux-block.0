Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC772FB99A;
	Fri, 14 Nov 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154303; cv=none; b=CEfdOr5FqHInUCy/O01kcRCgk/3WGnUV2ORmd0SeCUUrC3Ho/nov7JjQtXWvihNQFkPfOgkrAuUZ8ogCNsOkfqRb730OAQF8/IpuNHxmewDJWHjXH8TP/EXTbuyE5HAWKAPXdPx5hIMibZ0GzUWBpgDh9eD6EipMf9bwUOk08/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154303; c=relaxed/simple;
	bh=VGM08h36pMPsd0BV3/XdE7mrJOnlDt+8eYrzsuUFpA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KswFrcjkhRlz5HgbQyQ1d4yPla2M5CZHm2MXppkEcG+V9blOM0tRAVLbZWMv8wEsDUERAlzCc03FbIoTkYo9pbhXF8EkyBdILUWmAaE+Xy4uocPlq2GhqsQpMvoCKyrby/I1MpYq+Zpl/AliEfPqnNrGbsFdvGa4ZTKtjBVrGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KS4V2+ow; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KS4V2+ow"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d7V5S54WXzm0dj6;
	Fri, 14 Nov 2025 21:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1763154298; x=1765746299; bh=2ZbsK
	uEsobjRQL85XqOE3Q0BbhMg+wH9WsV9oX8PDJ4=; b=KS4V2+owUaNNlfUa6EtqL
	fa7GreXsjX2kvy+3N5gnFgtpfz1oBboeL/BqFGsz5AwRBih6SipgEJh6FzXRRWeK
	NN0atLbXlG7FAaTsoX9j2jlUe9qqjx8MYxmOnk2/Xbp/cwdU3h9ofV6c31tHJ+8P
	Kygv5YTMwGSO1dVaHXi4gZtETcC7DOMkxXcSFO3cPif8zF0shT1IEsVGHss+xzy5
	U46exLezeuJcz6AEV5uAiDnkmYbe/mCLuDqfK9o8BB2JTS3MQVoQDcSFPUV2xzL1
	o/FxIsjwObQVyI9xLmmH0kxp1QJjxG1ZJCqtaOP5OVkK1n1q+HhjOTBpD+lkBYc6
	A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dTS8yMlFgSUS; Fri, 14 Nov 2025 21:04:58 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d7V572z2Fzm2Gpx;
	Fri, 14 Nov 2025 21:04:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	stable@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v6 2/2] block: Remove queue freezing from several sysfs store callbacks
Date: Fri, 14 Nov 2025 13:04:07 -0800
Message-ID: <20251114210409.3123309-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114210409.3123309-1-bvanassche@acm.org>
References: <20251114210409.3123309-1-bvanassche@acm.org>
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
Add the __data_racy annotation to request_queue.rq_timeout to suppress
KCSAN data race reports about the rq_timeout reads.

This patch may cause a small delay in applying the new settings.

For all the attributes affected by this patch, I/O will complete
correctly whether the old or the new value of the attribute is used.

This patch affects the following sysfs attributes:
* io_poll_delay
* io_timeout
* nomerges
* read_ahead_kb
* rq_affinity

Here is an example of a deadlock triggered by running test srp/002
if this patch is not applied:

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
 block/blk-sysfs.c      | 26 ++++++++------------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 76c47fe9b8d6..8684c57498cc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -143,21 +143,22 @@ queue_ra_store(struct gendisk *disk, const char *pa=
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
+	 * Use WRITE_ONCE() to write bdi->ra_pages once.
 	 */
 	mutex_lock(&q->limits_lock);
-	memflags =3D blk_mq_freeze_queue(q);
-	disk->bdi->ra_pages =3D ra_kb >> (PAGE_SHIFT - 10);
+	WRITE_ONCE(disk->bdi->ra_pages, ra_kb >> (PAGE_SHIFT - 10));
 	mutex_unlock(&q->limits_lock);
-	blk_mq_unfreeze_queue(q, memflags);
=20
 	return ret;
 }
@@ -375,21 +376,18 @@ static ssize_t queue_nomerges_store(struct gendisk =
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
@@ -409,7 +407,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 #ifdef CONFIG_SMP
 	struct request_queue *q =3D disk->queue;
 	unsigned long val;
-	unsigned int memflags;
=20
 	ret =3D queue_var_store(&val, page, count);
 	if (ret < 0)
@@ -421,7 +418,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 	 * are accessed individually using atomic test_bit operation. So we
 	 * don't grab any lock while updating these flags.
 	 */
-	memflags =3D blk_mq_freeze_queue(q);
 	if (val =3D=3D 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
@@ -432,7 +428,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
 	}
-	blk_mq_unfreeze_queue(q, memflags);
 #endif
 	return ret;
 }
@@ -446,11 +441,9 @@ static ssize_t queue_poll_delay_store(struct gendisk=
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
@@ -459,7 +452,6 @@ static ssize_t queue_poll_store(struct gendisk *disk,=
 const char *page,
 	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
 	pr_info_ratelimited("please use driver specific parameters instead.\n")=
;
 out:
-	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
 }
=20
@@ -472,7 +464,7 @@ static ssize_t queue_io_timeout_show(struct gendisk *=
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
@@ -480,9 +472,7 @@ static ssize_t queue_io_timeout_store(struct gendisk =
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
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2fff8a80dbd2..cb4ba09959ee 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -495,7 +495,7 @@ struct request_queue {
 	 */
 	unsigned long		queue_flags;
=20
-	unsigned int		rq_timeout;
+	unsigned int __data_racy rq_timeout;
=20
 	unsigned int		queue_depth;
=20
