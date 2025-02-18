Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9122B5A1
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867367; cv=none; b=i4TN6AXUHI7KdlfeMW10Sh6v0gW52H6H3gjkmUZxFvITBDr7qwxAIEv5oO+gatMXRjx6q1Oup2OtEUIoWjKFEJSvwN1ykj/mx7LxRkJ/j0xQZGnVsEPw2+traymu1+tq17rQulxL02HDILmC0x1cJ71HzrRk2phtY/ivZFMvgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867367; c=relaxed/simple;
	bh=Phus4DwYUNqUc+UPT+ZBMDtQuoQAe4d7tQuCJebW3gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRi9bpkpB7mMhRWRSshciRg9JumYhVRIeqlcogXZDxkprS+Q+w9cvEWu438ReabRcSEv66PSd9vT2GT3j7JgFsqsUohyg7HGef6UjZ7G6QSZNQqioFTfHtt5q5h78eCkEPUE8U9fmD6FuZBxR2CDUm+8JNh1xUo6f3hDz24Q/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y/JQ7fNK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y/JQ7fNK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I5HZBw018904;
	Tue, 18 Feb 2025 08:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5+F01j7J/iDJDWult
	W/oHZXVfk6O/28GsvXmYpN1LiE=; b=Y/JQ7fNKdL1d8d/AoEJS42QY1RZ8t4AAQ
	B1LaFM9VZ5y7RfFs3y4cI6ir66l+jt5w8tKqrejJG77+ulLeWMf1pVMhPMHwNLaM
	mvF23z0Knyzok0mZaVcdWM5FMXwyGcEIrbCyZB3bMKIh54ncefxvgSaKwScSakno
	gH01q4KJrM6e733wImChAnXX7EuvGykowj33w+fgVjz+Obav/NCr0fXyjnSiz7oC
	Ds91BX4IpUDxHX8PH9hqMgtBFkfX86l2pqo8ZG1HsZwuSpjvdpFMckpOs0qmDY4i
	6sGr/dF04wIOVkoiWk57c5meRe5p+zVt6JWgDk9D7Nt9HYMY2m71w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44v7xubmdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I81P6t024851;
	Tue, 18 Feb 2025 08:29:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7y1hr7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I8TFhX34079432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:29:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0176920040;
	Tue, 18 Feb 2025 08:29:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B2D220043;
	Tue, 18 Feb 2025 08:29:13 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 08:29:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCHv2 2/6] blk-sysfs: acquire q->limits_lock while reading attributes
Date: Tue, 18 Feb 2025 13:58:55 +0530
Message-ID: <20250218082908.265283-3-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lOQ7_XoKEGKiy7N2ZrMHxWNUpvLRcfxQ
X-Proofpoint-GUID: lOQ7_XoKEGKiy7N2ZrMHxWNUpvLRcfxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180065

There're few sysfs attributes(RW) whose store method is protected with
q->limits_lock, however the corresponding show method of such attributes
runs with holding q->sysfs_lock and that doesn't make sense. Hence
update the show method of these sysfs attributes so that reading of
these attributes acquire q->limits_lock instead of q->sysfs_lock.

Similarly, there're few sysfs attributes(RO) whose show method is
currently protected with q->sysfs_lock however updates to these 
attributes could occur using atomic limit update APIs such as queue_
limits_start_update() and queue_limits_commit_update() which run 
holding q->limits_lock. So that means that reading such attributes 
holding q->sysfs_lock doesn't make sense. Hence update the show method 
of these sysfs attributes(RO) such that show method of these attributes 
runs with holding q->limits_lock instead of q->sysfs_lock. 

We have defined a new macro QUEUE_LIM_RO_ENTRY() which uses new show_
limit() method and it runs holding q->limits_lock. All sysfs existing 
attributes(RO) which needs protection using q->limits_lock while 
reading the entry have been now moved to use this new macro for 
attribute initialization.

Similarly, the existing QUEUE_LIM_RW_ENTRY() is updated to use new
show_limit() method for reading attributes instead of existing show()
method. As show_limit() runs holding q->limits_lock the existing sysfs
attributes(RW) whose read/show method needs protection using q->limits_
lock are now inherently protected. 

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 100 ++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0c9be7c7ecc1..7e22ec96f2b3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -24,6 +24,7 @@ struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
 	ssize_t (*show_nolock)(struct gendisk *disk, char *page);
+	ssize_t (*show_limit)(struct gendisk *disk, char *page);
 
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
 	ssize_t (*store_nolock)(struct gendisk *disk,
@@ -436,10 +437,16 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 	.store	= _prefix##_store,			\
 };
 
+#define QUEUE_LIM_RO_ENTRY(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {		\
+	.attr		= { .name = _name, .mode = 0644 },	\
+	.show_limit	= _prefix##_show,			\
+}
+
 #define QUEUE_LIM_RW_ENTRY(_prefix, _name)			\
-static struct queue_sysfs_entry _prefix##_entry = {	\
+static struct queue_sysfs_entry _prefix##_entry = {		\
 	.attr		= { .name = _name, .mode = 0644 },	\
-	.show		= _prefix##_show,			\
+	.show_limit	= _prefix##_show,			\
 	.store_limit	= _prefix##_store,			\
 }
 
