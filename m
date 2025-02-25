Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025072690DB
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490308; cv=none; b=gxGpBGdsgc1YwAqPTAYiR2tw6G813Xkl7sAHn8MaXIIItA0sFxAPwz4L5wenNR5GYk9PVvwouY17wJELwDkZl4eMdIdZrgFdjMTAdiDw0zaySO80bY2kFH4kSFuO4aVmSUKDbRgwFI8BZsE6/E5lo/fMZGO/u8MzuqqRqeM5Y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490308; c=relaxed/simple;
	bh=ixf76m5pv/P9z2AGUZb5x3gQrWlbcTY7iEyD6mA50ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIXI4CwDvA8DZcvciuGIhx9kfVnjqDkevyStTwrW+tX5NBoeFnBgVjU8RYtdtm8hpUt2GEr7RsGDOR5cGpPNB0CDQqS93dEQzX02PY9CKNh8NHmmpNRST68NyV8dMrn0dfrq6Ni0o1O2p3jBWEe2QHap5QivJPEfEBA+ur8jJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YHdIO34T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YHdIO34T"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5OKH8005409;
	Tue, 25 Feb 2025 13:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Stn/X3fpIyfnRiQyt
	N/HjnUEv0ffrBUreqB8EvHDJVw=; b=YHdIO34TyXKvndskgVYTtt173zamVgsIX
	q4v8SxYfS6zMLv84ae7Faa4Gpm+PKz58iUhF2vexBYgkHEI+Re0YthSoimkM4eQO
	hxM8AcuYWPga6Az5B/mg4JUT+RSc/EHtFC3NTCsFD2eYlBzuxgoJMK2q7zVpfSah
	Ygt6eAePVIiNdYrsNGhmpChFXQhfS51NATGDWrY9NrW076aXLvlk1s7Q+FfN5mzI
	aENHUNFL5GTMxQRCiNt7uws0ouac2Kcu6L74ckkPP/nrNwrrbRo1E6zcqfxqOeFV
	0ltM0nQDl9sWllFiAsTq4Cc+Th1aTr1HLiBuGhiU4LEagLnUXTEPg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4517p8j8r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PC3wUS027376;
	Tue, 25 Feb 2025 13:31:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1vp4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDVYNP59113764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:31:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31ADC2004B;
	Tue, 25 Feb 2025 13:31:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0B2020040;
	Tue, 25 Feb 2025 13:31:30 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.156.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:31:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv4 4/7] block: Introduce a dedicated lock for protecting queue elevator updates
Date: Tue, 25 Feb 2025 19:00:39 +0530
Message-ID: <20250225133110.1441035-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225133110.1441035-1-nilay@linux.ibm.com>
References: <20250225133110.1441035-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ze8Y9GX_0hZxjkineKBra7oY5OSQiXXu
X-Proofpoint-ORIG-GUID: Ze8Y9GX_0hZxjkineKBra7oY5OSQiXXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=743 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250092

A queue's elevator can be updated either when modifying nr_hw_queues
or through the sysfs scheduler attribute. Currently, elevator switching/
updating is protected using q->sysfs_lock, but this has led to lockdep
splats[1] due to inconsistent lock ordering between q->sysfs_lock and
the freeze-lock in multiple block layer call sites.

As the scope of q->sysfs_lock is not well-defined, its (mis)use has
resulted in numerous lockdep warnings. To address this, introduce a new
q->elevator_lock, dedicated specifically for protecting elevator
switches/updates. And we'd now use this new q->elevator_lock instead of
q->sysfs_lock for protecting elevator switches/updates.

While at it, make elv_iosched_load_module() a static function, as it is
only called from elv_iosched_store(). Also, remove redundant parameters
from elv_iosched_load_module() function signature.

