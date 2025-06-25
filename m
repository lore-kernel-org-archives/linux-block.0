Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9291B0F1E;
	Wed, 25 Jun 2025 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750881305; cv=none; b=FADESYQCxqcRTBos4my0FBGRqa9NPefuY/Etk71BWCbnikh/wJc1v472hDiS3js7pW0d8728QYGf2q/jT2zflMD4yyzYOmwooh5w/v1z3hcBVN7eEidEdhDPpYzc3notrpJ7U/X/y3eM0B9n+VwyXLRwKuP6DgDyZkQgcQIiftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750881305; c=relaxed/simple;
	bh=lPft7lKt5j2aR58iai8vitRl6Uz0VaNS2yjdHj/yw/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnEp4+0c4HKHI1lolw8Xau8WSvtTp/yj9EmCixVj8Z8eRmEpjJHl+jaG3d87DpacQOYLjEp2YD73jrgZsZUYclLCWN4+XpOuEKWs8d5I8BZbDWKysgjPye1W+nuHFwBHoR0HrN8GtIkR44M5c66gQIUlEgdtViBhByvgAVC+BYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UdBZGu0t; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UdBZGu0t"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bSCGG2d4Wzm0yQb;
	Wed, 25 Jun 2025 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1750881300; x=1753473301; bh=SkQKOpB5FWxJSFAatFHzlElwlfkVrt+xd27
	8AKd8OiU=; b=UdBZGu0tAc1we7MI2Pj2fcVPOtm5kDDTofDawPQQBh6KedrPHGS
	XlmutgLx/2lG7kI4dJ/Ta01I3WTiQtzUJID9uPL2E4X94ErVbE11iXQlHtD+X7HD
	XIlkwda9IrRc2NmfzujPr5mhdX0I1WlfIoKix5Als8ceTO4nNZj4FnX29eBULlda
	VfDTaAKH0MbDUrFi+fHA4xlVDmErlWLjXWKA9e+5HWvcJmT45Y5ECh6Yw5r5VWka
	Wcusw1DLNggsNpbp91LAOMy0FI4EpNobkj3CgNRLS3wHWwf0j9C4yh+RQGHmcjN3
	AP6Xeos4TSLFLD9XMRxPK+O++0awImz7r1w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id R3eBYWaB1CxQ; Wed, 25 Jun 2025 19:55:00 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bSCG81wh7zm0pKN;
	Wed, 25 Jun 2025 19:54:55 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: Fix a deadlock related to modifying the readahead attribute
Date: Wed, 25 Jun 2025 12:54:50 -0700
Message-ID: <20250625195450.1172740-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Every time I run test srp/002 the following deadlock is triggered:

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

Fix this by removing the superfluous queue freezing/unfreezing code from
queue_ra_store().

Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: b07a889e8335 ("block: move q->sysfs_lock and queue-freeze under sh=
ow/store method")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b2b9b89d6967..1f63b184c6e9 100644
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
