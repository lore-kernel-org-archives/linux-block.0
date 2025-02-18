Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CC22AE7F
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867370; cv=none; b=fl0keyPrFw18WOsEaVnHpkNV6qdTqbyv3uxTKvezYZUDLyarGYXvr4vnjRSRU7Z/2p4Y5MdfBz1XDM672JjUj5GDz2POdPt1+ENBbFeucTH4ne0YVFesyHIw4IxfwwKvibN+Otdp49Ime64IK4lpLazvu7tep3/M41q0i6nvwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867370; c=relaxed/simple;
	bh=x1xjj1BSIlvv4HeOIpJiW/kBOLX7NSrXJUn3wTcD23g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyleb2AOAMt0cMqlOZc2tPO2iRULsCNjdlSYX1HJ3wpQ94m9G1+GxETlwDMH7zk77ut1bcJ8AXt3zBOfcUU5ChUg7dGiWddjdz22wJqyKa1hliBy7lPHiM7PjvgpjfKDS/b6hebo2sd2UxWIirC3rjud10TNEbqXo9Uqi33xXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gq9B1ZQf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gq9B1ZQf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7X5mj009511;
	Tue, 18 Feb 2025 08:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d+Zr/RevP52C7m8K0
	YhVraBM4LeaySsEiDtfjwjJAeM=; b=Gq9B1ZQfNctv/qXD2aRawCWpaCL3DCwTW
	lQKAEti/e+unuF2nuOuubDONf09qEV/JV9Ggc0xUQpSIW4DW6U4mmmEIaLKKSi3f
	eLeiQR3M4dhBkc3RoMBlvIfJkiNwyVkj/NnaP2fmw8jVr1FsjK9e8ue3eeAfo/sE
	RYB2b2TTfHe40jXYyLYydSAuDW/gX9EPnXRVM7lsmGD2MqGc/tClpQPXJUiGB7ZE
	2+8787a137Nx8GTayjnNPuAQEOLxI0TO40vfRmVhaTU9fA/fzWwkznzne7pFnMqx
	wg0GKGn3mrOpEausqXNRW3K/pRpaOu4FB3RWm3V0BrsRPLHwr8RVQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vnwpg7s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I6Q98S003891;
	Tue, 18 Feb 2025 08:29:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68nt3cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I8THvQ8454536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:29:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3DBC20043;
	Tue, 18 Feb 2025 08:29:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 642CA20040;
	Tue, 18 Feb 2025 08:29:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 08:29:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCHv2 3/6] block: Introduce a dedicated lock for protecting queue elevator updates
Date: Tue, 18 Feb 2025 13:58:56 +0530
Message-ID: <20250218082908.265283-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218082908.265283-1-nilay@linux.ibm.com>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VeShlwMoBrv8Ec2loD3C_x_71VRpgzqP
X-Proofpoint-ORIG-GUID: VeShlwMoBrv8Ec2loD3C_x_71VRpgzqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=989 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180065

A queue's elevator can be updated either when modifying nr_hw_queues
or through the sysfs scheduler attribute. To prevent simultaneous
updates from causing race conditions, introduce a dedicated lock
q->elevator_lock. Currently, elevator switching/updating is protected
using q->sysfs_lock, but this has led to lockdep splats[1] due to
inconsistent lock ordering between q->sysfs_lock and the freeze-lock
in multiple block layer call sites.

As the scope of q->sysfs_lock is not well-defined, its misuse has
resulted in numerous lockdep warnings. To resolve this, replace q->
sysfs_lock with a new dedicated q->elevator_lock, which will be
exclusively used to protect elevator switching and updates.

[1] https://lore.kernel.org/all/67637e70.050a0220.3157ee.000c.GAE@google.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-core.c       |   1 +
 block/blk-mq.c         |  12 ++--
 block/blk-sysfs.c      | 133 ++++++++++++++++++++++++++++-------------
 block/elevator.c       |  18 ++++--
 block/genhd.c          |   9 ++-
 include/linux/blkdev.h |   1 +
 6 files changed, 119 insertions(+), 55 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d6c4fa3943b5..222cdcb662c2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -431,6 +431,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->limits_lock);
+	mutex_init(&q->elevator_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40490ac88045..f58e11dee8a0 100644
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
@@ -4934,7 +4934,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 		return false;
 
 	/* q->elevator needs protection from ->sysfs_lock */
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
 
 	/* the check has to be done with holding sysfs_lock */
 	if (!q->elevator) {
@@ -4950,7 +4950,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	list_add(&qe->node, head);
 	elevator_disable(q);
 unlock:
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 	return true;
 }
@@ -4980,11 +4980,11 @@ static void blk_mq_elv_switch_back(struct list_head *head,
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
index 7e22ec96f2b3..355dfb514712 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -58,7 +58,13 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 
 static ssize_t queue_requests_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(disk->queue->nr_requests, page);
+	int ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	ret = queue_var_show(disk->queue->nr_requests, page);
+	mutex_unlock(&disk->queue->sysfs_lock);
+
+	return ret;
 }
 
 static ssize_t
@@ -66,27 +72,42 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long nr;
 	int ret, err;
+	unsigned int memflags;
+	struct request_queue *q = disk->queue;
 
-	if (!queue_is_mq(disk->queue))
-		return -EINVAL;
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
+
+	if (!queue_is_mq(disk->queue)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = queue_var_store(&nr, page, count);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	if (nr < BLKDEV_MIN_RQ)
 		nr = BLKDEV_MIN_RQ;
 
 	err = blk_mq_update_nr_requests(disk->queue, nr);
 	if (err)
-		return err;
-
+		ret = err;
+out:
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 	return ret;
 }
 
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
+	int ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	ret = queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
+	mutex_unlock(&disk->queue->sysfs_lock);
+
+	return ret;
 }
 
 static ssize_t
