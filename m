Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EC18024
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573634; cv=none; b=Jr4X8+4EwnE1uV1LgHsi+5q3JSzMTUyI5mGdW5c9coX3ZEEcWY2mV++760a1k7VN/XUibSMmAz2whSV4SwOPRiYWfMlaSKIqaPHsiWb7AcFmoRapv5HDRt62crPSfNlWx97FbN82rdqeETplAnFF7V1vOCeApdngFuxaDJiC5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573634; c=relaxed/simple;
	bh=rCGGFM10aaoENGaNiZWDgMx+5Yoh6vKm5eTwdE1AHJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkFI7pBAWJApzdKNxr/XmudqmGlI/q2vdux2sp35y2y51t+okikrrvTePrvXNJIKiHVPpHxY6cyIAwOwapdmx4FHV/xpasBIme60MkrqjEjQd8KlKlsY38TXH0SSosc0ejPVVn1sNp8cMLRieRcEvL9XRQ6zqcpHnz1H6A2t8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XSTKaijF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSTKaijF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q6Pon6028806;
	Wed, 26 Feb 2025 12:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=stbldAD+oPl45gIvl
	DT4AID6KU2Y93CYcMyXBvDbgAU=; b=XSTKaijFrJDZnl0k7rHzipPy/0CFzCK2P
	rrvtgFG8+dWYxvFISUBFxjRrgda1Cq/YF6dYid1Vr3CRU+wF5oZiSmBRpvsrYYQk
	EYuYDbQfoTbKVQUeQ0DR4WKIz+veYZnNiXn73eXQwEfNfX+Z5IHtlTEEokSM/EFk
	06JGICYZLAsvFgJoFAv0u14bQOErQ3zc1VSVkpUogbaFjLH2zC98d4YnnvEOW9z0
	UF4qHMC0L2+mS/nMidM7TVR83XMlV8mzPsisOZYDT1qMyYD6bPfYMmtHngDAYdo4
	rYtxiJ0O3wuRDFTadDdABgL4rNiIX2f8aFewWu8N5Ndkw+yCgYsxw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451wp69hty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QArH9g012741;
	Wed, 26 Feb 2025 12:40:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwstv10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCeKtf34931382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:40:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A995720043;
	Wed, 26 Feb 2025 12:40:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F167520040;
	Wed, 26 Feb 2025 12:40:16 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.110.139])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:40:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv5 2/7] block: move q->sysfs_lock and queue-freeze under show/store method
Date: Wed, 26 Feb 2025 18:09:55 +0530
Message-ID: <20250226124006.1593985-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226124006.1593985-1-nilay@linux.ibm.com>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6ilXfmZSFo9clgQOHgLG5GMR2n7Kbpmd
X-Proofpoint-ORIG-GUID: 6ilXfmZSFo9clgQOHgLG5GMR2n7Kbpmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260100

In preparation to further simplify and group sysfs attributes which
don't require locking or require some form of locking other than q->
limits_lock, move acquire/release of q->sysfs_lock and queue freeze/
unfreeze under each attributes' respective show/store method.

While we are at it, also remove ->load_module() as it's used to load
the module before queue is freezed. Now as we moved queue-freeze under
->store(), we could load module directly from the attributes' store
method before we actually start freezing the queue. Currently, the
->load_module() is only used by "scheduler" attribute, so we now load
the relevant elevator module before we start freezing the queue in
elv_iosched_store().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 210 +++++++++++++++++++++++++++++++---------------
 block/elevator.c  |  20 ++++-
 2 files changed, 162 insertions(+), 68 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index eba5121690af..4700ee168ed5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -28,8 +28,6 @@ struct queue_sysfs_entry {
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
 	int (*store_limit)(struct gendisk *disk, const char *page,
 			size_t count, struct queue_limits *lim);
-
-	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
 static ssize_t
@@ -55,7 +53,12 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 
 static ssize_t queue_requests_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(disk->queue->nr_requests, page);
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	ret = queue_var_show(disk->queue->nr_requests, page);
+	mutex_unlock(&disk->queue->sysfs_lock);
+	return ret;
 }
 
 static ssize_t
