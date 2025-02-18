Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF922AE7F
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867366; cv=none; b=nLgKBNIFqZ8F1eBJx1h4iBlMrMiRR2kM2Erj5JiOZUjGrSAHlC5no4/7F0LOTd+TAsRhKpDrkPDuM7R+RHTugtSEKlL3d704sMm+4FhrVFaK8Cqolfd0xi8MNkV2lUHjKvwskMRMVCfPPzGpYKnyOrb7QwdjfEKnP99dlnhdFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867366; c=relaxed/simple;
	bh=dkxURuYzRfJuSJPVhfwACsfgHPbG7h5tpAFQfXOFHOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfFVtAM6u1WQnVJt6b3K+JoGRHTDs4Mqaj5mB9vFxnltQYFSvAn9MP9ooWIpsR9xvHiRKjKZVkFKcYycD2bCZ2TuanR9dPsTBRh4roOTFCyPY5koZSv3VKbFSLuDWz2YOV2nTllXOB+IPIUuVSqLUjpCNANWQU/oJYix8JoGyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rPPczPRZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rPPczPRZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I18qrH020796;
	Tue, 18 Feb 2025 08:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XJ0Wczo/XXxkErHfn
	Jfx0Ov8oLPx04SfsYbfkPePp60=; b=rPPczPRZm6Nbum27DopAf3F6sPoWtTnbk
	U5X0Z+DJmfzKzQiTqeGMUs/LhAnmoF8zzgBA+vJyJT4jaSX9BVaOnjkiCNAFKHEy
	qFSL/Yw31/KUsXidTcjtCaizUM1sU0T95w2jIl2oN3Rc86/rLdkd7tv6biKSCvC0
	hpbnL0V2esKRERzNDh76th2ypPqqwsz8QLvpOvYBMwYtbPCBAxrEpDjos3fXvsv2
	I/rnTW70dEHta98K5qfihpFZkqimdJ2uKTMkal3eRlHMoeUgU2BztjiX2uj26a4D
	sH2+xJrWAgyM43FSg1pXro5bqt6WySuh2/afx0BEPdGvQma0nH3mQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vg99sjh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I63nEO001641;
	Tue, 18 Feb 2025 08:29:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5myt5xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I8TDuk31654352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:29:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 273FF20043;
	Tue, 18 Feb 2025 08:29:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7349F20040;
	Tue, 18 Feb 2025 08:29:11 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 08:29:11 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes which don't need it
Date: Tue, 18 Feb 2025 13:58:54 +0530
Message-ID: <20250218082908.265283-2-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: jVTUaNN2HJkeP2F0ySxESLqnh19RZIQV
X-Proofpoint-ORIG-GUID: jVTUaNN2HJkeP2F0ySxESLqnh19RZIQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180065

There're few sysfs attributes in block layer which don't really need
acquiring q->sysfs_lock while accessing it. The reason being, writing
a value to such attributes are either atomic or could be easily
protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
are inherently protected with sysfs/kernfs internal locking.

So this change help segregate all existing sysfs attributes for which 
we could avoid acquiring q->sysfs_lock. We group all such attributes,
which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
method (show_nolock/store_nolock) is assigned to attributes using these 
new macros. The show_nolock/store_nolock run without holding q->sysfs_
lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-settings.c |   2 +-
 block/blk-sysfs.c    | 106 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 81 insertions(+), 27 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..c541bf22f543 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -21,7 +21,7 @@
 
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
-	q->rq_timeout = timeout;
+	WRITE_ONCE(q->rq_timeout, timeout);
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6f548a4376aa..0c9be7c7ecc1 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -23,9 +23,14 @@
 struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
+	ssize_t (*show_nolock)(struct gendisk *disk, char *page);
+
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
+	ssize_t (*store_nolock)(struct gendisk *disk,
+			const char *page, size_t count);
 	int (*store_limit)(struct gendisk *disk, const char *page,
 			size_t count, struct queue_limits *lim);
+
 	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
@@ -320,7 +325,12 @@ queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 	ret = queue_var_store(&val, page, count);
 	if (ret < 0)
 		return ret;
-
+	/*
+	 * Here we update two queue flags each using atomic bitops, although
+	 * updating two flags isn't atomic it should be harmless as those flags
+	 * are accessed individually using atomic test_bit operation. So we
+	 * don't grab any lock while updating these flags.
+	 */
 	if (val == 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
@@ -353,7 +363,8 @@ static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 
 static ssize_t queue_io_timeout_show(struct gendisk *disk, char *page)
 {
-	return sysfs_emit(page, "%u\n", jiffies_to_msecs(disk->queue->rq_timeout));
+	return sysfs_emit(page, "%u\n",
+			jiffies_to_msecs(READ_ONCE(disk->queue->rq_timeout)));
 }
 
 static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
@@ -405,6 +416,19 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 	.show	= _prefix##_show,			\
 };
 
+#define QUEUE_RO_ENTRY_NOLOCK(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {		\
+	.attr		= {.name = _name, .mode = 0644 },	\
+	.show_nolock	= _prefix##_show,			\
+}
+
+#define QUEUE_RW_ENTRY_NOLOCK(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {		\
+	.attr		= {.name = _name, .mode = 0644 },	\
+	.show_nolock	= _prefix##_show,			\
+	.store_nolock	= _prefix##_store,			\
+}
+
 #define QUEUE_RW_ENTRY(_prefix, _name)			\
 static struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr	= { .name = _name, .mode = 0644 },	\
