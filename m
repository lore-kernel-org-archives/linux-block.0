Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259E2737EF;
	Mon, 18 Aug 2025 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542981; cv=none; b=eR0uFdF3Vnx7xKapNkkm6PDh/kmyJZKKSCmT/ZY30Sycec8aVSHfLg+8akPueXCnV9aDGAmYtyqvCMWQKIEWtmqePqRk4Jhr+SF5bq1EQmFlnNBAf/cXmz96HtNLXgbWM70Fo2dK4gU2yW0lEyqLZ3xTo4U5XeNYVFCe/RsfVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542981; c=relaxed/simple;
	bh=rVceH7WgH8GnEORYZZ+4H0wG/EmxIJmj1SeQ3K/SX9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGS8IVXmsj513IhD2Mg809shyjl1JQZJPWTKVYzYdztktAOfUlCcLQwZ/ynTV8YYk4ZiU6KAyw1ElROotB8CQiBpR9AuSaotnfmhMve/DlPEU0Tr8FGpXYf6Xcfb2PL9LOTKznVYA7AJ1goRhpv+DGW9PJyjLMfSs2iLb8tBrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Pzzq2FfK; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Pzzq2FfK"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IFM767019664;
	Mon, 18 Aug 2025 18:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=ameLDw0BR3vTu
	DkjRtRePwqEBLDRYpdpUNQ9YWBBFhU=; b=Pzzq2FfKxNIZVGigK3y3z3sBIZRZy
	YWwkaPJEGVqSYeBXVfNFBXiTgy2tFAIqezVS+53NWP8BlKo5k4wPMGqFf02bbt5C
	tOnnHNulCVv+psyt+vdsIbHSz6X7r1/rnhWI3ZGwht5c9Gvbj5Ngt4DjWhWDFBzu
	LneEPXSBJQcX5hXdmD9epxsewQty3okKM/SP/rsgFO0bnRSeYV5nfpk9ybeAKrAH
	+0NUDnRO91wg+VmprzqesnIiDMYrbnsa+XrV8+Lov8kFedLBi8wBSG24nXReeIJA
	Ta27Sj6rCGHs/ojt9b/WbNTGaLvdYTUf9JoeloNJg26E6CQGytwMqZsUw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48m69f9yhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 18:49:21 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id B3A18805E2F;
	Mon, 18 Aug 2025 18:48:48 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 45933883B910; Mon, 18 Aug 2025 18:48:28 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size
Date: Mon, 18 Aug 2025 18:48:21 +0000
Message-ID: <20250818184821.115033-3-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20250818184821.115033-1-rajeevm@hpe.com>
References: <20250818184821.115033-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3NiBTYWx0ZWRfX77RX9fNJQzhV
 yl5nePVcIIelNoUFqUjmK8+zZwdEIQej3txt/jvvnYOwP3v6wrX1a0VhAGzwTKLx4BkNu5mmLCa
 hG5jHrtvhfwI0Zn9GQgPDFvETIaJ6M2NIyyjlc4Q9BnOi9YnFVMXcBzhn46LT6R/M8YXHmjbkVF
 7hkws8/wy5U0oug9x8ZMK8aSsiohyMsAE4iK5siXrg6Ata7uAj5zbnEZU4Ky1ww1XmUCKPBw9xt
 4S8soYrbZEoVXmWcPQ+ko4pLs9QrbfK8ea7aBZcp95lgX34e9/KH3E+vCY1Yz1Nl17dwydSFs1Y
 NwAkERHTCLtHGqGa5p+i/ZVk3tEtALED57sMHpmcR55hKuYPSlDNFIFxO1B3D41spZCTyBdj1yC
 eao6Sjlfy9vy2n+en4bmSF/VBBIdgwbPTHhdbpQQDtcgYs3hAjfBZI5lohNdiBVNzHaGuOnJ
X-Proofpoint-ORIG-GUID: RVY0BQg0QJVX-WlJTRXOuE34fIw80MJS
X-Authority-Analysis: v=2.4 cv=Asfu3P9P c=1 sm=1 tr=0 ts=68a375b1 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=XZbkMGOcC_xTVlInkEgA:9
X-Proofpoint-GUID: RVY0BQg0QJVX-WlJTRXOuE34fIw80MJS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180176

In lo_calculate_size, use vfs_getattr_nosec() instead of
i_size_read(), which improves accuracy for network and
distributed filesystems.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0e1b9eb9db10..57263c273f0f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -139,9 +139,20 @@ static int part_shift;
 
 static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 {
+	struct kstat stat;
 	loff_t loopsize;
-	/* Compute loopsize in bytes */
-	loopsize = i_size_read(file->f_mapping->host);
+	int ret;
+
+	/*
+	 * Get the accurate file size. This provides better results than
+	 * cached inode data, particularly for network filesystems where
+	 * metadata may be stale.
+	 */
+	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
+	if (ret)
+		return 0;
+
+	loopsize = stat.size;
 	if (lo->lo_offset > 0)
 		loopsize -= lo->lo_offset;
 	/* offset is beyond i_size, weird but possible */
-- 
2.43.7

