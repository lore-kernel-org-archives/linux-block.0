Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE432D44F
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953816; cv=none; b=tKR7BuiVybG4Q79+8/rjsvTBZkvH6bamzcFYCXeGtfJ4EavVK4ZCSwYRa+bihGDiJgfWA5gkXNIOQdQxkaU9wC/fr9qdpd/kJ06872e0Fp4Ta9BLbj3pGpgNryIp2veRHL0YlNaSTCMYrGNfCzlYSGxLSm2rB8dvQ9i5gbm2F2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953816; c=relaxed/simple;
	bh=P8GPKZYkr2ygSy+PWpN+18Z5dPMdk6QB7YMWgubPuJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu5a7SNdqEUOG1Zj/82vi2HZpbk2FM8ikbHJ8/CmkZSJcADbyga+glc1WauPiDchKB23Qm4IQ6oL/b7UblvRjJhOgSAcaUFTlf6mbhak71G5EOILVfCUmqpYcmKJYn245R11LpAhixKQ6nhKf3fe+ADQZPIMqR4RFa0QZxasg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VGxEUMAL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VGxEUMAL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC69RWM002817;
	Wed, 12 Nov 2025 13:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RIeEnEASy94q/dkN3
	bE4d+5BOCu9LWqiRCxLJDSP2LM=; b=VGxEUMALK1YD2yYNHwUf4jjSbIfMGi9Ab
	SMFUo/uwLkH/Hm5LJwB3Y4YT1amWzvlB5d8thg6CeoW4c5Lz6bvwGChBBkXsNG/k
	lquoZM1WlS+HJUMzkR9dh8Yxe+h2dwLV+YsGAE+pk5Wjjt0TXWNVzV22L7RzndiK
	bLkUnLtZ5x6UaaSou6R7/yWkbqTaX+qUo3+ngu9Z/2WZIhxuGFAde1C0beJqkoMV
	i39y5U3Z1LpJIRx/HPT6fJk4GxiUh4oD2ksYemohwivIW1QUWG0xcicc54S3prGX
	evumgj1fkownJtFKxPbve+rmYt7YyzPnGKUM0eBrlMButBXyj0Q5A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7aq3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:23:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACD9FE3028888;
	Wed, 12 Nov 2025 13:23:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sghwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:23:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACDNJBw41288078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 13:23:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 977172004B;
	Wed, 12 Nov 2025 13:23:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C8F620040;
	Wed, 12 Nov 2025 13:23:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 13:23:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv6 5/5] block: define alloc_sched_data and free_sched_data methods for kyber
Date: Wed, 12 Nov 2025 18:52:28 +0530
Message-ID: <20251112132249.1791304-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112132249.1791304-1-nilay@linux.ibm.com>
References: <20251112132249.1791304-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX1gQphe67HGb8
 BvnZ5db1/WrHxiaX2/qd1+Nh2xKByjho4YeTPzP55tz4yl5T7hns27ONwEQMDtSLJjTi3iI9vps
 XlJ7seDOxy/a2QbhDBm5U+NdWRfl7nWyuPQaTgZPQ1HPMQ2b8R03cG58EPpOoZIpLVW+1xy6CHx
 jML9L8SiIv6XOs2LZJtJBAlLxlVetL5pIPHgg2GczKVbgLwp+cpwk3r9sP0tH36MPC0qA5QKgxy
 UISmQc4WcD+HgiiwQYa2hnno+EmDY2ZAHlXz9Uwz4GR2+a6vdqixhF7tZtCbkoFe3ckoNTs35FY
 XIPPwul2P6oxDXNWE86QEwBHK9+GM5REbush5rwtJuk56rDCfja42n04D5Ct+0Bvj/dufp/9fzO
 LUcI9kL8hMCLPPfDppYu5HiX++teZA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69148a4a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=1sDiDhgU5wRd15m8xSAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qvF6hy-XP3NSjtXRi8v37O9rxGfzfbgV
X-Proofpoint-ORIG-GUID: qvF6hy-XP3NSjtXRi8v37O9rxGfzfbgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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

