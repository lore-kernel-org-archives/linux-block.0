Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE522AE59
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867514; cv=none; b=nriH4iUa+/OSdG5HcsRf2HwjGrBX0+EpiOsJqBTfKZizJKKQI1kr6RZtcUVy1J34gWolFu8mTQcsPLzwBAdh1bae0rKuaUcj0KMUtLT6EGmanYnxsH4Tmigx8NA/QU2ddzhP9WyGLAspbUlBqTuItxEIzK5Gemi/aZQzSH81iGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867514; c=relaxed/simple;
	bh=05nCs+48O8m7FXfOX8FGjxKSZdMSKaaz2qFSNc/lOn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sf3yJWSriGppDJ+MVc/lmiLpT2OQjMY6nZO87Gt9gkQIIGOSVpRXrExn8sqgVMk/2KjMpP9sSo8GZBCaCrDZyYjP3rUpa7/g2xWDoR2WA+mh0qsdY4f8JVzufVlJmloZAGPNIA+WgouZU5P8PR71UKJOLslYbHZY2R+J1+ZUd+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qb4QglB1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qb4QglB1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7WuQE009132;
	Tue, 18 Feb 2025 08:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F5N6shTMG8AYFaHU2
	J/21JJ/FGRMyZ+RiWmVdq0gPiE=; b=Qb4QglB1Df2iA34sdVjbncAUwEz8HI7Ck
	635hd4tUF285dcbbRAYrfSQZpRiV/paZRkan9CgUmp4s3UE5rs6uddJnHRODVNpQ
	WT63DTqtt3zZd+t/OdGn4XdusiS5fanfMY/BKy67TEBZPxx4yWQ50oHEKQzOugwK
	4KMd/oU5/ili40GoKOzlk7kSNU0dSLqfrQDEx+a4HTPtg1PskjuAdPAK68P9dqSA
	xDWAOqSbHMGzBhQeFZf08KM1cbik4uj9MubZuEOv1mZxzlW666VBT9qiYPK5xJ16
	p35rsU39YngD64NrVQPmdLKwYrkXL18o4PPDv0dWgicIC/I53tP6A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vnwpg7sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I6QLTO001633;
	Tue, 18 Feb 2025 08:29:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5myt601-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I8TM6A11338000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:29:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A969020043;
	Tue, 18 Feb 2025 08:29:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 177C420040;
	Tue, 18 Feb 2025 08:29:21 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 08:29:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCHv2 6/6] blk-sysfs: protect read_ahead_kb using q->limits_lock
Date: Tue, 18 Feb 2025 13:58:59 +0530
Message-ID: <20250218082908.265283-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218082908.265283-1-nilay@linux.ibm.com>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z1CCyfyT9kARBBqCgIj5X-uRjL6aj9U_
X-Proofpoint-ORIG-GUID: Z1CCyfyT9kARBBqCgIj5X-uRjL6aj9U_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180065

The bdi->ra_pages could be updated under q->limits_lock while applying
bdi limits (please refer blk_apply_bdi_limits()). So protect accessing
sysfs attribute read_ahead_kb using q->limits_lock instead of q->sysfs_
lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 876376bfdac3..a8116d3d9127 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -105,9 +105,9 @@ static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	int ret;
 
-	mutex_lock(&disk->queue->sysfs_lock);
+	mutex_lock(&disk->queue->limits_lock);
 	ret = queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
-	mutex_unlock(&disk->queue->sysfs_lock);
+	mutex_unlock(&disk->queue->limits_lock);
 
 	return ret;
 }
@@ -119,17 +119,24 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 	ssize_t ret;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
-
-	mutex_lock(&q->sysfs_lock);
+	/*
+	 * We don't use atomic update helper queue_limits_start_update() and
+	 * queue_limits_commit_update() here for updaing ra_pages bacause
+	 * blk_apply_bdi_limits() which is invoked from  queue_limits_commit_
+	 * update() can overwrite the ra_pages value which user actaully wants
+	 * to store here. The blk_apply_bdi_limits() sets value of ra_pages
+	 * based on the optimal I/O size(io_opt).
+	 */
+	mutex_lock(&q->limits_lock);
 	memflags = blk_mq_freeze_queue(q);
-
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		goto out;
 	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
 out:
+	mutex_unlock(&q->limits_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
+
 	return ret;
 }
 
-- 
2.47.1

