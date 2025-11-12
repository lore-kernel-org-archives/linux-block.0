Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F6146588
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925376; cv=none; b=fXw7DHh6LemvaOmvT/o1qPkDAInIPepibfNIXKMR4NMzlEtWPGAezVvcmNHgN7tw3C+D+1H6ugHw6G8KQdAfFlh8TXPOTupxx7kZYaaEhm4QumDMRpTJibHfxr8RpibMaqbZ9h+pml+m3wZT5In4ItdwQ2FXfA51H0xSb12VDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925376; c=relaxed/simple;
	bh=z+b1U78vSDKu1YsQm8a5rG9mdKjXrAB3is1R8QEPVa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XR7lFvuq3mnfKBa4X9c3m9ul2boWdIawFUSL8wKUeJs+ldaLYcYvmNV4VosjdEucRbSHdRSD++d/VUm/9sMoWQMBC7Mbp6YLfHkXutOFYmHMdKOq8MYJs9MPOfmTecTGs+jwcpP56ghMiWeyw3JHlyEOc+E0ev7rLTtgahvvUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I1nv23uL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I1nv23uL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC47Qjj005450;
	Wed, 12 Nov 2025 05:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dcNHTRKh04pwarseE
	I9Pq5DJMj06JDD3+NBlBFRgRKQ=; b=I1nv23uLcmUBVzlmD0TM3H11iYCKZlHqn
	NWsPZlEceFect7bceyME5+0Djn5bN8MmDRtZuo6fj+HQcQyigtRLVjvn6u+GKrIo
	nujyXy/s9SksIlbUCmT6vCBeeOKpTyGt98UEp/O7FEqW7xibS/O9PBha/EOO9GSH
	cmTPK4XhzM44JJAzQgf4ygCeCwMZ5+EbPuoAgwbGmgtv9H1S+e3vdpLpnVqIA/D/
	/iW6iNbLggeI84Fj+a2sggPd9t+GRhBbYr9u941h4LkHcwJGhk5+1M9rLyL+jssh
	hwoM88vhUgmT+29JqykfTVNQ+3pn0/tJSELy2/e4JxJQDMEvNBXIw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc78tmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 05:29:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC1eDP2007313;
	Wed, 12 Nov 2025 05:29:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdje99x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 05:29:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AC5TEqJ57540912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 05:29:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60F5820043;
	Wed, 12 Nov 2025 05:29:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76CBF20040;
	Wed, 12 Nov 2025 05:29:09 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.49])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 05:29:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv5 3/5] block: introduce alloc_sched_data and free_sched_data elevator methods
Date: Wed, 12 Nov 2025 10:56:04 +0530
Message-ID: <20251112052848.1433256-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112052848.1433256-1-nilay@linux.ibm.com>
References: <20251112052848.1433256-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX8IB/OherfLE5
 gy9cnkIcAvlPUcwKLRSaXZeUejXSJdjDMo4qgfpBV6u2tRtR+bDGj1c4FJqXL73nhosEe6w8h4/
 IWm29Sm9V8U1DY8uqxJXtVaUV28Ntw9gt3VtcLxGkSK8k1Hyv4C3AdHdAQc77vokUuuyhZXpjqF
 8wnUuIAEqptbrMwYv2LAQex0sr05xKInzwdIdqSe7xNHQz5D+UdeSHsVhhl2NPbdIIk3GRhicMG
 N+629B1lH0gk+dT+9Cz5cTARwqZ2o+gMt24ExfImz7yXNWT73n1lpLzIy1HJeaVCwT45SHIXjKC
 jw1X9VzbkHA/iCzKwJC5MUrqcuxDSlHYt+Wv+GfvVvRSzJDFEW5C+oIXqbNLZlEv/DlqUvos6wv
 D1SiV5YxhHdv9gxrGVbGctc0mPoHXg==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69141b2d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=CpxMeG0wO-ZvAn9saB0A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: nNGH8xtGmJpL13wXVx_hOuqFoNdP9h7l
X-Proofpoint-ORIG-GUID: nNGH8xtGmJpL13wXVx_hOuqFoNdP9h7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sched.h | 15 +++++++++++++++
 block/elevator.h     |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1f8e58dd4b49..3ac64b66176a 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -39,6 +39,21 @@ void blk_mq_free_sched_res(struct elevator_resources *res,
 void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
 
+static inline void *blk_mq_alloc_sched_data(struct request_queue *q,
+		struct elevator_type *e)
+{
+	if (e && e->ops.alloc_sched_data)
+		return e->ops.alloc_sched_data(q);
+
+	return 0;
+}
+
+static inline void blk_mq_free_sched_data(struct elevator_type *e, void *data)
+{
+	if (e && e->ops.free_sched_data)
+		e->ops.free_sched_data(data);
+}
+
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
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

