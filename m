Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F41A5B8B
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586774; cv=none; b=I2UlyWwyV8LsZV3OHJR90tU8g8Q6NTAYaMj2dG10fLiaTdgyiyvJac8+9kG/VpnTn208j7J+FyNyzSjqjO6+k935modyQLWgTMRs8TzdinUTI/sCv3iFs3KCzIv1u6K/oKwApsdozwJeM0UBhjImIWOUiArt4ZgO4frW7/vBHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586774; c=relaxed/simple;
	bh=UuccxB+7M18/59zRdgg4L5YXX5tukpuvVvpI1r4F5os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+OnDuBI97lxdSTgs6Q9xTwAjz0xaY3yqmi+4u7tLDWWTTSKjqalt+t3gItkkU8qOtc4mXtybvcfngFz4Qgq7irfkoiFZGZfLhI7QtNs8Ud7vHROZbjIFs7+F4FDG4F9b4N/avPNhSVoTqWcfZrraLJF053A8tpcldZuUfrv+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bi7WOD+g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bi7WOD+g"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8IBn4023045;
	Mon, 27 Oct 2025 17:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pQGROwG7Q2BkXkPaC
	SbEP9FeTaRnl7vOhWQMrCAfmU8=; b=bi7WOD+gVjcp5rx4dth5a3huqyPv6Pmjc
	NCOJpu+VLlt9CBDkYRquMrodaRDuVq39+XgI93mg8iVqf/KFxxU5Z4Krqalce21C
	ZyNTKyq/P1+IXJGfDEi9S3rtObjfhcM1dA0RewB6cDYMLzsYN7kNlqS8+VbM9EOE
	RXqCR85yVsMsJDHdsRRzbmnYG1bavVyU5W7DlEF83O1KBSrB+E/k8J3PvvHnapux
	IASIKlhfE4xpaXbpMGZuYUBY4pKhBiqsJVnmBxVywln4MFW3fhwnOTtoTBqVsnOt
	tLwjbc6WeVQWUTZP3MtdnQmYJC/lv5DDLaKcE/PKgeCBTZU4MLWvg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kyt863g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:37:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RFJMcX030075;
	Mon, 27 Oct 2025 17:37:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmet4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:37:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RHaxgl41877926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:37:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B742004B;
	Mon, 27 Oct 2025 17:36:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 939C520040;
	Mon, 27 Oct 2025 17:36:55 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 17:36:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, yukuai1@huaweicloud.com, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: [PATCHv2 4/4] block: define alloc_sched_data and free_sched_data methods for kyber
Date: Mon, 27 Oct 2025 23:05:59 +0530
Message-ID: <20251027173631.1081005-5-nilay@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 86HK0zrUR5II95AnwuSOFQh16-y71PX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX/ClsNAz+PXhF
 ySvAhujiAiY0u+igZfA2UuFjr6yRWqFwRk2Wo9Qs5W4hHEnzJ2ehgebRGaDeLS5ORfEwaBHsvjy
 MVLN/yGtj+NdzsZ94VDYy3dD35yaSMvdbMCtrd5E8KF4A4MX7zmO3+jSvvUNNDyb9b90lQxEB08
 ne5KZlqBmuhOTrGxSFvvAqOSqn/CmVlSgdOKU2kbhFWW0w/jwi4G1EMLH71e97OelhJ0pxTj+JL
 APQO7kQy4/qsybbLTDE+4GxcUsLolIwMzVZNBGOfhGzu5uW4+uVLscol8LdFtsbY4nwAPAQaITD
 sG/JSMCH7njJ/Xe29Sp3d+RCo5lmM6A5u8eTgOliTmaPTDkwNQjeAJIr3fz1/a1z3pzD02xaOrA
 66Bkl47uS/FdmC5UJoPaUKkiMb9V/Q==
X-Proofpoint-GUID: 86HK0zrUR5II95AnwuSOFQh16-y71PX2
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=68ffadbe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=1sDiDhgU5wRd15m8xSAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001

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

