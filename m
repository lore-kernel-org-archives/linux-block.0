Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B030E849
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586630; cv=none; b=E1RgLrn5YyPgIwwW8zKhd+0jwUD6anVRyD2Ce/qYaKRbqlTTMQmsy5PK0t1xWVz0D0ZV25T+42QVXlwXf/GD/pg9URKIdOtWgO378SGw+p3RpJqndJ4dAu8Z0+KO1CsbqEMo+BEj3+EPUrhGSZ2eD7ix+fgAIoW3RjRwpCMKC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586630; c=relaxed/simple;
	bh=03jIWMU2YV7cIll7FVXL7iSgcqCocdnm1T0vGQBfhm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMuIdj7L91ZpfXEUxju2b37W8ojQXqpXYk2T01A+1sEW6y6v27IKg9Ks5YrCNVigrOd8WbJbK4OaAqPR04Qh9kI/oAvjoy7G7LggvDGKH/3y2c7nR24mAB11Y8yT4b8WBlqLY2XcrbV0KQfDZkEZtcoHD18JOBxIZ2Tmny8j4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iOnskZAC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iOnskZAC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8SlLC016597;
	Mon, 27 Oct 2025 17:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9PzQ0iR4Jp2BVan7P
	Jr4EXYArt0/LZ5B5nhQMyJRBWU=; b=iOnskZACWOjkkvol319cDOZDzjZ1Jy6ih
	QMmMIaKPIN97OtTDF/HcS9/YUHdlp6/PWn0MiqcAkF2FMj2TbsrDEv+mdvg/ofS4
	IApQSi9CBeOWgC2Se++DCe+GD7zPOFG9xRzGgbFhz5L1YYLiXsoCdoZU1ekDxOTW
	KH6oqe7ZtHjb9Istx0JUHyy9bEgkxtwvhXymY12x05jCxrN5LC/N5bAwP7YFxNoR
	bhWlpL/2+M8JKHDgymLNI4kzeOxzxL8mE4z+rWDH+4JK3exp9zCWx9YPIj8qCROq
	Km3dTN5nWwb4TpSLSmWm85J5x4kNvlGxkhURSd7HdYiQoVrFsCTyA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys03uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:36:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RFKcVK030353;
	Mon, 27 Oct 2025 17:36:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a1acjpr8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:36:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RHaow456492424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:36:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E602A2004B;
	Mon, 27 Oct 2025 17:36:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F005820043;
	Mon, 27 Oct 2025 17:36:45 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 17:36:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, yukuai1@huaweicloud.com, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv2 2/4] block: move elevator tags into struct elevator_resources
Date: Mon, 27 Oct 2025 23:05:57 +0530
Message-ID: <20251027173631.1081005-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027173631.1081005-1-nilay@linux.ibm.com>
References: <20251027173631.1081005-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFnR0FYXXwibI1fPtBquy7Iqc1AIa4Tx
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=68ffadb4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=v11b6JBsMh7kvZZadcEA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfXyCd5giyaIjES
 kfw5vQ5k+UiW+9OfDZArjLSsXENYG3TC1XVd+1BB+/Dh+K8bwRFU9zMGuFAKb4/6ozKiZhuQq9u
 lt01f1E8HL8YGeUqzezKYjR5e6dkqzMQUJOn9TuQ19m8O7CHuEQOaJAVKSNTJa3elmeqsL0yEna
 8qGNYoYqv3TJ1c2zOseQ2H7F/qxxAbY1JHEvuRUvN+pM2xKM8y2WLZSWJCZVfCXVaBgG9Z2LYxy
 qCDKHmaZ8kX/YDkeozY88bBv8sxpoR0xMonO0ENQPBIOVgSw3ZT2z/qkCbLXqSiEXg0PrLT9nE7
 dR4jCqTh04HsKTcJOkMyGNMNrKjSW1EibpxupnLdhBzLkvGs4ZtYRdFzYril7ZJgNt8RYVRBfy2
 iLwmJWeM0A4AQD8fTnIOKpO3HjgCBQ==
