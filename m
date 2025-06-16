Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D88263C69
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750039649; cv=none; b=VBbqXpK1NuZPxzKinvZTpQ46hXg0DFRqwB1QSkExv0XOiRDPBWyei6Kkyvipw60sni++W8uO8hGAbwv5eDBRvia/IpfR+Ca5p8PBepEwi3RbMlwKZKfwSNPF5xOkkaTYGYwn25DqE3SjPVvk/3GdXSknNB8sieMOw1XAjlFlRmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750039649; c=relaxed/simple;
	bh=6lQZzUKKZqWZs1iFHkbKcVSvNP2oOVBrjY3NE7Z1hSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzqDSSHaTaw6Hj3Lz5gr0xChoxG5NINGnGRyWjT0+Z2FXlbSUxm4pd9mpf/qmVV4VELJBBCMIBrM5MTMRcQ1wQZ6nq9CGDG0IS4l9UhoZXR6dIxx7lipXeatgnZujBba2XitFm2Qs7ZEk9H/gHccpAAFnBHFM+U7mbhZJFTcDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LstgkR69; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LstgkR69"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750039647; x=1781575647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6lQZzUKKZqWZs1iFHkbKcVSvNP2oOVBrjY3NE7Z1hSs=;
  b=LstgkR6944gwRpkwmUMHnx8ZaS4CTXQj/TLhW1VHvTomWujVbV0eGLlY
   O9ug7hq/+Ux3CN6Nhav65nuGtzHrhpCeQmyITrTxuy4ONnGc2n4dLIfv2
   kNHyY1Hxxw1J3GzFUJ/Z08NG4nxIDHGGnUwxAhme0BLOshB/INCQiQnDh
   CTUxDiRvdGmUjzgiDkPBv0smSec30lhP2AyY4mUtZ1PjexOFtV7Idg0FP
   EVKDYVi1iGWOwfp+J9NRMaOlF9ahZhy+N3IxE5fmrgh9tLgy5xKbHcqt3
   NSz0sA4PHZ2Va+ZuDkI5pVtrm9eXF61DKLeKAKx5nZBnujh9L/aE4Fksp
   A==;
X-CSE-ConnectionGUID: gKP2l4/xT2i07knMR8gfyg==
X-CSE-MsgGUID: PzC7kkFyS3CGisClbutiBw==
X-IronPort-AV: E=Sophos;i="6.16,240,1744041600"; 
   d="scan'208";a="84623409"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2025 10:07:19 +0800
IronPort-SDR: 684f6de6_4I/xNZlz6X9JEiKh/IeDCA6IJLqgAaGIkd1TBFHRVN5Y5LW
 znL1EzygMQCQB1xV6SphVd4b27sxjf25SnEf/Qg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2025 18:05:43 -0700
WDCIronportException: Internal
Received: from wdap-do3irrikgj.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.172])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jun 2025 19:07:18 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@meta.com>,
	Keith Busch <kbusch@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] nvme/rc: introduce helper functions to check namespace metadata
Date: Mon, 16 Jun 2025 11:07:15 +0900
Message-ID: <20250616020716.2789576-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
References: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To confirm that the TEST_DEV namespace has metadata area for each LBA or
not, introduce the helper function _test_dev_has_metadata(), which
checks the sysfs attribute metadata_bytes.

Also, to confirm that the metadata is not used as the extended LBA,
introduce the helper function _test_dev_disables_extended_lba(), which
checks the NVME_NS_FLBAS_META_EXT flag in the flbas field.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9dbd1ce..215a10a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -153,6 +153,29 @@ _require_test_dev_is_not_nvme_multipath() {
 	return 0
 }
 
+_test_dev_has_metadata() {
+	if (( ! $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
+		SKIP_REASONS+=("$TEST_DEV does not have metadata")
+		return 1
+	fi
+	return 0
+}
+
+_test_dev_disables_extended_lba() {
+	local flbas
+
+	if ! flbas=$(nvme id-ns "$TEST_DEV" | grep flbas | \
+			     sed --quiet 's/.*: \(.*\)/\1/p'); then
+		SKIP_REASONS+=("$TEST_DEV does not have namespace flbas field")
+		return 1
+	fi
+	if (( flbas & 0x10 )); then
+		SKIP_REASONS+=("$TEST_DEV enables NVME_NS_FLBAS_META_EXT")
+		return 1
+	fi
+	return 0
+}
+
 _require_nvme_test_img_size() {
 	local require_sz_mb
 	local nvme_img_size_mb
-- 
2.49.0

