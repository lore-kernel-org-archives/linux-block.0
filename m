Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4514A614
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867492; cv=none; b=iX+d0mAVWOZMrgKyHZC4HAa+PUEX4hlNvwIoipmdawIv3sMN2GvgIkr/0rdafnZt9ltWXnjrM3WANen535FH3ekqUy1fUvRznWzKunj0egcXj/6i4ZT9wBT0oBha9cV+JC4+dPo9MSXH5pbQk4jUuuu9n/SBCLlXM4a5qrEfOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867492; c=relaxed/simple;
	bh=ar6BziJk4nf4WYvIFKWueLymL4XcLqxLj7IUzhZzUsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkoN0xCwmWqW5t3S4J4toV3jz3flH0mHK0FuW999tWMTtV8GvoRePpe0qHUGW+1oGaZ1Ac7mBKHtWm5ZdHlKKYvqE4ivF8m6OybMxPBJ5EHMgZ4TnVyONkyKExSrLwfsy3MkmgVPaOQCUnmeESIrYdqMGuZnW25tlk4XMbPWppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pVSx/UTq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pVSx/UTq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I3btle020580;
	Tue, 18 Feb 2025 08:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/q6/k1++O4exoyiHB
	ZfBQjVCTGvcQDsV14MZMZ6DR0I=; b=pVSx/UTqlaL9cWkbajtVqdoJ6ha+Q14Xn
	o4Y3B0BTBPZ88NqYSzWGejQvpyu2KrQ+2tTfXHcybkE0HaDvcjlMKeCu2kcj53QA
	+K2iopj3JZs7fYwAtdrbdc5LSxaXUDVl+TDJtoBNf7F/3+lrgwx7tGMNXS/yMkio
	ZoSxeaRC38iQH/B56cKylCAG0Ee+tPGNrkRuQ4W9rOl340vsg2onY5SA/DVeEZXS
	s2D4Fisw2OgKSnksRc2IqeljticDDQg8rdr6A2k7rPn/HvVcLYkJP/AlcHofjCwY
	s97Z+9Sy2Mzf92Pq4ZcHVBwWpmOqa8gj0t5318mg9YIt16okCW/0g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44v7xubme9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7Lbq9029537;
	Tue, 18 Feb 2025 08:29:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44v9mmjumf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I8TKYD50594222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:29:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7EFE2004B;
	Tue, 18 Feb 2025 08:29:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A04220040;
	Tue, 18 Feb 2025 08:29:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 08:29:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCHv2 5/6] blk-sysfs: protect wbt_lat_usec using q->elevator_lock
Date: Tue, 18 Feb 2025 13:58:58 +0530
Message-ID: <20250218082908.265283-6-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ib5anEazT31f6EQxCZ_pr4-72qlR1bdP
X-Proofpoint-GUID: Ib5anEazT31f6EQxCZ_pr4-72qlR1bdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180065

The wbt latency and state could be updated while initializing the
elevator or exiting the elevator. The elevator code path is now
protected with q->elevator_lock. So we should now protect the access
to sysfs attribute wbt_lat_usec using q->elevator_lock instead of
q->sysfs_lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 37ac73468d4e..876376bfdac3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -567,7 +567,7 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 {
 	int ret;
 
-	mutex_lock(&disk->queue->sysfs_lock);
+	mutex_lock(&disk->queue->elevator_lock);
 
 	if (!wbt_rq_qos(disk->queue)) {
 		ret = -EINVAL;
@@ -581,7 +581,7 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 				div_u64(wbt_get_min_lat(disk->queue), 1000));
 
 out:
-	mutex_unlock(&disk->queue->sysfs_lock);
+	mutex_unlock(&disk->queue->elevator_lock);
 	return ret;
 }
 
@@ -594,8 +594,8 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	s64 val;
 	unsigned int memflags;
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
 
 	ret = queue_var_store64(&val, page);
 	if (ret < 0)
@@ -634,8 +634,8 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	blk_mq_unquiesce_queue(q);
 
 out:
+	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
 	return ret;
 }
 
@@ -907,11 +907,11 @@ int blk_register_queue(struct gendisk *disk)
 			mutex_unlock(&q->elevator_lock);
 			goto out_crypto_sysfs_unregister;
 		}
+		wbt_enable_default(disk);
 	}
 	mutex_unlock(&q->elevator_lock);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-	wbt_enable_default(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
-- 
2.47.1

