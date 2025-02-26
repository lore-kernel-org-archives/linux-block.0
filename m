Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966C21770C
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573765; cv=none; b=GyMJNo4oNiOksDIRSQKF9gD/gMrin78cWGElAWQmh7CBwyv2uVrBqcpcykiwAeW+BgnUR5unum3dkrkUQLcQoZY2iorZ6JnosscwrCWZ7tTeSihPoevIXUGmbN2PZ093BxQdvXlddYkc/Vkk8dg3UxJfd8Aj/ANDSxRN7Hxp1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573765; c=relaxed/simple;
	bh=hFONj7u052lGswIYIygG2+1Jz0rvNyh0m8r5mBPqijk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIqjc41eF8AWKFKQt49bcn/qHFvhUCsfIC7Xjawk2gbDj4VLfpcQKM4ud+6nuEWz5ZtInj7WVWCW2JGDqD0Dog28Yp+Z+BHZHFee+zNyZHMpC//tt2W2KvRwGB6NVWSxSBX4fYkQgS65khRoKG4Sbs7AuskjVdBmr8vii7yL0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q2Ian3NX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q2Ian3NX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q7WjQH005935;
	Wed, 26 Feb 2025 12:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YfwK/u0xTqYKSoNUg
	xBw+NswnFoxdHxKKXx9cnxTubk=; b=Q2Ian3NX3PK/YFvcTgvbLzN3Zssc1Po76
	/46Xmyu2SkjjZGOO1tde1UKQxmy78NQJ/Ca/ocYn2TXy4+/CQwVOJNoHLw02quBr
	oipf8qLIrkJSj7WxMtCPIlAjqOe/rfWNcrVL0aL9MoSoc8BdyxJsXJOE3S2YlvtI
	EoAdlVAPulGkL1i+sDACqKBkpG4XdJMrY721wIkYuN6ld0tt6L+WoOcfLRfHPDst
	Ioel4EAAa8qFDWWcov8n6UQBXpO0COm2UK+p+4/42rLzh1oYaGkZCX9pBriMFMGl
	11oQ7UST/qs2JmlXYjAuZjH3Awi26qwyJ7AsI3ImelB2McH2rh6Bg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp19jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9ACrb026964;
	Wed, 26 Feb 2025 12:40:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkjgxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCeXZb50200994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:40:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6D492004B;
	Wed, 26 Feb 2025 12:40:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2166120040;
	Wed, 26 Feb 2025 12:40:30 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.110.139])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:40:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv5 5/7] block: protect nr_requests update using q->elevator_lock
Date: Wed, 26 Feb 2025 18:09:58 +0530
Message-ID: <20250226124006.1593985-6-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5Wd1tOjyMk0hynrhRTF44oFujvJNIiFx
X-Proofpoint-GUID: 5Wd1tOjyMk0hynrhRTF44oFujvJNIiFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260100

The sysfs attribute nr_requests could be simultaneously updated from
elevator switch/update or nr_hw_queue update code path. The update to
nr_requests for each of those code paths runs holding q->elevator_lock.
So we should protect access to sysfs attribute nr_requests using q->
elevator_lock instead of q->sysfs_lock.

Reviewed-by: Hannes Reinecke <hare@suse.de>
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
index 31b1b635c710..3e66ad016a23 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -561,10 +561,12 @@ struct request_queue {
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

