Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628A17A303
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043965; cv=none; b=rM4pWAkQ5ll1xMrPF8S3Fn5XGJ9uHZYY7Nosbn43cLHdFhY/Rg5VZsGTsvf+FpNgOEWrhWlfX9z92mdO+UWCmrLdZ2lcCukJPb1+wDygGWHgPuJdocDUvtRk5LPYERWmBomjvz8LqmlPhKdnZWQrB4t8H9fnE66539vQsnEpevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043965; c=relaxed/simple;
	bh=E4mfNQthHurkvEU9zeiVjaQwAmL9QIoXGPuCAIxQ+iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXfaHwgFP3jAHTg6EeaaJnjmKapRuKix81YQxUJV4gweZ94Gh8Y+G0PcqshQOhmJ7BUD9MOS/Al86UrBwUvJ4pZwF3Z6YdM6cOAewc+qGHTIrzOI1NXgtsXJJ+2BhI4J7qAv11mIC1ZhIDkwpvzZJ1dMFJ0fzLRBmcZRj0AFF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PrT4Judz; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PrT4Judz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785043967; x=1816579967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E4mfNQthHurkvEU9zeiVjaQwAmL9QIoXGPuCAIxQ+iI=;
  b=PrT4JudzT7sYzQrx3REEvlY5vS8HQWVHMr0L+NLh11Qh2Ro7a86Z3Ymx
   76Pr2f13nR7pOlInsXlEl88sba9fQaHVIESKTqMlShFTH9oSFW8OHo+HX
   WbVnkd+tIBNiwriKBRhB0KBtolBU8NiGqx6GR4rZA/ZJz1Ig/HRWWNjco
   LkuAYv5xdLSQnXYiPD8K4jhHIdkW9IOd7YZaGK8nb2OfvKQ7niGZkqE2z
   q069zSf5dotNYu4K9ca2lbL+O7tXEznGoJYv5ng1KeECdQfjiVwiqY/UI
   3ONd30rKw5QkWc/jIHWRAPicmAfZzcDE5aj3dhwRmPTF8uGIxIp2iKVrr
   A==;
X-CSE-ConnectionGUID: 9mBiNnrURvCRc127wk+sog==
X-CSE-MsgGUID: BiWs9cQGSpaIXcMV+G9V7Q==
X-IronPort-AV: E=Sophos;i="6.25,185,1779120000"; 
   d="scan'208";a="150242806"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2026 13:32:41 +0800
X-CSE-ConnectionGUID: +Q4fs6MjTJuRehNrAFZnaA==
X-CSE-MsgGUID: 5MiU3xQeTfGVM3oAG958rA==
IronPort-SDR: 6a659bd8_hefK/MpQfP0b+9eq29Od2TR2MJjCaYsBhQ67XMW7XdblmZ3
 SWgeSD+r1IVS1zVLFay9RUvFPJjZZUl1eXstn0Q==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2026 22:32:08 -0700
X-CSE-ConnectionGUID: Dcej5zzYQW6/jQXvPXn/zA==
X-CSE-MsgGUID: N6dAJwXHSrijE7c56fzzdg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 25 Jul 2026 22:32:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] test and handle concurrent IO scheduler switching
Date: Sun, 26 Jul 2026 14:32:04 +0900
Message-ID: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until the recent kernel commit 4ff58d6bc9dd ("block: serialize elevator
changes for the same queue using a writer lock") concurrent writes to
the sysfs file queue/scheduler caused KASAN failures [1]. The first
patch of this series adds the regression test case for the fix.

After the kernel commit, writes to the file queue/scheduler can return
-EBUSY. This is rare but can happen when udevd writes to the file at
exactly the same timing as blktests test cases, and it results in
unexpected test failures. The other two patches in this series handle
-EBUSY and avoid the failures.

[1] https://lore.kernel.org/linux-block/20260626004221.711326-1-shinichiro.kawasaki@wdc.com/

Shin'ichiro Kawasaki (3):
  block: add test for concurrent IO scheduler switching
  check: introduce _write_queue_sched() to repeat queue/scheduler writes
  common, block/{015,020,021,027,040}, zbd/012: use _write_queue_sched()

 check                      | 24 ++++++++++++++++++-
 common/dm                  |  2 +-
 common/multipath-over-rdma |  2 +-
 common/rc                  |  5 +---
 tests/block/015            |  2 +-
 tests/block/020            |  2 +-
 tests/block/021            |  2 +-
 tests/block/027            |  2 +-
 tests/block/040            |  3 +--
 tests/block/045            | 49 ++++++++++++++++++++++++++++++++++++++
 tests/block/045.out        |  2 ++
 tests/zbd/012              |  2 +-
 12 files changed, 83 insertions(+), 14 deletions(-)
 create mode 100755 tests/block/045
 create mode 100644 tests/block/045.out

-- 
2.54.0

