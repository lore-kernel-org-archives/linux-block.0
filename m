Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750102820D6;
	Wed, 13 Aug 2025 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114775; cv=none; b=Ohw/tHhQRpIJkEmPtSQ8ukAZUzH8OPJj6jBrlnD+/FC9psunzy2Y7gMq0WdtH6aa6eamx7+2JCof2k9H2QZ5UmJvW6Hq2NbgDW1un3kNPJdOInDoFy+SuzOgkCIG757Xk1yct2mEu7c7MTAKDBc01i61S7xvV2hG5ml6rTwSV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114775; c=relaxed/simple;
	bh=wHYxP5XMIVh3M+qVTlG2brwhZGIiH57O9Bcg2gsbjpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scItJ4P9IdP6mEoI6O5WJsdmslYJB6aDo6ANOJb3mpa4Ri5Va8cKt8uIVCqxCOtEiESL9mAtTWJHrKKnIAFL3/FguXmffHfA8rPQXwHnUvz/iohD97MYCIKTLciyTbnGfs2eH8lvW02yy+XoRSH4H3rEBwgZVKbJpDpcBlh/Jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ANzEAG34; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ANzEAG34"
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DG2Ux6023825;
	Wed, 13 Aug 2025 19:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=wHMjiB9Gbs1Kg
	kvNMoVptvnUaaW/w7VmPTUrDkCrJaA=; b=ANzEAG34i7pDDXGgO4zpM8PUFjO4W
	v11vt7/ybW8vlQnN0LYGO/HLd19jEhI3BJCzDfb91tEOtcZCc/L5rA6ZP1xlclFB
	j8f/20+Ot0ZTnMo1Ax7lk5Mi00SQ2sNmkaEIRhfNpu3Zjy2pYf09VwIYF44Fp1TJ
	uCk8mYtcWAm1R+xt7UZbcGS9xdHmJPjXSiwsO9PfW5Fa3bn571bQNEKRGmCOMDco
	CJh0emT2hEkal3Dxf/xNEbqjPvMICljBDyamLCvh8Qt+ygqmiU2S4/ODicpLeymb
	q2qbbbAqeBL0xpRyGaNhpqvMbvhHGT6mHfPbmAOEf8g+1nP4Le+ZvIpeg==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48gvv0jp5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 19:52:42 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D2688132CC;
	Wed, 13 Aug 2025 19:52:41 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id E3994883AC57; Wed, 13 Aug 2025 19:52:34 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v4 1/2] loop: Rename and merge get_size/get_loop_size to lo_calculate_size
Date: Wed, 13 Aug 2025 19:52:26 +0000
Message-ID: <20250813195228.12021-2-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20250813195228.12021-1-rajeevm@hpe.com>
References: <20250813195228.12021-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE4NCBTYWx0ZWRfX+KT3jIUssXd4
 R0JHn9Py61Qgp25jQrxXdlJZW+A8ty/YbexDxofEod0hX5nfQmKsWgtgjIUTQsZj9dvGIpFmFFx
 jCJ+l4Ms0g3ekhZEIbZ3oyApij/la4MnGv2QVnX+5SGg3BQymbu6JszCHEuYctvLyFIt1ye75QW
 xxtEK9DU4ovyNT+uAlZoxmhLAop2kRsU6GfEsLnwnbfEQvMsmHoPShaH1Pfoji5WgA6oyg6Jv5h
 ggVFwuETJexodrUePxNRDFafw1HtpRZ8UWyCpRl3L3j/7xyVyCc3FIrWaeXXABhXwzwIaGj5Ht4
 RaxGeVJXpxIpuXz9sh6BCVh6zrgt7huSYi3nXU29F7xam9iJlSpPSywyGMG6cn6GsxrS4z1GzKa
 L6y3gJ8vw+wUBNX+vL+yx7mQxZjwKxzzOREznACVg6A+EBJfFrsyJPQCF9IbSgZnJThBJuiQ
X-Proofpoint-GUID: Ru1mQIgWWbC_pSWBmUvuhqKI7ZERnUzj
X-Authority-Analysis: v=2.4 cv=BbHY0qt2 c=1 sm=1 tr=0 ts=689ced0a cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=rsV_Y8SVn8CFOHcOaF4A:9
X-Proofpoint-ORIG-GUID: Ru1mQIgWWbC_pSWBmUvuhqKI7ZERnUzj
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508130184

- Renamed get_size to lo_calculate_size.
- Merged get_size and get_loop_size logic into lo_calculate_size.
- Updated all callers to use lo_calculate_size.
- Added header to lo_calculate_size.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 50 +++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1b6ee91f8eb9..5faf8607dfb2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -137,30 +137,23 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
 static int max_part;
 static int part_shift;
 
-static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
-{
-	loff_t loopsize;
-
-	/* Compute loopsize in bytes */
-	loopsize = i_size_read(file->f_mapping->host);
-	if (offset > 0)
-		loopsize -= offset;
-	/* offset is beyond i_size, weird but possible */
-	if (loopsize < 0)
-		return 0;
-
-	if (sizelimit > 0 && sizelimit < loopsize)
-		loopsize = sizelimit;
-	/*
-	 * Unfortunately, if we want to do I/O on the device,
-	 * the number of 512-byte sectors has to fit into a sector_t.
-	 */
-	return loopsize >> 9;
-}
-
-static loff_t get_loop_size(struct loop_device *lo, struct file *file)
-{
-	return get_size(lo->lo_offset, lo->lo_sizelimit, file);
+static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
+{
+       loff_t loopsize;
+       /* Compute loopsize in bytes */
+       loopsize = i_size_read(file->f_mapping->host);
+       if (lo->lo_offset > 0)
+	       loopsize -= lo->lo_offset;
+       /* offset is beyond i_size, weird but possible */
+       if (loopsize < 0)
+	       return 0;
+       if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
+	       loopsize = lo->lo_sizelimit;
+       /*
+	* Unfortunately, if we want to do I/O on the device,
+	* the number of 512-byte sectors has to fit into a sector_t.
+	*/
+       return loopsize >> 9;
 }
 
 /*
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