X-Proofpoint-GUID: JFnR0FYXXwibI1fPtBquy7Iqc1AIa4Tx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010

This patch introduces a new structure, struct elevator_resources, to
group together all elevator-related resources that share the same
lifetime. As a first step, this change moves the elevator tag pointer
from struct elv_change_ctx into the new struct elevator_resources.

This refactoring improves encapsulation and prepares the code for future
extensions, where additional elevator-specific data or resources can be
added to struct elevator_resources without cluttering struct elv_change_
ctx.

Subsequent patches will extend struct elevator_resources to include
other elevator-related data.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.c |  8 ++++----
 block/elevator.c     | 14 +++++++-------
 block/elevator.h     |  9 +++++++--
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ac7876c98e64..b35300882852 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -559,7 +559,7 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 				ret = -ENOENT;
 				goto out_free_tags;
 			}
-			ctx->et = et;
+			ctx->res.et = et;
 		}
 	}
 	return 0;
@@ -569,9 +569,9 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
 	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
 		if (q->elevator) {
 			ctx = xa_load(elv_tbl, q->id);
-			if (ctx && ctx->et) {
-				blk_mq_free_sched_tags(ctx->et, set);
-				ctx->et = NULL;
+			if (ctx && ctx->res.et) {
+				blk_mq_free_sched_tags(ctx->res.et, set);
+				ctx->res.et = NULL;
 			}
 		}
 	}
diff --git a/block/elevator.c b/block/elevator.c
index cd7bdff205c8..51bf688b5c4e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -580,7 +580,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	}
 
 	if (new_e) {
-		ret = blk_mq_init_sched(q, new_e, ctx->et);
+		ret = blk_mq_init_sched(q, new_e, ctx->res.et);
 		if (ret)
 			goto out_unfreeze;
 		ctx->new = q->elevator;
@@ -656,9 +656,9 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	lockdep_assert_held(&set->update_nr_hwq_lock);
 
 	if (strncmp(ctx->name, "none", 4)) {
-		ctx->et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues,
+		ctx->res.et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues,
 				blk_mq_default_nr_requests(set));
-		if (!ctx->et)
+		if (!ctx->res.et)
 			return -ENOMEM;
 	}
 
@@ -683,8 +683,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	/*
 	 * Free sched tags if it's allocated but we couldn't switch elevator.
 	 */
-	if (ctx->et && !ctx->new)
-		blk_mq_free_sched_tags(ctx->et, set);
+	if (ctx->res.et && !ctx->new)
+		blk_mq_free_sched_tags(ctx->res.et, set);
 
 	return ret;
 }
@@ -713,8 +713,8 @@ void elv_update_nr_hw_queues(struct request_queue *q,
 	/*
 	 * Free sched tags if it's allocated but we couldn't switch elevator.
 	 */
-	if (ctx->et && !ctx->new)
-		blk_mq_free_sched_tags(ctx->et, set);
+	if (ctx->res.et && !ctx->new)
+		blk_mq_free_sched_tags(ctx->res.et, set);
 }
 
 /*
diff --git a/block/elevator.h b/block/elevator.h
index bad43182361e..621a63597249 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -32,6 +32,11 @@ struct elevator_tags {
 	struct blk_mq_tags *tags[];
 };
 
+struct elevator_resources {
+	/* holds elevator tags */
+	struct elevator_tags *et;
+};
+
 /* Holding context data for changing elevator */
 struct elv_change_ctx {
 	const char *name;
@@ -43,8 +48,8 @@ struct elv_change_ctx {
 	struct elevator_queue *new;
 	/* store elevator type */
 	struct elevator_type *type;
-	/* holds sched tags data */
-	struct elevator_tags *et;
+	/* store elevator resources */
+	struct elevator_resources res;
 };
 
 struct elevator_mq_ops {
-- 
2.51.0