@@ -63,27 +66,38 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long nr;
 	int ret, err;
+	unsigned int memflags;
+	struct request_queue *q = disk->queue;
 
-	if (!queue_is_mq(disk->queue))
+	if (!queue_is_mq(q))
 		return -EINVAL;
 
 	ret = queue_var_store(&nr, page, count);
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
 	if (nr < BLKDEV_MIN_RQ)
 		nr = BLKDEV_MIN_RQ;
 
 	err = blk_mq_update_nr_requests(disk->queue, nr);
 	if (err)
-		return err;
-
+		ret = err;
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 	return ret;
 }
 
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	ret = queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
+	mutex_unlock(&disk->queue->sysfs_lock);
+
+	return ret;
 }
 
 static ssize_t
@@ -91,11 +105,19 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long ra_kb;
 	ssize_t ret;
+	unsigned int memflags;
+	struct request_queue *q = disk->queue;
 
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
+
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
 	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
+
 	return ret;
 }
 
@@ -150,7 +172,12 @@ QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_hw_sectors)
 #define QUEUE_SYSFS_SHOW_CONST(_name, _val)				\
 static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 {									\
-	return sysfs_emit(page, "%d\n", _val);				\
+	ssize_t ret;							\
+									\
+	mutex_lock(&disk->queue->sysfs_lock);				\
+	ret = sysfs_emit(page, "%d\n", _val);				\
+	mutex_unlock(&disk->queue->sysfs_lock);				\
+	return ret;							\
 }
 
 /* deprecated fields */
@@ -239,10 +266,17 @@ QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
 
 static ssize_t queue_poll_show(struct gendisk *disk, char *page)
 {
-	if (queue_is_mq(disk->queue))
-		return sysfs_emit(page, "%u\n", blk_mq_can_poll(disk->queue));
-	return sysfs_emit(page, "%u\n",
-		!!(disk->queue->limits.features & BLK_FEAT_POLL));
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	if (queue_is_mq(disk->queue)) {
+		ret = sysfs_emit(page, "%u\n", blk_mq_can_poll(disk->queue));
+	} else {
+		ret = sysfs_emit(page, "%u\n",
+			!!(disk->queue->limits.features & BLK_FEAT_POLL));
+	}
+	mutex_unlock(&disk->queue->sysfs_lock);
+	return ret;
 }
 
 static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
@@ -254,7 +288,12 @@ static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 
 static ssize_t queue_nr_zones_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(disk_nr_zones(disk), page);
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	ret = queue_var_show(disk_nr_zones(disk), page);
+	mutex_unlock(&disk->queue->sysfs_lock);
+	return ret;
 }
 
 static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char *page)
@@ -281,35 +320,51 @@ static int queue_iostats_passthrough_store(struct gendisk *disk,
 
 static ssize_t queue_nomerges_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	ret = queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
 			       blk_queue_noxmerges(disk->queue), page);
+	mutex_unlock(&disk->queue->sysfs_lock);
+	return ret;
 }
 
 static ssize_t queue_nomerges_store(struct gendisk *disk, const char *page,
 				    size_t count)
 {
 	unsigned long nm;
+	unsigned int memflags;
+	struct request_queue *q = disk->queue;
 	ssize_t ret = queue_var_store(&nm, page, count);
 
 	if (ret < 0)
 		return ret;
 
-	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, disk->queue);
-	blk_queue_flag_clear(QUEUE_FLAG_NOXMERGES, disk->queue);
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
+	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
+	blk_queue_flag_clear(QUEUE_FLAG_NOXMERGES, q);
 	if (nm == 2)
