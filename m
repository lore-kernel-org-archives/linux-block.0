Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF106244664
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024830; cv=none; b=MucvQCAfSLU/wxwJAP7fN0m7vFQA3h9ny33KIL8p4NdmNxVJvAcjFEAn87g5xDEr/gfTdpnNWJpMFcjao/UrsqWg+ntdCxMQJcvNpR4NW9ZTSb9szPJWFTr8x+78O3Hd8l3XhF6lIv3ZN/sOBGbwhNy/oOeACdKfC/Pz0+pJYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024830; c=relaxed/simple;
	bh=moX0jhIuq/NvbwpSnpWsqhr6enWecrpPytvBQ94pM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTLYvNvCSA258OizZoJM3SP/kLFR1R20WUUGE3Xs4Cstkf62MNKAU9PKUTd+EDy6Rs8e46LAWjhLyavuTIuJ6QShfk6ECeMfGzR2wFECRnJqkyWKO7a/DEtmJLJHDsAlJrAtg4XYXbQFw9zhZIxDeREAy0eRfY7u2ADfcjSA2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bcd9eex4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bcd9eex4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACIIHN6011435;
	Thu, 13 Nov 2025 09:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YI9acWQlJchprr1VG
	bNp0yker1CM+xUKquVPAUl36Xw=; b=bcd9eex4BczYhQ0yibp8LgU4gr9P3yTLP
	zDr+CRu/JYgf4mCtWzVW2sjOxtv023G5U8iz7ddvGfm3zoQ497ELLCzV0l5/eoRd
	hdUVW7yRfzgjs9f3dWT91Qxlb6K7REiTrL8uXVUCbKSmgIurb5YX9zz9fvAqg+L1
	fQVgf3Lh/GRXkSzxtoS1NpLhPuFhKki0A6M/sbBdz3N2MQWWtgw4ITsbgVxNHjS8
	zpOksDZ4+kks1z4cNvwM8ig5H7Y8f1RqPY9Y4EVBxll34LuVnAQbaLGRRr7hJ2+i
	pqVcS53tCpccN9hA0oc6bo7ZnIw/Xk9/a1GbBOTNkNqSFZCpPzVUw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk4djf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD50NGq008193;
	Thu, 13 Nov 2025 09:06:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6n4xk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD96ZfV49742146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:06:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 457382004B;
	Thu, 13 Nov 2025 09:06:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C55A20043;
	Thu, 13 Nov 2025 09:06:33 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 09:06:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv7 5/5] block: define alloc_sched_data and free_sched_data methods for kyber
Date: Thu, 13 Nov 2025 14:28:22 +0530
Message-ID: <20251113090619.2030737-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113090619.2030737-1-nilay@linux.ibm.com>
References: <20251113090619.2030737-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WdIAEgd6MP_nWV_hFysbUZ1Ibjpobj8T
X-Proofpoint-ORIG-GUID: WdIAEgd6MP_nWV_hFysbUZ1Ibjpobj8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX3KvvLcKPTfA1
 stBFHBpENjrl3mL1IbLWvRSgJ2fHmVFHhoMMBZqDpioDu7hXh4W7A9FfxYwW37/ODlWg/cn5MTc
 X+mi1BzIb/XkjRdjd6CKXdDOEHDRhEuZkoELO5ceuoiF7eymWINGdlY3fw1irIqcIlhWbQZAA6j
 q1sRp15nq9Dn2oPiURyw8+gXFV6dJvF43sI9FIP8IqlaaYAirKAwkyGvRLzLsWjBaYUyXhNa8jE
 oR3dy43KkB+ykqwyUoV0KM5nBjUYnMjOsjFHYMw148mWCVzzY9PnaS2r+UCHw4Cv8jqsqAAxYtb
 ry7MmsA2w0KgADkN9VwVyuUCHWGs6177MGdJkNj6szpLzvkrjQ88JKA0gxxeRGBaX9xEs59YOox
 rB6QoxesewBVeSNolcaQsFP+X+nvTg==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69159f9e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=1sDiDhgU5wRd15m8xSAA:9
 a=H0xsmVfZzgdqH4_HIfU3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

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
Reviewed-by: Yu Kuai <yukuai@fnnas.com>
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