@@ -454,39 +461,39 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
-QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
-QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
-QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
-QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
+QUEUE_LIM_RO_ENTRY(queue_max_segments, "max_segments");
+QUEUE_LIM_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
+QUEUE_LIM_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
 
-QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
-QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
-QUEUE_RO_ENTRY(queue_chunk_sectors, "chunk_sectors");
-QUEUE_RO_ENTRY(queue_io_min, "minimum_io_size");
-QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
+QUEUE_LIM_RO_ENTRY(queue_logical_block_size, "logical_block_size");
+QUEUE_LIM_RO_ENTRY(queue_physical_block_size, "physical_block_size");
+QUEUE_LIM_RO_ENTRY(queue_chunk_sectors, "chunk_sectors");
+QUEUE_LIM_RO_ENTRY(queue_io_min, "minimum_io_size");
+QUEUE_LIM_RO_ENTRY(queue_io_opt, "optimal_io_size");
 
-QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
-QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
-QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
+QUEUE_LIM_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
+QUEUE_LIM_RO_ENTRY(queue_discard_granularity, "discard_granularity");
+QUEUE_LIM_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
 QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY_NOLOCK(queue_discard_zeroes_data, "discard_zeroes_data");
 
-QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_boundary_sectors,
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_boundary_sectors,
 		"atomic_write_boundary_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY_NOLOCK(queue_write_same_max, "write_same_max_bytes");
-QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
-QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
-QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
+QUEUE_LIM_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
-QUEUE_RO_ENTRY(queue_zoned, "zoned");
+QUEUE_LIM_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY_NOLOCK(queue_nr_zones, "nr_zones");
-QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
-QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
+QUEUE_LIM_RO_ENTRY(queue_max_open_zones, "max_open_zones");
+QUEUE_LIM_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
 QUEUE_RW_ENTRY_NOLOCK(queue_nomerges, "nomerges");
 QUEUE_LIM_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
@@ -494,16 +501,16 @@ QUEUE_RW_ENTRY_NOLOCK(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY_NOLOCK(queue_poll, "io_poll");
 QUEUE_RW_ENTRY_NOLOCK(queue_poll_delay, "io_poll_delay");
 QUEUE_LIM_RW_ENTRY(queue_wc, "write_cache");
-QUEUE_RO_ENTRY(queue_fua, "fua");
-QUEUE_RO_ENTRY(queue_dax, "dax");
+QUEUE_LIM_RO_ENTRY(queue_fua, "fua");
+QUEUE_LIM_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY_NOLOCK(queue_io_timeout, "io_timeout");
-QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
-QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
+QUEUE_LIM_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
+QUEUE_LIM_RO_ENTRY(queue_dma_alignment, "dma_alignment");
 
 /* legacy alias for logical_block_size: */
 static struct queue_sysfs_entry queue_hw_sector_size_entry = {
-	.attr = {.name = "hw_sector_size", .mode = 0444 },
-	.show = queue_logical_block_size_show,
+	.attr		= {.name = "hw_sector_size", .mode = 0444 },
+	.show_limit	= queue_logical_block_size_show,
 };
 
 QUEUE_LIM_RW_ENTRY(queue_rotational, "rotational");
@@ -589,6 +596,18 @@ static struct attribute *queue_attrs[] = {
 	 * attributes protected with q->sysfs_lock
 	 */
 	&queue_ra_entry.attr,
+
+	/*
+	 * attributes protected with q->limits_lock
+	 */
+	&queue_max_sectors_entry.attr,
+	&queue_max_discard_sectors_entry.attr,
+	&queue_rotational_entry.attr,
+	&queue_iostats_passthrough_entry.attr,
+	&queue_iostats_entry.attr,
+	&queue_stable_writes_entry.attr,
+	&queue_add_random_entry.attr,
+	&queue_wc_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
 	&queue_max_discard_segments_entry.attr,
@@ -617,18 +636,6 @@ static struct attribute *queue_attrs[] = {
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
 
-	/*
-	 * attributes protected with q->limits_lock
-	 */
-	&queue_max_sectors_entry.attr,
-	&queue_max_discard_sectors_entry.attr,
-	&queue_rotational_entry.attr,
-	&queue_iostats_passthrough_entry.attr,
-	&queue_iostats_entry.attr,
-	&queue_stable_writes_entry.attr,
-	&queue_add_random_entry.attr,
-	&queue_wc_entry.attr,
-
 	/*
 	 * attributes which don't require locking
 	 */
@@ -709,12 +716,19 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	ssize_t res;
 
-	if (!entry->show && !entry->show_nolock)
+	if (!entry->show && !entry->show_nolock && !entry->show_limit)
 		return -EIO;
 
 	if (entry->show_nolock)
 		return entry->show_nolock(disk, page);
 
+	if (entry->show_limit) {
+		mutex_lock(&disk->queue->limits_lock);
+		res = entry->show_limit(disk, page);
+		mutex_unlock(&disk->queue->limits_lock);
+		return res;
+	}
+
 	mutex_lock(&disk->queue->sysfs_lock);
 	res = entry->show(disk, page);
 	mutex_unlock(&disk->queue->sysfs_lock);
-- 
2.47.1

