Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0978405F7
	for <linux-block@vger.kernel.org>; Sun,  1 Mar 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370020; cv=none; b=syp40pg6Pu1XR3ctcIgeaBRSb3rlT4vWwdWvnBGSFNQsBPKEEWGDmvizZR4IEBUtu3D3jqwA7H5cS4zYcIRGmY3cwn5txIN4tDO9MqnOOQtWfZWNcRdtUmO0S2IxV/JD1qjdNGsedo8mINbwRYd9+Q7uTi0U7y9SybSdqNxAr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370020; c=relaxed/simple;
	bh=bs2SoH4NL5vP1/Fhp8iLu2szzE/T0jrgT4pBBwflQIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pegFmH3iyt7bpMsYgiHbZgW5ALkRmIRExAW1Oj0CQgvn50ZguaF3ZniHl6dExcBzJ4kerPFuIkLh0VLZXeR0mrEb4bLyTa654vJ1XdsvU0hy3qfhmMRFREQyreEjQJOdn3cVgFcKGM1pFNxv+dAR9BcM9h/Ozs+f2KW54flZbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D1vRpGRM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D1vRpGRM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621CvUwe969840;
	Sun, 1 Mar 2026 12:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zmYlCa/Vb+t+5MB8ckfY7ZXc0LOBTtTf6xO+nKfTj
	NA=; b=D1vRpGRMeksZbKRtrsajCAc2jr+HDiSh+Lq2e7LdAkK0WXWkHwR60eZgx
	yxRjdyTalrxhF5gmeTL3McRT9dPZhwBHlAOslVm3wzqlC5gPHwysHzJE0VBoSyiN
	Wo/5R+4RTuqe3VnocDz2vDw2ZRiihnEgBTlPYKGtTyiYmhBjziCYohI0+cTUwxRR
	DjiHguelM8y1WPDl7ovWHTCABdqUEvdRuVZUHyVDsn/uQvT72HYkE5sug9nq3Kio
	ubf3Pz/LwhLKqNWF5YAd8qxk4L7Q67fsJqAIpzEFQXXrOGjx8o+rhBBEtftQCUci
	8V0qSIxabpjH6+1YopW9xyXKWk7kA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbk5mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Mar 2026 12:59:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 621CHNc5003210;
	Sun, 1 Mar 2026 12:59:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2xsury-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Mar 2026 12:59:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 621Cxtcq49676608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Mar 2026 12:59:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AE7B20049;
	Sun,  1 Mar 2026 12:59:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CFC920040;
	Sun,  1 Mar 2026 12:59:53 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.31.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  1 Mar 2026 12:59:53 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, yi.zhang@redhat.com,
        yukuai@fnnas.com, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2] block: break pcpu_alloc_mutex dependency on freeze_lock
Date: Sun,  1 Mar 2026 18:29:43 +0530
Message-ID: <20260301125951.582690-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fa7qgYpAwYlmC3yBTTex3DG_0o4FZdb0
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a4384e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=0ddmZlBLnuk0VgvrfPYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDExNCBTYWx0ZWRfX69Qf6A7vLB5s
 3L67gRTEMqOw/Hmm/xVLp3s4tOCu719ARjXeMjXgAbZpBIO283wkf7IIlxXhnBU4l/sMTU/VaUi
 QQUaKS6MBddXQmerTC+mumxfvPC4mqmEdoMtVykUnliYPwxLKaX3lG2HKG72Ec7t2IypxcT8QF1
 6UfT+LqnIjdhQhAuByBBtRbLEwv0PNSTPAK7Zm553RHBWwN5oRuYQJf/9gk3BbdUgrNszfGpDp0
 /mmTvBaiTYxktbsw3M2z160h3Gr+0e1TC8R8NjHa9PlGkVlh2oN/MKyYNuWWr62yxVSRJYMud7S
 5ag7w4WfzpvE8XTTCvVdtNkkMgMCFEy5VxTj81CVcZgpsCKMU4TWN1gL50jd5LL4sBgDWs0lu6g
 K43lTvF7RKm6YlqTyjlhQ6C1HIbYkk1XLHUAOjip6q7bGa7ndabQGZMslci8xbAH4daziBlT3Kn
 6hvd1MV/pnomhkNFJXw==
X-Proofpoint-GUID: fa7qgYpAwYlmC3yBTTex3DG_0o4FZdb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010114

While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
after ->freeze_lock is acquired or queue is frozen. This potentially
creates a circular dependency involving ->fs_reclaim if reclaim is
triggered simultaneously in a code path which first acquires ->pcpu_
alloc_mutex. As the queue is already frozen while nr_hw_queue update
allocates tagsets, the reclaim can't forward progress and thus it could
cause a potential deadlock as reported in lockdep splat[1].

Fix this by pre-allocating tagset tags before we freeze queue during
nr_hw_queue update. Later the allocated tagset tags could be safely
installed and used after queue is frozen.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com/ [1]
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
  - Make blk_mq_prealloc_tag_set_tags() return the tags pointer directly,
    encoding error conditions using ERR_PTR(). Update caller to use IS_ERR()
    to distinguish between success and failure. (Yu Kuai)
---
 block/blk-mq.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9af8c3dec3f6..a27bade45de3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4793,38 +4793,45 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 	}
 }
 
-static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
-				       int new_nr_hw_queues)
+static struct blk_mq_tags **blk_mq_prealloc_tag_set_tags(
+				struct blk_mq_tag_set *set,
+				int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
 	int i;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
-		goto done;
+		return NULL;
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
 	if (!new_tags)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	if (set->tags)
 		memcpy(new_tags, set->tags, set->nr_hw_queues *
 		       sizeof(*set->tags));
-	kfree(set->tags);
-	set->tags = new_tags;
 
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
 
-done:
-	set->nr_hw_queues = new_nr_hw_queues;
-	return 0;
+	return new_tags;
+out_unwind:
+	while (--i >= set->nr_hw_queues) {
+		if (!blk_mq_is_shared_tags(set->flags))
+			blk_mq_free_map_and_rqs(set, new_tags[i], i);
+	}
+	kfree(new_tags);
+	return ERR_PTR(-ENOMEM);
 }
 
 /*
@@ -5113,6 +5120,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	unsigned int memflags;
 	int i;
 	struct xarray elv_tbl;
+	struct blk_mq_tags **new_tags;
 	bool queues_frozen = false;
 
 	lockdep_assert_held(&set->tag_list_lock);
@@ -5147,11 +5155,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (blk_mq_elv_switch_none(q, &elv_tbl))
 			goto switch_back;
 
+	new_tags = blk_mq_prealloc_tag_set_tags(set, nr_hw_queues);
+	if (IS_ERR(new_tags))
+		goto switch_back;
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue_nomemsave(q);
 	queues_frozen = true;
-	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
-		goto switch_back;
+	if (new_tags) {
+		kfree(set->tags);
+		set->tags = new_tags;
+	}
+	set->nr_hw_queues = nr_hw_queues;
 
 fallback:
 	blk_mq_update_queue_map(set);
-- 
2.53.0

