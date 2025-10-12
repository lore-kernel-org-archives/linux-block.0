Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DAC25A354
	for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294454; cv=none; b=Ex31I/t8vehepOMPEt2C1ZE9qqEw0Qzw3CTC6ywMGkwCD0A52aA8OBGgAiAkJBq+n1sRcO1NhuVydQToVxC6+AnL/OYwNuK1cPc6ukmvjM9CSomxSf+L3AykoPkryLuf1iEg7Vy5uxtajkQlYH6BFQkPL2RaLUtv20M4bOPNVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294454; c=relaxed/simple;
	bh=jPAdJQCpBQEnf+PFZT9rv3bkEEiZW89ug2y1tCqYIMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHEQkRzEgGr8ssaugFVgHZGWv5dNfW9QEyk/LaGCEhy+pfc+Kq8M0jLpG9b0n9UJT/Cq6h3wr6wsuHUPwEodbTriwwy4FvOlIaC9G6Uca+6vGLKQgjMe1K4IvnjfG9pTjMNVIRiPLD3uRhnVXBWjoxSEFNzQ56s+FnR1AKaI5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RPr6lUCf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RPr6lUCf"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CIdsPa014773;
	Sun, 12 Oct 2025 18:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=PR+j9XQlb20kzlvou4CGq3b4wJvPT
	Ma5KvHeINjEI6E=; b=RPr6lUCfDsSaTd1rjVydseX3uyyXXGbCM1QvX4JjvOPpy
	wHGAOacDSCTrkwLJWVlun98cWyvI9kmmgWmWjqzGG/kPmV7+Y/BdSqF+0XjFCgUJ
	5+k1m8D6tIN0DmjhrMmVQ0nJ95mD81PfEUEbkn86mQiKnIZuy2LY+0frTs1rhfUJ
	pL8APHKxedoOtkmKlPrBlpdqC1wcFhkrZl9lTXoSKLPCLA5pn2ck4m4OKhKZnP1v
	1N9dOpDtrzrzEIFADvu6KJ0dYqw6QGPUPHsHjZ8TDK7VrCbm1YDezKjhB9QOggxZ
	sE3n1eoNkbHjk8dfXK2SMSPRsNtJuaecm5+xbBcbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc156c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Oct 2025 18:40:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59CEKRtD038326;
	Sun, 12 Oct 2025 18:40:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcsxee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Oct 2025 18:40:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59CIeepH022304;
	Sun, 12 Oct 2025 18:40:40 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdpcsxeb-1;
	Sun, 12 Oct 2025 18:40:40 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: axboe@kernel.dk, andriy.shevchenko@linux.intel.com, phasta@kernel.org,
        fourier.thomas@gmail.com, viro@zeniv.linux.org.uk,
        martin.petersen@oracle.com
Cc: alok.a.tiwari@oracle.com, linux-block@vger.kernel.org
Subject: [PATCH] block: mtip32xx: Fix typos in comments and log messages
Date: Sun, 12 Oct 2025 11:40:03 -0700
Message-ID: <20251012184010.198891-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510120099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX4vB8Z15FE5Pd
 b0yVoizpc0jK05S67WP9OHqZr16qBPh+f/2TuK1w2oFd+CDky2kraSn15MRJw0C7ro6d0YXy1jH
 PX/KL40dfMcTsD29DveBr9nPoQFEuuCqdH/FUYL+KXTxkoFtjTRTehQ10I80KcvP52e7OmwNpDa
 J1C+QQsc3ynQQULZUy/lzmRU24rPiatcLiZot2QU71g+aKjXLwistmDDtZlfUdAmmEClNFt99HE
 58eiOq5F8veh/SdCwbOVqnsp7tqHcb+PPFFLncttDhzA55zA6oLZ21qIkHrU14nc/iEg1hgQ2jE
 6T5vxk67/5h/UcHLD0Q/JoVE12TeFAJ1PberO9XAczzzdp+QOyVlaHuEZwIwtKK8uQHJabitAVA
 2pA2qxMTQJZdVi91kRnEBAdh0Js00i0txNyYkFXm1SAHVe6jJa0=
X-Proofpoint-GUID: a9jlqaiwJszkxNFaF4i-T9ywRgSKpSkL
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68ebf629 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=RXALipHn05_ar3t3B5QA:9 cc=ntf
 awl=host:12091
X-Proofpoint-ORIG-GUID: a9jlqaiwJszkxNFaF4i-T9ywRgSKpSkL

This patch corrects several minor typos and spelling errors in mtip32xx.c
- Fixing "ge" -> "get" in a warning message.
- Correcting "kernrel" -> "kernel", "progess" -> "progress"
  "strucutre" -> "structure" in comments.

no functional impact.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 567192e371a8..df184a9f006f 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1337,7 +1337,7 @@ static int mtip_get_smart_attr(struct mtip_port *port, unsigned int id,
 	memset(port->smart_buf, 0, ATA_SECT_SIZE);
 	rv = mtip_get_smart_data(port, port->smart_buf, port->smart_buf_dma);
 	if (rv) {
-		dev_warn(&port->dd->pdev->dev, "Failed to ge SMART data\n");
+		dev_warn(&port->dd->pdev->dev, "Failed to get SMART data\n");
 		return rv;
 	}
 
@@ -2127,7 +2127,7 @@ static int mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
 /*
  * Sysfs status dump.
  *
- * @dev  Pointer to the device structure, passed by the kernrel.
+ * @dev  Pointer to the device structure, passed by the kernel.
  * @attr Pointer to the device_attribute structure passed by the kernel.
  * @buf  Pointer to the char buffer that will receive the stats info.
  *
@@ -2679,7 +2679,7 @@ static int mtip_hw_get_identify(struct driver_data *dd)
 		}
 	}
 
-	/* get write protect progess */
+	/* get write protect progress */
 	memset(&attr242, 0, sizeof(struct smart_attr));
 	if (mtip_get_smart_attr(dd->port, 242, &attr242))
 		dev_warn(&dd->pdev->dev,
@@ -3148,7 +3148,7 @@ static int mtip_block_compat_ioctl(struct block_device *dev,
  * that each partition is also 4KB aligned. Non-aligned partitions adversely
  * affects performance.
  *
- * @disk Pointer to the gendisk strucutre.
+ * @disk Pointer to the gendisk structure.
  * @geo Pointer to a hd_geometry structure.
  *
  * return value
-- 
2.50.1

