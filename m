Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B911A9FB0
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762547; cv=none; b=Ho8EHfmqj5oFX2NOQQK4p4nuPinZmOrSAvM7NboSKIa400vmCS1ruo5JYIMc7TPiSr2OJNV3SoxHkw5k+Bgiap1Ttrq+ddx+umYwPQzqiL86VHF0evIEkiimiZQ9inf6nkmJ0SANuwABZkOTcoXBjBFiqGVmGCv1Ng8BQHDUd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762547; c=relaxed/simple;
	bh=UuccxB+7M18/59zRdgg4L5YXX5tukpuvVvpI1r4F5os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxFG0kOmEDZThURMKHtTySnFcGLyvT/ydPQNZKz7Ca6iBAK9P5loIh1JTN3w7oodCjkYNX7BW9H3wqHdt9Fyw+z+35Grhxcbgl82Lc2EsyBSkNSxNAXzvDsfyQNb8NA3OrQDOfJLNodqDtWoIuUAeyGwSE2r6VAe2RjrKKtD2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CfvtdJ2Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CfvtdJ2Q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9MhG0V005929;
	Mon, 10 Nov 2025 08:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pQGROwG7Q2BkXkPaC
	SbEP9FeTaRnl7vOhWQMrCAfmU8=; b=CfvtdJ2QXM7D+X8Ns+wlmswqUu7+6dl0p
	tMkvP1cDeQlGsjVMYCixLyp2MaPXDL3kwkxxCZKoO2nO1Zw573sHuxw1wbSlq9Tn
	IKfQOwn+i1VWPy4usLHVqZejl5NkouQWPdQbrqg/gtGD2pq3dQcpnL6yajttliWT
	NXuiwFsunGpcQ4dDUoDXdNyUtqbDieuyIbkHBretMmF3vGF+SCHX6tPIrrlzeRmA
	VwPGa0PA0CPuMD79qnVJR7j3JW7mNnCttv14z8jbw1PTjPbE61zIawY8jMuHxeda
	ZzEojECBm12P0Gg9nk0o8JPOnAdeMfhqOTmWF++Oe0s3vCD7/6kJA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc6y79q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4rPcu007325;
	Mon, 10 Nov 2025 08:15:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdj4c83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA8FSbM12583362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:15:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A401E2004B;
	Mon, 10 Nov 2025 08:15:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA30520040;
	Mon, 10 Nov 2025 08:15:24 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.93.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 08:15:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv4 5/5] block: define alloc_sched_data and free_sched_data methods for kyber
Date: Mon, 10 Nov 2025 13:44:52 +0530
Message-ID: <20251110081457.1006206-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110081457.1006206-1-nilay@linux.ibm.com>
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX1fL1ECgBSIln
 aqr8uu0nOvJpOJ1benADMG+sDxwE5j9iRIaC1uea+zvmuux7KH75HVfGje/wNHVkTyorCm1N6pX
 xGTbJpwSgWKM9ATsaR+DZNfIefT/mybk8WJ/LPrIPN4syDFb4HQhPHaS6/KkxdMj7QA5ajRJZVH
 5Tzy/zTSqTMRzeJ/caIxyQRX5IZqYpT2mI/+vAzK2Q4CKYuScppMdFwe76Tb/2EDuU0y563NykF
 3gJeQiXWdcAmQRAhBoiARVe3lnvksTFnFgIttrqF/FuDG3Bvjb+d2aFsixWzk7MAe2B/rVUvkIF
 /3fDN1LeMnpydb5eZBqVBperq9xoj76Nt97EigqGx9viJoFhD1vudDo9vIZ3zVnni+ewkn/Kiyt
 BY0EA+HaPYt0mEqKkeMUL6gqW6yZwQ==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69119f23 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=1sDiDhgU5wRd15m8xSAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qmI-1VX7LuuPseX0MjlEBXBhSZpp4vpL
X-Proofpoint-ORIG-GUID: qmI-1VX7LuuPseX0MjlEBXBhSZpp4vpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

Currently, the Kyber elevator allocates its private data dynamically in
->init_sched and frees it in ->exit_sched. However, since ->init_sched
is invoked during elevator switch after acquiring both ->freeze_lock and
->elevator_lock, it may trigger the lockdep splat [1] due to dependency
on pcpu_alloc_mutex.

To resolve this, move the elevator data allocation and deallocation
logic from ->init_sched and ->exit_sched into the newly introduced
->alloc_sched_data and ->free_sched_data methods. These callbacks are
invoked before acquiring ->freeze_lock and ->elevator_lock, ensuring
that memory allocation happens safely without introducing additional
locking dependencies.

This change breaks the dependency chain involving pcpu_alloc_mutex and
prevents the reported lockdep warning.

[1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/

Reported-by: Changhui Zhong <czhong@redhat.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/kyber-iosched.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 18efd6ef2a2b..c1b36ffd19ce 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -409,30 +409,42 @@ static void kyber_depth_updated(struct request_queue *q)
 
 static int kyber_init_sched(struct request_queue *q, struct elevator_queue *eq)
 {
-	struct kyber_queue_data *kqd;
-
-	kqd = kyber_queue_data_alloc(q);
-	if (IS_ERR(kqd))
-		return PTR_ERR(kqd);
-
 	blk_stat_enable_accounting(q);
 
 	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 
-	eq->elevator_data = kqd;
 	q->elevator = eq;
 	kyber_depth_updated(q);
 
 	return 0;
 }
 
+static void *kyber_alloc_sched_data(struct request_queue *q)
+{
+	struct kyber_queue_data *kqd;
+
+	kqd = kyber_queue_data_alloc(q);
+	if (IS_ERR(kqd))
+		return NULL;
+
+	return kqd;
+}
+
 static void kyber_exit_sched(struct elevator_queue *e)
 {
 	struct kyber_queue_data *kqd = e->elevator_data;
-	int i;
 
 	timer_shutdown_sync(&kqd->timer);
 	blk_stat_disable_accounting(kqd->q);
+}
+
+static void kyber_free_sched_data(void *elv_data)
+{
+	struct kyber_queue_data *kqd = elv_data;
+	int i;
+
+	if (!kqd)
+		return;
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
 		sbitmap_queue_free(&kqd->domain_tokens[i]);
@@ -1004,6 +1016,8 @@ static struct elevator_type kyber_sched = {
 		.exit_sched = kyber_exit_sched,
 		.init_hctx = kyber_init_hctx,
 		.exit_hctx = kyber_exit_hctx,
+		.alloc_sched_data = kyber_alloc_sched_data,
+		.free_sched_data = kyber_free_sched_data,
 		.limit_depth = kyber_limit_depth,
 		.bio_merge = kyber_bio_merge,
 		.prepare_request = kyber_prepare_request,
-- 
2.51.0

