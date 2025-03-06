Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA619F438
	for <linux-block@vger.kernel.org>; Thu,  6 Mar 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254020; cv=none; b=WLW28ziaJxC6FLdraJN4WfQugc6cVt6Nrys5sPZKw+Ld/mT5B1T050LJLUkdSYA+xQjjeSy0eCFndM47s3LTmNog3e1xoBZJYAg4G1GICCTou4tSQGgNlM9tU5cfeH3lSXGd6+15dPA4MKCLWSMxP5y/ndiyKWMgOmjfQBArVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254020; c=relaxed/simple;
	bh=slXQxy8D3rzzEXV3gqS7Lt7NiuqIL4flKYR1TgDWdzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7DDyK/FaNAM0OKIjWvDNTb54RFMbgRr9pK2fb3IQFbdafV2sxXzHldG+b9IAlVsXLHedbjpWWEQ11msWJTni5t6cTn4PIEFHlNsZ7cszlbcocraVtQl87Yx3dipZji3wAOWprAxYHNL+yEAEU6n0zRhBJwLYnuh7Y1CKul2hcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BOkL+rj4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BOkL+rj4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5269LR8h032613;
	Thu, 6 Mar 2025 09:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GZ8E6SMjlfBsI+AHwBXNIYgwqStZAqJcARgkxsFlT
	UY=; b=BOkL+rj4WQFC23STLRubByyK3vtqpJ+plgcPmhK1+JSYnKNApM6OcEGeD
	C5/2czWh2Lf/Y6w0vuY1g/YAQOD4Ieozcv94dlmnxYGsscsaKJGIUFK8PnYiX0mY
	RJY4yxdJAd7m7TK9o0kxO8l+G10hKeLt0lC/ilcxLAfVj+bUzG8Y6UIaJ2Fs5B7f
	wSN9t9yXT7ql06qs1t4AjVKvIv6nSVSvyMsXLpSxEP/WzUItGuNzX7nB/sw6uRgN
	AxZ/qJAcHRzHS6OnCvyNNrOktvIIsUj4Nmb+TrwNCthWkTmPDl0/f7K0T5ADNsnQ
	WA7y3m8+7yZDlHrAd9Pg9G9A4KHAw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wspjwew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:40:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5268CY0P031946;
	Thu, 6 Mar 2025 09:40:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt85f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:40:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5269dwj932834284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 09:39:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2CA72004D;
	Thu,  6 Mar 2025 09:39:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4092320040;
	Thu,  6 Mar 2025 09:39:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 09:39:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCH] block: protect hctx attributes/params using q->elevator_lock
Date: Thu,  6 Mar 2025 15:09:53 +0530
Message-ID: <20250306093956.2818808-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8iE_6UPoDmkeYwIMN91PemnA9bpMbfyq
X-Proofpoint-ORIG-GUID: 8iE_6UPoDmkeYwIMN91PemnA9bpMbfyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_04,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=850 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060071

Currently, hctx attributes (nr_tags, nr_reserved_tags, and cpu_list)
are protected using `q->sysfs_lock`. However, these attributes can be
updated in multiple scenarios:
  - During the driver's probe method.
  - When updating nr_hw_queues.
  - When writing to the sysfs attribute nr_requests,
    which can modify nr_tags.
The nr_requests attribute is already protected using q->elevator_lock,
but none of the update paths actually use q->sysfs_lock to protect hctx
attributes. So to ensure proper synchronization, replace q->sysfs_lock
with q->elevator_lock when reading hctx attributes through sysfs.

Additionally, blk_mq_update_nr_hw_queues allocates and updates hctx.
The allocation of hctx is protected using q->elevator_lock, however,
updating hctx params happens without any protection, so safeguard hctx
param update path by also using q->elevator_lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Please note that this patch was unit tested against blktests and 
quick xfstest with lockdep enabled.

This patch should go on top of the previous patchset:
https://lore.kernel.org/all/20250304102551.2533767-1-nilay@linux.ibm.com/
---
 block/blk-mq-sysfs.c   |  4 ++--
 block/blk-mq.c         |  4 ++++
 include/linux/blkdev.h | 14 ++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3feeeccf8a99..24656980f443 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -61,9 +61,9 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	if (!entry->show)
 		return -EIO;
 
-	mutex_lock(&q->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
 	res = entry->show(hctx, page);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 	return res;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5a2d63927525..b9550a127c8e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4094,6 +4094,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
 
+	mutex_lock(&q->elevator_lock);
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		cpumask_clear(hctx->cpumask);
 		hctx->nr_ctx = 0;
@@ -4198,6 +4200,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->next_cpu = blk_mq_first_mapped_cpu(hctx);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
+
+	mutex_unlock(&q->elevator_lock);
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4daef0408683..b6f893e1741b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -563,12 +563,14 @@ struct request_queue {
 	struct list_head	flush_list;
 
 	/*
-	 * Protects against I/O scheduler switching, particularly when
-	 * updating q->elevator. Since the elevator update code path may
-	 * also modify q->nr_requests and wbt latency, this lock also
-	 * protects the sysfs attributes nr_requests and wbt_lat_usec.
-	 * To ensure proper locking order during an elevator update, first
-	 * freeze the queue, then acquire ->elevator_lock.
+	 * Protects against I/O scheduler switching, particularly when updating
+	 * q->elevator. Since the elevator update code path may also modify q->
+	 * nr_requests and wbt latency, this lock also protects the sysfs attrs
+	 * nr_requests and wbt_lat_usec. Additionally the nr_hw_queues update may
+	 * modify hctx tags, reserved-tags and cpumask, so this lock also helps
+	 * protect the hctx attrs.
+	 * To ensure proper locking order during an elevator or nr_hw_queue
+	 * update, first freeze the queue, then acquire ->elevator_lock.
 	 */
 	struct mutex		elevator_lock;
 
-- 
2.47.1

