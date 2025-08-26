Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB6279791
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225912; cv=none; b=AtvqOqMH9R0HbwKqM3Qcu8v6daJbANv+o5+Bml6U0SRVoNCANVpfWObtwLc1rCMC6h5SHs32Gb45IADoAoZfCY8XxRgTc8qXaBIWJWtF1pa90yy3v+kpxg8iDGNn4gA4tm8jUOejYmXcnmiTaE03KkdhJuY8EQF8dMdagUqKgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225912; c=relaxed/simple;
	bh=zpdLKYrrElyc4RTqGRamM6FD76tr79r3FvVgSB+6wgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLriDbaaz8pHZM9yVm3z8lZFE5048rJPAGUkxBcCcA1gQJ7ieDY8gZhtCA5DX18koBeNhuFQW7NASHdBWkmPZazzs8RmlLNECrdQQ8oPqgo3Q9cG+WwNnvIb6XfzlmmPicx1r+fFiLteYbKZR5/1460U42h17yGLjNaVt0r9byQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PQL++xN1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PQL++xN1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QE0lNn026907;
	Tue, 26 Aug 2025 16:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NP9/2UrQtBwH8wgZX5gVSKm2Vydd
	HxPMVnRwekPG2rM=; b=PQL++xN1Motee3tSNvsABwiTxIFwAcZgjTzpZwksQURp
	G8PLln1jZAJo03QtuY+hSaK80ZYcFzT3UqT/3Z7w+m8VwvYFQ1j9ayUELA/Sw0dN
	9ywegFyR8s6M3zShMGPxuqR1vPS7LN8im2euTxOkOwmZJX4zKQBnLp/yeh0Ky07C
	e59Y3e9EtYm5Z3rCC0bbfbvq838BUddfXCd72oqf87XJ5sauHaTIrq88ZWAsr7Du
	jqaavxCQg80vj+4w7xfurwVfRvOzicJk3Q6pAKfgxWjJoKemz8GZEHaYiivO9fvA
	XadAcKKU5h5nJ0Sz2VUi9g7PAcMiFhUTQfDEmnKwjg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hpyhvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 16:31:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGJXUB002482;
	Tue, 26 Aug 2025 16:31:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mbe7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 16:31:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57QGVWJE53674280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 16:31:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA3B20040;
	Tue, 26 Aug 2025 16:31:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 806852004B;
	Tue, 26 Aug 2025 16:31:30 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.46.213])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 16:31:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, axboe@kernel.dk, hch@lst.de,
        venkat88@linux.ibm.com, gjoyce@ibm.com
Subject: [PATCH] block: validate QoS before calling __rq_qos_done_bio()
Date: Tue, 26 Aug 2025 22:00:32 +0530
Message-ID: <20250826163128.1952394-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX+flmoxZiS7dK
 TyvN4kbIDMlDSSAvT1du1jQO1AvU5KSOKqnsbGmkK+NLDfbUEZj0wdGHuABy5eNVbTrYNpkD/D0
 2W59VKKB1bbHOF1Mj2uNOul1ze+X2haaeVuQLDS1/8vRm7GNB0hljfDtOURExXMD+L3Ng1SiUJk
 BEwNqku6G3jAd52KOjvJ35ArI1Fi8PiW6AbuNXINbLDke06oNRL33bPqvQ4mI936sPHaWEXNJ3m
 mXrMvM7akZjdEAj6c0xT/3OdkiQ3rh4AehBmklaEp2SokMPStCF6Pu5bz4WCAFuJDtOTvWZsWil
 A6eWBk6mp+k4unPg9mrJvYg5gLvXtUdSgXjOZKwuT5LfVuHWjA0GGl8CTmHVEsBUUa54f0mMkVs
 OL6egg5K
X-Proofpoint-ORIG-GUID: 08VXKHI7eUjHkgETIUXI8JPbHYeyLrA-
X-Proofpoint-GUID: 08VXKHI7eUjHkgETIUXI8JPbHYeyLrA-
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68ade167 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mB9xVynlB3IufWbWQNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

If a bio has BIO_QOS_xxx set, it doesn't guarantee that q->rq_qos is
also present at-least for stacked block devices. For instance, in case
of NVMe when multipath is enabled, the bottom device may have QoS
enabled but top device doesn't. So always validate QoS is enabled and
q->rq_qos is present before calling __rq_qos_done_bio().

Fixes: 370ac285f23a ("block: avoid cpu_hotplug_lock depedency on freeze_lock")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-rq-qos.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 1fe22000a379..b538f2c0febc 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -149,12 +149,15 @@ static inline void rq_qos_done_bio(struct bio *bio)
 	q = bdev_get_queue(bio->bi_bdev);
 
 	/*
-	 * If a bio has BIO_QOS_xxx set, it implicitly implies that
-	 * q->rq_qos is present. So, we skip re-checking q->rq_qos
-	 * here as an extra optimization and directly call
-	 * __rq_qos_done_bio().
+	 * A BIO may carry BIO_QOS_* flags even if the associated request_queue
+	 * does not have rq_qos enabled. This can happen with stacked block
+	 * devices — for example, NVMe multipath, where it's possible that the
+	 * bottom device has QoS enabled but the top device does not. Therefore,
+	 * always verify that q->rq_qos is present and QoS is enabled before
+	 * calling __rq_qos_done_bio().
 	 */
-	__rq_qos_done_bio(q->rq_qos, bio);
+	if (test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags) && q->rq_qos)
+		__rq_qos_done_bio(q->rq_qos, bio);
 }
 
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
-- 
2.50.1