@@ -446,7 +470,7 @@ QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
 QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
 QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
 QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
-QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
+QUEUE_RO_ENTRY_NOLOCK(queue_discard_zeroes_data, "discard_zeroes_data");
 
 QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
 QUEUE_RO_ENTRY(queue_atomic_write_boundary_sectors,
@@ -454,25 +478,25 @@ QUEUE_RO_ENTRY(queue_atomic_write_boundary_sectors,
 QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
 QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
-QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
+QUEUE_RO_ENTRY_NOLOCK(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
-QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
+QUEUE_RO_ENTRY_NOLOCK(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
-QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
+QUEUE_RW_ENTRY_NOLOCK(queue_nomerges, "nomerges");
 QUEUE_LIM_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
-QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
-QUEUE_RW_ENTRY(queue_poll, "io_poll");
-QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
+QUEUE_RW_ENTRY_NOLOCK(queue_rq_affinity, "rq_affinity");
+QUEUE_RW_ENTRY_NOLOCK(queue_poll, "io_poll");
+QUEUE_RW_ENTRY_NOLOCK(queue_poll_delay, "io_poll_delay");
 QUEUE_LIM_RW_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
-QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
+QUEUE_RW_ENTRY_NOLOCK(queue_io_timeout, "io_timeout");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
 
@@ -561,9 +585,11 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 
 /* Common attributes for bio-based and request-based queues. */
 static struct attribute *queue_attrs[] = {
+	/*
+	 * attributes protected with q->sysfs_lock
+	 */
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
-	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
 	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
@@ -575,46 +601,63 @@ static struct attribute *queue_attrs[] = {
 	&queue_io_min_entry.attr,
 	&queue_io_opt_entry.attr,
 	&queue_discard_granularity_entry.attr,
-	&queue_max_discard_sectors_entry.attr,
 	&queue_max_hw_discard_sectors_entry.attr,
-	&queue_discard_zeroes_data_entry.attr,
 	&queue_atomic_write_max_sectors_entry.attr,
 	&queue_atomic_write_boundary_sectors_entry.attr,
 	&queue_atomic_write_unit_min_entry.attr,
 	&queue_atomic_write_unit_max_entry.attr,
-	&queue_write_same_max_entry.attr,
 	&queue_max_write_zeroes_sectors_entry.attr,
 	&queue_max_zone_append_sectors_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
-	&queue_rotational_entry.attr,
 	&queue_zoned_entry.attr,
-	&queue_nr_zones_entry.attr,
 	&queue_max_open_zones_entry.attr,
 	&queue_max_active_zones_entry.attr,
-	&queue_nomerges_entry.attr,
+	&queue_fua_entry.attr,
+	&queue_dax_entry.attr,
+	&queue_virt_boundary_mask_entry.attr,
+	&queue_dma_alignment_entry.attr,
+
+	/*
+	 * attributes protected with q->limits_lock
+	 */
+	&queue_max_sectors_entry.attr,
+	&queue_max_discard_sectors_entry.attr,
+	&queue_rotational_entry.attr,
 	&queue_iostats_passthrough_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_add_random_entry.attr,
-	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
-	&queue_fua_entry.attr,
-	&queue_dax_entry.attr,
+
+	/*
+	 * attributes which don't require locking
+	 */
+	&queue_nomerges_entry.attr,
+	&queue_poll_entry.attr,
 	&queue_poll_delay_entry.attr,
-	&queue_virt_boundary_mask_entry.attr,
-	&queue_dma_alignment_entry.attr,
+	&queue_discard_zeroes_data_entry.attr,
+	&queue_write_same_max_entry.attr,
+	&queue_nr_zones_entry.attr,
+
 	NULL,
 };
 
 /* Request-based queue attributes that are not relevant for bio-based queues. */
 static struct attribute *blk_mq_queue_attrs[] = {
+	/*
+	 * attributes protected with q->sysfs_lock
+	 */
 	&queue_requests_entry.attr,
 	&elv_iosched_entry.attr,
-	&queue_rq_affinity_entry.attr,
-	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
+	/*
+	 * attrbiutes which don't require locking
+	 */
+	&queue_rq_affinity_entry.attr,
+	&queue_io_timeout_entry.attr,
+
 	NULL,
 };
 
@@ -666,8 +709,12 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	ssize_t res;
 
-	if (!entry->show)
+	if (!entry->show && !entry->show_nolock)
 		return -EIO;
+
+	if (entry->show_nolock)
+		return entry->show_nolock(disk, page);
+
 	mutex_lock(&disk->queue->sysfs_lock);
 	res = entry->show(disk, page);
 	mutex_unlock(&disk->queue->sysfs_lock);
@@ -684,7 +731,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	unsigned int memflags;
 	ssize_t res;
 
-	if (!entry->store_limit && !entry->store)
+	if (!entry->store_limit && !entry->store_nolock && !entry->store)
 		return -EIO;
 
 	/*
@@ -695,6 +742,13 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->load_module)
 		entry->load_module(disk, page, length);
 
+	if (entry->store_nolock) {
+		memflags = blk_mq_freeze_queue(q);
+		res = entry->store_nolock(disk, page, length);
+		blk_mq_unfreeze_queue(q, memflags);
+		return res;
+	}
+
 	if (entry->store_limit) {
 		struct queue_limits lim = queue_limits_start_update(q);
 
-- 
2.47.1

