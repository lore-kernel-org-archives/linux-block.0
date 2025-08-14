Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D12E7659
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159996; cv=none; b=pHfykv0nGaeV9oklzfigCYGr2uVl2MBNOEyahHIJuBqLPCN1QeHQHSAMqXoiM0pHDIpVYraYUs67rrn5/JJKyamNDzjP6DAA+Ui/SEnz3boy/2+G398PAeCyH0w43RqwDfaZmVxIXEIgGzXM6qXXAUQIZuKTW8O7JvzKlJfPUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159996; c=relaxed/simple;
	bh=dmjcfomUtRoAm+/LtKobqI65kbMEKI1bFvZa5Y5FzL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRQfnNjcdLQ1ec5KUzh0ayx6GUrAKgP2Q0S/0S+lpiczi9MkPj0an28MXIX/60oJyJG/3HslnzVrKOhVLXHer2y0ukcLU8+/2IrlKh8e+/mqI7VFdhZ8cdF9OlrkQfcDk9dRTM8YF4dcnZIV01+/B1fBfnJDWPv+ly/G2Yzni7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KuBitu9O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KuBitu9O"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E78r70016395;
	Thu, 14 Aug 2025 08:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=j+0xad/C8e7NE3Ish
	PTEI8JJhfCkw+JIh6Vm6tzphGY=; b=KuBitu9OLUBvnUJ2sbPTFWu3KKp1+C5NV
	ktzpbGjVCdspOAzrwk9/0sN+icfNKUAzUh4rY6oTX8nJw9C7OJ14AhJ08pBDQ1mO
	eTl7ZQRzJI+abV87BUk0eQ028G9V4XntPwIUtWJpTy4G9IDB3OsOxcJNTVaOAZyN
	VNsgqLIw5CsnlasiKlNR1JOldT+zl8hXrmgImL+wAmr/BYlGADDIQx0iyAqPevN/
	WDeUtsesjitGwR7Yyb98Fsnct2Cx/WznnVSYzBOuKbaB0xtT7S33rJYzM1IHCeyB
	ZtTLWkvrO9DP2hUkDsHEO+fagioQg0VCwZSE9gcJNod2ELu0PLEIw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48gypeayk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8FJgV026377;
	Thu, 14 Aug 2025 08:26:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21bgb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:26:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8QHm844433872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:26:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA1522004B;
	Thu, 14 Aug 2025 08:26:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD94320049;
	Thu, 14 Aug 2025 08:26:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.214])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 08:26:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de,
        shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com
Subject: [PATCHv3 1/3] block: skip q->rq_qos check in rq_qos_done_bio()
Date: Thu, 14 Aug 2025 13:54:57 +0530
Message-ID: <20250814082612.500845-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814082612.500845-1-nilay@linux.ibm.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eaU9f6EH c=1 sm=1 tr=0 ts=689d9dad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=AiHppB-aAAAA:8 a=VnNF1IyMAAAA:8 a=SUE9vTCVrhF7s5C67p8A:9
X-Proofpoint-GUID: zHDjJqq0VFxhV-Y2ig6aBZbNPzh3bfoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE2NyBTYWx0ZWRfX/jqmnEBbW4IM
 t57oOBt8MuDVx7W/bEnG2Z9w0UeYOCHVJyOeMB+xZ8NuxQeR9IOLcHJ8r+QHdm4ZxephSmNE4Ha
 QdTUKr8h0bR7Yu72IAKnwJU5Evol6j1Jf/8NhCMV3s7Y7+RwKjsBPS9hcqyw+QcPbSDgzJn4i0U
 YmqbC3EmbwJqhCC9bYRsmx+BHEDDQUOC6qx7aWY6xVCStUPzAW20ESXPjYaQEskFTJfwqTFsm5q
 SNqXSnQvwzQdrOl9g/6bgToILenrQKjUCP57dbV7OoVLtNQGyo1vXq1lwI38Siz25w9WJPmhnIN
 fW6t3Px6NTXgrowVLdc68mAV/xVOv8lLSqq6t7vFLDijtsfdcW37OSU62D0HC+LL9aHOtbPsBhh
 P2h6yHwA
X-Proofpoint-ORIG-GUID: zHDjJqq0VFxhV-Y2ig6aBZbNPzh3bfoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130167

If a bio has BIO_QOS_THROTTLED or BIO_QOS_MERGED set,
it implicitly guarantees that q->rq_qos is present.
Avoid re-checking q->rq_qos in this case and call
__rq_qos_done_bio() directly as a minor optimization.

Suggested-by : Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-rq-qos.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 39749f4066fb..28125fc49eff 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -142,8 +142,14 @@ static inline void rq_qos_done_bio(struct bio *bio)
 	    bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
 			     bio_flagged(bio, BIO_QOS_MERGED))) {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-		if (q->rq_qos)
-			__rq_qos_done_bio(q->rq_qos, bio);
+
+		/*
+		 * If a bio has BIO_QOS_xxx set, it implicitly implies that
+		 * q->rq_qos is present. So, we skip re-checking q->rq_qos
+		 * here as an extra optimization and directly call
+		 * __rq_qos_done_bio().
+		 */
+		__rq_qos_done_bio(q->rq_qos, bio);
 	}
 }
 
-- 
2.50.1