-		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, disk->queue);
+		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	else if (nm)
-		blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, disk->queue);
+		blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 
 	return ret;
 }
 
 static ssize_t queue_rq_affinity_show(struct gendisk *disk, char *page)
 {
-	bool set = test_bit(QUEUE_FLAG_SAME_COMP, &disk->queue->queue_flags);
-	bool force = test_bit(QUEUE_FLAG_SAME_FORCE, &disk->queue->queue_flags);
+	ssize_t ret;
+	bool set, force;
 
-	return queue_var_show(set << force, page);
+	mutex_lock(&disk->queue->sysfs_lock);
+	set = test_bit(QUEUE_FLAG_SAME_COMP, &disk->queue->queue_flags);
+	force = test_bit(QUEUE_FLAG_SAME_FORCE, &disk->queue->queue_flags);
+	ret = queue_var_show(set << force, page);
+	mutex_unlock(&disk->queue->sysfs_lock);
+	return ret;
 }
 
 static ssize_t
@@ -319,11 +374,14 @@ queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 #ifdef CONFIG_SMP
 	struct request_queue *q = disk->queue;
 	unsigned long val;
+	unsigned int memflags;
 
 	ret = queue_var_store(&val, page, count);
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
 	if (val == 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
@@ -334,6 +392,8 @@ queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
 	}
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 #endif
 	return ret;
 }
@@ -347,29 +407,52 @@ static ssize_t queue_poll_delay_store(struct gendisk *disk, const char *page,
 static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 				size_t count)
 {
-	if (!(disk->queue->limits.features & BLK_FEAT_POLL))
-		return -EINVAL;
+	unsigned int memflags;
+	ssize_t ret = count;
+	struct request_queue *q = disk->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
+	if (!(q->limits.features & BLK_FEAT_POLL)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
 	pr_info_ratelimited("please use driver specific parameters instead.\n");
-	return count;
+out:
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
+
+	return ret;
 }
 
 static ssize_t queue_io_timeout_show(struct gendisk *disk, char *page)
 {
-	return sysfs_emit(page, "%u\n", jiffies_to_msecs(disk->queue->rq_timeout));
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->sysfs_lock);
+	ret = sysfs_emit(page, "%u\n",
+			jiffies_to_msecs(disk->queue->rq_timeout));
+	mutex_unlock(&disk->queue->sysfs_lock);
+	return ret;
 }
 
 static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
 				  size_t count)
 {
-	unsigned int val;
+	unsigned int val, memflags;
 	int err;
+	struct request_queue *q = disk->queue;
 
 	err = kstrtou32(page, 10, &val);
 	if (err || val == 0)
 		return -EINVAL;
 
-	blk_queue_rq_timeout(disk->queue, msecs_to_jiffies(val));
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
+	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 
 	return count;
 }
@@ -428,14 +511,6 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 	.store_limit	= _prefix##_store,			\
 }
 