[1] https://lore.kernel.org/all/67637e70.050a0220.3157ee.000c.GAE@google.com/

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         | 15 +++++++--------
 block/blk-sysfs.c      | 32 ++++++++++++++++++++++----------
 block/elevator.c       | 35 ++++++++++++++++-------------------
 block/elevator.h       |  2 --
 block/genhd.c          |  9 ++++++---
 include/linux/blkdev.h |  8 ++++++++
 7 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d6c4fa3943b5..362d0a55b07a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -429,6 +429,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 
 	refcount_set(&q->refs, 1);
 	mutex_init(&q->debugfs_mutex);
+	mutex_init(&q->elevator_lock);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40490ac88045..474beae6cff2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4467,7 +4467,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	unsigned long i, j;
 
 	/* protect against switching io scheduler  */
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
@@ -4500,7 +4500,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 	/* unregister cpuhp callbacks for exited hctxs */
 	blk_mq_remove_hw_queues_cpuhp(q);
@@ -4933,10 +4933,9 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	if (!qe)
 		return false;
 
-	/* q->elevator needs protection from ->sysfs_lock */
-	mutex_lock(&q->sysfs_lock);
+	/* Accessing q->elevator needs protection from ->elevator_lock. */
+	mutex_lock(&q->elevator_lock);
 
-	/* the check has to be done with holding sysfs_lock */
 	if (!q->elevator) {
 		kfree(qe);
 		goto unlock;
@@ -4950,7 +4949,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	list_add(&qe->node, head);
 	elevator_disable(q);
 unlock:
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 	return true;
 }
@@ -4980,11 +4979,11 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	list_del(&qe->node);
 	kfree(qe);
 
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
 	elevator_switch(q, t);
 	/* drop the reference acquired in blk_mq_elv_switch_none */
 	elevator_put(t);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 }
 
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index bc641ac71cde..1091c6fb6dd8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -693,10 +693,15 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 * Attributes which are protected with q->sysfs_lock.
 	 */
 	&queue_requests_entry.attr,
-	&elv_iosched_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
+	/*
+	 * Attributes which require some form of locking
+	 * other than q->sysfs_lock.
+	 */
+	&elv_iosched_entry.attr,
+
 	/*
 	 * Attributes which don't require locking.
 	 */
@@ -865,15 +870,19 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		goto out_debugfs_remove;
 
+	ret = blk_crypto_sysfs_register(disk);
+	if (ret)
+		goto out_unregister_ia_ranges;
+
+	mutex_lock(&q->elevator_lock);
 	if (q->elevator) {
 		ret = elv_register_queue(q, false);
-		if (ret)
-			goto out_unregister_ia_ranges;
+		if (ret) {
+			mutex_unlock(&q->elevator_lock);
+			goto out_crypto_sysfs_unregister;
+		}
 	}
-
-	ret = blk_crypto_sysfs_register(disk);
-	if (ret)
-		goto out_elv_unregister;
+	mutex_unlock(&q->elevator_lock);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(disk);
@@ -898,8 +907,8 @@ int blk_register_queue(struct gendisk *disk)
 
 	return ret;
 
-out_elv_unregister:
-	elv_unregister_queue(q);
+out_crypto_sysfs_unregister:
+	blk_crypto_sysfs_unregister(disk);
 out_unregister_ia_ranges:
 	disk_unregister_independent_access_ranges(disk);
 out_debugfs_remove:
@@ -945,8 +954,11 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(disk);
 
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
 	elv_unregister_queue(q);
+	mutex_unlock(&q->elevator_lock);
+
+	mutex_lock(&q->sysfs_lock);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
 
diff --git a/block/elevator.c b/block/elevator.c
index 041f1d983bc7..b4d08026b02c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -457,7 +457,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 	struct elevator_queue *e = q->elevator;
 	int error;
 
-	lockdep_assert_held(&q->sysfs_lock);
+	lockdep_assert_held(&q->elevator_lock);
 
 	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
