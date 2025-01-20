Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1591E0DB5
	for <linux-block@vger.kernel.org>; Mon, 20 Jan 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378270; cv=none; b=ADMwBNdyjCrKl8honq4LJfqd3X5x9Ri2wGw6n+v3Zji5nYWUDDjNkOCogt7/GnYn9mMeognr+qqodGeb7ZDdxuE7d6z5THFgkHl+EWuqF6r6xOlKF2dPx/qPnQ75OpMGyziZ1qTtxYNi1u9URBrzC65XBNrwJU7w8mc3fir5G5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378270; c=relaxed/simple;
	bh=OMkSEQ3Om3bt61Y0D7WBiLPMsczFYqpKJt++8SUBbc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+ZCPq3na9vz/Ak/8OMYTe2EZcvaiWu4dQY3Q/1yo8/TTGSsn+XtZzOsA4HUdBfClXLQAixTpBn6yIFKladQrmtIMzftPkjBM6QlbqstZiL35slqzg20VYXp78TuUPV0op7NFFgPp1ZbW31MmRCFV9VtnYIzKyK7b1a5wklRBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YfzVO6QO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YfzVO6QO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9HuwX011031;
	Mon, 20 Jan 2025 13:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g0giwmre8Ni/12YNy
	VbZqPkt1qu45fUCw3uvisJt0tE=; b=YfzVO6QOTDLdgmzp8q18caoa1aKEj12Iz
	t8O7AP/dtix/wNNIJsbGeVMvcubm+myciCkgC8IP9eYYECQw/25zJet5HtoC4PuB
	J1NqOOjnT1Z6DCsHWqA7fGG2rPIf8VG1vXdqrX+ijP3uMZN2DSI5EZldAnzdeZ2o
	s1WFs7RHFyZCYrxColtbnka8jkjqjIZuu4P7KhNP5ouSTYdB7u+mRBnFVafy/QEa
	duTEuvK719tIcy8tsHDXezGUBNcg8CAc45IFVc8o1QmvqPTB5zAbTnGCPFLDNMJ2
	TZ+f7q4rAZlmqzIZGoErrcNRzoXLGUjbalEr8Q6uyBdsOTE8rzDQA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4493ny499r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 13:04:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K97Pvd032248;
	Mon, 20 Jan 2025 13:04:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruje4bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 13:04:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KD4HMK46072146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 13:04:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 547E02004B;
	Mon, 20 Jan 2025 13:04:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB8820040;
	Mon, 20 Jan 2025 13:04:16 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.54.147])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 13:04:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [RFC PATCH 1/1] block: get rid of request queue ->sysfs_dir_lock
Date: Mon, 20 Jan 2025 18:34:11 +0530
Message-ID: <20250120130413.789737-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250120130413.789737-1-nilay@linux.ibm.com>
References: <20250120130413.789737-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OMnzniyJvxmZKTVbqoggQxysvcaUWcOj
X-Proofpoint-GUID: OMnzniyJvxmZKTVbqoggQxysvcaUWcOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=910 bulkscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200108

The request queue uses ->sysfs_dir_lock for protecting the addition/
deletion of kobject entries under sysfs while we register/unregister
blk-mq. However kobject addition/deletion is already protected with
kernfs/sysfs internal synchronization primitives. So use of q->sysfs_
dir_lock seems redundant.

Moreover, q->sysfs_dir_lock is also used at few other callsites along
with q->sysfs_lock for protecting the addition/deletion of kojects.
One such example is when we register with sysfs a set of independent
access ranges for a disk. Here as well we could get rid off q->sysfs_
dir_lock and only use q->sysfs_lock.

The only variable which q->sysfs_dir_lock appears to protect is q->
mq_sysfs_init_done which is set/unset while registering/unregistering
blk-mq with sysfs. But this variable could be easily converted to an
atomic type and used safely without using q->sysfs_dir_lock.

