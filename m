Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FC2571B8
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404010; cv=none; b=pEjKOELsmIvnuQSGRskvKg9wAlGkQhmNpBlAGf5r1wQeBGD17qiPIYfUeH3Xa/xyBIPI3A1Y+vi6yks3EbF16PXiVGbw5NB+xZ4qauKhSkE7CZSKT16lxsJNeclocFY2TKMMPiHIOB16fxM5NF8Q5XqnpTuV6dwcr5IKhfU4ILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404010; c=relaxed/simple;
	bh=0LCaeeP5JDYa5ry9FZeXVVT9czcvp+gYj65bzuhLqik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt10PnGagvNrjO9ywd1YvULLM185H7wpRhz6UX9cDP8BcXXT/eyZEeekQ9GfUc1F10Axr0CYOMaUlX3+3c8VFZnjWS4zRQxTkSi/Sk/X97GOOxYmb5q5gPu1aqrlHZOStp65OiFBsoRVCDgL3vQ1ZgJa3G5fKy1j1Mmhxcp/aDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=auCdwz+j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="auCdwz+j"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCc3vP013713;
	Mon, 24 Feb 2025 13:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eMCw9Ntb4bPAfjoeE
	xGA3td4yyXV+r8HypFRg/g57Y8=; b=auCdwz+jHBUEBXYIzf/91f+iAcC/tO+ud
	pX/eYL1NzBEyZQAdzvx+kaP7f/5WbBctVyZnYuKGP6SgNHp6zGaZYm6wB3OtnigE
	0cSDWOKuvbPA7iGz8sv0EQ9Txvf8TGjamWSPC3CrtAn3YOGOPPukCz/0I0vI2mPP
	BwHptk4L9ShyDwbm0Qic3qmiE4tPyS6CJEVeYs+caxjQHJWXPsg4QyUm3EmS9V6v
	gp3StJ6d7qkLrABF27J0mZo3mubGAaGoRFBsBWg3EGb+1zZEixBb+Ii73eKFLXNd
	6T2VPa24iD55T/pu9/Vr6vLgcgF2/NdoaW/4tpPgS7VrFkV7gZZdQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450fm02jth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OC9hVK026965;
	Mon, 24 Feb 2025 13:31:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk76sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ODVF6K56295706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:31:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4327620043;
	Mon, 24 Feb 2025 13:31:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AA2620040;
	Mon, 24 Feb 2025 13:31:13 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 13:31:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv3 5/7] block: protect nr_requests update using q->elevator_lock
Date: Mon, 24 Feb 2025 19:00:56 +0530
Message-ID: <20250224133102.1240146-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224133102.1240146-1-nilay@linux.ibm.com>
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nanJfbndff5wGfOLIfVjAnFZ_s6ZnJqv
X-Proofpoint-GUID: nanJfbndff5wGfOLIfVjAnFZ_s6ZnJqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240098

The sysfs attribute nr_requests could be simultaneously updated from
elevator switch/update or nr_hw_queue update code path. The update to
nr_requests for each of those code paths runs holding q->elevator_lock.
So we should protect access to sysfs attribute nr_requests using q->
elevator_lock instead of q->sysfs_lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 148b127e7f04..1ca0938b2fd7 100644
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
 	 * attributes protected with q->sysfs_lock
 	 */
-	&queue_requests_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
@@ -701,6 +700,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 * other than q->sysfs_lock
 	 */
 	&elv_iosched_entry.attr,
+	&queue_requests_entry.attr,
 
 	/*
 	 * attributes which don't require locking
-- 
2.47.1

