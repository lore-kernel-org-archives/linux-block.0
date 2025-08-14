Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8211E7C1C;
	Thu, 14 Aug 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198685; cv=none; b=KxkDmqxvpyKJ5Y+QlC3SYihKQofsc3J1MxeVPmDiOCnp7r3xByX2U1CjVxmgLj1fD+IOJPudelq1rZ+0UpvmgKL5neGf2lDhcwy0ZU8E+ZOkMGf1gLOCjuux0m++LCTPU1JfARZd1k9UBejk8x/XnFrTxn8b/9Dy0J5GO6e43uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198685; c=relaxed/simple;
	bh=9XE4ZobYI/NqVdvC0uo3n87qyaQTaZUkjPKyqlP5wQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGRM2SF0W4S/11SpXWwCKI/molGQYQ/4ZlwrvjtcROXIl8XyjyDlkbW6VqN1CBOSibtZRnVdSoM8SqcZb06q7Rs2KtbEmSKm19OCC0dGSF5wTasLcSKHXarUM3uVwaSlJBwee2VWeg7EsIrrLluel+QnBEEm0Sh1diz9r5NseWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=CfHa/pCg; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="CfHa/pCg"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EFWJER009338;
	Thu, 14 Aug 2025 19:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=XpGChlmrL4BcuJE2a2uUcO04sPQ2c1KFgPgTD
	gpXhlk=; b=CfHa/pCgb5lE6AP0utkwsezycQDQ7q67r1mpBLT5K+eqmoqkI8t7I
	7CphZgaCJzaNzYqykGQKnv5P4RtoA3gP7kPJrdrQJTewaiZTdL1+2sDTFWPxMmre
	duDM1Z0DQtXm8LS5OAhARIZ9i29AWsjSUqVP6I0szAiuKrpy57PEu/jgEmZ3xWWs
	5LKlvqK2M6Ctaoum6edjhYHdIQWm7NaEMpD6HJAXJ0OJejfun4UKRGLqrYhD6ADQ
	Pfsu/fuLU76W3IRsXkOV8hAznYVRxo2dNvhH5o5Pg36hbMftjyuR5N2Zw7PP7/Fj
	XkN5kPGJ57C/MPsF209giRFwkE6G9beWQ==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 48gxjk4phq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 19:11:10 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4E7F1800265;
	Thu, 14 Aug 2025 19:10:11 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id B2A768800123; Thu, 14 Aug 2025 19:10:06 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v4 1/2] loop: Rename and merge get_size/get_loop_size to lo_calculate_size
Date: Thu, 14 Aug 2025 19:10:03 +0000
Message-ID: <20250814191004.60340-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE2MyBTYWx0ZWRfX15Rt5aVdb3uB
 XXcpVWuuTw7VTLbQxzVIVVYCWyKuNpj/nnlRkGG5pvTNLMznkztLVprMOsU3cdUXhRcQ5tlL89b
 Ywk60+8rKpe4Nz1J7NHX/rPb0xQ60AcSaEqyGoNb+R8Lms87b4MnPsb4PJkMnJNxC0HjCnXCBcR
 FnRMJqGwQdFw4AxSOcEu3uS1gPiQhyHWc+Lf2CyHABOZKcU6bZInb/22FNAUVQguvflXqfe729o
 pWYPJT+Qq99/qyKzJ+ZdhzIbJqZDB+JP+Ix0wu/zNU5CEkv96ZBE10mRqc7/Ji3DJL7Wz17xcmU
 9/uxYyF76acsEBasjxeM6dIP/ZQtufAc1yOtLevN6CrbpLj2lnZASkAkHhTNHLpPAVi/cP/B41L
 cS7Il07AnnBEY1hZZX7qmvfPs0bO0rL3drm1XPiBuLfI40KjEY1bWNB8ZtqsC/H7dg6ADhiv
X-Proofpoint-GUID: jVRynczNfY227vW2V0LqXoOLDcyzchjs
X-Proofpoint-ORIG-GUID: jVRynczNfY227vW2V0LqXoOLDcyzchjs
X-Authority-Analysis: v=2.4 cv=cJvgskeN c=1 sm=1 tr=0 ts=689e34ce cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=SlmTxP4Kr1pQ6mi-SkUA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508140163

- Renamed get_size to lo_calculate_size.
- Merged get_size and get_loop_size logic into lo_calculate_size.
- Updated all callers to use lo_calculate_size.
- Added header to lo_calculate_size.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1b6ee91f8eb9..0e1b9eb9db10 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -137,20 +137,18 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
 static int max_part;
 static int part_shift;
 
-static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
+static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 {
 	loff_t loopsize;
-
 	/* Compute loopsize in bytes */
 	loopsize = i_size_read(file->f_mapping->host);
-	if (offset > 0)
-		loopsize -= offset;
+	if (lo->lo_offset > 0)
+		loopsize -= lo->lo_offset;
 	/* offset is beyond i_size, weird but possible */
 	if (loopsize < 0)
 		return 0;
-
-	if (sizelimit > 0 && sizelimit < loopsize)
-		loopsize = sizelimit;
+	if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
+		loopsize = lo->lo_sizelimit;
 	/*
 	 * Unfortunately, if we want to do I/O on the device,
 	 * the number of 512-byte sectors has to fit into a sector_t.
@@ -158,11 +156,6 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
 	return loopsize >> 9;
 }
 
-static loff_t get_loop_size(struct loop_device *lo, struct file *file)
-{
-	return get_size(lo->lo_offset, lo->lo_sizelimit, file);
-}
-
 /*
  * We support direct I/O only if lo_offset is aligned with the logical I/O size
  * of backing device, and the logical block size of loop is bigger than that of
@@ -569,7 +562,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	error = -EINVAL;
 
 	/* size of the new backing store needs to be the same */
-	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
+	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, old_file))
 		goto out_err;
 
 	/*
@@ -1063,7 +1056,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-	size = get_loop_size(lo, file);
+	size = lo_calculate_size(lo, file);
 	loop_set_size(lo, size);
 
 	/* Order wrt reading lo_state in loop_validate_file(). */
@@ -1255,8 +1248,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	if (!err && size_changed) {
-		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
-					   lo->lo_backing_file);
+		loff_t new_size = lo_calculate_size(lo, lo->lo_backing_file);
 		loop_set_size(lo, new_size);
 	}
 out_unlock:
@@ -1399,7 +1391,7 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	size = get_loop_size(lo, lo->lo_backing_file);
+	size = lo_calculate_size(lo, lo->lo_backing_file);
 	loop_set_size(lo, size);
 
 	return 0;
-- 
2.43.7

