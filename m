Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F01FDE2B
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084042; cv=none; b=hhhHs0/N2NX0mmThpYFrequxT5X8e85gGv5qFPUCCjyJQshG91gaYrsdvqo9imjDlaCdf3oqNW+a6dB/XjXt+hpX0BkgDXkbuzxMG2Vu7Ss/rSXhCBO6wkP+o1zjEj+3s6rDEMNvWrhH42uOc3pLuX1pejYuGyZ2n7zwFH1derU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084042; c=relaxed/simple;
	bh=qYsOmkxmJSbULeA+8DFy3RPhafw0wQFz03I/J6MOXOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubPnXhVj4X++gnUAOrI57tNZkGFNTMMYrRxqmhwSWpi3LC/DZKHjIGk4/PbptfTjqMKYKjcFnefpfAAftZ99NIB0WH62cVhHFm8vbfq1jSu9L1ZuuMJFZgadS+a5LgqyLTCL8Fq9JeDDemlQb64AEKCU1/Ar0yZUXvIX+VRXnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a5CojEmm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a5CojEmm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5248ELH1025152;
	Tue, 4 Mar 2025 10:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J8n/OYwF2NrL4z8Nu
	bu6AZFt+EdMcDh2V1mtV3lXCAs=; b=a5CojEmmhCi6+Jmq8lNlwvTM4Pqr8heRf
	duHB968zLsXdg/qrskHxa9dxqUPqNCQq0gjdUfY0uQnHmyqnjF+9XefFSnusdHw9
	PWp8LHSiEBbWLYLgJBlkt0dFMBWVo3OJj502zvfJI7vTZpzQzxtoITYbx8GhGNDT
	O1SzoMGRAwm9q1e7fnn/AZDtEHJCIsioZmrb4Ljy4zm8g4FiJJosqUbNafHnKtrd
	mf+3djQbcjKlUETgoKRIORqe9zQsQZLGeTI4L6TM9j5Unvcim82KutSl5KKiS6J1
	+Ke3To0iQwiZjbOi/YUMwG7Xo4uMr1d4KNJPl+SsGOk4zF6iyNg7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455cf2pm8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:26:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5248FXx1013728;
	Tue, 4 Mar 2025 10:26:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kmsp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:26:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524AQ7p958917250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 10:26:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6F8820040;
	Tue,  4 Mar 2025 10:26:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E996A20043;
	Tue,  4 Mar 2025 10:26:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 10:26:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, lkp@intel.com, gjoyce@ibm.com
Subject: [PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock
Date: Tue,  4 Mar 2025 15:52:35 +0530
Message-ID: <20250304102551.2533767-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250304102551.2533767-1-nilay@linux.ibm.com>
References: <20250304102551.2533767-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vzze_AJ0ee9Jxyj84VpnJDupQKEaHJs0
X-Proofpoint-ORIG-GUID: vzze_AJ0ee9Jxyj84VpnJDupQKEaHJs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040084

The wbt latency and state could be updated while initializing the
elevator or exiting the elevator. It could be also updated while
configuring IO latency QoS parameters using cgroup. The elevator
code path is now protected with q->elevator_lock. So we should
protect the access to sysfs attribute wbt_lat_usec using q->elevator
_lock instead of q->sysfs_lock. White we're at it, also protect
ioc_qos_write(), which configures wbt parameters via cgroup, using
q->elevator_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-iocost.c     |  2 ++
 block/blk-sysfs.c      | 20 ++++++++------------
 include/linux/blkdev.h |  4 ++--
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 65a1d4427ccf..c68373361301 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3249,6 +3249,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	}
 
 	memflags = blk_mq_freeze_queue(disk->queue);
+	mutex_lock(&disk->queue->elevator_lock);
 	blk_mq_quiesce_queue(disk->queue);
 
 	spin_lock_irq(&ioc->lock);
@@ -3356,6 +3357,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(disk->queue);
+	mutex_unlock(&disk->queue->elevator_lock);
 	blk_mq_unfreeze_queue(disk->queue, memflags);
 
 	ret = -EINVAL;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f1fa57de29ed..223da196a548 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -557,7 +557,7 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 	ssize_t ret;
 	struct request_queue *q = disk->queue;
 
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
 	if (!wbt_rq_qos(q)) {
 		ret = -EINVAL;
 		goto out;
@@ -570,7 +570,7 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 
 	ret = sysfs_emit(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
 out:
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 	return ret;
 }
 
@@ -589,8 +589,8 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
@@ -619,8 +619,8 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 
 	blk_mq_unquiesce_queue(q);
 out:
+	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 
 	return ret;
 }
@@ -689,19 +689,15 @@ static struct attribute *queue_attrs[] = {
 
 /* Request-based queue attributes that are not relevant for bio-based queues. */
 static struct attribute *blk_mq_queue_attrs[] = {
-	/*
-	 * Attributes which are protected with q->sysfs_lock.
-	 */
-#ifdef CONFIG_BLK_WBT
-	&queue_wb_lat_entry.attr,
-#endif
 	/*
 	 * Attributes which require some form of locking other than
 	 * q->sysfs_lock.
 	 */
 	&elv_iosched_entry.attr,
 	&queue_requests_entry.attr,
-
+#ifdef CONFIG_BLK_WBT
+	&queue_wb_lat_entry.attr,
+#endif
 	/*
 	 * Attributes which don't require locking.
 	 */
@@ -882,10 +878,10 @@ int blk_register_queue(struct gendisk *disk)
 			goto out_crypto_sysfs_unregister;
 		}
 	}
+	wbt_enable_default(disk);
 	mutex_unlock(&q->elevator_lock);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-	wbt_enable_default(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed8d139a4f5d..2977a583d740 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -565,8 +565,8 @@ struct request_queue {
 	/*
 	 * Protects against I/O scheduler switching, particularly when
 	 * updating q->elevator. Since the elevator update code path may
-	 * also modify q->nr_requests, this lock also protects the sysfs
-	 * attribute nr_requests.
+	 * also modify q->nr_requests and wbt latency, this lock also
+	 * protects the sysfs attributes nr_requests and wbt_lat_usec.
 	 * To ensure proper locking order during an elevator update, first
 	 * freeze the queue, then acquire ->elevator_lock.
 	 */
-- 
2.47.1

