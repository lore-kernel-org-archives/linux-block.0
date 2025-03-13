Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50E26659E
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866779; cv=none; b=LMhk/HyR7pR+GcqLY5g+GrjpqxvUom+X3JI0Qy5CdLi4bnFa+fR52NrKZTK6L0cEbiDxzTr9WVnEil8Gv/UHJbtLALv7NWD9E4Wm4xWta3nqt8CmNd4dHRYqg+VVoQYXyuUwXPLDaHAuNOGKiOOjaUct4Sv7gwu+9DKQFc4oPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866779; c=relaxed/simple;
	bh=l/i3BbZGvZoVMDsdVAe3Q9ijqmqQq3QIX5MEQ3LV1hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghJ9IrkdH51sTzEtwg0RQjOB+oTyrdRdFpiJ5b27ft7KkahTgGD1rk6c76FVKjcGMcXSLUiw6CQ2jEfFTfZgZHbB+webua6B1vCd00zWyx5taNtQH+nYqaltlsE678bDrHiBMnyxi7j2XUNIhZJffccAG6oe0wbhgUZAcVxlUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rn7zh+4u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rn7zh+4u"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3jvdm006503;
	Thu, 13 Mar 2025 11:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z/3CqngCnsQ+dywl8
	/Yeb1PsqBlTmgF+7QiIhSlBct0=; b=Rn7zh+4u/rh8Zk3WqUrhaO//jPwdhyd9V
	X80ZGU+JG+V+JooNrwpKXZSNkpN/r/ocXbDX3z7MhAh46FvDGslzXpuQXmMiSbpp
	JnhLAVnNme8VxqVkXz6zP4zn96rai5ke5D2A5x6WMw2cgNBf/AX4l5w/PpGEig9d
	ZoN2iNaKExCXuw1u74HV4NZe9NIC28eIlIqMZQ44E/YfLVfBURIFAyOKgrP97uFj
	OFKDGQm6sN3kifsOxKsiJHi6wubQb/Nu17/FOu1yUC7Qk9hBY44rvZXhQMa4ywLu
	T0REKzVDM3xiRjFvKQBcagAJhR1gum7BTnxV56EP23jiv1JPh1hfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr92396-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D8S4x9026029;
	Thu, 13 Mar 2025 11:52:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atsphkm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52DBqcNR32834260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 11:52:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D75E620043;
	Thu, 13 Mar 2025 11:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 879F62004D;
	Thu, 13 Mar 2025 11:52:37 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 11:52:37 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv2 1/3] block: protect debugfs attrs using elevator_lock instead of sysfs_lock
Date: Thu, 13 Mar 2025 17:21:50 +0530
Message-ID: <20250313115235.3707600-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313115235.3707600-1-nilay@linux.ibm.com>
References: <20250313115235.3707600-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BB56hy7dtfWP6hXNkE2a3RoXk0TSIbb9
X-Proofpoint-ORIG-GUID: BB56hy7dtfWP6hXNkE2a3RoXk0TSIbb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=989 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130090

Currently, the block debugfs attributes (tags, tags_bitmap, sched_tags,
and sched_tags_bitmap) are protected using q->sysfs_lock. However, these
attributes are updated in multiple scenarios:
- During driver probe method
- During an elevator switch/update
- During an nr_hw_queues update
- When writing to the sysfs attribute nr_requests

All these update paths (except driver probe method which anyways doesn't
not require any protection) are already protected using q->elevator_lock.
So to ensure consistency and proper synchronization, replace q->sysfs_
lock with q->elevator_lock for protecting these debugfs attributes.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-debugfs.c | 16 ++++++++--------
 include/linux/blkdev.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index adf5f0697b6b..62775b132d4c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -400,12 +400,12 @@ static int hctx_tags_show(void *data, struct seq_file *m)
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
@@ -417,12 +417,12 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
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
@@ -434,12 +434,12 @@ static int hctx_sched_tags_show(void *data, struct seq_file *m)
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
@@ -451,12 +451,12 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
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

