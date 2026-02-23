Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA273491E1
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832481; cv=none; b=FD8PtQIHK79YgHa8esRJF0WvPR6v/2VVmNF5tYcKurFcQI+JKeSKYoA4hvUNG8vPZJja8pZL8+u6bG67cZhzTPSsjyjEyiiV5n9l98ly1wzXzW80VcpIlhSviTAjebZkalKWiA4LEYOM7/+YrXnxCSu7ytf0Focha2x3aduu69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832481; c=relaxed/simple;
	bh=KpQwsZX6wPSc8P/twa9sW5j21j/xglKX+fmhHVd/5UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO63ZDh1Ul3TmzHXihBVV1AyzuFDCDLolM0MKDpin3HtZlQUDq2Pvvd9gAu1VZjhJh9PF5lDnG4jOnsbx+k2gAOF5Qa/icRZwVH7hXtiPo5D7ra6MnQ3GtiBFoz8Ubxj27xdxLOSSsAWdj4w1FLJNYsISq1KP+8VOFmi1yAyV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZF1sXNLk; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZF1sXNLk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832480; x=1803368480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KpQwsZX6wPSc8P/twa9sW5j21j/xglKX+fmhHVd/5UI=;
  b=ZF1sXNLkTKPfSIc0v9QWWU02htBAFjX0iA51CABL4d7vjtUFBXtDOfTa
   1e74toOL+Tm1aa4SRrbj8UHYjChIIuftoOS1NJAyJMiS/02mevrd+uoSH
   LnUtTrS8sHbb8i2f4aYQ9K3tQ8psvyWz1w3Bye0BMtnUzwQ3DkpIK3RGz
   1lJzXRa77/EsAfi/EoeDgJMxBcMWh1zDKXM4KcfwIEFfHU9xOI95DIGOu
   JPB80YVI75SPTCEsFws1eukSLfVAxhfIis5jiKmx+QKkxYWo891FDZuDq
   r79HehaMgmM+BobSx+zmb7maVDjLyn4k1Z0tJruNr6KUvfBQlk5iQBUlf
   A==;
X-CSE-ConnectionGUID: W4o9cEOPQf6yKTmHZDFMow==
X-CSE-MsgGUID: 7gANFyZeR4Kv/iREvL8vAw==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="140846177"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:13 +0800
IronPort-SDR: 699c0499_lgdpmhKKpXXuLcI0KBacnacpMUn7HibKpYhRqcM1evWVceG
 ZNo7eJID4gj+j5tkW6KwgDL2x5/sMCahfywLtog==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:14 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:13 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] common/nvme: do not call 'nvme id-ns' to non-nvme devices
Date: Mon, 23 Feb 2026 16:41:08 +0900
Message-ID: <20260223074110.144758-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case block/041 tests PI metadata capability in the block layer.
At this moment, nvme is the only one block device that supports the
capability. To check that the test target nvme devices fulfills the
requirement, the test case calls 'nvme ns-id' command via
_test_dev_disable_extended_lba(). However, since the test case is in
the block group, TEST_DEVS can specify non-nvme devices. Even though the
test case is skipped by _require_test_dev_is_nvme() check, the
'nvme ns-id' is called for the non-nvme device and fails. It spits out
unnecessary error messages.

To avoid the error message, check if the test device is nvme before
calling 'nvme ns-id'. For the check, factor out a helper function
_test_dev_is_nvme(). While at it, replace short command options -q and
-f with long options --quiet and --canonicalize for readability.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/common/nvme b/common/nvme
index a419cd3..bb4896a 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1121,8 +1121,12 @@ _nvmet_target_cleanup() {
 	fi
 }
 
+_test_dev_is_nvme() {
+	readlink --canonicalize "$TEST_DEV_SYSFS/device" | grep --quiet nvme
+}
+
 _require_test_dev_is_nvme() {
-	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
+	if ! _test_dev_is_nvme; then
 		SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
 		return 1
 	fi
@@ -1150,8 +1154,8 @@ _test_dev_has_no_metadata() {
 _test_dev_disables_extended_lba() {
 	local flbas
 
-	if ! flbas=$(nvme id-ns "$TEST_DEV" | grep flbas | \
-			     sed --quiet 's/.*: \(.*\)/\1/p'); then
+	if ! _test_dev_is_nvme || ! flbas=$(nvme id-ns "$TEST_DEV" | \
+	   grep flbas | sed --quiet 's/.*: \(.*\)/\1/p'); then
 		SKIP_REASONS+=("$TEST_DEV does not have namespace flbas field")
 		return 1
 	fi
-- 
2.53.0

