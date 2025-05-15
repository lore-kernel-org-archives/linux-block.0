Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4B4174A
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316727; cv=none; b=LJpd1RlfvPlG28HKgxNh8F3278ywXIpxq0JVMnBFKZ7/HkMP0k3+e/05Vx6Z1cwKrencgf9hI+M3GoUl9damWQV9VWYeeboBHm08qV+3VLw+GAvvbOUvLXZ4260DRJv8a6gHPKyln1dUzBpbbynlCdexX51GaHcQ+mocIeYgG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316727; c=relaxed/simple;
	bh=q2ET9/+bt9Vsa8AzZ/oFr3h320hweDn/KGwxG8vX0J4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZ5gjRbyZ+8WhShleCg8L+EAipIKg3DwNAdRlBXJJ+JuZPL7GzREebN5AazeUUK8Jxi8LtDH8v944x3yy53aA6QBlQD8VuVGXKMTMqB0940ILl0/xanq0ShxFHAmXcyLE699d47edFj6okEV43ZQcj+NyMw+R09FnXKD39vGFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cArfjUCc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cArfjUCc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg8nm002405;
	Thu, 15 May 2025 13:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kdS23tOsPLpqZdLQGNakVcWlKLUAKKDNbZMv5lebe
	wM=; b=cArfjUCcAqRHz1IR+1ERQggFwfUExhvtJjTPGeTtAQulnZBI3siCoQhFU
	6gMuoFeP/IlGLl7hH7JJxS36K2z2RBUZDnY9O/KG3t8wv4qRIFAJdF+wx5XtjMBL
	6DXJEmPLSRG8ll0I77duUEW+wb1bJv4yQRTbKsw9YZSqt7VGy4K69mIBP0mGQ4UD
	5bM65zXRjABIipUVdWmOAAYXFlsNnvLL1MVzZzMpSdbZfYYmyKkq0bon+5z9piNp
	wd9UcBhCHWnzrS6hNRMeXOE82IdO16eHkLtmBvAZ05Lq2K7z2k8/4KBarWP157on
	MSznGpWo5skr8xQD5kwcDcLSikGIg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6mqw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 13:45:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FAlGJi026939;
	Thu, 15 May 2025 13:45:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpjfpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 13:45:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54FDjEnu43647398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 13:45:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01230200C8;
	Thu, 15 May 2025 13:45:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5734200C5;
	Thu, 15 May 2025 13:45:12 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.223])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 May 2025 13:45:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, hare@suse.de, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCH] block: fix elv_update_nr_hw_queues() to reattach elevator
Date: Thu, 15 May 2025 19:14:39 +0530
Message-ID: <20250515134511.548270-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=6825efec cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=cr-Vr6duBYozg7E4TfkA:9
X-Proofpoint-ORIG-GUID: 1k7XDSEDDzHV-oLN6Yjwx-mz3T-u8Out
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEzNCBTYWx0ZWRfXwCLi80tcSdAQ 5860CdrseLAFlRzIAH2R6BCymrcU6xjqwvUTu7yzrcQ9KQvanhbRwME5IinAu20rko/TsmdaZ4S jcyvsiyq5aZ58HoP0Jbloj7wk/sBJfSbNq5guuGKfQZ5Pb8DEi/3/IeTRzKQTg1hwEg9/HvM3KV
 kIG/Em56AzBdG5/paRcenXWPx9kCK37XybfvBPDJEftCdtlk5h2ylTr4Y11fyujrPtjgVNtmQRY E4WldCrx1TwjowC1xPScFirQ98hxNQRuUQBktd4kIRW0TWz2Eu0ZIkPosNJZtvu/KE7KAlU5NUB L4oMZkSFDRwTOuy7Y4w2JEwfx8VqObi+xOpugOfuINbM2ddQ1FfYjL0a3GYu1ViNs2tVknWOZvH
 URkXN+UhPaVrrm+T/6buBenIrvzgdltC2SKtGsIArL+eh7S62Jwti/UpWZ7XSDgfGFs6ozzk
X-Proofpoint-GUID: 1k7XDSEDDzHV-oLN6Yjwx-mz3T-u8Out
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150134

When nr_hw_queues is updated, the elevator needs to be switched to
ensure that we exit elevator and reattach it to ensure that hctx->
sched_tags is correctly allocated for the new hardware queues.
However, elv_update_nr_hw_queues() currently only switches the
elevator if the queue is not registered. This is incorrect, as it
prevents reattaching the elevator after updating nr_hw_queues, which
in turn inhibits allocation of sched_tags.

Fix this by allowing the elevator switch if the queue is registered,
ensuring proper reattachment and resource allocation.

Fixes: 596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index f8d72bd20610..ab22542e6cf0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -697,7 +697,7 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
 	mutex_lock(&q->elevator_lock);
-	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q)) {
+	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
 		ctx.name = q->elevator->type->elevator_name;
 
 		/* force to reattach elevator after nr_hw_queue is updated */
-- 
2.49.0

