Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912B2773D3
	for <linux-block@vger.kernel.org>; Thu,  4 Jun 2026 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590443; cv=none; b=hGr2Upu+9r2zX/NtQFQ1I85m/JcAK74T43ZoDXhibvCtyRt2KFLwGt+4kWnwCDnnQw95SqMmk2Ww8dTlHnFqsvHCZ1uxcRxU/kYr0UAB5X/ZShXtnFkavofDY/OIPAdyMM4qj96eNfYYKADHsZ1Ez97TyfKUC8D0xJ6xNWQm7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590443; c=relaxed/simple;
	bh=aa+41FCTpRuto3R8W6Fg6frn2Y3e4Je/Eai0AYz+hak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzMXvlPwbC8q3dH7lo6n8U5JbVGpKOItgeMacMKp7f8gD7x5IaqmxCaPFaO1Z5pUChaVCRcQJ/9xp/kLDsQuXiIU8B2YyxveREbu1TjPQkTufIhkDlysTD+U5adMiILHIVkN2qcLLKdyQtzcrmWQ34NA4TFQjBc8LfcB4H2rjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GsgxMQ31; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GsgxMQ31"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Bw9ru2298475;
	Thu, 4 Jun 2026 16:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=szVXT5AklZ4O+pOf0gPl3tuQpJhpFn7aF74Tm8MCP
	Vw=; b=GsgxMQ31oXqLo5GNQjkWx6bZdl+uZGIYavU28JpWM1MkswQFW77VE8bYR
	kp4OXGrEyoTinBTTVOF9gfncsLrDtwO6wz5lhEIBzEgV8YfJt2B+6Lc3szdZlxBN
	zwZFzaJXDYD6C9jbU9wxh/5AoAAzgTJ4VKoFy6boQkfRGuDKhyXKQGBeEXILBdcR
	3EjFcsg4W/1tFji4wQ42ssEh271264Ois0f6HynUJmRkifOfDDzeUrAKB+ROIt/1
	zqZAOppZj0IL3yfZZZPmoI5cgJEvtdFm2iDmBksxQY8Hdo5uABS8gE1Z3s48sYmk
	xl9LjupYZoLLKWkB4FPfKXXNVJhqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnaj09tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:27:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GOCM7012101;
	Thu, 4 Jun 2026 16:27:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kdvuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:27:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654GRBnv46530888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 16:27:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7506F58059;
	Thu,  4 Jun 2026 16:27:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0B6B58058;
	Thu,  4 Jun 2026 16:27:10 +0000 (GMT)
Received: from ltcrain119-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 16:27:10 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: linux-block@vger.kernel.org, axboe@kernel.dk
Cc: tom.leiming@gmail.com, yukuai@fygo.io, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH]block: Observing higher CPU utilization during random IO testing
Date: Thu,  4 Jun 2026 12:27:09 -0400
Message-ID: <20260604162709.3006327-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1NyBTYWx0ZWRfX7FR36tbkuDeG
 M2Yq/gG+Jk2ufOqUHazD4isbv96jI65x5oMM+yMdWynnIBOg2hDKR2myaOxH4Bu3pYkEJdHvUQr
 S57O1IKfP9fQbomzL1xO9Y+QanO6mhpuSI55mTr86vruQkgJTm4NdXcQs2sgZ/w2DQbFarzz8wG
 TsQYTaF0WmAXV0NlYpY1W/YTXESEsyczAhOUeHZrgullIegKrLIus2Ic/EbTDFsjhwX7ubh5Tm9
 5+34cMfq9NmSKaExdsJHUpLUvMQggKHvK5tdQjk6kuqXWkW3eKQhkmj9OKE70RrRom3zwz8Pvti
 gQ51iGvP0Ety+AyjdJHIywVtpxnr8n9h8TBOaKGN3lJeh/TqhxTn6WOHLYuGXgOsSl1RhmPFQ7y
 KPjsqzGJycuVV9/NZ5hHm28q3nI9MoJi51qhtAScjYtPjHt4RPPrBjkDkJs81+QeKJ6XundTAQS
 V/JhlB/4f3e2vLRyAzg==
X-Proofpoint-ORIG-GUID: q2BLS2uL-lMk_A4jwcOZrVTNzQ4SSHbc
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a21a761 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=msvfNpiPRe6fYSCHkfsA:9
X-Proofpoint-GUID: KtahuVjY_n31BoeZl8fCWZioxjROhFii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040157

From: Wen Xiong <wenxiong@linux.ibm.com>

Hi All,

Our performance team observed the higher CPU utilization in RHEL10 compared
to RHEL9.8, observed the similar issue in upstream kernel(v7.1-rc6) as well
when running FIO random IO tests. Random IO tests are more CPU intensive
than sequential IO tests due to several factors: more context switching,
interrupt Handling, cache Inefficiency etc.

Given commit 060406c61c7c ("block: add plug while submitting IO")
causes performance regression. This patch reverts it.

Below is performance comparison with the latest upstream kernel.

Iotype  qd   nj    rmix    mpstat busy        mpstat busy
                         with inner plug    without inner plug
Randrw  1    20    100       53%                 24%
Randrw  1    40    100       70%                 24%
Randrw  1    20    70        40%                 24%
Randrw  1    40    70        60%                 26%
Randrw  1    20    0         14%                 6%
Randrw  1    40    0         20%                 7%

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
Suggested-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..ee87edf166b6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -626,11 +626,6 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 
 static void __submit_bio(struct bio *bio)
 {
-	/* If plug is not used, add new plug here to cache nsecs time. */
-	struct blk_plug plug;
-
-	blk_start_plug(&plug);
-
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
@@ -645,8 +640,6 @@ static void __submit_bio(struct bio *bio)
 		}
 		blk_queue_exit(disk->queue);
 	}
-
-	blk_finish_plug(&plug);
 }
 
 /*
-- 
2.52.0

