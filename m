Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242381F8BAA
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084047; cv=none; b=U3yHOdbpDbn64EjTjyeg99Dfz5QlHvv2wn9CGdE9CfeE13+T13X6pCSQ4uyTXgX1Iwalm9aHwYyIrLS15rk8UJ6FAqYlmzbeVivmr4uLc/4LbG4ricOPLJUq1cnqQchKv3UiOsvCT9DrutwMoYicSnvaYg5ASGz3g3gF4t6BUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084047; c=relaxed/simple;
	bh=K7TBEhE0QW9iXeG52cYA6Z4gY8b/mOiUYv91re7tiCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ2eszC3WHmbRH2Y78EgFa8e+1Z3O1G6UregWZ3OjGCypTj6QqrYhWd8QElydZ43MB+T48hOQSwrbg2ZBdqPanonAuDaX0xeetAy37b2D+XpfRjClio8Ldc/bW0yV0uOJI/OSIk3oc1Iadfl0JBCjvzBJFXOr3OXsEAwQYOLhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CTu9MD41; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CTu9MD41"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249K7aS022808;
	Tue, 4 Mar 2025 10:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FB2WnC/eRi0Wy05rY
	3R4VeIw0TmygO+UpoMIOEpMAUc=; b=CTu9MD41SnmqS9g0nNT1zfvJ5y9q5+YqN
	WYt/Gjcqq7LWWPx0b1+QDKE4JktAlLoCUZbPP9NssijkPwzmEw3PbvP9Mdm4qLfd
	43nMocZySWTRJszwsvkOSMBoP/CzrZrf7rH747KUHICGQGRe5zeARjsckt8it8VW
	S9B6go4i45oMfaTqpNH8fe4q2xVfGfProqk1K9XXwGii0K1zNHymbGwGEOz7l49i
	d2U/B9mfsQI4XnvKvEWnSQJKbfZXR+q7YNOPEwHQR9kartYmfXhV/DRdLOsem3ZF
	KSLytndHJGjjLYk4qQErezSOGNp6KnE/aWPmN8i1HhNwj0jqa0DBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunx2ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:26:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5247DWmD032219;
	Tue, 4 Mar 2025 10:26:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjsw3aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:26:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524AQ56x45285708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 10:26:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9256E20043;
	Tue,  4 Mar 2025 10:26:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0D5220040;
	Tue,  4 Mar 2025 10:26:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 10:26:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, lkp@intel.com, gjoyce@ibm.com
Subject: [PATCHv6 5/7] block: protect nr_requests update using q->elevator_lock
Date: Tue,  4 Mar 2025 15:52:34 +0530
Message-ID: <20250304102551.2533767-6-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: roPl8adS4pUING2e-0zOJu6lhIvhfMfa
X-Proofpoint-GUID: roPl8adS4pUING2e-0zOJu6lhIvhfMfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040084

The sysfs attribute nr_requests could be simultaneously updated from
elevator switch/update or nr_hw_queue update code path. The update to
nr_requests for each of those code paths runs holding q->elevator_lock.
So we should protect access to sysfs attribute nr_requests using q->
elevator_lock instead of q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c      | 10 +++++-----
 include/linux/blkdev.h | 10 ++++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1562e22877e1..f1fa57de29ed 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -55,9 +55,9 @@ static ssize_t queue_requests_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
 
-	mutex_lock(&disk->queue->sysfs_lock);
+	mutex_lock(&disk->queue->elevator_lock);
 	ret = queue_var_show(disk->queue->nr_requests, page);
-	mutex_unlock(&disk->queue->sysfs_lock);
+	mutex_unlock(&disk->queue->elevator_lock);
 	return ret;
 }
 
@@ -76,16 +76,16 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
 	if (nr < BLKDEV_MIN_RQ)
 		nr = BLKDEV_MIN_RQ;
 
 	err = blk_mq_update_nr_requests(disk->queue, nr);
 	if (err)
 		ret = err;
+	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 	return ret;
 }
 
@@ -692,7 +692,6 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	/*
 	 * Attributes which are protected with q->sysfs_lock.
 	 */
-	&queue_requests_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
@@ -701,6 +700,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 * q->sysfs_lock.
 	 */
 	&elv_iosched_entry.attr,
+	&queue_requests_entry.attr,
 
 	/*
 	 * Attributes which don't require locking.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 079bc2d00e22..ed8d139a4f5d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -563,10 +563,12 @@ struct request_queue {
 	struct list_head	flush_list;
 
 	/*
-	 * Protects against I/O scheduler switching, specifically when
-	 * updating q->elevator. To ensure proper locking order during
-	 * an elevator update, first freeze the queue, then acquire
-	 * ->elevator_lock.
+	 * Protects against I/O scheduler switching, particularly when
+	 * updating q->elevator. Since the elevator update code path may
+	 * also modify q->nr_requests, this lock also protects the sysfs
+	 * attribute nr_requests.
+	 * To ensure proper locking order during an elevator update, first
+	 * freeze the queue, then acquire ->elevator_lock.
 	 */
 	struct mutex		elevator_lock;
 
-- 
2.47.1

