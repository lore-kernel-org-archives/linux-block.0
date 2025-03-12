Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54023C8BD
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775363; cv=none; b=VRfqzCfokZ3Py3y/kwDCXoRAIGmfJbY8shYLeE4jlMq3VgZTuJctie4x8AG5Ttv+zT2dBX/+w/78rge/heQPsvJdi4evCXuQyBdMfoc9s1gWM6vJgwDZpiMv7/1MV/pln6jNjbx9E445xF7Kxb15mOtGx0UuTr0VSoYQYjj1LGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775363; c=relaxed/simple;
	bh=dTyPS3irdlzIb9gsRiOPOQl6R9tTcDcwesI9WV/v9x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJJZnPO80GSgyWCQZSQDG8gbSP5sgkgMZPVpIYKrg7tMpCH38feoyQFkfEYFWi6/ppi3riGsFGfL38IQLJFO/tOXwWIkuYhGKv99KXWcL9j4Y4JgIZHLJ3uXx51Hl3xMqfWAa2cZbeHCQXy828VRIvjQLPf6W2hlpGI6uYa4Kek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LP7KcHMA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LP7KcHMA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7vFkg008899;
	Wed, 12 Mar 2025 10:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0ZGoIdYUjuO+UmYSYY6lONWmTw4jjZ8TRY3Qp9NHF
	LQ=; b=LP7KcHMAhEiTQrqKDC9aa/A8skOnoeAJfQEEz2XA+lszhgMUqpTjytXnY
	EMatMMF+9W38q6VQjsyfMD5udN0kel5lQtaozoyqJm7VsSQEgXMsE3oNSGz3ukle
	RMveE+T7fORWL+GKzp5pzDZqy9IjeKYuRrPnIwpfDcAPa235/Ar/lx/YAYrxWl7R
	5ttbTdExH7h/8iTeC1xvqsq7aeYh8fzim+vZsDp/WqRh1fbND2AqxIdTWdSQX3sR
	pyZExBbofY7cm2FgL1P8uyr18djFfBr8rkOrITiCep521rDY2oCIDEc2nw0ElUlr
	gU6yuhDAh3AXRklO/wwAhSDx2m4hg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avk4b3ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 10:29:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CAD12T027172;
	Wed, 12 Mar 2025 10:29:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsquhxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 10:29:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CAT9kV40829414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 10:29:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C26D20040;
	Wed, 12 Mar 2025 10:29:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED47E2004D;
	Wed, 12 Mar 2025 10:29:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.69.177])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 10:29:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCH] block: protect debugfs attributes using q->elevator_lock
Date: Wed, 12 Mar 2025 15:58:38 +0530
Message-ID: <20250312102903.3584358-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vUxoqqjZgeCvE39RaGCQClc18DyeGjKH
X-Proofpoint-GUID: vUxoqqjZgeCvE39RaGCQClc18DyeGjKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120072

Currently, the block debugfs attributes (tags, tags_bitmap, sched_tags, 
and sched_tags_bitmap) are protected using q->sysfs_lock. However, these 
attributes are updated in multiple scenarios:
- During driver probe method
- During an elevator switch/update
- During an nr_hw_queues update
- When writing to the sysfs attribute nr_requests

All these update paths (except driver probe method which anyways doesn't
not require any protection) are already protected using q->elevator_lock
.So to ensure consistency and proper synchronization, replace q->sysfs_
lock with q->elevator_lock for protecting these debugfs attributes.

Additionally, debugfs attribute "busy" is currently unprotected. This
attribute iterates over all started requests in a tagset and prints them. 
However, the tags can be updated simultaneously via the sysfs attribute 
"nr_requests" or "scheduler" (elevator switch), leading to potential race 
conditions. Since the sysfs attributes "nr_requests" and "scheduler" are 
already protected using q->elevator_lock, extend this protection to the 
debugfs "busy" attribute as well.

This change ensures that all relevant debugfs attributes are properly
synchronized, preventing potential data inconsistencies.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Please note that this patch was unit tested against blktests and 
quick xfstests.

---
 block/blk-mq-debugfs.c | 25 +++++++++++++++----------
 include/linux/blkdev.h |  6 +++---
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index adf5f0697b6b..d26a6df945bd 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -347,11 +347,16 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 	struct show_busy_params params = { .m = m, .hctx = hctx };
+	int res;
 
+	res = mutex_lock_interruptible(&hctx->queue->elevator_lock);
+	if (res)
+		goto out;
 	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
 				&params);
-
-	return 0;
+	mutex_unlock(&hctx->queue->elevator_lock);
+out:
+	return res;
 }
 
 static const char *const hctx_types[] = {
@@ -400,12 +405,12 @@ static int hctx_tags_show(void *data, struct seq_file *m)
 	struct request_queue *q = hctx->queue;
 	int res;
 
-	res = mutex_lock_interruptible(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
 		goto out;
 	if (hctx->tags)
 		blk_mq_debugfs_tags_show(m, hctx->tags);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 out:
 	return res;
@@ -417,12 +422,12 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
 	struct request_queue *q = hctx->queue;
 	int res;
 
-	res = mutex_lock_interruptible(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
 		goto out;
 	if (hctx->tags)
 		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 out:
 	return res;
@@ -434,12 +439,12 @@ static int hctx_sched_tags_show(void *data, struct seq_file *m)
 	struct request_queue *q = hctx->queue;
 	int res;
 
-	res = mutex_lock_interruptible(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
 		goto out;
 	if (hctx->sched_tags)
 		blk_mq_debugfs_tags_show(m, hctx->sched_tags);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 out:
 	return res;
@@ -451,12 +456,12 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	struct request_queue *q = hctx->queue;
 	int res;
 
-	res = mutex_lock_interruptible(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
 		goto out;
 	if (hctx->sched_tags)
 		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_unlock(&q->elevator_lock);
 
 out:
 	return res;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22600420799c..709a32022c78 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -568,9 +568,9 @@ struct request_queue {
 	 * nr_requests and wbt latency, this lock also protects the sysfs attrs
 	 * nr_requests and wbt_lat_usec. Additionally the nr_hw_queues update
 	 * may modify hctx tags, reserved-tags and cpumask, so this lock also
-	 * helps protect the hctx attrs. To ensure proper locking order during
-	 * an elevator or nr_hw_queue update, first freeze the queue, then
-	 * acquire ->elevator_lock.
+	 * helps protect the hctx sysfs/debugfs attrs. To ensure proper locking
+	 * order during an elevator or nr_hw_queue update, first freeze the
+	 * queue, then acquire ->elevator_lock.
 	 */
 	struct mutex		elevator_lock;
 
-- 
2.47.1