@@ -94,11 +115,19 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long ra_kb;
 	ssize_t ret;
+	unsigned int memflags;
+	struct request_queue *q = disk->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
 
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
-		return ret;
+		goto out;
 	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+out:
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 	return ret;
 }
 
@@ -534,14 +563,24 @@ static ssize_t queue_var_store64(s64 *var, const char *page)
 
 static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 {
-	if (!wbt_rq_qos(disk->queue))
-		return -EINVAL;
+	int ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+
+	if (!wbt_rq_qos(disk->queue)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (wbt_disabled(disk->queue))
-		return sysfs_emit(page, "0\n");
+		ret = sysfs_emit(page, "0\n");
+	else
+		ret = sysfs_emit(page, "%llu\n",
+				div_u64(wbt_get_min_lat(disk->queue), 1000));
 
-	return sysfs_emit(page, "%llu\n",
-		div_u64(wbt_get_min_lat(disk->queue), 1000));
+out:
+	mutex_unlock(&disk->queue->sysfs_lock);
+	return ret;
 }
 
 static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
@@ -551,18 +590,24 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	struct rq_qos *rqos;
 	ssize_t ret;
 	s64 val;
+	unsigned int memflags;
+
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
 
 	ret = queue_var_store64(&val, page);
 	if (ret < 0)
-		return ret;
-	if (val < -1)
-		return -EINVAL;
+		goto out;
+	if (val < -1) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
 		ret = wbt_init(disk);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (val == -1)
@@ -570,8 +615,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	else if (val >= 0)
 		val *= 1000ULL;
 
-	if (wbt_get_min_lat(q) == val)
-		return count;
+	if (wbt_get_min_lat(q) == val) {
+		ret = count;
+		goto out;
+	}
 
 	/*
 	 * Ensure that the queue is idled, in case the latency update
@@ -584,7 +631,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 
 	blk_mq_unquiesce_queue(q);
 
-	return count;
+out:
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
+	return ret;
 }
 
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
@@ -593,7 +643,7 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 /* Common attributes for bio-based and request-based queues. */
 static struct attribute *queue_attrs[] = {
 	/*
-	 * attributes protected with q->sysfs_lock
+	 * attributes which require some form of locking
 	 */
 	&queue_ra_entry.attr,
 
@@ -652,10 +702,10 @@ static struct attribute *queue_attrs[] = {
 /* Request-based queue attributes that are not relevant for bio-based queues. */
 static struct attribute *blk_mq_queue_attrs[] = {
 	/*
-	 * attributes protected with q->sysfs_lock
+	 * attributes which require some form of locking
 	 */
-	&queue_requests_entry.attr,
 	&elv_iosched_entry.attr,
+	&queue_requests_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
@@ -729,10 +779,7 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 		return res;
 	}
 
-	mutex_lock(&disk->queue->sysfs_lock);
-	res = entry->show(disk, page);
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return res;
+	return entry->show(disk, page);
 }
 
 static ssize_t
@@ -778,12 +825,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 		return length;
 	}
 
-	mutex_lock(&q->sysfs_lock);
-	memflags = blk_mq_freeze_queue(q);
-	res = entry->store(disk, page, length);
-	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
-	return res;
+	return entry->store(disk, page, length);
 }
 
 static const struct sysfs_ops queue_sysfs_ops = {
@@ -852,15 +894,19 @@ int blk_register_queue(struct gendisk *disk)
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
@@ -885,8 +931,8 @@ int blk_register_queue(struct gendisk *disk)
 
 	return ret;
 
-out_elv_unregister:
-	elv_unregister_queue(q);
+out_crypto_sysfs_unregister:
+	blk_crypto_sysfs_unregister(disk);
 out_unregister_ia_ranges:
 	disk_unregister_independent_access_ranges(disk);
 out_debugfs_remove:
@@ -932,8 +978,11 @@ void blk_unregister_queue(struct gendisk *disk)
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
index cd2ce4921601..6ee372f0220c 100644
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
@@ -723,11 +723,19 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 {
 	char elevator_name[ELV_NAME_MAX];
 	int ret;
+	unsigned int memflags;
+	struct request_queue *q = disk->queue;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(disk->queue, strstrip(elevator_name));
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		return count;
+
 	return ret;
 }
 
@@ -738,6 +746,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 	struct elevator_type *cur = NULL, *e;
 	int len = 0;
 
+	mutex_lock(&q->elevator_lock);
 	if (!q->elevator) {
 		len += sprintf(name+len, "[none] ");
 	} else {
@@ -755,6 +764,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 	spin_unlock(&elv_list_lock);
 
 	len += sprintf(name+len, "\n");
+	mutex_unlock(&q->elevator_lock);
 	return len;
 }
 
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
index 248416ecd01c..5690d2f3588e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -562,6 +562,7 @@ struct request_queue {
 
 	struct mutex		sysfs_lock;
 	struct mutex		limits_lock;
+	struct mutex		elevator_lock;
 
 	/*
 	 * for reusing dead hctx instance in case of updating
-- 
2.47.1

