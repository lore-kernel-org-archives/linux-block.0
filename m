Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB9298CC7
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152305; cv=none; b=m0W67vUqQKeAAX1dC1akI8xjaasoSIhslGr8v7ddDqZ1FtrNa10RAQDmQKJ8q/tQ7HPSNZ7PyFo3axZKe2OVcnaU8yE6txvweFRsvCmCpgbjAIMSIf6v49lSA6YHj21toa1TzMJQuhXRJbE0Tc4e3dtLle2x7yXfiHn1CcWevVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152305; c=relaxed/simple;
	bh=aPe0vsx/nGHi1e605HlWuc8sA9ZaHCix4D3MQ39sNAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi9iAQgVvKIj5c1Z6JAOmYbWyt+l3iVNjUpVwjYEDEt8p5482FN73aUD/7aZARqM1TgKTHUY4Nzbl8bGr/ES0/TGo/AhtfqQbKM998jv1SbnRCg0kjxIwpFBHVuSRAcRVwMUghzvqqBiqBvJdlhIAUdWyWFAtxKsBKqC8nefsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rd40Mo6M; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rd40Mo6M"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762152303; x=1793688303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aPe0vsx/nGHi1e605HlWuc8sA9ZaHCix4D3MQ39sNAE=;
  b=rd40Mo6MmdJj5LsKdaPwNzK0zV+Kw0zciXlhGqUAKdb9120BrBCQOQZC
   5hn5MiNxXUIYttABsF8yHWoODYb+02pzyP0HntQU0BBtgDElSCuvjdu1x
   /unCY1vKAlgVAFDIonGlZlfU+84Pl2FaQLJquCsRaLChYakc0uFZ6F/AB
   qAa43FNBrVsM8FYOlWfzh7nSFDniEFDh8bIGr1YWiyJYD+Vdq/RwldUn7
   L/Ya+dk5A8KJzS/eKwWkYW2NL/ia2ZnUwKyMEo1LFMblgq1wnmTcQ9N2u
   e1kgawtqwP2ISqrhLFqKimV0CdGzlgBu/ZF9DYQMnns7ZoduIvM6eHUoS
   A==;
X-CSE-ConnectionGUID: r5GGL+qgTJ6+/Q3+d+0YVg==
X-CSE-MsgGUID: MAqkgWQvQrK5BRfMvCdKDw==
X-IronPort-AV: E=Sophos;i="6.19,275,1754928000"; 
   d="scan'208";a="134391238"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 14:44:57 +0800
IronPort-SDR: 69084f69_OEHEmWtU8oZEg13Ayd/3I4W8Diptg4zYlo1QvWBbiWRQSXI
 pOkUf3QfF6WnM19nUF9mNhX7rCEEQ0g1pYz1dyQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2025 22:44:57 -0800
WDCIronportException: Internal
Received: from wdap-zcgq2z60ds.ad.shared (HELO shinmob.flets-east.jp) ([10.224.109.249])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2025 22:44:57 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/5] throtl/rc,002: adjust to scsi_debug
Date: Mon,  3 Nov 2025 15:44:51 +0900
Message-ID: <20251103064454.724084-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
References: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the test case throtl/002 assumes that the test target device
is null_blk. For null_blk, it is possible to specify the page size as
the maximum I/O size during set up. However, in the case of scsi_debug,
the maximum I/O size is not configurable, causing the test case to fail
when the test case is extended to support scsi_debug.

To prevent the failure, set the maximum I/O size after the test device
is initialized, regardless of the device type. To achieve this, add a
new helper function _throtl_set_max_io_size() which modifies the sysfs
attribute max_sectors_kb to adjust the maximum I/O size for the device.

Suggested-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/throtl/002 | 5 ++++-
 tests/throtl/rc  | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/throtl/002 b/tests/throtl/002
index bed876d..87b9f91 100755
--- a/tests/throtl/002
+++ b/tests/throtl/002
@@ -24,7 +24,10 @@ test() {
 	fi
 
 	io_size_kb=$(($(_throtl_get_max_io_size) * 1024))
-	block_size=$((iops * io_size_kb))
+	if [ "${io_size_kb}" -gt "${page_size}" ]; then
+		_throtl_set_max_io_size $((page_size / 1024))
+	fi
+	block_size=$((iops * page_size))
 
 	_throtl_set_limits wiops="${iops}"
 	_throtl_test_io write "${block_size}" 1
diff --git a/tests/throtl/rc b/tests/throtl/rc
index d20dc94..8c25b1a 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -114,6 +114,10 @@ _throtl_get_max_io_size() {
 	cat "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
 }
 
+_throtl_set_max_io_size() {
+	echo "$1" > "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
+}
+
 _throtl_issue_fs_io() {
 	local path=$1
 	local start_time
-- 
2.51.0

