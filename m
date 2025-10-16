Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FF1B6CE9
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592686; cv=none; b=EW4rShAaEMmJkxSA2x/8VdJGv48kK1PTA6qP/PQrQhDIejUXObuZFkVNsSP7/cjLu105y6GsV8xlDgyP8u++ewaFHkwLUQ5ZuhiMdfK1y0IT3kWOfLszQbsqikvNd6+aoFTrkY0SxJUswdaLhUZSCgP/EgHZSxwM3EV+Un0x2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592686; c=relaxed/simple;
	bh=UuccxB+7M18/59zRdgg4L5YXX5tukpuvVvpI1r4F5os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDfqbNhRK+WOh0mRkiGgGNf4Vw5uLYKOt/TaoKlexbLXsVX8q8gSLW72JFl9DmVk48FewrWllfxo5kVDjMqHPQ3kUVTpuHWDGw9z2auK3u7lpik52QRPhxmgYXxjbbmOoW9owZdZkyzgdvg2SiOWueo5LH5dSxQSVgYnyMsgh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CBk8oRNs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CBk8oRNs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G07HCd010524;
	Thu, 16 Oct 2025 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pQGROwG7Q2BkXkPaC
	SbEP9FeTaRnl7vOhWQMrCAfmU8=; b=CBk8oRNsG0f4gpkQ3Cxa01Rn85J+iWLVE
	auNOco+IQCubqF9GFRHfOo8joxhYCq9P7TnRrAkKK8ud024cl8+XnnS+MMj5wStt
	mm+QB2gysPBXIKj/Nm9nJBxRVf+VX3GUxEHl31Gsuy2J5D7yqC+TSv+Ko7Cpb30D
	fWE25yx1w96E32R8tqKpgFpiv+EcguUZbncVZfLzzF6D8LIATq6PO4UgyvbmgPW6
	6fYwdfYDwIAiMEOUT0Fh79mDgHNF4oOyAHAAHjdE2tVtVcGCbNP9vIbNuPBJGU7S
	X3Epx6MBAeqdWEIhod9ECDMybLC2+XH82D+99MKUvwH+Yk0/BSYFQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu8mm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:31:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G36HGG015016;
	Thu, 16 Oct 2025 05:31:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjkujm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:31:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59G5V7OZ34079258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 05:31:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C15420043;
	Thu, 16 Oct 2025 05:31:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6D3620040;
	Thu, 16 Oct 2025 05:31:04 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.148])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 05:31:04 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, yukuai1@huaweicloud.com, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCH 3/3] block: define alloc_sched_data and free_sched_data methods for kyber
Date: Thu, 16 Oct 2025 11:00:49 +0530
Message-ID: <20251016053057.3457663-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016053057.3457663-1-nilay@linux.ibm.com>
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VUH_ZV_egEqMzif3tZMdpRBTHY_LJ1nL
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f0831d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=1sDiDhgU5wRd15m8xSAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: VUH_ZV_egEqMzif3tZMdpRBTHY_LJ1nL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXwZXUL13CLN+k
 oivr0n/blp9JItbDiYhTSyZFnKCuyk6Sfw/0UjiufEP10TEuIrj4puzgQguFSvvWIFf2CbDS9PL
 t/vMKVhy+1F9TrAH4YbBFIa0uJdtIxD7J13qwZG5lEEVBY5yroYX3s9PncU+AxSzQ1UZGe20Hkz
 u37pI27/2bwiWQCem2UM/JY2gLA31QJbZZyqnK2EVkBdb3FIWQ+1Arb7AJW8Y8r8uRApHIY/62I
 piZFu99nEO2a5Hh/gO6RhDPI6IOmDJtbZHN2IAivCgA6de4Pm1w/9jxGSgJL6e3F6vn1WS30RD8
 LDHO2sHpR1DBm3DMcYnDbPlt0Nlv5o8u+rub6vlDpuftrSnOSAHcJeoRfW0eOLbziXplrpGbu7a
 jt2PbTGPd45OUzE+0KNC4v89vJp//A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

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

