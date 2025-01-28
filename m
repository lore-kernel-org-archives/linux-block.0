Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA427452
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074896; cv=none; b=dfdZ/uyDHMcIrb7Dcvy1aDUeauKwiFNG7M7KKAwuOm5EcKw+8gZWIjvm0vT8Q8RtdHE2uUE7oBDURa1m5UVjOghMCZc5Xujo/TDgqQeIAKwGMmO7wmJMIxuCrCx10dt3W/600QzOMJy7UDtntUJiJTsdUrtwLncBQCoFGg8dJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074896; c=relaxed/simple;
	bh=QTALWCIUpsiYfgzs2y0NsgWFllmJwr7wAtxSbJX+wN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X16e/RxM2tueY15srrEmMlNnv3OjFzu1MKwXtEKvvHy0wtp8TSzrzRRrm3sx+MvMfH0v3zUMoBBjs4JRjUjOjFa265O4+Fw8KbvusN1+zuwtBi+WAS/Q4ipXO4codU++zxPhUB2f/M0/Y2+lmr0TE1NQjus4W1aRzkr2IY2HO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtFbI/wa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtFbI/wa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SAZlEE009913;
	Tue, 28 Jan 2025 14:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qJyxqalfOT0iJXETO
	lrmcLM6xXroPuxW7QLlF45rlAM=; b=qtFbI/waHs8RIZME45oykhbG7ttoF6Vnb
	QPh7ansKE+SxavB1GKxiZOdlNv2OgAjuQi7B3kWJcoIFPmHmJlJ//jOfvUWx3mO+
	+7p0hteFNMERZ2w6/TQyBJ3aJLy6C0st9IS4/GuQSm4QSchrU9lL7dmBAcWNGY07
	Awv1r5GIYFdS1YugQQf58VK2P46ZCG2srVe49E1H2RuWKT6WW1MiDUdNBVcElle4
	Mh8Ial1WhD57Ti0PfgN18T9PLCw2zppnYD6RhRr9hSM9WdvEVIdG6ljDtO93T83+
	x9DTiSuOizq9Vw9ddH0OzagKcErj++jf1BORAj0HANOaQeHifacfg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdydvhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 14:34:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDN1Xq019276;
	Tue, 28 Jan 2025 14:34:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9munry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 14:34:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SEYf7m29295116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 14:34:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89B9E200AB;
	Tue, 28 Jan 2025 14:34:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1106A200A9;
	Tue, 28 Jan 2025 14:34:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.95.231])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 14:34:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [RFC PATCHv3 1/2] block: get rid of request queue ->sysfs_dir_lock
Date: Tue, 28 Jan 2025 20:04:13 +0530
Message-ID: <20250128143436.874357-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128143436.874357-1-nilay@linux.ibm.com>
References: <20250128143436.874357-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t9Picoi4ghrHZzLP1y-MSKGha-1IT4_y
X-Proofpoint-ORIG-GUID: t9Picoi4ghrHZzLP1y-MSKGha-1IT4_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280108

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
blk-mq with sysfs. But use of q->mq_sysfs_init_done could be easily
replaced using queue registered bit QUEUE_FLAG_REGISTERED.

So with this patch we remove q->sysfs_dir_lock from each callsite
and replace q->mq_sysfs_init_done using QUEUE_FLAG_REGISTERED.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-core.c       |  1 -
 block/blk-ia-ranges.c  |  4 ----
 block/blk-mq-sysfs.c   | 23 +++++------------------
 block/blk-sysfs.c      |  5 -----
 include/linux/blkdev.h |  3 ---
 5 files changed, 5 insertions(+), 31 deletions(-)

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
index 156e9bb07abf..6113328abd70 100644
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
@@ -237,7 +235,6 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 			goto unreg;
 	}
 
-	q->mq_sysfs_init_done = true;
 
 out:
 	return ret;
@@ -259,15 +256,12 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	lockdep_assert_held(&q->sysfs_dir_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
-
-	q->mq_sysfs_init_done = false;
 }
 
 void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
@@ -275,15 +269,11 @@ void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	mutex_lock(&q->sysfs_dir_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!blk_queue_registered(q))
+		return;
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
-
-unlock:
-	mutex_unlock(&q->sysfs_dir_lock);
 }
 
 int blk_mq_sysfs_register_hctxs(struct request_queue *q)
@@ -292,9 +282,8 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
 	unsigned long i;
 	int ret = 0;
 
-	mutex_lock(&q->sysfs_dir_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!blk_queue_registered(q))
+		goto out;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
@@ -302,8 +291,6 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
 			break;
 	}
 
-unlock:
-	mutex_unlock(&q->sysfs_dir_lock);
-
+out:
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e09b455874bf..7b970e6765e7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -764,7 +764,6 @@ int blk_register_queue(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	int ret;
 
-	mutex_lock(&q->sysfs_dir_lock);
 	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
 	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
@@ -805,7 +804,6 @@ int blk_register_queue(struct gendisk *disk)
 	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
-	mutex_unlock(&q->sysfs_dir_lock);
 
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
@@ -830,7 +828,6 @@ int blk_register_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 out_put_queue_kobj:
 	kobject_put(&disk->queue_kobj);
-	mutex_unlock(&q->sysfs_dir_lock);
 	return ret;
 }
 
@@ -861,7 +858,6 @@ void blk_unregister_queue(struct gendisk *disk)
 	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
 	mutex_unlock(&q->sysfs_lock);
 
-	mutex_lock(&q->sysfs_dir_lock);
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
@@ -878,7 +874,6 @@ void blk_unregister_queue(struct gendisk *disk)
 	/* Now that we've deleted all child objects, we can delete the queue. */
 	kobject_uevent(&disk->queue_kobj, KOBJ_REMOVE);
 	kobject_del(&disk->queue_kobj);
-	mutex_unlock(&q->sysfs_dir_lock);
 
 	blk_debugfs_remove(disk);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 76f0a4e7c2e5..248416ecd01c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -561,7 +561,6 @@ struct request_queue {
 	struct list_head	flush_list;
 
 	struct mutex		sysfs_lock;
-	struct mutex		sysfs_dir_lock;
 	struct mutex		limits_lock;
 
 	/*
@@ -605,8 +604,6 @@ struct request_queue {
 	 * Serializes all debugfs metadata operations using the above dentries.
 	 */
 	struct mutex		debugfs_mutex;
-
-	bool			mq_sysfs_init_done;
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-- 
2.47.1

