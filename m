Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573D29ACC6
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024807; cv=none; b=rOe5gfTvj5Rdz6zSZlePD7fHgD9Bb+yTGBW1NiR/VGoDRZW6nA9ETi12F92ntS7ceHTW8pz9Ymc0iaw2MN5BKDFHC4ivQ/Cgyt2Cx/h9iwCCIvCX2VdxDzb3WMKI4TkmyA2lscaj1KdU9DZhTLYwj4sFh1FjmlPpmAJH4mIXZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024807; c=relaxed/simple;
	bh=tc5erzrGIqJ9G7fcIfAvaBZhnyGD9AlkxkB26j30Z3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReSelwsd4wXZLbp/xXzDR6StJRxEGwyOUzgmam7ee+zXjfL78IaYKFzNWg3jcOJ5bg51LMIozhPlc7C+0pLMKJeJLYgVpAoLYmVXf5cMLe0vOfHBN/jMyDtsmmJCBfx+pLXuhG4aNm5L5uO8x0hVFtFoBuevHLH5Qpi7Kx2uj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iyAc9uLJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iyAc9uLJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD6RT7k002817;
	Thu, 13 Nov 2025 09:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wtCKI+waYucVkpLE6
	H5SXTwv15v+rfTBbigIvfJdOfI=; b=iyAc9uLJ5S8zUUhru8lgON+7LNVFjwq8Y
	bvmLkKtuchTHrdsfTdi+DPh7xEmu8iL0RAYcD2oB2v//yXxgCOceAhEcejwO9PGJ
	9lXInB5NFDltM/ZLSme3kRjLQX4m8KWGiz9U2jClqtztiuJCGsLdHry1gk/ED3/m
	3tld84PPzxJohD/t6k76HcFs3uI2c2Gs6L1RkgbUsn3TAhlp47MIoUV3YeSjQTRP
	a+hKoiPwQQper/8UKgC6L4D/HcuHepqLW8sFpY4vpulmeh7I50rTLBF3uTOAqPI+
	Wco/jm/iAth/7SeudU4WBdBZSmLxB45NhcYaJJJuqZYToUxi3RWog==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7f4wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8vUaP004755;
	Thu, 13 Nov 2025 09:06:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjy52w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 09:06:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD96V4H16646606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:06:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F002004B;
	Thu, 13 Nov 2025 09:06:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 030AD20040;
	Thu, 13 Nov 2025 09:06:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 09:06:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv7 3/5] block: introduce alloc_sched_data and free_sched_data elevator methods
Date: Thu, 13 Nov 2025 14:28:20 +0530
Message-ID: <20251113090619.2030737-4-nilay@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfXwHGJ2mMtfG3C
 mxIrsGW1sCHImsJ0pW9OZACUEONVL8pK90cd2KWU0/soLVS5FueAreM5p2NdgFngyM8up5cIgZ1
 WGtIxlcgHxhK0dWD8tbK0IsOPADLrJ8jX6/eORHHRKFh+5nhEDv7ap2O8GhlGnkC2GmiIwc1goG
 Wd3vuX6BHnwO9YrAf7vlh/t8aa3nO+kHVgRtRMJJ4Lm5OcamXEQI6ru+g7z0qNVljiDPhDcCWbZ
 YOwqFMKnPlMZyy58yIzaBlKRgio6DyYY7GWBfS7bPC9vz3pe/O4pK5oyCoSYnQrd4wKGFfs9BKz
 sS3eCEIPGsuhmlzgAS+rHOZ0e46iHrSOl6JdU2AD5woCtcQQbD+ZugYt+SjBzYq2Hr6fmPyTE7M
 BvCMqRXjaAf7ImdjWVhZh+l8OdAkng==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69159f9a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=oZaPcNu4UMv1xk5kmJAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: YPTQdOy7tZMSUu20M1z1uj_cz-_eLZMo
X-Proofpoint-ORIG-GUID: YPTQdOy7tZMSUu20M1z1uj_cz-_eLZMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

The recent lockdep splat [1] highlights a potential deadlock risk
involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
mutex. The trace shows that the issue occurs when the Kyber scheduler
allocates dynamic memory for its elevator data during initialization.

To address this, introduce two new elevator operation callbacks:
->alloc_sched_data and ->free_sched_data. The subsequent patch would
build upon these newly introduced methods to suppress lockdep splat[1].

[1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.h | 24 ++++++++++++++++++++++++
 block/elevator.h     |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1f8e58dd4b49..4e1b86e85a8a 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -38,6 +38,30 @@ void blk_mq_free_sched_res(struct elevator_resources *res,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
+/*
+ * blk_mq_alloc_sched_data() - Allocates scheduler specific data
+ * Returns:
+ *         - Pointer to allocated data on success
+ *         - NULL if no allocation needed
+ *         - ERR_PTR(-ENOMEM) in case of failure
+ */
+static inline void *blk_mq_alloc_sched_data(struct request_queue *q,
+		struct elevator_type *e)
+{
+	void *sched_data;
+
+	if (!e || !e->ops.alloc_sched_data)
+		return NULL;
+
+	sched_data = e->ops.alloc_sched_data(q);
+	return (sched_data) ?: ERR_PTR(-ENOMEM);
+}
+
+static inline void blk_mq_free_sched_data(struct elevator_type *e, void *data)
+{
+	if (e && e->ops.free_sched_data)
+		e->ops.free_sched_data(data);
+}
 
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/elevator.h b/block/elevator.h
index 621a63597249..e34043f6da26 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -58,6 +58,8 @@ struct elevator_mq_ops {
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*depth_updated)(struct request_queue *);
+	void *(*alloc_sched_data)(struct request_queue *);
+	void (*free_sched_data)(void *);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct request_queue *, struct bio *, unsigned int);
-- 
2.51.0

