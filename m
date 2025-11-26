Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD530274A;
	Wed, 26 Nov 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167772; cv=none; b=H7ao6dq/WgfpFfzaRFWkvOGaSMmFaAXGunCVcj+AQT9zMZT0R7zZ8uGIzXawjqaQbgPD0FdOzLufT0PaL+xz/cWuaTzeVLFYNzh6ZqwaPIWWxCa+lpztGhs8ugM4ON+DWteOzPlEDHcRNZfyNxB/VaxVSGrS7qx2+BVeDVLOIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167772; c=relaxed/simple;
	bh=mHFpQgiYWI0tY3BnKBybNqwXtPd21h9SNkSmw63UDyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYuAZ14uKFkgar9erY72Kj6sgry+924bw4Odco0xAIl55Uer+/coEME1x3il0HVmrGq2Vqzm4bbUwXme5OKhE0MBP9t1+IF5YI/fzx2NZBrad/GqCCsHkIN5mHIQiEOr0Qj2s7OhBNBbzodinrt27cbhF+GRdJl9o2wyfAIU3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/j7dRDQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/j7dRDQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQBKfoD007904;
	Wed, 26 Nov 2025 14:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PjAEx2O9S7co0nPvD1ZppRF8SxrPxdg6wEnSlgFa2
	/k=; b=c/j7dRDQR8+hoqyOn+dcnAAxmthvhJDSrwl+5p/VxcwbRxXmmk8PWaPu/
	XWnK3nzLfxcLKbJMYiipxRy2JCQpv1a9vMGA/pAsSMpnWh8ZBeWta5R6aDYRJWl8
	FmvH2uYtW1XRBjaaJj3pFSPbUQzc6JlthfIWrxtcduFu4EOFPuEDWgQCzZnaAjdh
	7ENbJmkhOiHRACM6b/bm3tAwN/QIlV1HCB3DWXFAxGOdKTbUEeZ40sL9ykwUz+2R
	AaWbyNkNJGO3YeGSL5Lmqxf+YfSbbRRNKCXPBLWLW9624hyKAYrGdNeTHYXX1l5o
	n0P1flsvvu24DANTyu0VhVetgE8VQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvcpbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:36:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQC0A8V016395;
	Wed, 26 Nov 2025 14:36:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0kay7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:36:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQEa3wn24314576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 14:36:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F56020040;
	Wed, 26 Nov 2025 14:36:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E13572004D;
	Wed, 26 Nov 2025 14:36:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Nov 2025 14:36:02 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zram: Remove KMSG_COMPONENT macro
Date: Wed, 26 Nov 2025 15:36:02 +0100
Message-ID: <20251126143602.2207435-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX8LKiuBGbiOWk
 IZVeQUk2FyQFEpxAVoucV/0SohDvlTJEXQr/okrQmZ81dIFGTYlaNXHk74hszfDmeZCQesMd8oX
 hDVSVDN9R52wIBRHQMYxV+fIEUezMQWPvkGu+04/cBlFq5Cho9EVbyFrmrft9YD5ei/oRLnsB55
 8D0AvDHenGX600rY7VEyZpKVidfcoPhecEwy4bnaNHL0v48AZZCHguTrFIC59agkU1B1Gb9xGAT
 1579Lm9hWSxC4CCyKgz/yfizAnwz2mzxsG5hvWTdP97i6qmx30+J3x9j5PCtrBSEFrNJgBBbc7o
 ExYKMYWG6NJqFGpf288/VLbHLW/GL42pdjJku1Xke6d6Xa8Eyg1kKuugm2312z1LJHW0TTPq2Mk
 IwoTkvV9nfAHfzQtGI1hAAg9RxnIxQ==
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=69271056 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8
 a=_PnsFKANFZt3O2ycFBMA:9 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: oOeuXCafgeFY9YGul4aC3rs5Cvp4vBSe
X-Proofpoint-GUID: oOeuXCafgeFY9YGul4aC3rs5Cvp4vBSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
catalog" from 2008 [1] which never made it upstream.

The macro was added to s390 code to allow for an out-of-tree patch which
used this to generate unique message ids. Also this out-of-tree doesn't
exist anymore.

The pattern of how the KMSG_COMPONENT is used was partially also used for
non s390 specific code, for whatever reasons.

Remove the macro in order to get rid of a pointless indirection.

[1] https://lwn.net/Articles/292650/

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..4ea0d435a24e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -12,8 +12,7 @@
  *
  */
 
-#define KMSG_COMPONENT "zram"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "zram: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-- 
2.51.0

