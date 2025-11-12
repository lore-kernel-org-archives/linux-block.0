Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32857314B66
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953806; cv=none; b=r9aUmAC9jkcfao/wNvSrE14wJ+lWL8gKzCvpRCfXp/IZfDOaAWF0uL0dYShO8dh+SUO+jl0p78eR9I4Gp61ijDCj26iLZ21wWhmNFf5B17CSjBX/NzJ/28Fs6+rK19lyKqv84s/fALSDYK91+2zTHQzD1MztDuEb50yFJpgC8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953806; c=relaxed/simple;
	bh=2DbvNLJ6g/LBfgAJMyEY1JlJnpWSv3pTdWDsKzI/T1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMH2ES2UPEEDqXy3OWlXdnHl6iB1+8AziuynpnTg7cY9+yzsIcd5z/4JYBgCsnc4OFJAJSDaZOYsT4L9Kb41fvrL63RXZ6wgpStkOvO8XN+NY8mdUEZXlhXRg/IIwTLYxTpJ2mxKb6WO0vwNLNvMXrVpXrk4Uq3A1/eABSopq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hk8O2Xbe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hk8O2Xbe"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC14DIS013492;
	Wed, 12 Nov 2025 13:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Kt4wgYe6Zo/g2v/m
	Af3tqDONy5/Apyanvaaqnl8FCk=; b=Hk8O2XbefsuV28IBeT5/jeiK18SX0HMch
	j0noY0tMhzjXIEjqErdcZgNzwep35zpPlpM35KxkYxjPE9/DajhmjXLk/CbjD3AF
	nF8g+2fxridVQQGmjcvszrkSS7+kWAQnVYtzXUR2i5RTxVwoODN/jYHBJdL5m0GR
	b3WGwzO6aO6MjBcqbUbQggskJhOkE3BFVItmAJwDGVIIB1YOYuTI/FpmiIEIbY6j
	G0y//+tAcFjJ8BjZ9eg8VMX2gmJ2/MF08ytKgE941fk34Qvp6BpEYCRZR4bP3EAr
	rzHvxauGAWcJQ1TFg3ApJp7D3atcjkfVLEYIkzGzzV4RlJefz2Gvw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx18mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:23:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDDI8Z028939;
	Wed, 12 Nov 2025 13:23:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sghvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 13:23:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACDN9Pk43778306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 13:23:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC192004B;
	Wed, 12 Nov 2025 13:23:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A920220043;
	Wed, 12 Nov 2025 13:23:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 13:23:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, yukuai@fnnas.com, gjoyce@ibm.com
Subject: [PATCHv6 3/5] block: introduce alloc_sched_data and free_sched_data elevator methods
Date: Wed, 12 Nov 2025 18:52:26 +0530
Message-ID: <20251112132249.1791304-4-nilay@linux.ibm.com>
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
X-Proofpoint-GUID: rF4PPEm9vxVljFQj8WgvPjUr57k0rPe-
X-Proofpoint-ORIG-GUID: rF4PPEm9vxVljFQj8WgvPjUr57k0rPe-
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69148a41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=90xjmj8kXcwhmpjDbvkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX9vQz3PGVX8c2
 i+3TfnzGgxNVVxNP6IcAlgiVu76Fo86jU+SxeNcLDQIHwlhuoWKWT6ueV+xOv8CRAelbI6Jm9r/
 BxLGmzcQ5G7KKpVYG9IkR5XV+mbL5jHrJX+R+3C+Yi379uosm+oBb8hNIXbPGkZo6QMXY5Ha5lT
 s1xRKIYsHZ1K5Ud9Umpd2sxTV5qZU/d+MgD8SpShKz2g2oTKGuaxgIrNx0n8zR9ZMs8TnFErhwY
 1piMXux7nDpRFYURdZCm+6GLY+2oTYc09XOVyC4cbNHx9wDugBP6DVcDV7P7XKRa6VPhQxzlP8g
 kozmvCFlRfG9keQ0XIFDVv+OkXRqL9ixNPjp7AMU7XK5a+L2fE+NElE6GQPstBm16wFH3k+5xDm
 5xOGdwKuDM7XePcrSKt2f8aQkw/vYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

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
 block/blk-mq-sched.h | 25 +++++++++++++++++++++++++
 block/elevator.h     |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1f8e58dd4b49..f9433a1cc7f8 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -38,6 +38,31 @@ void blk_mq_free_sched_res(struct elevator_resources *res,
 		struct blk_mq_tag_set *set);
 void blk_mq_free_sched_res_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set);
+/*
+ * blk_mq_alloc_sched_data() - Allocates scheduler specific data
+ * Returns:
+ *         - Pointer to allocated data on success
+ *         - &blk_mq_sched_data sentinel if no allocation needed
+ *         - ERR_PTR(-ENOMEM) in case of failure
+ */
+static inline void *blk_mq_alloc_sched_data(struct request_queue *q,
+		struct elevator_type *e)
+{
+	void *sched_data;
+	static char blk_mq_sched_data;	/* act as a success sentinel */
+
+	if (!e || !e->ops.alloc_sched_data)
+		return &blk_mq_sched_data;
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