@@ -481,7 +481,7 @@ void elv_unregister_queue(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
-	lockdep_assert_held(&q->sysfs_lock);
+	lockdep_assert_held(&q->elevator_lock);
 
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
@@ -618,7 +618,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	unsigned int memflags;
 	int ret;
 
-	lockdep_assert_held(&q->sysfs_lock);
+	lockdep_assert_held(&q->elevator_lock);
 
 	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
@@ -655,7 +655,7 @@ void elevator_disable(struct request_queue *q)
 {
 	unsigned int memflags;
 
-	lockdep_assert_held(&q->sysfs_lock);
+	lockdep_assert_held(&q->elevator_lock);
 
 	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
@@ -700,28 +700,23 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	return ret;
 }
 
-void elv_iosched_load_module(struct gendisk *disk, const char *buf,
-			     size_t count)
+static void elv_iosched_load_module(char *elevator_name)
 {
-	char elevator_name[ELV_NAME_MAX];
 	struct elevator_type *found;
-	const char *name;
-
-	strscpy(elevator_name, buf, sizeof(elevator_name));
-	name = strstrip(elevator_name);
 
 	spin_lock(&elv_list_lock);
-	found = __elevator_find(name);
+	found = __elevator_find(elevator_name);
 	spin_unlock(&elv_list_lock);
 
 	if (!found)
-		request_module("%s-iosched", name);
+		request_module("%s-iosched", elevator_name);
 }
 
 ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 			  size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
+	char *name;
 	int ret;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
@@ -731,16 +726,18 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * queue to ensure that the module file can be read when the request
 	 * queue is the one for the device storing the module file.
 	 */
-	elv_iosched_load_module(disk, buf, count);
 	strscpy(elevator_name, buf, sizeof(elevator_name));
+	name = strstrip(elevator_name);
+
+	elv_iosched_load_module(name);
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
-	ret = elevator_change(q, strstrip(elevator_name));
+	mutex_lock(&q->elevator_lock);
+	ret = elevator_change(q, name);
 	if (!ret)
 		ret = count;
+	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 	return ret;
 }
 
@@ -751,7 +748,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 	struct elevator_type *cur = NULL, *e;
 	int len = 0;
 
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
 	if (!q->elevator) {
 		len += sprintf(name+len, "[none] ");
 	} else {
@@ -769,7 +766,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 	spin_unlock(&elv_list_lock);
 
 	len += sprintf(name+len, "\n");
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 	return len;
 }
diff --git a/block/elevator.h b/block/elevator.h
index e526662c5dbb..e4e44dfac503 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -148,8 +148,6 @@ extern void elv_unregister(struct elevator_type *);
  * io scheduler sysfs switching
  */
 ssize_t elv_iosched_show(struct gendisk *disk, char *page);
-void elv_iosched_load_module(struct gendisk *disk, const char *page,
-		size_t count);
 ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
diff --git a/block/genhd.c b/block/genhd.c
index e9375e20d866..c2bd86cd09de 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -565,8 +565,11 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
 out_exit_elevator:
-	if (disk->queue->elevator)
+	if (disk->queue->elevator) {
+		mutex_lock(&disk->queue->elevator_lock);
 		elevator_exit(disk->queue);
+		mutex_unlock(&disk->queue->elevator_lock);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(add_disk_fwnode);
@@ -742,9 +745,9 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_quiesce_queue(q);
 	if (q->elevator) {
-		mutex_lock(&q->sysfs_lock);
+		mutex_lock(&q->elevator_lock);
 		elevator_exit(q);
-		mutex_unlock(&q->sysfs_lock);
+		mutex_unlock(&q->elevator_lock);
 	}
 	rq_qos_exit(q);
 	blk_mq_unquiesce_queue(q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..31b1b635c710 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -560,6 +560,14 @@ struct request_queue {
 	struct blk_flush_queue	*fq;
 	struct list_head	flush_list;
 
+	/*
+	 * Protects against I/O scheduler switching, specifically when
+	 * updating q->elevator. To ensure proper locking order during
+	 * an elevator update, first freeze the queue, then acquire
+	 * ->elevator_lock.
+	 */
+	struct mutex		elevator_lock;
+
 	struct mutex		sysfs_lock;
 	struct mutex		limits_lock;
 
-- 
2.47.1

