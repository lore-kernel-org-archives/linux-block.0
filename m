Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEC266F01
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866772; cv=none; b=NNqpqkFtAsWaFHP+Mds0Pmbu9N2nkeBE14fM5pgG+bNhdjQeiI0WcB0kGyXQl4EZM3YgQnTw7NXXxEDaHYelTc21DBY7AsQgJevXKQGwsxB29Qftds4O2lk9lrYFrZiLGkbRd6hcFz7m85jk9jwnEQ0YTvZKK2Lzn6290ohDjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866772; c=relaxed/simple;
	bh=lUG7V7wTDeuvu/E5E6vhklmw93TxJu4ukUznksQffmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxME4dR5npo/z7AXx2jusl1ImA/VwvHcLnijanQx49MOpd2ziNC0Ukjkd+H2w+e+wkvh3Lz6M+l915d9pvh6+OT9gvxta3jM92U0V9YknLR2pgj3QpfUoTWWjh1Usl+Uik9nC7Z117ExPmz/2pkPxvMdQ6EtXQ5deAC/7buV+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phfgskqL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phfgskqL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D8ejDP010375;
	Thu, 13 Mar 2025 11:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I7yQ+4qKm1VpMZmZB
	Wertmdabmj9rVfBW4pb0Pj2NBA=; b=phfgskqL6nvykMrzuZOGWznBCvyk4eTmT
	Vd7TYTn1ncjYLQyc7AjCteQXv4k2NMe8EMbVKAm6mRtN2bVa9Qc8E6zp9Xchbl0+
	B0uBucCSmCMqZ6NBtK1trZ3fNkPsEIkxY7Jut3N0sOUvX0FhhG4ukfMgtCEnBgzF
	I7cplyiHDeHHMWJql/o5T/niQpUn4Mpo8f0VWa3+6rgES4etpqJ1Ky4ORaYpQoPV
	Ga068Y92AXOCahIdqriFGXUsAR+8nVCOIQO5PV89EsjRMX+3O5nDWepU0lZ2oDiq
	a+vCRk1nfsPFN1O5//QAAj5CFUWyN0+BHSvM9iXtuaUMy3i7knayQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhg0bew2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D8XPpe015411;
	Thu, 13 Mar 2025 11:52:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atsphk8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:52:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52DBqejY58720610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 11:52:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8287A20040;
	Thu, 13 Mar 2025 11:52:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A1772004B;
	Thu, 13 Mar 2025 11:52:39 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 11:52:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv2 2/3] block: Remove unnecessary goto labels in debugfs attribute read methods
Date: Thu, 13 Mar 2025 17:21:51 +0530
Message-ID: <20250313115235.3707600-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313115235.3707600-1-nilay@linux.ibm.com>
References: <20250313115235.3707600-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jGOkS0VSlPXYF2Hew-evdlnNl1JQYFKJ
X-Proofpoint-ORIG-GUID: jGOkS0VSlPXYF2Hew-evdlnNl1JQYFKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130090

In some debugfs attribute read methods, failure to acquire the mutex lock
results in jumping to a label before returning an error code. However this
is unnecessary, as we can return the failure code directly, improving code
readability and reducing complexity.

This commit removes the goto labels and ensures that the method returns
immediately upon failing to acquire the mutex lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-debugfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 62775b132d4c..1c958bbaddce 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -402,13 +402,12 @@ static int hctx_tags_show(void *data, struct seq_file *m)
 
 	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
-		goto out;
+		return res;
 	if (hctx->tags)
 		blk_mq_debugfs_tags_show(m, hctx->tags);
 	mutex_unlock(&q->elevator_lock);
 
-out:
-	return res;
+	return 0;
 }
 
 static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
@@ -419,13 +418,12 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
 
 	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
-		goto out;
+		return res;
 	if (hctx->tags)
 		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->elevator_lock);
 
-out:
-	return res;
+	return 0;
 }
 
 static int hctx_sched_tags_show(void *data, struct seq_file *m)
@@ -436,13 +434,12 @@ static int hctx_sched_tags_show(void *data, struct seq_file *m)
 
 	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
-		goto out;
+		return res;
 	if (hctx->sched_tags)
 		blk_mq_debugfs_tags_show(m, hctx->sched_tags);
 	mutex_unlock(&q->elevator_lock);
 
-out:
-	return res;
+	return 0;
 }
 
 static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
@@ -453,13 +450,12 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 
 	res = mutex_lock_interruptible(&q->elevator_lock);
 	if (res)
-		goto out;
+		return res;
 	if (hctx->sched_tags)
 		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->elevator_lock);
 
-out:
-	return res;
+	return 0;
 }
 
 static int hctx_active_show(void *data, struct seq_file *m)
-- 
2.47.1

