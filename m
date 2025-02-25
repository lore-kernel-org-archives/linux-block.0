Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07929CE1
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490451; cv=none; b=VyrJkEZNGFSg/WRcUwkR0fhmzAcYoVH2dufDWdqsmAi9i81LZMTkfLwlYCfWfjqnp1mStb9tArYbZINbECfvvDp9P8KQ7S4BIBdY6Fpk5DfAqXsu9REyKu4gv57k++CNHexVgV+aiyn7s0VJl/R0vqyw1QT6eGYNTWnYCUOJpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490451; c=relaxed/simple;
	bh=EPlVE1UUIS7amr1VcIO7tpnvcLPQRciEOXHldGTOV6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEovxpx9/I8iNchlkivFEBYnAdlj776nJIw9LdP0im3TfsoaZyaf9VWzyyL1TtfqxSApQ0Y58270gMUtOyhCbeXEvIw6Dif0UrMgAPgWCmUd/1Ucr3D8SE4k7na8kMdjRrvqh7tnn6mezc+LxePmvicr8ioSb2RnHiSJTW2V4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ftxW97Rv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ftxW97Rv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7WxcI006829;
	Tue, 25 Feb 2025 13:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8Y9CBgGy+2cxc/plg
	yirRf2Bc47fmyudG2ck2oR7dLM=; b=ftxW97Rv5tos/6ZmbGWwCIQZEZR2D+nYK
	yZAFB1tseIBogd7dxMggGAyqj/CQ26DXWB83O30CFw+Oh1WdW+QO1H3I6/bGrotj
	q20KCDkpCbA9k8JU1jjGO8g9goFosDS8hqfpjWmJ02Co2rCcJfDJaCHmKlQOG+Ud
	uuzOidMhSxWL2uvlIx3uTcn9ekBniFPcCEfjlga35NE4OnMcN/ylTpbz+w6t+kzy
	QHF717NsauW7Ga0Wh0Te/3geZjrl27PuBPX3bskyF9kFjejs9YWYpMc7YEhqrp6w
	5JrdkZVJFuzZ5ccBxCQoNTlZ9DdisJ9wFanaa9piQDY+evyTV+m0A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4519jp9qfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAogpd026961;
	Tue, 25 Feb 2025 13:31:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkd006-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDVcJZ55771598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:31:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 597152004B;
	Tue, 25 Feb 2025 13:31:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5EB320040;
	Tue, 25 Feb 2025 13:31:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.156.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:31:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv4 5/7] block: protect nr_requests update using q->elevator_lock
Date: Tue, 25 Feb 2025 19:00:40 +0530
Message-ID: <20250225133110.1441035-6-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: mXLrz5k5dATaJ60N03SaXKrqU5n5R7Yf
X-Proofpoint-GUID: mXLrz5k5dATaJ60N03SaXKrqU5n5R7Yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250090

The sysfs attribute nr_requests could be simultaneously updated from
elevator switch/update or nr_hw_queue update code path. The update to
nr_requests for each of those code paths runs holding q->elevator_lock.
So we should protect access to sysfs attribute nr_requests using q->
elevator_lock instead of q->sysfs_lock.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1091c6fb6dd8..0bf00060e119 100644
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
 	 * other than q->sysfs_lock.
 	 */
 	&elv_iosched_entry.attr,
+	&queue_requests_entry.attr,
 
 	/*
 	 * Attributes which don't require locking.
-- 
2.47.1

