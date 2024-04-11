Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC01482E4
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833961; cv=none; b=jhswD+hGI5ikUbk4pwTCVL2CeRkXle+zeNlsUxwdopBMBDG8arPnJiYax29vvhHPYh+gn9k97PDTC3oPDXBXg34jd61sA8YMQ+i4VQUnIML0ZcVZxfROUiRQjytC7XPYREAbwR9MqppkF/sUBAUIuK96kX/bz5TR5AU3Q2LwDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833961; c=relaxed/simple;
	bh=0dEVP8079QDShYaAiKf9wK3Q+gWxerIusvSgNLm1mn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Duq90NHfMPqchXqDkdiOcQvL5yjYQxMuvQO+xUC2saWZtbPID9lBFAQIiVR7AmqgCBXj+VzWev+Hy6ajjZLz37aabP+i4EYsT6tUcyDf3cMm5dUmqzxS+l29P0RXD+LSjTehIVq1B8cttPiWdmySB7R7wdefVg2R7oB3kCdUyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bggW3aIH; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bggW3aIH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833960; x=1744369960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dEVP8079QDShYaAiKf9wK3Q+gWxerIusvSgNLm1mn0=;
  b=bggW3aIHmaGRifR066AmU33O4P5m9+eivDewww5K95ZP45J9VzhTh/5m
   b/Zi1FcHhfErDXn/GT2KXd3W/+Vg4dVr/iE/oolwgkRLjEKQ+3dkiPGMM
   eUnt6EIou8Mw2KoDCQJprtHZ8b6L8rcoJm6GAuSgx2tgvzw4HOv7owHzt
   B1FMspv976DtS/x0y8CKoWym19TMrSEu3sdx4nMhGFds8smwaQINsdOxI
   BhskaSH4PmA+RRkaDx2WRj2EQx1oyIrR/44cixwn3K/aj/JXyw2T3hJ4J
   nCObJe5X7+1t0Kub5cdMFK9eU/d91/p6OqH0zGvDC9rcnaPrP9H4ovHSg
   w==;
X-CSE-ConnectionGUID: Q86+GWt5TCeUqr2Exow+ZQ==
X-CSE-MsgGUID: AyLQZ7xtRd+G/kweWKxRtA==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579877"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:36 +0800
IronPort-SDR: bApv/fxB5BzlyOBcNllrvDJ5Io9Lxg2JjKhtgKn/KPMR5VDLuhZnYPDyvYJjqcqcchqkyl6YQL
 XHjqlP1H8jdA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:21 -0700
IronPort-SDR: RoaQMkeK6dYXYX5Q91RFE2NFWnktHdoz9Uwq9S9w8aNWtgVnSBuReyoFEjn9iXC6uQ3YCqq/5p
 DHVU8bNfZqQQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:36 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 07/11] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Thu, 11 Apr 2024 20:12:24 +0900
Message-ID: <20240411111228.2290407-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the test cases in nvme test group do exact same test for two
blkdev types: deice type and file type. Except for this difference, the
test cases are pure duplication. It is desired to avoid the duplication.
When the duplication is avoided, still it is required to control which
condition to run the test.

To avoid the duplication and also to allow the blkdev type control,
introduce a new configuration parameter NVMET_BLKDEV_TYPES. This is an
array to hold default values (device file). Also add the helper function
_set_nvme_trtype_and_nvmet_blkdev_type(). It sets up nvmet_blkdev_type
variable for each test case run from NVMET_BLKDEV_TYPES. It also sets
nvme_trtype from NVMET_TR_TYPES.

When NVMET_BLKDEV_TYPES and NVMET_TR_TYPES are set as follows, the test
case with _set_nvme_trtype_and_nvmet_blkdev_type in set_condition() hook
is called 2 x 3 = 6 times.

  NVMET_BLKDEV_TYPES=(device file)
  NVMET_TR_TYPES=(loop rdma tcp)

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  3 +++
 tests/nvme/rc                  | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ede3a81..ca11f58 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -108,6 +108,9 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
   Run the tests with the given transport. This parameter is still usable but
   replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.
+- NVMET_BLOCK_DEV_TYPES (array)
+  Set up NVME target backends with the specified block device type.
+  Valid elements are 'device' and 'file'. Default value is '(device file)'.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d51f623..c1a14a1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+[[ -z $NVMET_BLKDEV_TYPES ]] && NVMET_BLKDEV_TYPES=(device file)
 
 # Check consistency of NVMET_TR_TYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -51,6 +52,21 @@ _set_nvme_trtype() {
 	COND_DESC="nvmet tr=${nvme_trtype}"
 }
 
+_set_nvme_trtype_and_nvmet_blkdev_type() {
+	local index=$1
+	local bd_index=$((index / ${#NVMET_TR_TYPES[@]}))
+	local tr_index=$((index % ${#NVMET_TR_TYPES[@]}))
+
+	if [[ -z $index ]]; then
+		echo $(( ${#NVMET_BLKDEV_TYPES[@]} * ${#NVMET_TR_TYPES[@]} ))
+		return
+	fi
+
+	nvmet_blkdev_type=${NVMET_BLKDEV_TYPES[bd_index]}
+	nvme_trtype=${NVMET_TR_TYPES[tr_index]}
+	COND_DESC="nvmet bd=${nvmet_blkdev_type} tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
-- 
2.44.0

