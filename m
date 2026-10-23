Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792786683;
	b=Ilx8S2S+k2IL5PYE81OzUUUz81NN8uIbxWUfMvBjvrtkjImln2yQtUBLHHiy8NpL/9Eb
	 3khligD8OFR21tD9DgTfKk9vIoRD89YFuFUaYUX+lQiJ6l6Sxt61XPyNS0a2ul4GePQ6y
	 IYhUvoq/S5epQU9LUonOS9tA9L7Z+myIuNQWl1Z2vC3o6Pv93QCuBKTe/czSpD5XmtlGf
	 BofSIz5QGvVCxcYQukCwlWneUe66kvF38SFgih3HplJFN9y1G5D28d8rwWjJnA+YVMfOQ
	 w1DUasy5Yb2FWIQP+00lFXSJkHCmDZJ0xQN+NeNYjvRZhXsS7N6enbtDGtGCIXqfUBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786683;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=uRYww9vPDB7eBeDr4GhK1+jQ+LPs4+QyokdqRCG88Z0=;
	b=WYAA4xK8/98zk1hle8eHOzTEZQbbN76trc6z3MQpxhzovZhamsSGNhFhqs6Uba3+Ksaq
	 5Isi6iRL8SUwEIN/+JXJIU1CQJV3pTJODw+uudk5ALtVNRb97bGZguKe7AlL+TMAR4y0l
	 im4XP877qf6Yk1C5y4APQ8wsqbzQSKVcVKEQnBxTE2hzMEV4gwK15us31y2o3fVIl8u5c
	 l1rMuHc5RP4zxCzM9GucIsdyazQmQk0r+KTznrebIdGvwIse9fPYfmYKKtXdg45iDwCRR
	 S/K4WG9/g71hdJuqg1ckARBZh8Qmrx2Sq7mYWV2EkmE/jiYBFU5VjrFkx/+AHgtdKuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=jiskkh0d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0A606A31A;
	Fri, 23 Oct 2026 20:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA0A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=jiskkh0d
ARC-Seal: i=1; a=rsa-sha256; t=1792786645; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k7aSQBvgJ8ZVAYOnICPIJAg/N96u5IlLhXREFlAcmVbx69nuA+EzqNkUrDrbL92I2ySNN8YgiH9Dk4CEXfRx7X1HWC4JQbAbTdc5Oi9gmrRPXF1QR/9TPjFgd4ZuB02OJZmHcFEfYrC1WhklNJIMvnuUprnHDZHJynu/szr+CTI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792786645; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uRYww9vPDB7eBeDr4GhK1+jQ+LPs4+QyokdqRCG88Z0=; 
	b=fz3K8/ZaPx9jHM+x++cFSxYOy0IVEF5BWDHJwY92/jYLLb1FGcVw4Pxle7hqYG0rgWXZ4ouM0e3sRR0HziOdTshaIpYM3r49BcDF60suJnxkxFKbCGwmSrJ8eN+2aPU2IC54I+yBo4wEDrcnwJradtAmu++8r2HbnjokiNtJLMg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792786645;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uRYww9vPDB7eBeDr4GhK1+jQ+LPs4+QyokdqRCG88Z0=;
	b=jiskkh0dp5GCXVCsEtfSUqr4JR5MimceZfeP8H7bLLKPRYh0A8kDNusardOxdlfq
	ZunZ7b+78+YUqF69FdgPcRTLFwWaD3TyMzDcGZ6chW1Ifq3tVtlN5WX+o3tf7ptKr7e
	EbmK/xUbi1oA+sHJM2jJVRGSNZPVu1CSi7BSTgBQ=
Received: by smtp.zohomail.com with SMTPS id 1792786642053928.007163592512;
	Fri, 23 Oct 2026 13:17:22 -0700 (PDT)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai@fygo.io>,
	Reindl Harald <h.reindl@thelounge.net>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: only serialize elevator switches of the same queue
