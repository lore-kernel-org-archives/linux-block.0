Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDF1FDA86
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083989; cv=none; b=gJMF/4xcSey6N4mZEcC2/sTwRe5D55JKSvSTVkUNj6m+AzHVWOOpyyq9RBpCj3ZoHbaYqlaGUzoxfRPu9Jktizp2YgmziwaETJoFxJylEVgRvTdF83KfOCPm4QHI3GMmyqWy12w5yoy1hggj4V4CP9Oj/VMjdjjl5fyxOhhKLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083989; c=relaxed/simple;
	bh=PDEqRnc/CzZUJlbl3fgWYT6Lyo+JXpZLolbs0D0EsAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hReX6VtruK7PSHgeHXVs8FtRTwsWFWKJ49m93gOcFNCMY0RDaq5isp9ueRtCGaxG/mpXsEF7yawA3RUhJ8SYKLFzzKXhehpWiE7C6VvpQWpsqKK50SzPo7OLR+lTH0J61S4vj/CLHGa0mf+heIxoj1ECR4qcr18cwBcpeztOyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ce7ur/oy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ce7ur/oy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249hhqi022673;
	Tue, 4 Mar 2025 10:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EdDZPhhOVqrRyGrpq
	MgxhB9MxyJ3ltHLHIhH/OQlHRE=; b=Ce7ur/oyHju96iTY86EOVXV2vgs+N+vCT
	BPEMWLzV++uPaffyZlLnou1dFFpwxBo+I4fVmYCpVeRRd458Wkv4+JuNVtXB5uGv
	LA1uS2jBnX+bwT2ya7ZQB6txM5Zhpcz21eyncfTVOVx+Kd0+RkMF9Mho87Oxy1xq
	5zo2+nBoYsOozDshTigfPBxI6fC9PX69Z66TV7rPYI/bKs4FtZSy8ACy3PTw2c3c
	kyeAACcqE45GbPhOSgtsK40G5VQsHirJixi3JhVuSD0Rt1Z8f+AFkBxduMe6BzEC
	sSAm2dlOJmbjrwFH8hHyjSGkrU/fXhV54ilj9QYiLxlRMbT/VECog==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455ku5391t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:26:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5247ONQE020835;
	Tue, 4 Mar 2025 10:26:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djncvu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:26:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524AQAQk8454486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 10:26:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F95C20040;
	Tue,  4 Mar 2025 10:26:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C5BD20043;
	Tue,  4 Mar 2025 10:26:08 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 10:26:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, lkp@intel.com, gjoyce@ibm.com
Subject: [PATCHv6 7/7] block: protect read_ahead_kb using q->limits_lock
Date: Tue,  4 Mar 2025 15:52:36 +0530
Message-ID: <20250304102551.2533767-8-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: osMM9rAIEsRTeQQglv52JRWMUoIqRKXZ
X-Proofpoint-GUID: osMM9rAIEsRTeQQglv52JRWMUoIqRKXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040084

The bdi->ra_pages could be updated under q->limits_lock because it's
usually calculated from the queue limits by queue_limits_commit_update.
So protect reading/writing the sysfs attribute read_ahead_kb using
q->limits_lock instead of q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c      | 16 ++++++++++------
 include/linux/blkdev.h |  3 +++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 223da196a548..d584461a1d84 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -93,9 +93,9 @@ static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
 
-	mutex_lock(&disk->queue->sysfs_lock);
+	mutex_lock(&disk->queue->limits_lock);
 	ret = queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
-	mutex_unlock(&disk->queue->sysfs_lock);
+	mutex_unlock(&disk->queue->limits_lock);
 
 	return ret;
 }
@@ -111,12 +111,15 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
-
-	mutex_lock(&q->sysfs_lock);
+	/*
+	 * ->ra_pages is protected by ->limits_lock because it is usually
+	 * calculated from the queue limits by queue_limits_commit_update.
+	 */
+	mutex_lock(&q->limits_lock);
 	memflags = blk_mq_freeze_queue(q);
 	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+	mutex_unlock(&q->limits_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 
 	return ret;
 }
@@ -670,7 +673,8 @@ static struct attribute *queue_attrs[] = {
 	&queue_dma_alignment_entry.attr,
 
 	/*
-	 * Attributes which are protected with q->sysfs_lock.
+	 * Attributes which require some form of locking other than
+	 * q->sysfs_lock.
 	 */
 	&queue_ra_entry.attr,
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2977a583d740..4daef0408683 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -573,6 +573,9 @@ struct request_queue {
 	struct mutex		elevator_lock;
 
 	struct mutex		sysfs_lock;
+	/*
+	 * Protects queue limits and also sysfs attribute read_ahead_kb.
+	 */
 	struct mutex		limits_lock;
 
 	/*
-- 
2.47.1

