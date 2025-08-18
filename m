Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8F3314A5;
	Mon, 18 Aug 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542951; cv=none; b=J5ZO9ZGp0084L3d9RHuboUzPf0eM/Uktskw9AO9gRh1dk9KsImsP6+XWQ87Yv8HG+kJvFzvRTvo8/iV7Gz/GNekgjHjqVYqr7BZchnKfkljP2ItNjjVc7o0xp2uuiuYBH7GkBvVBc2DTdyzOFWLv5owQLa02CV1Cey1IjhWupcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542951; c=relaxed/simple;
	bh=58T/05imWQvD6p4dHOS/FRvkCp+AM46+vB/3ZcTxmFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgkx3LCBjcukQTHIGmdDqSUO0XmBFWOk8pKa9yh7iUqFo1xXjPQEMkgEPArNxn/D3CS/7l3GYMsipka+WuSEYaTl9HszQzxM2pacH7+nwTHSUq9Fya7kYzzcg5THGT3MDYDCSBCTB7jaztdCr8Ai3wHGsQs1RQLNAwtaJgIvH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Apg2F4g2; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Apg2F4g2"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IB6s5I027362;
	Mon, 18 Aug 2025 18:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=Knk53XSodiWJU
	cWSw7daHPGmi3QSj2S5WbMAwpKSJxA=; b=Apg2F4g2mhdNo4MQnrVgkJDDfYz8y
	Kr8pGmcl7vFFLw6KKxZiDnnWWZutZvWE3bno7TZeoq7R+2stuDeWqH/fpyt3kVub
	phsHstzA4Xnr0qrjTzB2gp4sL5V72Om4hSr03Ct5kuS43NbUrUz/FYJ6mBm6Cjju
	xySHBwer72pkvcuZ/45ElNIYwgnrKSGGqSescQJnOJUGFRK3bA4P68/pTf+iPWXi
	KyG6q/AntTaxFYw4HAQJmqWm8Ed+4QKT2kQrjqMUjS80axSlJh2MLL5R/SEdIIqP
	MU1k7SSt3sXPRE6HNuHCPJWZIR+JIbtbESvRowumo600aMwsFQOjgL6qg==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48jkd3jxxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 18:48:46 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 5FFF5130D8;
	Mon, 18 Aug 2025 18:48:45 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 1E7B2883B90F; Mon, 18 Aug 2025 18:48:27 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v4 1/2] loop: Consolidate size calculation logic into lo_calculate_size()
Date: Mon, 18 Aug 2025 18:48:20 +0000
Message-ID: <20250818184821.115033-2-rajeevm@hpe.com>
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
X-Authority-Analysis: v=2.4 cv=TOxFS0la c=1 sm=1 tr=0 ts=68a3758e cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=SlmTxP4Kr1pQ6mi-SkUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3NSBTYWx0ZWRfX7baZ+xeJerkT
 ie/fsvnLxRqZXXfnGEYcWOj/Q/15p57B89VJxqaK4nCusu2rymv1Md3OHIbCx7/D9Q/5EGcPv8B
 /0asxZrPePEAWcVJaTiL+hOsc5bZQZfSxXc4Sd8uivzB3IzCMH9aRwDjiTRdQ9Qoo38FqWwiqC7
 ucS+JjaLenmcrtSZ7ugMk3HScDMCogeMYhv3/nw8Ha6ZZHRL/brLC9yaSUwwqnDs+pG5xvxKCuM
 I68q3zzxRsVv067CSqrEZMSD5eAfPc08VJlgRVtjaADoBllP/6FQn6Yxd3rJ8JJpqEfgFCjmyCu
 kAVbKyjdnL7Yi1EPInwd0uH8W3fWuFKIyP//WOUAnpS9Ix87eC119SPTzUCb9G/ChygkT1RZG9x
 JoRQuFWbCZLqqpp741cs1S+ZtqUk4CFTFOA6d5zRkb+OGgeacWqhbrEqmVe3DOx3AcjLnKl0
X-Proofpoint-GUID: jOfvX6Omv3se0TizggLo8_qzfIpsnMMz
X-Proofpoint-ORIG-GUID: jOfvX6Omv3se0TizggLo8_qzfIpsnMMz
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508180175

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
2.43.7