-#define QUEUE_RW_LOAD_MODULE_ENTRY(_prefix, _name)		\
-static struct queue_sysfs_entry _prefix##_entry = {		\
-	.attr		= { .name = _name, .mode = 0644 },	\
-	.show		= _prefix##_show,			\
-	.load_module	= _prefix##_load_module,		\
-	.store		= _prefix##_store,			\
-}
-
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
@@ -443,7 +518,7 @@ QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_LIM_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_LIM_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_LIM_RO_ENTRY(queue_max_segment_size, "max_segment_size");
-QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_ENTRY(elv_iosched, "scheduler");
 
 QUEUE_LIM_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_LIM_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -512,14 +587,24 @@ static ssize_t queue_var_store64(s64 *var, const char *page)
 
 static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 {
-	if (!wbt_rq_qos(disk->queue))
-		return -EINVAL;
+	ssize_t ret;
+	struct request_queue *q = disk->queue;
 
-	if (wbt_disabled(disk->queue))
-		return sysfs_emit(page, "0\n");
+	mutex_lock(&q->sysfs_lock);
+	if (!wbt_rq_qos(q)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	return sysfs_emit(page, "%llu\n",
-		div_u64(wbt_get_min_lat(disk->queue), 1000));
+	if (wbt_disabled(q)) {
+		ret = sysfs_emit(page, "0\n");
+		goto out;
+	}
+
+	ret = sysfs_emit(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+out:
+	mutex_unlock(&q->sysfs_lock);
+	return ret;
 }
 
 static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
@@ -529,6 +614,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	struct rq_qos *rqos;
 	ssize_t ret;
 	s64 val;
+	unsigned int memflags;
 
 	ret = queue_var_store64(&val, page);
 	if (ret < 0)
@@ -536,20 +622,24 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
+
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
 		ret = wbt_init(disk);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+	ret = count;
 	if (val == -1)
 		val = wbt_default_latency_nsec(q);
 	else if (val >= 0)
 		val *= 1000ULL;
 
 	if (wbt_get_min_lat(q) == val)
-		return count;
+		goto out;
 
 	/*
 	 * Ensure that the queue is idled, in case the latency update
@@ -561,8 +651,11 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	wbt_set_min_lat(q, val);
 
 	blk_mq_unquiesce_queue(q);
+out:
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 
-	return count;
+	return ret;
 }
 
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
@@ -684,22 +777,20 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
-	ssize_t res;
 
 	if (!entry->show && !entry->show_limit)
 		return -EIO;
 
 	if (entry->show_limit) {
+		ssize_t res;
+
 		mutex_lock(&disk->queue->limits_lock);
 		res = entry->show_limit(disk, page);
 		mutex_unlock(&disk->queue->limits_lock);
 		return res;
 	}
 
-	mutex_lock(&disk->queue->sysfs_lock);
-	res = entry->show(disk, page);
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return res;
+	return entry->show(disk, page);
 }
 
 static ssize_t
@@ -709,21 +800,13 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
-	unsigned int memflags;
-	ssize_t res;
 
 	if (!entry->store_limit && !entry->store)
 		return -EIO;
 
-	/*
-	 * If the attribute needs to load a module, do it before freezing the
-	 * queue to ensure that the module file can be read when the request
-	 * queue is the one for the device storing the module file.
-	 */
-	if (entry->load_module)
-		entry->load_module(disk, page, length);
-
 	if (entry->store_limit) {
+		ssize_t res;
+
 		struct queue_limits lim = queue_limits_start_update(q);
 
 		res = entry->store_limit(disk, page, length, &lim);
@@ -738,12 +821,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
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
diff --git a/block/elevator.c b/block/elevator.c
index cd2ce4921601..041f1d983bc7 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -723,11 +723,24 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 {
 	char elevator_name[ELV_NAME_MAX];
 	int ret;
+	unsigned int memflags;
+	struct request_queue *q = disk->queue;
 
+	/*
+	 * If the attribute needs to load a module, do it before freezing the
+	 * queue to ensure that the module file can be read when the request
+	 * queue is the one for the device storing the module file.
+	 */
+	elv_iosched_load_module(disk, buf, count);
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	ret = elevator_change(disk->queue, strstrip(elevator_name));
+
+	mutex_lock(&q->sysfs_lock);
+	memflags = blk_mq_freeze_queue(q);
+	ret = elevator_change(q, strstrip(elevator_name));
 	if (!ret)
-		return count;
+		ret = count;
+	blk_mq_unfreeze_queue(q, memflags);
+	mutex_unlock(&q->sysfs_lock);
 	return ret;
 }
 
@@ -738,6 +751,7 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 	struct elevator_type *cur = NULL, *e;
 	int len = 0;
 
+	mutex_lock(&q->sysfs_lock);
 	if (!q->elevator) {
 		len += sprintf(name+len, "[none] ");
 	} else {
@@ -755,6 +769,8 @@ ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 	spin_unlock(&elv_list_lock);
 
 	len += sprintf(name+len, "\n");
+	mutex_unlock(&q->sysfs_lock);
+
 	return len;
 }
 
-- 
2.47.1

