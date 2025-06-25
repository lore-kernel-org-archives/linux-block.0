Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345A1DE892
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851910; cv=none; b=TtW/TeF+J/Z+HVxBBTKRpKdv2u1TH0i1Ld+p6UwXd92vZcFSwBbZko2c/QOzkKpJlX5E0C7S5GdMFtncknl1sCPBb+RObt0m1JUTTCNeUqOQHUEwCZw+OMajnOJbpJIBd/fvje7SjZs0PRk/9anZ4nFVksioENn93CkKKFvaRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851910; c=relaxed/simple;
	bh=OXwdL5wUZAqT//wh8UKlLgeP78FHgRETbz3LAYMACW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAABEDLZ6AElRnyFhwP8U4x4zfh5mgfxxHUOBpkAXJ5se3+LB2oIT8K5ECvn22HPWDSCktw3DkGxurT5YW+aA92NUov9RV8h05Wa2I+Jc7KX7Q7ocFt0nzoVV/GryqWSYpgG2PUj9LX3jUufo+c0AhIi1dms4LBOtDZxEtVYzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bh7AosbT; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bh7AosbT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851909; x=1782387909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXwdL5wUZAqT//wh8UKlLgeP78FHgRETbz3LAYMACW4=;
  b=bh7AosbT0s0k6Z6daPuzHrRCE5TWiMxPc44fyx6lw3pxlLJ8gEQpzWzf
   2WoG0AQ39GXiuA5QE/PJJB7WSj7aqnG7VeS3cfRXfkZp0fpRkaRuUxKCn
   DwyBdGnNsUpzs6KZZ8hEFwbNZl1uL9Ew2S0AsMsW8CybTARKxKn7+24p2
   645cUoIEx/AGdmOiXCmSsA2lrQndXTuPr59e1XHxBlPnrqnhorqptokhs
   8y0bNVH+ezSMO9RIY1iwnVARyGIufbbHBCd6hKG3Ekdmn7rMYTCEQyM6Z
   2fjtQ/cltniDSsuulC7g2UpDXzrQbQ4LgwvXvGodC9NWeZ1y/B3yL0qAH
   g==;
X-CSE-ConnectionGUID: D59JsS9BQAeTzMdtomQ4lg==
X-CSE-MsgGUID: zLhTrBA2S5qS1m4p8uIANQ==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85207167"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:45:08 +0800
IronPort-SDR: 685bd2c4_Bl2kOk3hL5Us1sR/8EyfBN4sFM1XpcfEki07O8ZYmuB72yt
 g8vhMKOPk6/wLumAe2FBPhYkhX2QxKu9HZQRwUw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2025 03:43:16 -0700
WDCIronportException: Internal
Received: from 5cg2075g47.ad.shared (HELO shinmob.wdc.com) ([10.224.173.209])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2025 04:45:07 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme/049: add fio md_per_io_size option
Date: Wed, 25 Jun 2025 20:45:05 +0900
Message-ID: <20250625114505.532610-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
References: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TEST_DEV namespace has a format with metadata, fio workloads with
io_uring_cmd engine errors out with the message "md_per_io_size should
be at least 64 bytes". To avoid the failure, add the option
--md_per_io_size to the fio workloads.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>
---
 tests/nvme/049 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/nvme/049 b/tests/nvme/049
index 7304d66..70a6d11 100755
--- a/tests/nvme/049
+++ b/tests/nvme/049
@@ -15,6 +15,15 @@ requires() {
 	_have_fio_ver 3 33
 }
 
+metadata_bytes_per_4k_io() {
+	local phys_bs md_bytes
+
+	phys_bs=$(<"${TEST_DEV_SYSFS}"/queue/physical_block_size)
+	md_bytes=$(<"${TEST_DEV_SYSFS}"/metadata_bytes)
+
+	echo $((4096 * md_bytes / phys_bs))
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
@@ -23,6 +32,7 @@ test_device() {
 	local target_size=4096
 	local common_args=()
 	local fio_output
+	local md_io_bytes
 
 	test_dev_bs=$(_min_io "$ngdev")
 	common_args=(
@@ -39,6 +49,9 @@ test_device() {
 		--runtime=2
 	)
 
+	md_io_bytes=$(metadata_bytes_per_4k_io)
+	((md_io_bytes)) && common_args+=(--md_per_io_size="${md_io_bytes}")
+
 	((test_dev_bs > target_size)) && target_size=$test_dev_bs
 
 	# check security permission
-- 
2.49.0

