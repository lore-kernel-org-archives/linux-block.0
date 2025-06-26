Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4E2EF643;
	Thu, 26 Jun 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970260; cv=none; b=TewhflEBuiKCUfNc8HRu81zHdAKa7vAu+/YJ5GTOQV95nUKaUdzKxeJynvYZDeOvngc/lLdms0glSxRopFQIQOSSO251I8SkxIKhAi5Be2LYVbCdltzZ8IuN9kuk/at8xciibSxv27DNQvXP+jLgIJ1DK9lewqRN7E7+7uYHSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970260; c=relaxed/simple;
	bh=WKYh5t4C6qO80ky0LCeweouDyHv1YzhJxgWcKP2hNA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIoDdFf6mdB2XKiQiOHdG71Ub7azgW2vx4uJD8Yba+vKT2LBkpLw5M5ys44J77gKEjrnIGmaSpEq1zICkVDTIIGI1K7eRw600BDCnshA06RC5cgVgpsrA35P+oSXKELstA/rBz15oi5iJWN99Agc9TvzRncAMqD5pG+vCJNKfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SawnpusJ; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SawnpusJ"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bSr8y1jRbzlvX86;
	Thu, 26 Jun 2025 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1750970256; x=1753562257; bh=qk7yE5MJ2c6YX1uthJHDuOf012KadpyHtYm
	qoV6gJUc=; b=SawnpusJ78zTXZZ11S+og7UHi7CfnsugSeg2pfKYc/H8lQoQX6v
	VKrrH0LmmCXUt9JbU9eCli3ASZ9sEUM5mHqYijMANCNZ4i+zvtKkyo/mJWvvqB3y
	a01wemKLHhgKvIPg6HlJmeR5t2zdhFrSrM5q3OzNdPMTG5fa0pJrCEVSnHfEi7Gs
	RYePxXR98p1AVzVnBjo9M/Zus9CL1tZ3Dg9brgCzVZtsJKj47d+Szw+XGBb/xpVh
	k5dgZP3IT3CrywsmoOAdxejB9Etq7HJ5OirIo8hkdt4XQL/cjaiDEtBtDzzADrrf
	N07A6hv/QQAnLdOjfeFbx4zrBpgZ0Pggq5Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h8YqaikX0Eu9; Thu, 26 Jun 2025 20:37:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bSr8s0kBPzlvWh6;
	Thu, 26 Jun 2025 20:37:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] block: Fix a deadlock related to modifying the readahead attribute
Date: Thu, 26 Jun 2025 13:37:13 -0700
Message-ID: <20250626203713.2258558-1-bvanassche@acm.org>
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

This deadlock happens because blk_mq_freeze_queue_nomemsave() waits for
pending requests to finish. The pending requests do never complete becaus=
e
the dm-multipath queue_if_no_path option is enabled and the only path in
the dm-multipath configuration is being removed.

Fix this deadlock by removing the queue freezing/unfreezing code from
queue_ra_store().

Freezing the request queue from inside a block layer sysfs store callback
function is essential when modifying parameters that affect how bios or
requests are processed, e.g. parameters that affect bio_split_to_limit().
Freezing the request queue when modifying parameters that do not affect b=
io
nor request processing is not necessary.

Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: b07a889e8335 ("block: move q->sysfs_lock and queue-freeze under sh=
ow/store method")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: made the patch description more detailed.

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
