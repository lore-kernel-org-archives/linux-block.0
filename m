Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C281C84DE;
	Mon, 25 Aug 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160308; cv=none; b=px6tujXkSyvG36rk3fF7g6h3vcKVI1w0/1pBMAxoq6tgNfmAJGimyXhamNZYjaqSVPAg2dbXRpHqLQLuznq+05Js3AilxsF3XH0Mtg+PzG2vPWFwa9zcmOOTinOIjOQZNvXRR6aL0tKfqPWznGqwFFXCxSqz3Hu0HoHXcJgvsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160308; c=relaxed/simple;
	bh=fgGQOOWVARkkIjm5wTMdHiPYH1a5XCvYTl2XfgU3g80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTB/o5eh5NJBXk6nLzEW/ByDoptHEz9CLFGskt85wNMiRj1vDgyAJ4KIGKdFGPHiWi7POHOiXsPIRyTNguM5tfolWCL72shSSrun+yk63AqsUVS5gxK5jG9iH0Cjr95HYpn2aE2EGtJKbDtu2Wc9vFUCLb4KCb8zlS5AHI+msig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=PvgbxLOq; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="PvgbxLOq"
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFWUYj027811;
	Mon, 25 Aug 2025 22:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=y0jfYyJPpP/lB
	UWf5CDgdWNGC/ezlsyrYqn6pCpecQk=; b=PvgbxLOqhgl3QjcgRKq+mmalnVHAq
	1kMCTm1H+0PgJ4I185NPM9X1+WhQtOlCKTwC2oOXrxhTysWlUKlpEgVETeRQ+ah7
	5Fgnn+3RO1PbWz7isU03X1Vu4lox76NERs2iZQgGPr6qSvr8HpfBPSdEHRC/Aq3S
	stYK3lZIpjxw+DiJI/vk38HEdgXo/oMkey98qVt2KCOs0sjzP0ZkXOWB/8qv0yqn
	I0KdO7eyOBxyvDvzW8aQD+DPww/zS55GAdL7I4t3ppF63JDF0LiOdD4u/US4WOvj
	PaXkKmDQOw8JuTHYVHbivw7bm/hlih2fuRvfkrH5qeDCFIImrwHfL95mg==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48qucxmkrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 22:18:01 +0000 (GMT)
Received: from mlperfr9.3-rocky.novalocal (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 35F88132D7;
	Mon, 25 Aug 2025 22:18:00 +0000 (UTC)
Received: from mlperfr9.3-rocky.novalocal (localhost [127.0.0.1])
	by mlperfr9.3-rocky.novalocal (Postfix) with ESMTPS id EB5B7A0A40A3;
	Mon, 25 Aug 2025 22:17:49 +0000 (UTC)
Received: (from rocky@localhost)
	by mlperfr9.3-rocky.novalocal (8.16.1/8.16.1/Submit) id 57PMHnu13714508;
	Mon, 25 Aug 2025 22:17:49 GMT
From: Cloud User <rajeevm@hpe.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, hch@infradead.org,
        yukuai3@huawei.com, rajeevm@hpe.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: [PATCH 1/2] loop: Rename and merge get_size/get_loop_size to lo_calculate_size
Date: Mon, 25 Aug 2025 22:17:40 +0000
Message-ID: <20250825221741.3714488-2-rajeevm@hpe.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825221741.3714488-1-rajeevm@hpe.com>
References: <20250825221741.3714488-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CvoqliveRvD6br3Pxty96OCykQM3mGYV
X-Authority-Analysis: v=2.4 cv=Melsu4/f c=1 sm=1 tr=0 ts=68ace119 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=SlmTxP4Kr1pQ6mi-SkUA:9
X-Proofpoint-ORIG-GUID: CvoqliveRvD6br3Pxty96OCykQM3mGYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDIwMSBTYWx0ZWRfX1yfkjjvEtf/b
 eGgOsRZLTZ3kiQ6JiaGxAciNT9dnJGGb+Z3UD1k5U9VkU0itz+lB7hKLrkFFK9I7zsIMfD4YR40
 NprP8NX5gGDb0q5UvIxYOlujoIiBbWYP6VKBhxbxz4e7XZhJ6L+UbUeGDUClOZuHWo5Xzr7ZaYO
 8VII6e3fGs+0kOgJAIdj/21lYHVFiM7liKYzK9OkHVmFJOinY680f4hBbTbI6rD63IF2ub6l5fS
 rYNrIa6f5/u4DUjkDQ+wOR3jfZoXWUj0JGkdkYBvSLZhmI/pVmUKI0BRaDk0BxOMRcED/eal/IQ
 oMYDnpsj1TErSgYxTcZhWt2HCUfenSTN4CorUdpRFS0Bf4vZlmbChvpZuBlNGKwPjKRXs4NX8ZK
 yCccTtRoNLYe3XmxdNpkYuJ9acKDMljmHayEJ1WwQn3fU2oCdau/S4/FCTF0J3gFvTBF7KKy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508250201

From: Rajeev Mishra <rajeevm@hpe.com>

Renamed get_size to lo_calculate_size and merged the logic from
get_size and get_loop_size into a single function.
Updated all callers to use lo_calculate_size

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
2.47.3

