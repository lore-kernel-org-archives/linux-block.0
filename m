Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C025E469
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023593; cv=none; b=VOSUZMJ9Fdgl1+VhBQsC/5PvX0bA7iiTckmvbLc3cJF3Ou7lWaVNSkr+8aPQVRcnzj5LzsjYdUZ4tG6FwyqBNGRTHYHcpz3OyubByZcSLlwyNK3Fieiyn2I+vgwV5Bvn+ibnm7Q/WuRGJpggXkLChFkbZQ9WYpOskuHWw/fU7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023593; c=relaxed/simple;
	bh=B8Jm1t4ivLdKBAqYWfTbrvG7jy8pwKuLODhGy+CCOnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQ8qRtojxO8Rv9wfP4ZHJrQ4NU1+6Lo1Rr7fqSqDbGh3Aua9gz5UhL2nnMGTNUQci7qWysw+YXtyA0RuQmy2QLUxp34r/1JypxAPKYGX1PEkGTCdb0Qa7DArTDSBkEeYdHUrqU1CvzuzQ9MFKhN/LJS7oNdIwR+ks8WW0g1TCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=itXzqkhK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="itXzqkhK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OKk7H52962734;
	Wed, 25 Feb 2026 12:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=We0wyRroY31mI5gz3akklSxC90QO+HeOcmdou42Ro
	so=; b=itXzqkhK8aVPX4MoOOi5wPwXclsXS+cVDWSMwhKs9BpAGBq7r+IWLP2cl
	/nfrs4GfJRP3kz6ZYijKkdaCHqcyUL8WcqiV0QMfjytcL3hvecrJFtf5vJgyr4RE
	bIgRSERKS1/2liqgWdt0uqNTb53wXsZ1nd3elGP6qMT63DmxiYy9uMfim/C7utL1
	ez3vIklTpbzW0nviCM/k8RfKErucc3/vRdcKmpGXJQZjIgaq4F2uy/+mse2Mzx2n
	G9TNn6fZasErNYP3ADUEBygyYuHRvEdTE2iXV3f2NCyASFfEq/h6XpY/6l+LVM4r
	Z7xXgn6C0FMAph18NxAtXXObAbA0w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gfpms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 12:46:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PChhga015983;
	Wed, 25 Feb 2026 12:46:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sndvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 12:46:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PCkCRe49283382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 12:46:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E6C220043;
	Wed, 25 Feb 2026 12:46:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADD1B20040;
	Wed, 25 Feb 2026 12:46:07 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.9.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 12:46:07 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, yukuai@fnnas.com,
        yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] block: break pcpu_alloc_mutex dependency on freeze_lock
Date: Wed, 25 Feb 2026 18:14:16 +0530
Message-ID: <20260225124556.1152510-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699eef16 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=0ddmZlBLnuk0VgvrfPYA:9
X-Proofpoint-GUID: wl35JuTQjEY5qiqkMhV7xYAxckQDsqTi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX8IfrN/4SNS6J
 QNX8QGfHnHeUvIzjr7nfTZ0NQIbq3eRncn7pqTWBoMAchfHtekzMRmHsbrrRk+Hm37UYFSSXrie
 IB/tuG+cq/FGQdq1LecScfxktN9rHQgBLFiESVLraEVzw5douOWUyXd3/c3BvwhZTe/F/BvmXfK
 dj5Gl3+ftrTLuXp3jDGh8foBaRt5cnBuxUnNR2ovAOe/hiqzhlviLD7n4cu2za3ppnR7thX0w2z
 WWyogUY3GF85Kej1uoUCTGjwaq/l4UKflNWnsPXJ3Ozz5oykUjRtWOtLn7qVs7oL/PjVYGcpuLe
 wWIYxiEZuTGqzI1Cl45rucNncwldLQy7AJQTbPRgX6/syr19oSzPc1rBIdr2COqCYEVjgbvxTHv
 shEP565KaT7g5oLHYw8lYB9Rwa+V0jQctFZ1a+u2ZF05d84bfc8pY+PH0axq+2W8dQTsKUajbli
 XmHCftHu0BkKvsiXa6A==
