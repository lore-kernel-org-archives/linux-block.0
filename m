Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7F2798FB;
	Mon, 25 Aug 2025 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145937; cv=none; b=hLY3ZfJA2d4kTf1AcpwJBhaZcPhSYv6f7LNTh+sEYqUsoeTd+9rJB5Rt4afv4nJsCY/NerAstGjPOeKe6IZTtvGo9+GV4MnR80X2sitRtj0++hYyRW/biAhHMiFN8lSF6vj/1GdgwP1Wu61w7kGAKbRXP3E6pHg3+9Ems7ugKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145937; c=relaxed/simple;
	bh=dp28qYPxsm8KbDCT4NEaZ4Yg86ZSr2Ee74duus94/rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/Bk7ZficRchmM9t/Cidp+tkmsSoiyMYyzCuaIQY4egssw5psfOHym6ANqMmbhfqxIEKHaMXCddiKkZEYlaXqwaPLPDdmB6fz2AwpS525gszW0pB19ZebtQJYVRcRhi3MDB16Zh7YIWG7WEQYJ1n5i4nYqNTMkZTE0Hkb16hvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=fZeuW3oP; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="fZeuW3oP"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PE3fvk018056;
	Mon, 25 Aug 2025 18:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=GqenFbVHORaaL
	NwrYhVpETeOY5EZU2le5oeUYt9o/OM=; b=fZeuW3oPIIl94VwjsbgyxTL0oUNxN
	BmZyo8PQS7eh5dhtXjaKJ+HbIyCmmlIei//1YGMrRKyWGxjFnmGrmytIccP6Fq7e
	s2skkeqCW71pOQ6CnfiRfFHj355NMTWQx35WaFVRwtZSuGB33USkjxXBHGp01JLV
	KG2zcCJegJyxm+J0um3104JD3eCR+9ChxoACuBF2Ry92o6fSiRp0nZI0zLbO3/dP
	udV2mcO3cdMX9dgK707bSiPEHvhDVMzhoXh1L2RcnC53L0CF5nNFYi7jAJEoyJ2c
	Ho688MmW4D+G6HQtqqmxTdD7niSXA3YzLP9PmzyMeYeboMFj+T2JBWO7Q==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 48rj2edpc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 18:18:12 +0000 (GMT)
Received: from mlperfr9.3-rocky.novalocal (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DD99313154;
	Mon, 25 Aug 2025 18:18:10 +0000 (UTC)
Received: from mlperfr9.3-rocky.novalocal (localhost [IPv6:::1])
	by mlperfr9.3-rocky.novalocal (Postfix) with ESMTP id 16D9DA0ACF57;
	Mon, 25 Aug 2025 18:18:06 +0000 (UTC)
From: Cloud User <rajeevm@hpe.com>
To: yukuai1@huaweicloud.com, ming.lei@redhat.com, hch@infradead.org,
        yukuai3@huawei.com, rajeevm@hpe.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
Date: Mon, 25 Aug 2025 18:17:58 +0000
Message-ID: <20250825181758.3464556-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <36f30d8d-02fb-4579-b527-16da24cdc856@kernel.dk>
References: <36f30d8d-02fb-4579-b527-16da24cdc856@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE2NSBTYWx0ZWRfX1qp1wAHeU3mP
 QsXGQaCuJXRqrhgvJDOQLydnnlD9PDwlqka6Up4dC/vScNu8j5wiNFAJoHuYi7kJQuODrNiWwIJ
 RcKXV2by4qWqAfARa5UAdmM2BVXscvtKerII2/VkUSf+i2+CdIQxq77USO6u+mHuKzGHzyMkFnd
 Czu8wGGJUHFLv9xTThjEtW/yC5fHafxflUIwy1U2VuJLUulbJFferqXC23sipe0O3upcQEt73f8
 sD1ud7SC57iYT38iy+PO4JeCyA2JlGadrSe6zNSb/vpB9kESYzyKSc7Oy/LMgcVqVNOL/2mVoIx
 JF4kUhsCJDzbjt0XyU2M59c0W3UjLNAlpkSiD1d8m8SgcjJHh++ZqmNInu2w7xJAwOsxU/EnfS9
 jzCoqsVGK1Y4m5fsbmXRrQkHisUfOIV42SidaiG2eENh/MpJ9Yp65IJjisPUy3x/74olsmMg
X-Proofpoint-ORIG-GUID: YUY8DnqQDpVSet8Y-UP2kfDILGX_nflQ
X-Proofpoint-GUID: YUY8DnqQDpVSet8Y-UP2kfDILGX_nflQ
X-Authority-Analysis: v=2.4 cv=a5ow9VSF c=1 sm=1 tr=0 ts=68aca8e4 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=BkdJ9jHThSt66Mx6hGYA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250165



Hi Jens, Kuai,

Thank you for your feedback, and apologies for the delay.

I will send the v5 patch in two parts as before.
The final commit will include the fix you suggested.
Below is the final git diff; the key change is the added ISBLK check.

Best regards,
Rajeev Mishra

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1b6ee91f8eb9..1e81620c0c72 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -137,20 +137,33 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
 static int max_part;
 static int part_shift;
 
-static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
+static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 {
+	struct kstat stat;
 	loff_t loopsize;
+	int ret;
 
-	/* Compute loopsize in bytes */
-	loopsize = i_size_read(file->f_mapping->host);
-	if (offset > 0)
-		loopsize -= offset;
+	/*
+	 * Get the accurate file size. This provides better results than
+	 * cached inode data, particularly for network filesystems where
+	 * metadata may be stale.
+	 */
+	if (S_ISBLK(file->f_inode->i_mode)) {
+		loopsize = i_size_read(file->f_mapping->host);
+	} else {
+		ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
+		if (ret)
+		      return 0;
+		loopsize = stat.size;
+	}
+
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
@@ -158,11 +171,6 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
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
@@ -569,7 +577,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	error = -EINVAL;
 
 	/* size of the new backing store needs to be the same */
-	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
+	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, old_file))
 		goto out_err;
 
 	/*
@@ -1063,7 +1071,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-	size = get_loop_size(lo, file);
+	size = lo_calculate_size(lo, file);
 	loop_set_size(lo, size);
 
 	/* Order wrt reading lo_state in loop_validate_file(). */
@@ -1255,8 +1263,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	if (!err && size_changed) {
-		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
-					   lo->lo_backing_file);
+		loff_t new_size = lo_calculate_size(lo, lo->lo_backing_file);
 		loop_set_size(lo, new_size);
 	}
 out_unlock:
@@ -1399,7 +1406,7 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	size = get_loop_size(lo, lo->lo_backing_file);
+	size = lo_calculate_size(lo, lo->lo_backing_file);
 	loop_set_size(lo, size);
 
 	return 0;
