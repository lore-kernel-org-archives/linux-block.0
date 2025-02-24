Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC417C79
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404010; cv=none; b=D2F7qB7aDlyWW8vhrcBfPBvQReC8l3P0DUs+HgrSAz5bXjKI/BoDTfwVBF71JjkXBmp7OPOlpOIAXVs+NMVDIO3Z/Yq3oV9epMq7t1SwuYst+3x4HozwpIsxFxFnnl3hN3V+Zp7WvuXYj1i158yhLhrfq8rlXxLEy6dBSk2QQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404010; c=relaxed/simple;
	bh=7FfhmbPU/IZ6+jop9I/ILGaDJWxuv1Ty1q0ER6IdK0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlB0ZkEX0MdD/+lzr6IQl4oQTrfPdZWaH9SM8qO9M7WxvwACg5//6O4KGxlMuEg1fzlhu/Uhe1zGW+o/6QVU8guMUqXr+kg1WVcrDGTMlQ7tnh4YLqbgnO+WtQsr/ffu6oWHtcRf9Oj3HrxptF17tjtOn49ASJdZBBjufKt0qls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QzaBGcJ4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QzaBGcJ4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O6Q0m8020540;
	Mon, 24 Feb 2025 13:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F/C1tkzO6wkRamums
	CvEkqUxhlco7Eub8qIl+Mo4Ztw=; b=QzaBGcJ4cilR4NMuex9q3Z4hzBpqygBjY
	5U4FVHHv2G3flQiRi+N3BaEecarpHebcq4u2Jhq99UDxDe1g4YVaYBEmcVRZGE82
	2ISeGo7NXrtCBufvRbcaSrgqZvftxpaXYk2tObMEAb/puIim+jp8wXgAamjdpvOe
	pL+4Dc+7Ogl10KG14ShwJP5m7lKo/VfzMDuD9Ii9o1s67JTLDVBugLBVAkEyzxlE
	YQhc5C7qZJcnUubx1ACkqtuht68bq83bgxeyNtkrQyTfvmXeLMMlfzRypzagF2cY
	VJSHOmKQ3gZjYTU5sYHjflN9ELnuOmJwDCroAD7oxkZKLDefDVDcw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450kg69rvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9xRTN027328;
	Mon, 24 Feb 2025 13:31:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1pw6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ODVHNI46465458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:31:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F9B920040;
	Mon, 24 Feb 2025 13:31:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AEFE2004B;
	Mon, 24 Feb 2025 13:31:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 13:31:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv3 6/7] block: protect wbt_lat_usec using q->elevator_lock
Date: Mon, 24 Feb 2025 19:00:57 +0530
Message-ID: <20250224133102.1240146-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224133102.1240146-1-nilay@linux.ibm.com>
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qiNJaksgzwD3QlOFCQzWLHdXFFAaZah4
X-Proofpoint-GUID: qiNJaksgzwD3QlOFCQzWLHdXFFAaZah4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240098

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
index 1ca0938b2fd7..8f47d9f30fbf 100644
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
-	 * attributes protected with q->sysfs_lock
-	 */
-#ifdef CONFIG_BLK_WBT
-	&queue_wb_lat_entry.attr,
-#endif
 	/*
 	 * attributes which require some form of locking
 	 * other than q->sysfs_lock
 	 */
 	&elv_iosched_entry.attr,
 	&queue_requests_entry.attr,
-
+#ifdef CONFIG_BLK_WBT
+	&queue_wb_lat_entry.attr,
+#endif
 	/*
 	 * attributes which don't require locking
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

