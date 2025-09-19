Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5702F4A1F
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276691; cv=none; b=KP8GLq9dou6lBMqTgMSqxc3apldtgzPj0vgDPZF/gjSUvEfxRm+M5iycAjCYa55MEdVQ9CC6WgwTl/sJwgb9H7QW5+9wDyrWEICf9qnRXvK9kwXRObFqerywyPfxs2bLGZizmTQIyTUXrKDfbGN20MWwtPUSNQXu3rgjvl1+U7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276691; c=relaxed/simple;
	bh=cth8tC4sym6Tceon1BuDXNXqztm7EhsKI0VksILhRFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=V+ESNadHelOa5L/kwjvZw9HMtqUdnxTxOE96XwowxOT5La4CnUo5Iykf0HEQHnydgzRXAWt8xg6Xils2kKUcNFXarBe9j/tN6/fK6X/QASNWXpc1C1yeIbnpt0dU3+Y5AuHaXboVpW7ZNdVF8CEIzQhV6SaLvVczR9U3Vceb+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jF6S/lh3; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jF6S/lh3"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250919101121epoutp02f9b18acadc787dccd42e218e2836356b~mp1NvYqaH0413504135epoutp023
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:11:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250919101121epoutp02f9b18acadc787dccd42e218e2836356b~mp1NvYqaH0413504135epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758276681;
	bh=ytWexLwnaXxOaZLNDjvFncvdbUCUgUOmUAzSymAMMM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jF6S/lh3yOknETXZw62uxNejyy+RgxqHUFZEKZxD91Si+qEV/+UZrh4xcZoGS+DX0
	 MAC/EV0WoR0bJ0P1/l92Cx3G3ixzpd+vCZN8yp+cXSbrP9qp/hd4tzUSODB7gujCjJ
	 quiYqQEc8MptUTVVxWc35Il4/FO+KOIk2oSiH6cs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250919101121epcas5p2e1adb1e257f79c464e4bbcd982bd5d6a~mp1Nd8jVM0172301723epcas5p2p;
	Fri, 19 Sep 2025 10:11:21 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cSpF40cL5z2SSKf; Fri, 19 Sep
	2025 10:11:20 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250919101119epcas5p2dd1f96167b7d39ae98087898a19b6a76~mp1LyvWG10189501895epcas5p2Z;
	Fri, 19 Sep 2025 10:11:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250919101117epsmtip15584ceb4e3a3e906a6898f1a28921aa1~mp1J0UZ6V0186901869epsmtip1b;
	Fri, 19 Sep 2025 10:11:16 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [blktests v2 1/2] common/nvme: move NVMe helper checks out of
 tests/nvme/rc
Date: Fri, 19 Sep 2025 15:40:27 +0530
Message-Id: <20250919101028.14245-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250919101028.14245-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250919101119epcas5p2dd1f96167b7d39ae98087898a19b6a76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250919101119epcas5p2dd1f96167b7d39ae98087898a19b6a76
References: <20250919101028.14245-1-anuj20.g@samsung.com>
	<CGME20250919101119epcas5p2dd1f96167b7d39ae98087898a19b6a76@epcas5p2.samsung.com>

Move some of the NVMe capability helpers from tests/nvme/rc to
common/nvme/ so they can be sourced from tests outside the nvme/ group
(e.g. tests/block). No functional changes.

Suggested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 common/nvme   | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc | 41 -----------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/common/nvme b/common/nvme
index 8de41fa..e893f29 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1102,3 +1102,44 @@ _nvmet_target_cleanup() {
 		_cleanup_blkdev
 	fi
 }
+
+_require_test_dev_is_nvme() {
+	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
+		SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
+		return 1
+	fi
+	return 0
+}
+
+_test_dev_has_metadata() {
+	if [ ! -e "${TEST_DEV_SYSFS}/metadata_bytes" ] || \
+		   (( ! $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
+		SKIP_REASONS+=("$TEST_DEV does not have metadata")
+		return 1
+	fi
+	return 0
+}
+
+_test_dev_has_no_metadata() {
+	if [ -e "${TEST_DEV_SYSFS}/metadata_bytes" ] &&
+		   (( $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
+		SKIP_REASONS+=("$TEST_DEV has metadata")
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
diff --git a/tests/nvme/rc b/tests/nvme/rc
index a1a4ce2..23c6c51 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -129,14 +129,6 @@ group_device_requires() {
 	_require_test_dev_is_nvme
 }
 
-_require_test_dev_is_nvme() {
-	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
-		SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
-		return 1
-	fi
-	return 0
-}
-
 _require_test_dev_is_nvme_pci() {
 	if [[ ! "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ devices/pci ]]; then
 		SKIP_REASONS+=("$TEST_DEV is not a PCI NVMe device")
@@ -165,39 +157,6 @@ _require_test_dev_support_sed() {
 	return 1
 }
 
-_test_dev_has_metadata() {
-	if [ ! -e "${TEST_DEV_SYSFS}/metadata_bytes" ] || \
-		   (( ! $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
-		SKIP_REASONS+=("$TEST_DEV does not have metadata")
-		return 1
-	fi
-	return 0
-}
-
-_test_dev_has_no_metadata() {
-	if [ -e "${TEST_DEV_SYSFS}/metadata_bytes" ] &&
-		   (( $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
-		SKIP_REASONS+=("$TEST_DEV has metadata")
-		return 1
-	fi
-	return 0
-}
-
-_test_dev_disables_extended_lba() {
-	local flbas
-
-	if ! flbas=$(nvme id-ns "$TEST_DEV" | grep flbas | \
-			     sed --quiet 's/.*: \(.*\)/\1/p'); then
-		SKIP_REASONS+=("$TEST_DEV does not have namespace flbas field")
-		return 1
-	fi
-	if (( flbas & 0x10 )); then
-		SKIP_REASONS+=("$TEST_DEV enables NVME_NS_FLBAS_META_EXT")
-		return 1
-	fi
-	return 0
-}
-
 _require_nvme_test_img_size() {
 	local require_sz_mb
 	local nvme_img_size_mb
-- 
2.25.1

