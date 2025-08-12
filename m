Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559C2F067C;
	Tue, 12 Aug 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029788; cv=none; b=N6XQc61NjLTpzjU/NxNKk4JbDI2t0AsYQUGh+FDho3keD0/0w6eQuDyR1pZkHlXctnLIrORSqbxwp9eLIl8+1c8Frs8bVbTYuORX0goNsoa/YbEjuZiRbs8w1cyzNDrMO3dCOIxP+E+3FwguxmliFp0hgH3PKSyTSNz5ISGe6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029788; c=relaxed/simple;
	bh=ReOXUiapkiPyT+dNUFjKcI1zRg06NazNsC4FbCqX5pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AK+QgAoh5tkRi4nmkDc7awrLZXXsrkd5HekiZEiGeUWkVbsyAcUB/GQ0VvXbTF/CuR60Wae/51MtF/3PKvS0ECsF1nMYe4MLhjWQrwFsMIFoWdAoJpmOTCHgpSm9LqbgjoA1PYcqQRPWGF9U5LLV6hDXbupmmbEAzf2SkyumJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=iPJ3MRfB; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="iPJ3MRfB"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJRLZB018944;
	Tue, 12 Aug 2025 20:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=95lsorJVpsmlUu1G3BMjrZjeCRoLf9/MPQzrr
	gkGVII=; b=iPJ3MRfBV5JltkJBDoWHqSkf4P+ED7GqFyQptkGGSPlsMT0RSmDWx
	dO4GFWE7Gq1YCT5kuledcHz6e+myeXqKn3j/lLmaC+b6wq7JQJbM6k5MvMDJycBD
	+x8wy21slxlK6WwSGURetJOl/eQdkOkbo9IdwldwEDAQrXAWqLamzCMwVGtriIgi
	UXo2fRwwdcWDCIDaNN4egcssfM7unFFHwZ3j6kMooCUr1KsU29n0ow44RLwentYb
	0pB2cKVJ2CVzbXxtOXPakJMgZV5Y1V39aGw1V9Vt/FA9EtJvZ1O9eemomsfd8I+g
	xw2HI4sN6BUhH5Mw+CIajQ3onNNQGsgug==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48g2rdnuq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 20:16:09 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A48E1805E05;
	Tue, 12 Aug 2025 20:16:08 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 8EF97883AC57; Tue, 12 Aug 2025 20:07:09 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v3] loop: use vfs_getattr_nosec() for accurate file size
Date: Tue, 12 Aug 2025 20:07:07 +0000
Message-ID: <20250812200707.233139-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sjITrpqU6aCvmWqh_-0wdgVWG5e1udJc
X-Authority-Analysis: v=2.4 cv=EOIG00ZC c=1 sm=1 tr=0 ts=689ba10a cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=wM2jcdVKGrdHGHgjmVEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE5MyBTYWx0ZWRfXzoFb0l9DJvU3
 wfjpda4IJNxhU5hMNzlo8JgbIpAhZCgjoni/xKtCG1OitvekgDRJbIpMRv0dvWcaejYp3imZUeX
 ONmzX23wzH7gQI/zGMeGBJ6wz14jeExyG8+s428ztBog4ZK6Tex2z4Li3QGMeH8KKHxEszhx38i
 zbnXhyD3qDwMPHB7FZE2RWc+1fXNfdAiXt9RCzwrui+PfM7XIk8ZLhdbccQMmKYFAUEdsYT9eo/
 IypQrB6xgoiQQJzm8cDSxPCRPl8iVh6XwZpknqXoGkLRXcbuc54eDXMsVOLHHrqmSE5KpYBbkZi
 bo3itBOlM+Kg4zg2GIMdIyQj688p6EweXdaY4vG9UvsHo9aM7mCUWIdJh0W/y7t5znG4P8wmsLr
 qU0l6LtqYUiyt9cKCbxbz3QtVKe/wQEtJzdvWG897ldEWHoaXIzspZX/Gm5l7fjUC8bhRCU5
X-Proofpoint-ORIG-GUID: sjITrpqU6aCvmWqh_-0wdgVWG5e1udJc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120193

This commit includes the following changes:
 1. Renamed get_size to lo_calculate_size.
 2. Merged the functionality of get_size and
    get_loop_size into lo_calculate_size.
 3  Updated callers of the above functions
    to use lo_calculate_size.
 4. Replaced i_size_read with vfs_getattr_nosec()
    to obtain a more accurate file size for
     network filesystems where cached metadata may be stale

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 53 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1b6ee91f8eb9..6bfec38275b0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -137,20 +137,43 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
 static int max_part;
 static int part_shift;
 
-static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
+/**
+ * lo_calculate_size - calculate the effective size of a loop device
+ * @lo: loop device
+ * @file: backing file
+ *
+ * Calculate the effective size of the loop device based on backing file size,
+ * offset, and size limit. Uses vfs_getattr_nosec() for accurate file size
+ * information, particularly important for network filesystems where cached
+ * metadata may be stale.
+ *
+ * Returns: size in 512-byte sectors, or 0 on error
+ */
+static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 {
+	struct kstat stat;
 	loff_t loopsize;
+	int ret;
 
-	/* Compute loopsize in bytes */
-	loopsize = i_size_read(file->f_mapping->host);
-	if (offset > 0)
-		loopsize -= offset;
-	/* offset is beyond i_size, weird but possible */
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
+
+	if (lo->lo_offset > 0)
+		loopsize -= lo->lo_offset;
+	/* offset is beyond file size, weird but possible */
 	if (loopsize < 0)
 		return 0;
 
-	if (sizelimit > 0 && sizelimit < loopsize)
-		loopsize = sizelimit;
+	if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
+		loopsize = lo->lo_sizelimit;
 	/*
 	 * Unfortunately, if we want to do I/O on the device,
 	 * the number of 512-byte sectors has to fit into a sector_t.
@@ -158,11 +181,6 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
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
@@ -569,7 +587,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	error = -EINVAL;
 
 	/* size of the new backing store needs to be the same */
-	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
+	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, old_file))
 		goto out_err;
 
 	/*
@@ -1063,7 +1081,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-	size = get_loop_size(lo, file);
+	size = lo_calculate_size(lo, file);
 	loop_set_size(lo, size);
 
 	/* Order wrt reading lo_state in loop_validate_file(). */
@@ -1255,8 +1273,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	if (!err && size_changed) {
-		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
-					   lo->lo_backing_file);
+		loff_t new_size = lo_calculate_size(lo, lo->lo_backing_file);
 		loop_set_size(lo, new_size);
 	}
 out_unlock:
@@ -1399,7 +1416,7 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	size = get_loop_size(lo, lo->lo_backing_file);
+	size = lo_calculate_size(lo, lo->lo_backing_file);
 	loop_set_size(lo, size);
 
 	return 0;
-- 
2.43.7

