Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0221506A
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573772; cv=none; b=jeDoJpXfLj/EtgJzS1myNG7XsSq0eAIxRkcVHUBm5GJxqeIdrdv5cXXG6frZn6kidVHBU7VMM7ywnZsdXnAT3ikaQu5CqRXIX9xK8igS+Uqo6NY/Ze3lpbt/QV/r/dfAmm2hvnN0zgzGLuR7akU4/Zf7fGKE3by7d8Qd/Ywpyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573772; c=relaxed/simple;
	bh=PtAOfHyfrjd0LrqBGdVDUxkQhHekm29uGUjIFTtuVP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckZMfOP1e133H1a874QgsY3cYHyJ0BQq+jZZKCvDo49NRmYO9Youket6K6bkJ7FlROD198N7mVsZv12rfvxuypxepszWlY2TkHD9JO1hOoqnfj2yT+70ATI2hswh/cXVXuhe1nLD2cmLKHtB6amwU9pkC2kC51IalagZcd8OTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M3bTwVSd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M3bTwVSd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q7WiVY005931;
	Wed, 26 Feb 2025 12:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hY+4KegWEWw1DMz+h
	fH/0wULhmuXfP71/r4H3UJc36Q=; b=M3bTwVSd4gybO0iRR+W7T7PXtOEp+B164
	FCx6bCEG/A4tXKtGb9GtMAUeLkaeZgsT/9I8q8onzz71hqb/AENJk2n2uRJeF1no
	yjNEbjodnt8sjJEncUmmoLT6/J7+5aDvnw3ZEOZ7vzRSa0w9z5zVVEAEPnsPR1at
	51CBX7GViKQHFcL4Zyhdl1IxHtZiDhW4bgr6gPjCWJA4NlbxURWoqFuyIrc63rPC
	hLc7zlsSFIY7GTVvQZZ8gn2dfc+j48PaW1MZ9UUC7dyfumFKC+pUhIgbQ0MOW4lG
	myejh5U8A9EaHDVjr1I9xp7uhTj+4E8ajnRN/ajH4RrVKvU/0ZzFw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp19jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QASJJr012465;
	Wed, 26 Feb 2025 12:40:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwstv2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCecdE41877962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:40:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45FA20043;
	Wed, 26 Feb 2025 12:40:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BBFA20040;
	Wed, 26 Feb 2025 12:40:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.110.139])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:40:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock
Date: Wed, 26 Feb 2025 18:09:59 +0530
Message-ID: <20250226124006.1593985-7-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ddYkTTOgDABREmeX2cx8Ma_KKu6cktsE
X-Proofpoint-GUID: ddYkTTOgDABREmeX2cx8Ma_KKu6cktsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260100

The wbt latency and state could be updated while initializing the
elevator or exiting the elevator. It could be also updated while
configuring IO latency QoS parameters using cgroup. The elevator
code path is now protected with q->elevator_lock. So we should
protect the access to sysfs attribute wbt_lat_usec using q->elevator
_lock instead of q->sysfs_lock. White we're at it, also protect
ioc_qos_write(), which configures wbt parameters via cgroup, using
q->elevator_lock.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-iocost.c     |  2 ++
 block/blk-sysfs.c      | 14 ++++++++------
 include/linux/blkdev.h |  4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

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
index f1fa57de29ed..46033d640e30 100644
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
@@ -701,7 +701,9 @@ static struct attribute *blk_mq_queue_attrs[] = {
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
@@ -882,10 +884,10 @@ int blk_register_queue(struct gendisk *disk)
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
index 3e66ad016a23..0ee3b5c9388e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -563,8 +563,8 @@ struct request_queue {
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

