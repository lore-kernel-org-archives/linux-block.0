Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC76390C80
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331415; cv=none; b=QPq92qvzpc9ung2ScPrhxyku4waATDKZZ1WYJMdO2o1Qu6riMgUXJxB15sUXFzKOiI6F8xH3gsXThog2iskMUtyrtUbT/RMk2RcYk5Q/IrTkdSsb2/QzIUzD2h3JhHNBSEHtFtj9TA7LUeJnVL0wABWx8oPhczw+GQZyCaCpf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331415; c=relaxed/simple;
	bh=++JLhZpi1xdqCJros8jmtJGqBn5PKbLkhmaFAp924l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4iyutHoLDxnr8NMnPbEQr2GiR7hfhtKPfpsE7GKXLt/du0KmMr92+QAGPQgoUki3DOI5mzACRnn1D1Xnl2t/nnphp3mVt3z5EzCSXof3gsZOkEHX7dNvVtGrbXM9OvXvQ+BI/SJ5RoAGYtZKF7wOfGWKfo1ZbJs2x6svXpKvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VamPnWmA; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VamPnWmA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331413; x=1805867413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=++JLhZpi1xdqCJros8jmtJGqBn5PKbLkhmaFAp924l8=;
  b=VamPnWmA0UGiBEhoNh1waP6M+L0/4RSNTOMJSVbZUqpdcY08h0lGleVL
   R2mX2U24e8nYCclQHKoTrH4y6GzuQxsoQrgSzwSSDjK6z3Q4J+PLr50EN
   FlrsKt1fX4hvqjMPqGD5dfr2dB6uYFMp7C2PTdMkwgdqCilC8MJmPF3Y2
   bc+TWyyp4PG479y176jIpVs9BXmClnAsvicyvb/1Wc34n23YCHPs4OErX
   g6W5lsg8PcYlO5LEFTpDynS8hYc7wV+sc8BskNZA74eNH9EHslQAMllBf
   e3fjpbrfV6dIYiPBT/b25YhqEictpjWC7lOvK8/WUMRfD+aWLBQAqQBCV
   w==;
X-CSE-ConnectionGUID: ccpGwrNwQeCGoUZ84FJYcA==
X-CSE-MsgGUID: zHH09fbrSqmlTz750aqXxg==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614095"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:06 +0800
IronPort-SDR: 69c225fe_2TxZFzklUr4UXWY+a/lSCxHQhD1pdtejC1puHsmjxqNfRnp
 y0Agt3S4S4bH/L96drv20lxxO0GUfArRxU6v9xw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:50 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:51 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/7] Skip tests if scsi_debug module is already loaded and in use
Date: Tue, 24 Mar 2026 14:49:42 +0900
Message-ID: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When blktests users have scsi_debug devices configured for purposes other than
blktests, running blktests currently unloads scsi_debug unconditionally and
breaks the existing setup. To avoid disrupting such configurations, this patch
series improves blktests to check whether the scsi_debug module is already
loaded and in use, and to skip test cases that require scsi_debug in that
situation.

This series was originally proposed as a GitHub Pull Request [1]. Disha Goel and
I worked on the patches. The first four patches fix pre-existing problems found
while working on this series. The fifth patch implements the improvement
described above. The last two patches fix two additional problems that were
found during this work.

[1] https://github.com/linux-blktests/blktests/pull/218

Disha Goel (1):
  Skip tests if scsi_debug module is already loaded and in use

Shin'ichiro Kawasaki (6):
  check: move fallback device handling into
    _check_and_call_test_device()
  check: call _unload_module() after fallback_device_cleanup()
  check: do not create fallback device when other requirements are not
    met
  check: call fallback_device() in the same bash context
  common/scsi_debug: ensure scsi_debug is loadable before loading it
  zbd/012: add missing scsi_debug check

 check             | 84 ++++++++++++++++++++++++-----------------------
 common/scsi_debug | 31 ++++++++++++++---
 tests/block/009   |  2 +-
 tests/block/025   |  2 +-
 tests/block/028   |  2 +-
 tests/block/032   |  2 +-
 tests/loop/004    |  2 +-
 tests/md/002      |  2 +-
 tests/scsi/007    |  2 +-
 tests/scsi/009    |  2 +-
 tests/srp/rc      |  2 +-
 tests/zbd/008     |  2 +-
 tests/zbd/009     |  2 +-
 tests/zbd/010     |  2 +-
 tests/zbd/012     |  1 +
 15 files changed, 83 insertions(+), 57 deletions(-)

-- 
2.49.0

