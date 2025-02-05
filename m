Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0691DDC0D
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766724; cv=none; b=pHMDpt+eMqVProIMkLkBismmAQEK14P613ZgWlS9yzVQMkhuE1OrQ3m3X9vpXc78h6sypObJDEFTnk41j5B0p6LYRcat0XAu/5Cepkrd3VOMhDQ18/BsBN757wfnVgwRP9mtrDq0F6/piY/Hn31yv0yBVOidngMQm8XhjOao67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766724; c=relaxed/simple;
	bh=yYa+OhlQ/D3XNZEcqwqG67PXMdrpmIYlETBeOj9tQ04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWK8QM6rifuPuNDacrHUPwanOEYIYgV0XOgfBmowSjtFrYkbWCmsKZzLrYrDQHCzjf018/5aPWjDBIxfnyeuosDcXLGrCoNHRVcfkOJgZJf6RhePWsutv976MInrfi514TPKA03Do0BPjVkrCLT8c1DvvxbiOMrOh1GzCpwj5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=plwOtRUJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="plwOtRUJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5157Wu5L000943;
	Wed, 5 Feb 2025 14:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wmFEtqyD424Su6E5c
	0GAQWtG2N0V1k7BnxvIWYExLF0=; b=plwOtRUJ5rr1FjLk4Brp5FDt6pwb8FGZZ
	WRMpbUfA2H34h2uLJwAOo9IVCgxdWHHS3wpP23yPA+xZhr5D6fZDXSRh0OhAujVB
	B1xeCICa2+yqTw8nKOSwUPvr8uivZ0nnP7Ak7Wb84HTVgUjQ5J3jjAjkNcfLqElX
	UbhwHlSN+SzkYHfU1ekBaclTYbgEJXNwTONntC/EG5y5O2EZ0JoNU53Clar6mxMg
	LdXA6d2uYdyRJu0oqLhCQlVkdfG5wiJPSlCETtpX6bpl/0QVfh8kG8sn4j0tu61M
	Rz+abSfYpbu1cqZzJUPg7sLwI4MVl1chmspOAye1ZURYVp+jYQ6gA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m3pnt07w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 14:45:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515CdKSQ024461;
	Wed, 5 Feb 2025 14:45:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn983c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 14:45:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515EjDfV29557246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 14:45:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF1C520043;
	Wed,  5 Feb 2025 14:45:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A42F20040;
	Wed,  5 Feb 2025 14:45:12 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.80.122])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 14:45:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCH 2/2] block: avoid acquiring q->sysfs_lock while accessing sysfs attributes
Date: Wed,  5 Feb 2025 20:14:48 +0530
Message-ID: <20250205144506.663819-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205144506.663819-1-nilay@linux.ibm.com>
References: <20250205144506.663819-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2_n2PXnYK9Q3iJ37skxZnKrIHpdw0TbM
X-Proofpoint-GUID: 2_n2PXnYK9Q3iJ37skxZnKrIHpdw0TbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=963 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050114

The sysfs attributes are already protected with sysfs/kernfs internal
locking. So acquiring q->sysfs_lock is not needed while accessing sysfs
attribute files. So this change helps avoid holding q->sysfs_lock while
accessing sysfs attribute files.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sysfs.c |  6 +-----
 block/blk-sysfs.c    | 10 +++-------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3feeeccf8a99..da53397d99fa 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -52,7 +52,6 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	struct blk_mq_hw_ctx_sysfs_entry *entry;
 	struct blk_mq_hw_ctx *hctx;
 	struct request_queue *q;
-	ssize_t res;
 
 	entry = container_of(attr, struct blk_mq_hw_ctx_sysfs_entry, attr);
 	hctx = container_of(kobj, struct blk_mq_hw_ctx, kobj);
@@ -61,10 +60,7 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	if (!entry->show)
 		return -EIO;
 
-	mutex_lock(&q->sysfs_lock);
-	res = entry->show(hctx, page);
-	mutex_unlock(&q->sysfs_lock);
-	return res;
+	return entry->show(hctx, page);
 }
 
 static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6f548a4376aa..2b8e7b311c61 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -664,14 +664,11 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
-	ssize_t res;
 
 	if (!entry->show)
 		return -EIO;
-	mutex_lock(&disk->queue->sysfs_lock);
-	res = entry->show(disk, page);
-	mutex_unlock(&disk->queue->sysfs_lock);
-	return res;
+
+	return entry->show(disk, page);
 }
 
 static ssize_t
@@ -710,11 +707,10 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 		return length;
 	}
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
 	res = entry->store(disk, page, length);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
+
 	return res;
 }
 
-- 
2.47.1

