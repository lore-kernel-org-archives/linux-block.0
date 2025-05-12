Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9E2609CE
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042211; cv=none; b=kac1I6PWkrUsN8gXVw8Bv9Ffeiv399JAu6W9UAV26VL479KclsoNYEL+TcylP9jldGTQdpRQkmIf6IvBwu43tJkn81jx7WSd42wRCTkCMsXG6q5LMMF3Ex9TVcq83SzV6Nq9itofc/+ILB4T98M4Z7sf2spAT4DoAoecfomaAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042211; c=relaxed/simple;
	bh=V3/NloPURu6IoIFKSUMSCjmmrzfIlelF/VYBLzHwyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HYKrSu17ozskLK6b+O7E5kvWUQ+ig3CXQp7IZL4hBuOnZg1JCTdQ9ZItg08HaicvugwHIwHy8PcSCt5p9XDFENkOtn+h4I4p9TwOcTtwgCR6c876INvu8cbMde1z3cDlu3DQdhk9LCf/eXU5dJ4lzZUG7dMjy3OzbgNvWmQdZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mDd7BkkY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mDd7BkkY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C8pgaL007300;
	Mon, 12 May 2025 09:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=aML892QLmQO5eVMBLiVVE2avjHAa
	SEHYRBIhnqIQlwc=; b=mDd7BkkYqql0EqDV5Mzj5++3ThC27ZI/M/hl/HgJ7xua
	lceHPIS6tSbkfhO3fEX5ITiEsz0NU2L4h0fzgiyrUbf3RfLDT1Qsye1D4N1Di+YC
	CHkpNuGhu2mrIITzI9LpTwIjOFANCSLiLiYSwtx/8gIWdRjrlkS5kplPlWCRyQMM
	dihuYnbHiW+La0ZRt6Xqu1T2SpV1SBUZKOBonn4tlUofIST9FehUBAAoyN+QbUl9
	rjl+D9IALmKh7NWEpRRrBj0zW36KoZIzf5LGhdd21d/5gYOXYrBdz2k6ZXBS7SzT
	Uw2HOGQPATQYt6jY4nHwhJ5k963/9K8oAYxm/NgaAg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kdug84wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:30:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C5BEZo024437;
	Mon, 12 May 2025 09:30:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmkw5cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:30:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C9TwxE52691328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:29:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1836C2009B;
	Mon, 12 May 2025 09:29:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 856C02009D;
	Mon, 12 May 2025 09:29:55 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.16.128])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 09:29:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCH] block: unfreeze queue if realloc tag set fails during nr_hw_queues update
Date: Mon, 12 May 2025 14:43:38 +0530
Message-ID: <20250512092952.135887-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OOUn3TaB c=1 sm=1 tr=0 ts=6821bf99 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=7ZNjnjnpTjzHF3BlZ_YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7PyGhDj-kNRUWNT5yUIJm5_xGuCfbckC
X-Proofpoint-GUID: 7PyGhDj-kNRUWNT5yUIJm5_xGuCfbckC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5NSBTYWx0ZWRfX4kuW/7CYsBEO wpBse7bx/NSpyxokv5OOQVE8gRTZyRiqW4mZ6ntIr/QRiiQg71SGNMicKwIU9AGHfohG9cdZM1p m4eXW/u5x4bCJHnATsCnJKfHjizkmbGc8wk8nQan/2UiPdohWcKfwIzScR/5T2/PLqWQaCoPv2j
 3RqWH1OWCEWN9FvGqO95ZZsXTQzidjb6KvVfJucI03xUSgX+8D2nOkAbe1yhsAg9Qa4TRCCTv2X uDFLdMX3gzz+KXmSchJ01c7ohe/ulVCOTx5Y8WhMOospi4W5zCAjT2Vq/jU2td6sd24AgrItZ+5 /nMKSDohzLrri+sIw4cO61KvkmC1HMAEEmRRr13GiD1jAFoobhFPK+gxDzJuMpxXOg0tKo8IdkZ
 Bc/Wk8nwUIm/RBrkq8XxLKGt8Ind2VHcJ+JgvXyxzKknupIfUTOsdtxFT/kzLn2v7nMNLobR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120095

In __blk_mq_update_nr_hw_queues(), the current sequence involves:

1. unregistering sysfs/debugfs attributes
2. freeze the queue
3. reallocating the tag set
4. updating the queue map
5. reallocating hardware contexts
6. updating the elevator (which unfreeze the queue again)
7. re-register sysfs/debugfs attributes

If tag set reallocation fails at step 3, the function skips steps 4–6
and proceeds directly to step 7, re-registering the sysfs/debugfs
attributes without unfreezing the queue first. This is incorrect and
can lead to a system hang or lockdep splat, as the queue remains frozen
and is never properly unfrozen.

This patch addresses the issue by explicitly unfreezing the queue before
re-registering the sysfs/debugfs attributes in the event of a tag set
reallocation failure.

Fixes: 9dc7a882ce96 ("block: move hctx debugfs/sysfs registering out of freezing queue")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f79a9808fd1..cbc9a9f97a31 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5002,8 +5002,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue_nomemsave(q);
 
-	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
+	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_unfreeze_queue_nomemrestore(q);
 		goto reregister;
+	}
 
 fallback:
 	blk_mq_update_queue_map(set);
-- 
2.49.0

