Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826D22B59B
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867371; cv=none; b=fCZmbHpyyFBt9EarsicEDXd9iHaNr5RlEJU838Pcd+omVAu1hsfb4vLU6zDr3ad1HmOidDPKkM1CNsT0X/NFu4sIZd/82BYW5oMNuRE+0k+8Ds3nsi02QxpaxL/CQLZWyAXsCjYU57KPqnyfhgu3P76DrsfkgHlCfY+2RUb2JSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867371; c=relaxed/simple;
	bh=igUe4AUJuiPh/XOC7o6fLV+p/JheBjxL+W5aWPu1FZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI5kwT82zWi+oe0n6FHHIDgmt3XZFkAGGn3dKAuiq2nR3GIEIG+Ae8HbxmVMhpbtb5NQ8w4O6QS7GmyAFCv7L23Bn0ZLbjLjyx34XuDDGSigiz0KWZ/14UB/ebk5TWImjURlLdQABO+ekDG6KUvaX1dDo8s35lrJWmvS006HDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SukSCgZl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SukSCgZl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I7XlR8010678;
	Tue, 18 Feb 2025 08:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wydVK/+EAtjCRo3nS
	4JCQKr3lnhUUiYGG8xzVePau0s=; b=SukSCgZlZLji5vLjHA1ZxYbzTt38HR2FU
	8hlbFRwQey0VRXSBf92b6qGTpUpPIslwIu5ROgo8m6LiWNa8EXAMiFZSxhM5ygT4
	eC0OgXGryziF3xoG8oCPbIfIfVIq96n925TgC5Bt90ynqEARKjdsdPSEmgeurwsI
	KlQ8eUjg8QCt+VZmlH0HQEwICZeEnm2VoVZmLvxGS1RxWqRXMUAzOtTlZxzmi6vc
	TnRYUpUAMlhDw09NAdFIqxJFV2dvFki7RO7phYCNhxWmpb1SNIApuIlFxlj5emnf
	oSOECjD5iptGWBA23Xl4kVulpXdB46PjOVNCiHH+VEEN6Jux23NgQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vnwpg7sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I5raK0001599;
	Tue, 18 Feb 2025 08:29:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5myt5ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I8TILI22937866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:29:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA71D20043;
	Tue, 18 Feb 2025 08:29:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC1F20040;
	Tue, 18 Feb 2025 08:29:17 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 08:29:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCHv2 4/6] blk-sysfs: protect nr_requests update using q->elevator_lock
Date: Tue, 18 Feb 2025 13:58:57 +0530
Message-ID: <20250218082908.265283-5-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: MXSz1MTvOth_f69PoBE85yJKxMs_WCOv
X-Proofpoint-ORIG-GUID: MXSz1MTvOth_f69PoBE85yJKxMs_WCOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180065

The sysfs attribute nr_requests could be simultaneously updated from
elevator switch/update or nr_hw_queue update code path. The update to
nr_requests for each of those code path now runs holding q->elevator_
lock. So we should now protect access to sysfs attribute nr_requests
using q->elevator_lock instead of q->sysfs_lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 355dfb514712..37ac73468d4e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -59,10 +59,11 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 static ssize_t queue_requests_show(struct gendisk *disk, char *page)
 {
 	int ret;
+	struct request_queue *q = disk->queue;
 
-	mutex_lock(&disk->queue->sysfs_lock);
-	ret = queue_var_show(disk->queue->nr_requests, page);
-	mutex_unlock(&disk->queue->sysfs_lock);
+	mutex_lock(&q->elevator_lock);
+	ret = queue_var_show(q->nr_requests, page);
+	mutex_unlock(&q->elevator_lock);
 
 	return ret;
 }
@@ -75,8 +76,8 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
 
-	mutex_lock(&q->sysfs_lock);
 	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
 
 	if (!queue_is_mq(disk->queue)) {
 		ret = -EINVAL;
@@ -94,8 +95,9 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	if (err)
 		ret = err;
 out:
+	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_unlock(&q->sysfs_lock);
+
 	return ret;
 }
 
-- 
2.47.1

