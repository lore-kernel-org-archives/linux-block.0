Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E037155352;
	Wed, 28 Aug 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845852; cv=none; b=Yxe+22KAcKYos4t0GOMXnwC3X6gqeOlKFotJygAP9R1rLncfqMMn3EqfClxG+mpW3IArd88Lx0YTB4exA/j+Q5eRsCw2y+OdYzvVdks8PZBMGeLQH1WyvCQeJKS41SNoYxsBBHp3yXbId3beE5dqwHsfxV9PnY/TxgpesR01KQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845852; c=relaxed/simple;
	bh=DAZw4dKbjYxQ/XUR7oulIBEXHxsRe8vk0SMfFTIeMXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DaIqLxdyjeyZr7Et1ZF+lzi9vOX95SPC+XQQIqQLP2n/IjLTqHsNZrlk6yKRcmEI4hAHCpRqRx/dx4BJbEa5GzLneSN+9+v80BMxOliLfjJf+dwQ0mDPU6cNyPKIZa3F9Xmng/Y6BZcyOP5H9q66s2kW3+/EfrJR4iw726FyBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E7ObMKPb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E7ObMKPb"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SB22UK003146;
	Wed, 28 Aug 2024 11:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=biUpZUVisTjyaUKNnvHNNG/jleI/CKxhuOCjjsOuR/k=; b=E7
	ObMKPbzzkocgMtCHm7UTeSL/F5uJzzXkeRy9C4d/6xKHNlxIDb5Z/L/RfaAGizlp
	W1WH6temyEPqZnI4LDva+UhTXUZaF8JFBcxJB3Qe6DuLELooctsSbGLxIleMOVzH
	+HkdpftHXuP28nJQ4ww1D5kSXeFo0ctzi0xb9m7lQ8zWR3BU6cc1E4fM0MD77cuQ
	Zwp4jbsukPyjMLDO+LpaO8gc083PN+vVhY1+erm+lFL7/IMAJyAlTF79XhNA1dPw
	LQBxRYfZpm2eBJ+4bSyBeT2jYuFPYAUvOsDScgOQE9uEBpajN5tNJxLnS4CwpuRm
	eWcjmIO9X+w3sMoLEVRg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puu9mnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 11:50:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47SBoBKr006956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 11:50:11 GMT
Received: from hu-mapa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 28 Aug 2024 04:50:08 -0700
From: Manish Pandey <quic_mapa@quicinc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_nitirawa@quicinc.com>, <quic_bhaskarv@quicinc.com>,
        <quic_narepall@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_mapa@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH] blk-mq: Allow complete locally if capacities are different
Date: Wed, 28 Aug 2024 17:19:58 +0530
Message-ID: <20240828114958.29422-1-quic_mapa@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wGgtsDGNzAWWH1F7i4d0G8pe6xA3HUNX
X-Proofpoint-ORIG-GUID: wGgtsDGNzAWWH1F7i4d0G8pe6xA3HUNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_04,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280086

'Commit af550e4c9682 ("block/blk-mq: Don't complete locally if
capacities are different")' enforces to complete the request locally
only if the submission and completion CPUs have same capacity.

To have optimal IO load balancing or to avoid contention b/w submission
path and completion path, user may need to complete IO request of large
capacity CPU(s) on Small Capacity CPU(s) or vice versa.

Hence introduce a QUEUE_FLAG_ALLOW_DIFF_CAPACITY blk queue flag to let
user decide if it wants to complete the request locally or need an IPI
even if the capacity of the requesting and completion queue is different.
This gives flexibility to user to choose best CPU for their completion
to give best performance for their system.

Link: https://lore.kernel.org/all/66912a22-540d-4b9a-bd06-cce55b9ad304@quicinc.com/T/
Co-developed-by: Can Guo <quic_cang@quicinc.com>
Co-developed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq.c         |  3 ++-
 block/blk-sysfs.c      | 12 ++++++++++--
 include/linux/blkdev.h |  1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5463697a8442..af048dad9667 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -93,6 +93,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
+	QUEUE_FLAG_NAME(ALLOW_DIFF_CAPACITY),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa28157b1aaf..1584312d870a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1164,7 +1164,8 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	if (cpu == rq->mq_ctx->cpu ||
 	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
 	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
-	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
+	     (test_bit(QUEUE_FLAG_ALLOW_DIFF_CAPACITY, &rq->q->queue_flags) ||
+	      cpus_equal_capacity(cpu, rq->mq_ctx->cpu))))
 		return false;
 
 	/* don't try to IPI to an offline CPU */
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 60116d13cb80..37d6ab325180 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -300,8 +300,9 @@ static ssize_t queue_rq_affinity_show(struct gendisk *disk, char *page)
 {
 	bool set = test_bit(QUEUE_FLAG_SAME_COMP, &disk->queue->queue_flags);
 	bool force = test_bit(QUEUE_FLAG_SAME_FORCE, &disk->queue->queue_flags);
+	bool allow = test_bit(QUEUE_FLAG_ALLOW_DIFF_CAPACITY, &disk->queue->queue_flags);
 
-	return queue_var_show(set << force, page);
+	return queue_var_show((set << force) | (allow << set), page);
 }
 
 static ssize_t
@@ -316,15 +317,22 @@ queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	if (val == 2) {
+	if (val == 3) {
+		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_set(QUEUE_FLAG_ALLOW_DIFF_CAPACITY, q);
+	} else if (val == 2) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_clear(QUEUE_FLAG_ALLOW_DIFF_CAPACITY, q);
 	} else if (val == 1) {
 		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_clear(QUEUE_FLAG_ALLOW_DIFF_CAPACITY, q);
 	} else if (val == 0) {
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
 		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_clear(QUEUE_FLAG_ALLOW_DIFF_CAPACITY, q);
 	}
 #endif
 	return ret;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b7664d593486..902fb726ebe1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -602,6 +602,7 @@ enum {
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
+	QUEUE_FLAG_ALLOW_DIFF_CAPACITY,	/* complete on different capacity CPU-group */
 	QUEUE_FLAG_MAX
 };
 
-- 
2.17.1

