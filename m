Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20419BBC
	for <linux-block@vger.kernel.org>; Sat, 19 Jul 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752931661; cv=none; b=TKU4Q6FLU1zm690IE3uhaB72MiZChUND/qNOdmHnfg7nqrPc46ONgLu0q9JKZLLfXh5Q62mjV6HJjldxjxQQaljVzTxT+xlBy+1MHeqWidafyJgSiqh3qH8oB2ZiPrhblJBeeMsqJbu15FiAw82aXRv6jZh5t4LGzIW1ntPUuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752931661; c=relaxed/simple;
	bh=AGMRt3yOoPbWBnPOjeZlddTNZD7BI3lqOFaIDHhK9q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvF9GAaUETswgL9ck33wlGi4Vy3FH1M2Jwntnnk/1Cp2CCns2NZSNNX6Qel3gKmVjXy6NYdpPaAh6eAlqpr2BLG3bWAmj3CKuVwGLnDJKoYeK7fO0/7lxvcArM2qwbMbuOoQeIQJNYhvxrTMWalyNWZUTnJ9sQWBz6Ch1hk9EQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F08xDSUx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F08xDSUx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J9C303015602;
	Sat, 19 Jul 2025 13:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rURdsGaaMbNM3W4mOYBnMj1seWldsTbjTGtbxDHHU
	BM=; b=F08xDSUxTinlSwYbs0w5VbFuthfM+Io8VMuMxtNCAGzDJZ55+J1xgGrrs
	HVLD67+SOJ1miAFz5s2SQVHe/Vavg6xjlzqmaurfGodK0Q5LO+n51AfuukW/eiAm
	CtQZn+HljTDwW0mtsYYIYPVvh3QfrM2eeYZ8gnciE3B6dTDiPlOKTZR4KN1wo1Pv
	AaWu7/9v/95kYIGGq4JJe4+DLFY+YhJBRPyFXMG7MtjbPr0HeLQq/6fsKKf7iXPV
	g/xv5I+blB5hBYG1d4/IviU8nbo+I7Uk4UdGdMvqjarovUPqusMklF5v/xyWL98r
	Ka2JrOjc2eSUhRfVFO1YZfphYBI0g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v114t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 13:27:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56JDEqWt025517;
	Sat, 19 Jul 2025 13:27:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31q5vww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 13:27:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56JDRQpp18940384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Jul 2025 13:27:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE32920043;
	Sat, 19 Jul 2025 13:27:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C920F20040;
	Sat, 19 Jul 2025 13:27:24 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.22.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Jul 2025 13:27:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCH] block: fix module reference leak in mq-deadline I/O scheduler
Date: Sat, 19 Jul 2025 18:56:47 +0530
Message-ID: <20250719132722.769536-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLdoRhLL c=1 sm=1 tr=0 ts=687b9d42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=RFxZD7pVsyVzHcZ24eIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEzMSBTYWx0ZWRfX78T+MOjdB5gP
 uZrjdQa7hzvPojhgPmUucBFwUzI0UP+XWafSIPAG1n3FCDwray7YYhyTYMVnDCJpH5uGDIiVs5p
 E5+3Z6bZAE+BMPoHgq5P7D8pXgkq0dNV9ci9KKccoCfae9h5Lh/S9TiyQu7/2+5dSNW+Fkwd5sN
 xfT5ZVsK8s/60ekgk0eVKPc5sqq3hgwUbA1vNOvvznQQSGn+wH2XLXL0JI4gNW/h8OziKeevbTT
 F50w7NEXR5srdpO4zmYmU8Q0jh5LHgV0+BKVoZIDsmSVbwDjbqSQZIZd82In0hLM9stfkzG50d1
 Dke1jSjkwkp6lYsiHOt4tE9y2VzciaWDF+pVTBUdribJSTUXWYmIkV0i5wF8r5p2VSRzaVGn70y
 t8FvaYxnkj3GOZytdsP9/HYh4NCKNMODRIEQE24I/wDyKMmsfac4R/4pPi7GTE6Duo7x42RM
X-Proofpoint-ORIG-GUID: LyPfrmSJ5__YLBBNqOYid0PUZWldvHqj
X-Proofpoint-GUID: LyPfrmSJ5__YLBBNqOYid0PUZWldvHqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190131

During probe, when the block layer registers a request queue, it
defaults to the mq-deadline I/O scheduler if the device is single-queue
and the mq-deadline module is available. To determine availability, the
elevator_set_default() invokes elevator_find_get(), which increments the
module's reference count. However, this reference is never released,
resulting in a module reference leak that prevents the mq-deadline module
from being unloaded.

This patch fixes the issue by ensuring the acquired module reference is
properly released.

Fixes: 1e44bedbc921 ("block: unifying elevator change")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Note: This patch is based on https://lore.kernel.org/all/20250718133232.626418-1-nilay@linux.ibm.com/
So please apply this patch after the above is merged.
---
 block/elevator.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 83d0bfb90a03..2bbf7ad7f4db 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -719,7 +719,8 @@ void elevator_set_default(struct request_queue *q)
 		.name = "mq-deadline",
 		.no_uevent = true,
 	};
-	int err = 0;
+	int err;
+	struct elevator_type *e;
 
 	/* now we allow to switch elevator */
 	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
@@ -732,12 +733,18 @@ void elevator_set_default(struct request_queue *q)
 	 * have multiple queues or mq-deadline is not available, default
 	 * to "none".
 	 */
-	if (elevator_find_get(ctx.name) && (q->nr_hw_queues == 1 ||
-			 blk_mq_is_shared_tags(q->tag_set->flags)))
+	e = elevator_find_get(ctx.name);
+	if (!e)
+		return;
+
+	if ((q->nr_hw_queues == 1 ||
+			blk_mq_is_shared_tags(q->tag_set->flags))) {
 		err = elevator_change(q, &ctx);
-	if (err < 0)
-		pr_warn("\"%s\" elevator initialization, failed %d, "
-			"falling back to \"none\"\n", ctx.name, err);
+		if (err < 0)
+			pr_warn("\"%s\" elevator initialization, failed %d, falling back to \"none\"\n",
+					ctx.name, err);
+	}
+	elevator_put(e);
 }
 
 void elevator_set_none(struct request_queue *q)
-- 
2.50.1

