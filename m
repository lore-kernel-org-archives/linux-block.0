Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E01755C
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810511; cv=none; b=SjXBReVMYaCM5jbdUm+BN2O1NdTK2FyvqYmZYXpBasyN5EsDjgMxgjUcVKDLAqMjB7a7wZGrE6Ew6U7ZAAkmI2HPAv+yNkhhRiueJ9FwRjRa6Y3VE5XfsAfbiE7jaQXIU6udZt/WPmQNiHwT4bhaAJ+nBXeAqYBz1yLOdcDRNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810511; c=relaxed/simple;
	bh=P5q9gL3DmOdRu3GNWoTEQhagzOV4QzL8Rtx94737wF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7UW1AIJbxPGH4GvTHi9yjYEgdwgDWi+EU5NVy5nJS+8gNh40RA1xW98IWcYmkIU/uhc67YfRPr6vRU4hzoMoREUUTDuwVSIa2XXdmC2O9rD/uDGKF2ATW2FwyCqaAf0ORk1cy2ZtTE4f9OtPkkKBF4iQkSoSeYw6/xtABxfuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fZftGRPz; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fZftGRPz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810509; x=1746346509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P5q9gL3DmOdRu3GNWoTEQhagzOV4QzL8Rtx94737wF0=;
  b=fZftGRPzU5roLuKA/dIIEKcqTE8LRQakN3TpYPNw+l6lXUbP8W7aujKv
   8/uErO96/4IBWmLshtvwqA1vAm71LPKjvoU5Jpy0ouEUxZd/vCOLecjVO
   A1o6meoVuMcEXK1XpMAk50ujdv4ctc0HyL3jwqi30NekG0tIzTytahS4+
   X8Ag5uNw3AU9QKAkJ+gfZ1Kb58okN3ZHfhINCbGaJyqBycuwZiWUpk4i7
   2rHNZlCXA/x1h0J1kzw4AhjRfWsl9CPA2e8pOmJkq2TkoTwtNfnXHsAFX
   jmafBN8F8WeQ4SNW+hkWeTPAyCOXBv5E7bAWAPB8G9hT6ozC9dtgDdSl4
   A==;
X-CSE-ConnectionGUID: 60egoB/DRfy36qjNMVjUdw==
X-CSE-MsgGUID: w04omRyaTduPb97jvwULQg==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540348"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:09 +0800
IronPort-SDR: JFqTnlfifxP//rgUIaYo66Iiuu97Cp3psZ//LWM6aVmN/+P3uPoVxS17XlI+HmjGyLTC/pSCBc
 ZNtj5v2C5nJlfGyq/FP2x3j/KuuYE+fW472EnalEZjYiMUBMQ62+uri8nODlMCIgLmFJ4sYdgq
 oIvtZOtB8ZV23+NXZt5Ky5P15jmx1LeCqehl27baccaoGP5emVw1wmxZbOZc5kX8YOFwEluWij
 olBdGuW3/kcIqOWhDuVm9+TXGOnOlO0kGe061ES+gqD2FAGLcjj7eomZ9pyle5wOFioxi035hk
 Ih4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:07 -0700
IronPort-SDR: K+FpRuSxzQ8RzKwVSAclukCTJYrI0z4fPzXf4jwEtUhChsaPqMqqN8h7Sinkg6eHUfNX8qnYLc
 OtlIH7g9gXMd7G2798ifjf6PhCMpqzkzAZAkJLPJSjixuRN1+sszHmCcqOadMm0Seij2n60qZr
 zrTFpRFGcEwmNy080yGkrffv6v7ZSNb4RFoAjdr1gscxvvgewSg1QofUo3je/i2brsoq6QPNL+
 Vxz+MSSHabNXRRFFFvktVUGYTWEoGnT9CmRsMeYy8JGUjHJTIM3Aox87QxX0OqFwl9i7eqU5EU
 dqk=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 16/17] nvme/{rc,016,017}: rename nvme_num_iter to NVME_NUM_ITER
Date: Sat,  4 May 2024 17:14:47 +0900
Message-ID: <20240504081448.1107562-17-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To follow uppercase letter guide of environment variables, rename
nvme_num_iter to NVME_NUM_ITER.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 5 +++--
 tests/nvme/016                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/rc                  | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 736ab48..7bd0885 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -117,8 +117,9 @@ The NVMe tests can be additionally parameterized via environment variables.
   Run the tests with given image size in bytes. 'm', 'M', 'g' and 'G' postfix
   are supported. This parameter had an old name 'nvme_img_size'. The old name
   is still usable, but not recommended.
-- nvme_num_iter: 1000 (default)
-  The number of iterations a test should do.
+- NVME_NUM_ITER: 1000 (default)
+  The number of iterations a test should do. This parameter had an old name
+  'nvme_num_iter'. The old name is still usable, but not recommended.
 
 ### Running nvme-rdma and SRP tests
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index a65cffd..d1fdb35 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -23,7 +23,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${nvme_num_iter}"
+	local iterations="${NVME_NUM_ITER}"
 	local loop_dev
 
 	loop_dev="$(losetup -f)"
diff --git a/tests/nvme/017 b/tests/nvme/017
index 4f14471..114be60 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -23,7 +23,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${nvme_num_iter}"
+	local iterations="${NVME_NUM_ITER}"
 
 	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ef7b966..6fc0020 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -20,7 +20,7 @@ export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
-nvme_num_iter=${nvme_num_iter:-"1000"}
+_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
-- 
2.44.0