Date: Fri, 23 Oct 2026 13:17:04 -0700
Message-ID: <20261023201704.20577-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Since commit 4ff58d6bc9dd ("block: serialize elevator changes for the
same queue using a writer lock"), a write to queue/scheduler fails with
-EBUSY whenever something else holds set->update_nr_hwq_lock. That
commit takes the lock for write, and it has to be a trylock because of
commit ce8ee8583ed8 ("block: use trylock to avoid lockdep circular
dependency in sysfs").

The lock covers the whole tag set, so it is easy to hit. A scheduler
write fails while another queue of the set is switching, or while a
sibling disk of the same SCSI host or NVMe controller is added or
removed. That is what breaks the udev rules that set the scheduler on
7.2.

Go back to taking the lock for read. The write lock was there to keep
two switches of one queue from overlapping in elevator_change_done(),
which touches the elevator sysfs and debugfs entries outside of
q->elevator_lock, so use a new mutex for that instead. It is held across
elevator_change(), and only the sysfs store takes it. The other callers
of elevator_change() run before the queue is registered, after its sysfs
files are gone, or with the lock held for write, so they cannot race
with the store.

nr_hw_queues updates, nr_requests writes and disk removal still take the
lock for write, so a scheduler write can still get -EBUSY while one of
those holds or waits for it, as before 4ff58d6bc9dd.

Fixes: 4ff58d6bc9dd ("block: serialize elevator changes for the same queue using a writer lock")
Cc: stable@vger.kernel.org # v7.2+
Reported-by: Reindl Harald <h.reindl@thelounge.net>
Closes: https://lore.kernel.org/r/077dd42e-cbc9-4c23-a5ef-3d20e4fc7757@thelounge.net
Assisted-by: LLM
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---

Tested on arm64 and x86_64 in QEMU, with KASAN, lockdep and debug lists.

Writes failing with -EBUSY, one number per run (writers x writes):

                                       x86_64        arm64
  one queue
    v7.3, 4 x 400                      795, 756      807, 926
    patched, 6 x 600                   0             0
  one writer per namespace
    v7.3, 4 x 400                      649, 597      704, 662
    patched, 4 x 600                   0             0
  one writer, sibling namespaces added and removed
    v7.3, 1 x 400                      23, 32, 34    42, 43
    patched, 1 x 400                   0, 2, 0       0

With 4ff58d6bc9dd reverted from v7.3, six writers on one queue hit
KASAN in elevator_change_done() on all three runs (arm64): a
null-ptr-deref in blk_mq_debugfs_register_sched() and use-after-frees
in kobject_add() and kobject_uevent_env(). With the patch the same test
is clean. 20 disk removals under writers, block/005 and block/047 pass
as well.

A write to queue/scheduler now sleeps on the mutex with the read lock
held, so a queued nr_hw_queues update or disk removal waits for the
writes ahead of it.
I did not reuse q->sysfs_lock because blk_unregister_queue() holds it
while draining the sysfs files, and elevator_change_done() runs after
q->elevator_lock is dropped, so that lock does not cover it.

 block/blk-core.c       |  1 +
 block/elevator.c       | 16 +++++++++-------
 include/linux/blkdev.h |  6 ++++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..655c18237967 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -473,6 +473,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	refcount_set(&q->refs, 1);
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->elevator_lock);
+	mutex_init(&q->elevator_store_lock);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
diff --git a/block/elevator.c b/block/elevator.c
index 2161b6eea680..0a8fcb4bad06 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -812,16 +812,16 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * reference during concurrent disk deletion:
 	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
 	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
-	 *
-	 * Use the writer lock instead of the reader lock of update_nr_hwq_lock
-	 * to serialize the two-stage elevator switch steps in
-	 * elevator_change(): the core switch step under the elevator lock and
-	 * the elevator_change_done() step outside the elevator lock.
 	 */
-	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
+	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
 		ret = -EBUSY;
 		goto out;
 	}
+
+	/* The reader lock is shared: serialize both stages of a switch here. */
+	ret = mutex_lock_killable(&q->elevator_store_lock);
+	if (ret)
+		goto out_unlock;
 	if (!blk_queue_no_elv_switch(q)) {
 		ret = elevator_change(q, &ctx);
 		if (!ret)
@@ -829,7 +829,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	} else {
 		ret = -ENOENT;
 	}
-	up_write(&set->update_nr_hwq_lock);
+	mutex_unlock(&q->elevator_store_lock);
+out_unlock:
+	up_read(&set->update_nr_hwq_lock);
 
 out:
 	if (ctx.type)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..87fcf2921253 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -610,6 +610,12 @@ struct request_queue {
 	 */
 	struct mutex		elevator_lock;
 
+	/*
+	 * Serializes queue/scheduler writes. Lock order: update_nr_hwq_lock
+	 * (read), this lock, then the queue freeze.
+	 */
+	struct mutex		elevator_store_lock;
+
 	struct mutex		sysfs_lock;
 	/*
 	 * Protects queue limits and also sysfs attribute read_ahead_kb.
-- 
2.43.0