So with this patch we remove q->sysfs_dir_lock from each callsite
and also make q->mq_sysfs_init_done an atomic variable.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-core.c       |  1 -
 block/blk-ia-ranges.c  |  4 ----
 block/blk-mq-sysfs.c   | 25 +++++++------------------
 block/blk-sysfs.c      |  5 -----
 include/linux/blkdev.h |  3 +--
 5 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 32fb28a6372c..d6c4fa3943b5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -430,7 +430,6 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	refcount_set(&q->refs, 1);
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->sysfs_lock);
-	mutex_init(&q->sysfs_dir_lock);
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index c9eb4241e048..d479f5481b66 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -111,7 +111,6 @@ int disk_register_independent_access_ranges(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	int i, ret;
 
-	lockdep_assert_held(&q->sysfs_dir_lock);
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (!iars)
@@ -155,7 +154,6 @@ void disk_unregister_independent_access_ranges(struct gendisk *disk)
 	struct blk_independent_access_ranges *iars = disk->ia_ranges;
 	int i;
 
-	lockdep_assert_held(&q->sysfs_dir_lock);
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (!iars)
@@ -289,7 +287,6 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
 {
 	struct request_queue *q = disk->queue;
 
-	mutex_lock(&q->sysfs_dir_lock);
 	mutex_lock(&q->sysfs_lock);
 	if (iars && !disk_check_ia_ranges(disk, iars)) {
 		kfree(iars);
@@ -313,6 +310,5 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
 		disk_register_independent_access_ranges(disk);
 unlock:
 	mutex_unlock(&q->sysfs_lock);
-	mutex_unlock(&q->sysfs_dir_lock);
 }
 EXPORT_SYMBOL_GPL(disk_set_independent_access_ranges);
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 156e9bb07abf..0d2226035ab6 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -223,8 +223,6 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 	unsigned long i, j;
 	int ret;
 
-	lockdep_assert_held(&q->sysfs_dir_lock);
-
 	ret = kobject_add(q->mq_kobj, &disk_to_dev(disk)->kobj, "mq");
 	if (ret < 0)
 		goto out;
@@ -237,7 +235,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 			goto unreg;
 	}
 
-	q->mq_sysfs_init_done = true;
+	atomic_set(&q->mq_sysfs_init_done, 1);
 
 out:
 	return ret;
@@ -259,15 +257,13 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	lockdep_assert_held(&q->sysfs_dir_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
 
-	q->mq_sysfs_init_done = false;
+	atomic_set(&q->mq_sysfs_init_done, 0);
 }
 
 void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
@@ -275,15 +271,11 @@ void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	mutex_lock(&q->sysfs_dir_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!atomic_read(&q->mq_sysfs_init_done))
+		return;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
-
-unlock:
-	mutex_unlock(&q->sysfs_dir_lock);
 }
 
 int blk_mq_sysfs_register_hctxs(struct request_queue *q)
@@ -292,9 +284,8 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
 	unsigned long i;
 	int ret = 0;
 
-	mutex_lock(&q->sysfs_dir_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!atomic_read(&q->mq_sysfs_init_done))
+		goto out;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
@@ -302,8 +293,6 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
 			break;
 	}
 
-unlock:
-	mutex_unlock(&q->sysfs_dir_lock);
-
+out:
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 368c2f6f5c85..6f548a4376aa 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -762,7 +762,6 @@ int blk_register_queue(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	int ret;
 
-	mutex_lock(&q->sysfs_dir_lock);
 	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
 	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
@@ -803,7 +802,6 @@ int blk_register_queue(struct gendisk *disk)
 	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
-	mutex_unlock(&q->sysfs_dir_lock);
 
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
@@ -828,7 +826,6 @@ int blk_register_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 out_put_queue_kobj:
 	kobject_put(&disk->queue_kobj);
-	mutex_unlock(&q->sysfs_dir_lock);
 	return ret;
 }
 
@@ -859,7 +856,6 @@ void blk_unregister_queue(struct gendisk *disk)
 	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
 	mutex_unlock(&q->sysfs_lock);
 
-	mutex_lock(&q->sysfs_dir_lock);
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
@@ -876,7 +872,6 @@ void blk_unregister_queue(struct gendisk *disk)
 	/* Now that we've deleted all child objects, we can delete the queue. */
 	kobject_uevent(&disk->queue_kobj, KOBJ_REMOVE);
 	kobject_del(&disk->queue_kobj);
-	mutex_unlock(&q->sysfs_dir_lock);
 
 	blk_debugfs_remove(disk);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 76f0a4e7c2e5..1502970eefff 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -561,7 +561,6 @@ struct request_queue {
 	struct list_head	flush_list;
 
 	struct mutex		sysfs_lock;
-	struct mutex		sysfs_dir_lock;
 	struct mutex		limits_lock;
 
 	/*
@@ -606,7 +605,7 @@ struct request_queue {
 	 */
 	struct mutex		debugfs_mutex;
 
-	bool			mq_sysfs_init_done;
+	atomic_t		mq_sysfs_init_done;
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-- 
2.47.1

