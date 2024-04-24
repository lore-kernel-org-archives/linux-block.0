Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE85158A20
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945611; cv=none; b=Qxu1RI5LEmVbe5Rw9vLR6/fSNKa96cyfD0kAXCNCy2n1/4GqGg1zsX8ZBPmPtSQ5dO8vnH1/QvuNDyL87vm2PrPL2k44Xvb9ERzwlDD+oyTtyMYI7IyX+Oi1k7iudUHwj/tOO5c37iW8jRJ68sPjivRlsAJ9QlAAjoeD1Z0DVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945611; c=relaxed/simple;
	bh=tGY6fd0PKJRJ+c573V4B+/BeY3ESXX4f9SxgBT516LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbPljayLZ29CrkIxwfq/Xrh++1LqhMza+BWkp6Rv09nfI9q3kPanCf5ZMk25AFdPjLHjxKuHOZpKvwiSKr3YrpSjkjj6S04fTTx6m04BY450k+uhYwFydjdI8Hdrgv1wU3RvNNH7naXrOwpsII0aYuQbEJsKbZA2pU5shdWsppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=W5hbvpYm; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W5hbvpYm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945610; x=1745481610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGY6fd0PKJRJ+c573V4B+/BeY3ESXX4f9SxgBT516LY=;
  b=W5hbvpYmbYZhV/Nu1P0m265gTocpdAMZ7Cyqq11HGM3IxtSg1VUO1RFH
   JvbRuFDeC0xbjADAEaCeGOeqyi8naH6kHR0yNeHPR72RAIOE0U01XOE+T
   KpI6LDs/kkkDvngphxijbcdjNUzmhV8N1UUDTEyjiPV4zZCpbtJZVpphr
   N7bg0Qwu+QcQiZuDRpAuKC36nN5mPKa1T+hBabjJKY8P0VUcCWUpBqcwc
   xoztD564pn+KXKhkQc3PDut0bbnyZ7w2PwXzyQRdXVFObBq3NleWu1IcM
   oKoagVdk6qh/6nL70aIr+zL/FiP7dCoU7oA9xlkCJijWVLaGPcfHMOB9B
   w==;
X-CSE-ConnectionGUID: ugb9lnoLR8e7jT6xze7asg==
X-CSE-MsgGUID: 1Kaud65ETCSeKpvtldswIw==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515700"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:05 +0800
IronPort-SDR: tq7xn2DDSpkGDJnkekyDJX/ChNU3xf/NZ9x6oOUeb3dMcCsBytqiXwmMkvpqw6O5cqn2Gg6ede
 5sGRcuP90nUuNTNMLpxOUN1DUZXLmQqdNxOSUG625MOQFTxgNX2fqrOXtj/pspu89GOgGPpnek
 33q0vzXXqbj+uuoTHnPAYPqlFey3rbMr9b8vq7f8BS5Abr4b06qdZK7RZC4Z8S1sBD2sYwuI8g
 lMvQqUS5gKPP6/ElXKhb0KJeJ2VBPNsM+S1IWYFrA8D9o3/Ep/at1ifrOA9kN8AVhbovaOJGN4
 KgU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:15 -0700
IronPort-SDR: 1GChv3wADjXNeXIlpYLQmCSm5xc5biJkfcbVcALA+mSe4B1ZFgsvHGu7izbaS5LxuCouLHTWnW
 vpKyqoL0tF84N5ukoaaqJTJLUe718pZ5TKmNuh9x1eZa98/5WyYvbM1/MdmL4zpMiRdwaduf8F
 ASdfV11LsQ4q71SAYQng2RDLFmMe0dA3U1opq7XxpTW10KOUwIC+sO0lbzLlM6yGEQE8Ue8mUF
 vL1swgm2pP8g2ClQlkcEnP82GHqMxD/OJTM6+Gy+RhFAkFyl5GIfQ6ZEW6I0JtK0oDkU2z0/MG
 V9E=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:04 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 08/15] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Wed, 24 Apr 2024 16:59:48 +0900
Message-ID: <20240424075955.3604997-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the test cases in nvme test group do the exact same test for two
blkdev types: device type and file type. Except for this difference, the
test cases are pure duplication. It is desired to avoid the duplication.
When the duplication is avoided, it is required to control which
condition to run the test.
    
To avoid the duplication and also to allow the blkdev type control,
introduce a new configuration parameter NVMET_BLKDEV_TYPES. This
parameter specifies which blkdev type to setup for the tests. It can
take one of the blkdev types. Or it can take both types, which is the
default. When both types are specified, the test cases are repeated
twice to cover the types.
    
Also add the helper function _set_nvme_trtype_and_nvmet_blkdev_type().
It sets up nvmet_blkdev_type variable for each test case run from
NVMET_BLKDEV_TYPES. It also sets nvme_trtype from NVMET_TRTYPES.

When NVMET_BLKDEV_TYPES and NVMET_TRTYPES are set as follows, the test
case with _set_nvme_trtype_and_nvmet_blkdev_type in set_condition() hook
is called 2 x 3 = 6 times.

  NVMET_BLKDEV_TYPES="device file"
  NVMET_TRTYPES="loop rdma tcp"

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/rc                  | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 571ee04..64aff7c 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -108,6 +108,11 @@ The NVMe tests can be additionally parameterized via environment variables.
   tests are repeated to cover all of the transports specified.
   This parameter had an old name 'nvme_trtype'. The old name is still usable,
   but not recommended.
+- NVMET_BLKDEV_TYPES: 'device', 'file'
+  Set up NVME target backends with the specified block device type. Multiple
+  block device types can be listed with separating spaces. In this case, the
+  tests are repeated to cover all of the block device types specified. Default
+  value is "device file".
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec54609..a31690d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -22,6 +22,7 @@ _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
 _NVMET_TRTYPES_is_valid() {
 	local type
@@ -54,6 +55,27 @@ _set_nvme_trtype() {
 	COND_DESC="nvmet tr=${nvme_trtype}"
 }
 
+_set_nvme_trtype_and_nvmet_blkdev_type() {
+	local index=$1
+	local bd_index tr_index
+	local -a blkdev_types
+	local -a trtypes
+
+	read -r -a blkdev_types <<< "$NVMET_BLKDEV_TYPES"
+	read -r -a trtypes <<< "$NVMET_TRTYPES"
+
+	if [[ -z $index ]]; then
+		echo $(( ${#trtypes[@]} * ${#blkdev_types[@]} ))
+		return
+	fi
+
+	bd_index=$((index / ${#trtypes[@]}))
+	tr_index=$((index % ${#trtypes[@]}))
+	nvmet_blkdev_type=${blkdev_types[bd_index]}
+	nvme_trtype=${trtypes[tr_index]}
+	COND_DESC="nvmet bd=${nvmet_blkdev_type} tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
-- 
2.44.0

