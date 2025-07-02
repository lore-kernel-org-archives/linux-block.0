Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF852E498F;
	Wed,  2 Jul 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480695; cv=none; b=r532rwSSD0cU3XXQmpYBgvpbf58Teu4En/wuNdJoTxbJsTOzXqY2VEo+xljGFoPOQdCRjgFN2/yuc8DxdzbMlnteyjt7evQjvBRdX1t2rPoVcZ+dujYKZQCOz27CPfub8G31oYsuOvrOTsHRJFSZ2THXhz1F3LAwOInyxAO1GwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480695; c=relaxed/simple;
	bh=Z7w2EElGyohA2SqdU87tdCECohPKySYQX1tLMyYL9rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otc+pjjvR3JzXkaN7/P2UBSELf3JfTzaIMc6MhLMf1uirJhtcjRQQsKR4iCW1BErAnAgIWM12W587TWaoCCbrOMi9uOMgQrygeBVpcer1uw11he156ujfMK8E2Wf71rSzRiyQbCVdaH5vppTBNfkip9/x4+AqJd2KI8oVFCkfa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qe0RzKf0; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qe0RzKf0"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXSx01Qldzm0XBf;
	Wed,  2 Jul 2025 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751480690; x=1754072691; bh=hzzvY
	E9l/lDgH+Z4erLQHYmRCe/GVGQFXbr8+aKs/ag=; b=Qe0RzKf0WeYI7uBSTb9IF
	QiKxwFz3nUsaNciYPXxbBx6ycXiP6LQ49W6rDBd5MNyh7Hz/Ky9G6XaINZRRaaDB
	L/T1rF2w1e8VXxz00qrpswGrOCccSOFnkug4l6xrrcsmMm9JYGLyI+H9SyyGwAZR
	ayb4z+Sg9vuZdR1kJ3FUV6Nl1ROdcJgRGx0YYLnvFANOkCmH4kXcdjha8GfYZOtY
	3F1r/gwQ5bo17x6KAUrxV78q42bO2uuw12r1zDXOXNTAZ6GXJ0iCpnq2NjWmti/Q
	9uEBcvImiTZt0IFz1lXsbtaAGul4NylQr359hLI5LZsGCATUMhjAN5kVFoB9NTek
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IVWFJS-00Yo9; Wed,  2 Jul 2025 18:24:50 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXSwv0nbCzm0bg2;
	Wed,  2 Jul 2025 18:24:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] block: Remove queue freezing from several sysfs store callbacks
Date: Wed,  2 Jul 2025 11:24:28 -0700
Message-ID: <20250702182430.3764163-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702182430.3764163-1-bvanassche@acm.org>
References: <20250702182430.3764163-1-bvanassche@acm.org>
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
Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b2b9b89d6967..ab34fe62f4da 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -105,7 +105,6 @@ queue_ra_store(struct gendisk *disk, const char *page=
, size_t count)
 {
 	unsigned long ra_kb;
 	ssize_t ret;
-	unsigned int memflags;
 	struct request_queue *q =3D disk->queue;
=20
 	ret =3D queue_var_store(&ra_kb, page, count);
@@ -116,10 +115,8 @@ queue_ra_store(struct gendisk *disk, const char *pag=
e, size_t count)
 	 * calculated from the queue limits by queue_limits_commit_update.
 	 */
 	mutex_lock(&q->limits_lock);
-	memflags =3D blk_mq_freeze_queue(q);
 	disk->bdi->ra_pages =3D ra_kb >> (PAGE_SHIFT - 10);
 	mutex_unlock(&q->limits_lock);
-	blk_mq_unfreeze_queue(q, memflags);
=20
 	return ret;
 }
@@ -317,21 +314,18 @@ static ssize_t queue_nomerges_store(struct gendisk =
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
@@ -351,7 +345,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 #ifdef CONFIG_SMP
 	struct request_queue *q =3D disk->queue;
 	unsigned long val;
-	unsigned int memflags;
=20
 	ret =3D queue_var_store(&val, page, count);
 	if (ret < 0)
@@ -363,7 +356,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 	 * are accessed individually using atomic test_bit operation. So we
 	 * don't grab any lock while updating these flags.
 	 */
-	memflags =3D blk_mq_freeze_queue(q);
 	if (val =3D=3D 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
@@ -374,7 +366,6 @@ queue_rq_affinity_store(struct gendisk *disk, const c=
har *page, size_t count)
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
 	}
-	blk_mq_unfreeze_queue(q, memflags);
 #endif
 	return ret;
 }
@@ -388,11 +379,9 @@ static ssize_t queue_poll_delay_store(struct gendisk=
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
@@ -401,7 +390,6 @@ static ssize_t queue_poll_store(struct gendisk *disk,=
 const char *page,
 	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
 	pr_info_ratelimited("please use driver specific parameters instead.\n")=
;
 out:
-	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
 }
=20
@@ -414,7 +402,7 @@ static ssize_t queue_io_timeout_show(struct gendisk *=
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
@@ -422,9 +410,7 @@ static ssize_t queue_io_timeout_store(struct gendisk =
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
