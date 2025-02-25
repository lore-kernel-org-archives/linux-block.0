Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F913A1DB
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490442; cv=none; b=p2+TZ6uncNlfRbxTIeCD/xj+Rfb5rY7oBu4otzXmuoRp1cn/g5HzJxn2OX/qI6qOgyoYCBh2jPUyKD6BT5lJ1Fhxox21t2xUmVzRXDSZdCdTLyq84F3zZHhQZkw/oykE8C3UX/hfYwh9X9RwgQcCSiKK0zm3QJ8J/QLpwRojqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490442; c=relaxed/simple;
	bh=8T35rDqQB8Jru6KK7el2MzYx2lMtJEkVP4uk/2ke0K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYn2/V3irrZ/DoYUSkvLFE9evU5AeibGvOtApq0B1hiGf2QUaXbeDbPJl+vB2D/ka/HmcHfZU/0rLN00h/AdE6syVNOrwB5BN02+6jvDC5jJGbCmhuunrLhLF/5rO7Wkw4P921lKjCEizjffrY23BpgM8wMOLAKi0vmgCk82oiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fskCJdTH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fskCJdTH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7XLrN007160;
	Tue, 25 Feb 2025 13:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ep3Lun7kQUVIFCjiX
	pVDv2FEx/b6V3zrgoemi9NfDi8=; b=fskCJdTHFl+7HcCr39H80or+7XVljguzC
	YhQvCFUk6ftCdFohRIvFnT52Ez0s6m+NRMB1QmM8alhQSxuTrQY/2CqELGdls/+K
	ngGmRmLo0tmuyY6rxqSvatwP+CrSCvrGnNaPGkzPfpzr/G2Fg6M8548CY4Ll3Mwc
	zgsWfFbEWypzIkNCnroXNckytTAJQhSoQyw3Bz6Z+hQl/SxhldOmpzC0wEsGM91B
	Binisoz7TQlqktd5hLKa6OLmW+gRG/TUNPlrUEizGOz39r58QU+VNk/Qsqoq2cFT
	U3blPTZEpYYNK7+JCiC5wC72lUF/aD2A7WqwXw0o9c5ZsomOgr0zQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4519jp9qgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PD4EOA012507;
	Tue, 25 Feb 2025 13:31:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9ydajp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDVloG36110668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:31:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A20B20040;
	Tue, 25 Feb 2025 13:31:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B8E2004B;
	Tue, 25 Feb 2025 13:31:43 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.156.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:31:43 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv4 7/7] block: protect read_ahead_kb using q->limits_lock
Date: Tue, 25 Feb 2025 19:00:42 +0530
Message-ID: <20250225133110.1441035-8-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: j1yRZvRyEhiknGhCsXzvq8LtO08gt1sC
X-Proofpoint-GUID: j1yRZvRyEhiknGhCsXzvq8LtO08gt1sC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250090

The bdi->ra_pages could be updated under q->limits_lock because it's
usually calculated from the queue limits by queue_limits_commit_update.
So protect reading/writing the sysfs attribute read_ahead_kb using
q->limits_lock instead of q->sysfs_lock.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 31bfd6c92b2c..8d078c7f0347 100644
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
+	 * Attributes which require some form of locking
+	 * other than q->sysfs_lock.
 	 */
 	&queue_ra_entry.attr,
 
-- 
2.47.1