X-Proofpoint-ORIG-GUID: wl35JuTQjEY5qiqkMhV7xYAxckQDsqTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250123

While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
after ->freeze_lock is acquired or queue is frozen. This potentially
creates a circular dependency involving ->fs_reclaim if reclaim is
triggered simultaneously in a code path which first acquires ->pcpu_
alloc_mutex. As the queue is already frozen while nr_hw_queue update
allocates tagsets, the reclaim can't forward progress and thus it could
cause a potential deadlock as reported in lockdep splat[1].

Fix this by  pre-allocating tagset tags before we freeze queue during
nr_hw_queue update. Later the allocated tagset tags could be safely
installed and used after queue is frozen.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com/ [1]
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq.c | 53 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d5602ff62c7c..687fd47786a6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4793,10 +4793,10 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 	}
 }
 
-static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
-				       int new_nr_hw_queues)
+static int blk_mq_prealloc_tag_set_tags(struct blk_mq_tag_set *set,
+		       int new_nr_hw_queues, struct blk_mq_tags ***tags)
 {
-	struct blk_mq_tags **new_tags;
+	struct blk_mq_tags **new_tags = NULL;
 	int i;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
@@ -4807,24 +4807,42 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	if (!new_tags)
 		return -ENOMEM;
 
-	if (set->tags)
-		memcpy(new_tags, set->tags, set->nr_hw_queues *
-		       sizeof(*set->tags));
-	kfree(set->tags);
-	set->tags = new_tags;
-
 	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
-		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
-			while (--i >= set->nr_hw_queues)
-				__blk_mq_free_map_and_rqs(set, i);
-			return -ENOMEM;
+		if (blk_mq_is_shared_tags(set->flags))
+			new_tags[i] = set->shared_tags;
+		else {
+			new_tags[i] = blk_mq_alloc_map_and_rqs(set, i,
+					set->queue_depth);
+			if (!new_tags[i])
+				goto out_unwind;
 		}
 		cond_resched();
 	}
 
 done:
-	set->nr_hw_queues = new_nr_hw_queues;
+	*tags = new_tags;
 	return 0;
+out_unwind:
+	while (--i >= set->nr_hw_queues) {
+		if (!blk_mq_is_shared_tags(set->flags))
+			blk_mq_free_map_and_rqs(set, new_tags[i], i);
+	}
+	return -ENOMEM;
+}
+
+static void blk_mq_init_tag_set_tags(struct blk_mq_tag_set *set,
+		int new_nr_hw_queues, struct blk_mq_tags **new_tags)
+{
+	if (set->nr_hw_queues >= new_nr_hw_queues)
+		goto done;
+
+	if (set->tags)
+		memcpy(new_tags, set->tags, set->nr_hw_queues *
+		       sizeof(*set->tags));
+	kfree(set->tags);
+	set->tags = new_tags;
+done:
+	set->nr_hw_queues = new_nr_hw_queues;
 }
 
 /*
@@ -5113,6 +5131,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	unsigned int memflags;
 	int i;
 	struct xarray elv_tbl;
+	struct blk_mq_tags **new_tags;
 	bool queues_frozen = false;
 
 	lockdep_assert_held(&set->tag_list_lock);
@@ -5147,11 +5166,13 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (blk_mq_elv_switch_none(q, &elv_tbl))
 			goto switch_back;
 
+	if (blk_mq_prealloc_tag_set_tags(set, nr_hw_queues, &new_tags) < 0)
+		goto switch_back;
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue_nomemsave(q);
 	queues_frozen = true;
-	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
-		goto switch_back;
+	blk_mq_init_tag_set_tags(set, nr_hw_queues, new_tags);
 
 fallback:
 	blk_mq_update_queue_map(set);
-- 
2.52.0

