Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C2207DE0
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490318; cv=none; b=BWLSVnlDksm5VebwbETlTvgryuLpBgJuEB6w3HfFWmqNQ0LVDzeqgS5hRCuI8iDAHKgxsYqxR3q3e1eyeGqm7dfNVGwinUQ5boVUcWmwFf5k9C08RwY8qpqaHRF1mNwEuIDDxIMbNdWP/vDWnYDSaHxAJJgUUimBluCEEt2H61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490318; c=relaxed/simple;
	bh=uDGbmhKlv/IaqgWgecVVULcrGLFPly1ROdkthVkfTZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKwCZORafg8fH2TdtTFa5Ko4NL7qxL17A6x6HVjnkmysLSVzYwINCikM1w4igvX4YQ/KBUifWyIivn6Nd5lJqZPpqbE2gU94szfLfMHm7vVKTuIvk827fBbifp37CTXuQYEH/zCXZcqUNS7qL5OmGywdfi7QkEwbsMMrrJiQ7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KudFhseb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KudFhseb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5No5t004885;
	Tue, 25 Feb 2025 13:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3iOYoFIYqnf1AvF1e
	RPqcCm9sK49mRFqsaGJx+XsO78=; b=KudFhseba1KVoI8DrzKqCkmOyBaR2SbuH
	ns4OHuoghzqDPRvFe7nJBer/WTuIpDMN9hJvtZC6RaQ2QtfyvnywgwLOAARy9T5L
	YQQ6PSTT1Vcc84MGKNpeMk6P0JF5YX/GpBkHRqbtx4HQUWlQVtfeGBUp+WywqDb9
	dUvPcruP6OCjKFzdTlTQvQ80Uown3UhF7tinbNjlKTxwgf9QgMvwzgwac0eocAnY
	LGfkFug2nEJDDtMPvvvyvZ9kzyz1DSIfttP4jnCziHFDa7tyKZfr4tXHMQBQoQLt
	BeSMqiTFiWvkkMQxUrWspfw42uzRkR6R3nPaxfxbKKq9vZWPAA6/g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4517p8j8s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAOB3h026269;
	Tue, 25 Feb 2025 13:31:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnd3bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDVgM920906394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:31:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B60152004B;
	Tue, 25 Feb 2025 13:31:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2416520040;
	Tue, 25 Feb 2025 13:31:39 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.156.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:31:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv4 6/7] block: protect wbt_lat_usec using q->elevator_lock
Date: Tue, 25 Feb 2025 19:00:41 +0530
Message-ID: <20250225133110.1441035-7-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: Q1Dj2hsVDtwenQ2Fh9JRRTDzdvCMspyg
X-Proofpoint-ORIG-GUID: Q1Dj2hsVDtwenQ2Fh9JRRTDzdvCMspyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250092

The wbt latency and state could be updated while initializing the
elevator or exiting the elevator. It could be also updates while
configuring IO latency QoS parameters using cgroup. The elevator
code path is now protected with q->elevator_lock. So we should
protect the access to sysfs attribute wbt_lat_usec using q->elevator
_lock instead of q->sysfs_lock. White we're at it, also protect
ioc_qos_write(), which configures wbt parameters via cgroup, using
q->elevator_lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-iocost.c |  2 ++
 block/blk-sysfs.c  | 20 ++++++++------------
 2 files changed, 10 insertions(+), 12 deletions(-)

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
index 0bf00060e119..31bfd6c92b2c 100644
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
 	 * Attributes which require some form of locking
 	 * other than q->sysfs_lock.
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
-- 
2.47.1

