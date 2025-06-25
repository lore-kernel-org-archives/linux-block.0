Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4525BF03
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851911; cv=none; b=KlWnDSD9bGfJ3HjvifR3abLtkby/1UqQKUzGAZY+ki8MnURBmfd4VUJwNE5oTUmS0LQahaoytN6I94h02q5V/jJ8eFrvOLtlr9pW43xet2bY3odyLbIZZ18OsojiWjLCK5Ls4NXROYIgUADzGrVY8hp8cUv0icNJmenouSSjrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851911; c=relaxed/simple;
	bh=K5K8ZEZmhAzuvLd2wh8Qk1d7AMXq5iNFkaxq4bqNNnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmK2SGly0y1NRHVCsZmc9LdwyDaOH+kZeA3GI+L7C3ZF1jTtq87KtwUf9fUQJhTVMQaajzWownOzTTj4eTwCltZWyW6XBjzTRH1jcWQhM0dzyi+nW61jM4Zlt7JX+40I4yzfD0zeU4uP4aTzyP4YxeUn5oC6rJ/m84czQc2cV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=okN97f4H; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="okN97f4H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851908; x=1782387908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5K8ZEZmhAzuvLd2wh8Qk1d7AMXq5iNFkaxq4bqNNnE=;
  b=okN97f4HQt5DTbfRWDdWnqoxx3BkTyC02Z3ql6aKpfSrTGuvsEwAfreI
   Y79s+AweBgqnH09cfsQaQaTyqJpl6lvNCmipBNOS3EtKpvbrFQD7ngAef
   3DNzqlpryZe7JCh5ukPLSKXlAJhvk4Pn3icxBUPFU94bPrBNHwIyJ9kJI
   +YmxP2FcuL8CkKKiVL/DQwPuMvwHLAAoTRgzlV3gwAB+7n9gcOCn0Nl01
   lhj8kOei+go6Dyg63YDt2ddgWi7gWhTbFuno8laCbatlosSCqRzPydA7T
   Ze4AVCNKjleTnep4Rkm+qPSyX/v564NobGSqHXpyu2VNn4LCa6IVTFZxC
   g==;
X-CSE-ConnectionGUID: N3bMRiWsTaGyhTOnF8abwQ==
X-CSE-MsgGUID: 4b8fvKAQTq+2xunfRCXxew==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85207166"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:45:07 +0800
IronPort-SDR: 685bd2c3_g/2heO5phcVssx32++9CgwmtZGX2OmDMUVPuKmuFsqG3wOK
 WMLoP6MRvE1qhMqBuowoZAeMuBx6MuXYTnpRrYQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2025 03:43:15 -0700
WDCIronportException: Internal
Received: from 5cg2075g47.ad.shared (HELO shinmob.wdc.com) ([10.224.173.209])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2025 04:45:06 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] nvme/{034,035}: skip when the test target namespace has metadata
Date: Wed, 25 Jun 2025 20:45:04 +0900
Message-ID: <20250625114505.532610-2-shinichiro.kawasaki@wdc.com>
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

According to the comment in nvmet_passthru_override_id_ns() in the
kernel code drivers/nvme/target/passthru.c, "Presently the NVMEof target
code does not support sending metadata, so we must disable it here".
Because of this limitation, when TEST_DEV namespace has the format with
metadata, the passthru target namespaces created in the test cases
nvme/034 and nvme/035 have zero capacity. This makes I/Os fail and the
test cases fail.

To avoid the failures, skip the test cases when TEST_DEV has metadata.
For that purpose, introduce the function _test_dev_has_no_metadata(),
which checks the sysfs attribute metadata_bytes.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/034 | 1 +
 tests/nvme/035 | 1 +
 tests/nvme/rc  | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/tests/nvme/034 b/tests/nvme/034
index a4c5e97..aa6fda3 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -16,6 +16,7 @@ requires() {
 
 device_requires() {
 	_require_test_dev_is_not_nvme_multipath
+	_test_dev_has_no_metadata
 }
 
 set_conditions() {
diff --git a/tests/nvme/035 b/tests/nvme/035
index 71039ad..9eef0d7 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -20,6 +20,7 @@ device_requires() {
 	_require_test_dev_is_not_nvme_multipath
 	_require_test_dev_size "${NVME_IMG_SIZE}"
 	_test_dev_suits_xfs
+	_test_dev_has_no_metadata
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 215a10a..bca28ba 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -161,6 +161,14 @@ _test_dev_has_metadata() {
 	return 0
 }
 
+_test_dev_has_no_metadata() {
+	if (( $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
+		SKIP_REASONS+=("$TEST_DEV has metadata")
+		return 1
+	fi
+	return 0
+}
+
 _test_dev_disables_extended_lba() {
 	local flbas
 
-- 
2.49.0

