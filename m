Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD01D5CC9
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775799034; cv=none; b=fZwZbhrPBIDJyzpug5mfZ6Ib1P1MWkzMLaXUfudGiAjHvLCQWyBHxq/zHmJD+FhVN9n2X8WYzVA+HjXf+t6elWY3mPJKpjp3TavTASWj+3amV9lRdXg3C/Rke4T3mD2VbegG2nzI3RbPC1R6lhE3uiUPZMEP/UfCQdUkf1nX2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775799034; c=relaxed/simple;
	bh=0kHRCkKR7w5qCs7SPG64TzR5yrr/Dh+Q6UR8sGjPAk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTBkyEfweyIdAJWJfnl/7t/kmxihc/uVgVq39gWFC8bd+BhnoggxyRme6veqo2K1ghLyL0SmftO0JcO4qySpZ7A2ZKpByB1uURTaSk9rdzp9jVqu4AcMMu8Jl+cvk1AiS4XgozkHW/UwPovbCMF8oF1Jn1FV/D7zIuUQLpFO3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TZ5PSNj0; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TZ5PSNj0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1775799033; x=1807335033;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0kHRCkKR7w5qCs7SPG64TzR5yrr/Dh+Q6UR8sGjPAk8=;
  b=TZ5PSNj0JYjiPcGdWLtDAZYYdBBvrQOk/9omco6/n0IGC4r4z5UgIhsH
   zqsXliW7g+B9yQcTzvfq3vTYd5ad+DCnb9GNUCxNnebjLaAhkYOu36CAa
   f1CpjZzemQ8t+JQ9z6oKGI8NcwR9p3IJm0Nu41mpsz+SJpKcZVdzSfvaY
   mWI+tzCpmqlQIScTyV5xyTzdxq/4oTo7hQ6aMs5nWlDT7qwXdRxxPNp5g
   kL+9D2I4v8y3EVCH3CT2OUtX+HKM2nVvYJ/b5HDSOHn4WXTLxqVWzQ1iC
   PG6EyY1kQZ/e/OPr03GTOzcmDYehnJyTDFxScyobg4mc4iXdkeN2cRt35
   A==;
X-CSE-ConnectionGUID: TGVDGGyCSze/DKOyTmOwCQ==
X-CSE-MsgGUID: j9oAmYQMQs+748YCskhu4Q==
X-IronPort-AV: E=Sophos;i="6.23,171,1770566400"; 
   d="scan'208";a="144259547"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2026 13:30:27 +0800
IronPort-SDR: 69d88ae9_BhZiNXIu0VuGI2XnKXSpYvKpmqXru+1roLIwod0ONPFk3X7
 R8Xtrs8zPcX5XZ66dAAl2qtbwdlnxFKTBI94nRQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2026 22:30:17 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Apr 2026 22:30:17 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/1] common/scsi_debug: use _patient_rmmod() to unload scsi_debug
Date: Fri, 10 Apr 2026 14:30:16 +0900
Message-ID: <20260410053016.4013504-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper _have_scsi_debug_group_number_stats() loads and unloads
scsi_debug to check parameters of scsi_debug. However, the unload is too
soon after the load, then it often fails. To avoid such unload failures,
use _patient_rmmod() to unload scsi_debug.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://github.com/linux-blktests/blktests/issues/241
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/scsi_debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index 6aa7420..86ea3f4 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -57,7 +57,7 @@ _have_scsi_debug_group_number_stats() {
 		SKIP_REASONS+=("scsi_debug does not support group number statistics")
 		ret=1
 	fi
-	modprobe -qr scsi_debug >&/dev/null
+	_patient_rmmod scsi_debug >&/dev/null
 	return ${ret}
 }
 
-- 
2.49.0

