Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04781E492D
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762536; cv=none; b=SAdXgjzrCZbDBxuGoUH7gOLCNwxmBxI+FDOV0o3cVp0HTf6vp6vPPTyBnX3CwXinH6iQ+pDNe5o6bLt77raDqigWWfip9li2cIN5j+/+NVM1r50Kec5HcYRFOq6JiaPx23LEgG1vgUJL+/5xto7KMIU5Zoun97vzgsfkepMMqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762536; c=relaxed/simple;
	bh=1vW8jLOn/y8+xqak6l357DvP97T9ZXLIDjB9nam99Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKrcADcJReUO/CHVR9wRCMKV8V01C0ZlGJJXsu4Elqf6QIL3mO4LA2qcv9E9W7ypmJMfKSN6atXRHqf3VMXnTqtNJ8R1/Mfh7KUst21WsEJ3nFf3b2ZmLpTbYf77gMmPCQI/8Md53vyJqM6jYiuZw5Ps5JpyLVE/N/BeO/escFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LXqZ1lNl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LXqZ1lNl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9CDFHX024459;
	Mon, 10 Nov 2025 08:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ab5+qWRpfKfRRXeJK
	1uujXLUlyHpc2X03oc/xMKG4q4=; b=LXqZ1lNlWcqEOXapC31UQ57OUu4xR1dRW
	abhtJrT9TWdFWpw0ginWU1aCUwun4VYYq89VnyUbDbIYvmv8gpuPNmZkq4zmhGVR
	OxsQe0iZSqKlVExAritt2A5aWlqag+XZOJwA11BjfL4XVUpntXPs/tIFcX3J6Svq
	1k0DJ/rRF/4ObWIDkFdyVrJtC2+WwPRqy2dqhdmop7TppbnD1K0/Ep7VFz+gNgNs
	O/cU5xvwhJwPM+CSAJcgtjEsJ5foI1lYn6rldN3mj9L+jaSaOhvinOhcee47HmD3
	iVILvW+TawBVoRbUyItWVGE3vmqkjxDGrbNcd3gv6Nl5bdlwbDtpw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjn3tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4kjp1014853;
	Mon, 10 Nov 2025 08:15:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpjvh9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:15:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA8FJ0L47776112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:15:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 507F12004B;
	Mon, 10 Nov 2025 08:15:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A1920040;
	Mon, 10 Nov 2025 08:15:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.93.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 08:15:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv4 3/5] block: introduce alloc_sched_data and free_sched_data elevator methods
Date: Mon, 10 Nov 2025 13:44:50 +0530
Message-ID: <20251110081457.1006206-4-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: J2aAPknIOzttNvMD42ih1YZ118XnVFFU
X-Proofpoint-ORIG-GUID: J2aAPknIOzttNvMD42ih1YZ118XnVFFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX768bVBLmYPqp
 Yu/ThAzVhoenwLU+65sNsBBFabYaMA4Tmy52Jef34IWPuRfI1zs1GsS8/4X9L2oRTY3a6HDEwV8
 1VabznqCGQbdfeb8jnx9n+D/B2Y9xpNVGUundh6Ym2B6CjfGjR0L7pHvHAaMGatOy3VrnAFSsV9
 ZptpB4fdEF397fkIbUfwVRP7ScJ6IBIJsia/U/z95YEyLugeihweVil8d92ftgl3oH05o4U+/xq
 PHD8k5zMLWYRAn9+DkfRCWv9u8uUgRAyvbXeKojJfsTw9y0HGYz+FFAmAL4qabpoUzdsjcDxGJH
 NR/l9r6SqMecjjv3dbZPsOYmjCDHGRKbfu4tuvKN3D6Xuw0F0tMxZ4E3X22NBn/KPooDuvQG7Dz
 7d6ulnbyxHM7CN1X6nnlPUlepiTJcw==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69119f1a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=ikDfgUULsRvjK1aHHRcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

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
 block/blk-mq-sched.h | 17 +++++++++++++++++
 block/elevator.h     |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 97204df76def..d38911d0d9eb 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -39,6 +39,23 @@ void blk_mq_free_sched_res(struct elevator_resources *res,
 void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
 
+static inline int blk_mq_alloc_sched_data(struct request_queue *q,
+		struct elevator_type *e, void **data)
+{
+	if (e && e->ops.alloc_sched_data) {
+		*data = e->ops.alloc_sched_data(q);
+		if (!*data)
+			return -ENOMEM;
+	}
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

