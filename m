Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870DC2116E6
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573656; cv=none; b=P0ew1jkbUdbPM1v/PzwHrThJJ/foGkU4Yr4Prak9AImlDn6VRwh5CHVNiksO3IVIUKSxx+g8+lcSzxpLxjStBW/gCwjmfwJxPutIIT8sqQKw0beYEcTR647m4K58WPrwMWX2HSOojUVAbv3tYezJt2ivFmhpbFzapvv/cB1BQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573656; c=relaxed/simple;
	bh=lCgkdcMonSxDVkxnuE1IMHcW9BvQUT7zBlY4r3AbMJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOVsoCYLVKea5lLvGnpOVK9+DgBg1lxKitW11BrjkLFAC2A9TMkNyE8HVvR9cNgPs4LrCDihIgKmTUWRjdyiLhcSNvcJ12NegJosbjOb4MI9IzyvdoD0AoduGBBLGLz82Oj3ZMqim5Rj2Ci6mWgVT5quLyXzhKHVM/Q2RPgstAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jBA/a5IK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jBA/a5IK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5Nrjv020545;
	Wed, 26 Feb 2025 12:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/rexhIlsRaSNU4S+T
	XuNVEvqfxuNUq0aGPUotJW5trQ=; b=jBA/a5IKXXtUQDwjYKv3C6CJbrDl3qA+w
	ZYb4jKw8NF/Xr+s4/3QiSdnmB3hqaUEvvUWdgFNiK9bEcOo31GEsfT//FIsNXSp5
	crsszjvSIp8AqFSK8mm11C6NG2bxxmtrhlesJSHt5FOAnZodjajXoRLsBpsYWipP
	pSruwP3g+eFjbphvlVT5bDDlXrRuR2vtTskeZ6WpkpWY1gVadS+9cxySO3kI7Ndr
	7tUnNusdhIZx5AyXFmXJFabzW8kx8k/Z+mUSZeU/fc52juVj21MwAkYgfPggoHCv
	DQlXtXK7uWLzzAif6d5OlrNwo1DOssMM1Cq/q5ZeX1sYq4ywVu62w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451vs81t79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAw2e9012131;
	Wed, 26 Feb 2025 12:40:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yjtx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:40:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCegaE46399924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:40:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31AA320040;
	Wed, 26 Feb 2025 12:40:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B47282004B;
	Wed, 26 Feb 2025 12:40:38 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.110.139])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:40:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv5 7/7] block: protect read_ahead_kb using q->limits_lock
Date: Wed, 26 Feb 2025 18:10:00 +0530
Message-ID: <20250226124006.1593985-8-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ikhBmKJRMsDbMbHO5_T__WZOu6pclLoE
X-Proofpoint-GUID: ikhBmKJRMsDbMbHO5_T__WZOu6pclLoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=994 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260100

The bdi->ra_pages could be updated under q->limits_lock because it's
usually calculated from the queue limits by queue_limits_commit_update.
So protect reading/writing the sysfs attribute read_ahead_kb using
q->limits_lock instead of q->sysfs_lock.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c      | 16 ++++++++++------
 include/linux/blkdev.h |  3 +++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 46033d640e30..67c5c4cee6b4 100644
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
index 0ee3b5c9388e..3bee1b4858b6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,6 +571,9 @@ struct request_queue {
 	struct mutex		elevator_lock;
 
 	struct mutex		sysfs_lock;
+	/*
+	 * Protects queue limits and also sysfs attribute read_ahead_kb.
+	 */
 	struct mutex		limits_lock;
 
 	/*
-- 
2.47.1

