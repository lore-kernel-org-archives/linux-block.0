Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65B450F2
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818632; cv=none; b=Wv73bZry7xTtqRzkzYhJ8ZuGQgHNx1/PivhbHyU0P4ooKdrcsjx8t0a6sUka0HCNLikADdFWyPxzeofbaciXYHWFR11Liq2Z4aLytE4P5tdAYcjfItVCbezIQQ1+KDW5bkmCS1/jCB+7TrDcSThfWuVwwt7pPBYkBYy2qJcJJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818632; c=relaxed/simple;
	bh=PDj67Fv7CBvZc78I7RRUIl5oyUv0NdaTnY0EWNfx6+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+xel/yo2zfd5EYy2eYP/t5xr4+SpDWDYpInkLSQ4Hb5X+4rg9QPxqpPLWkP1zcV+Z8wqWsViGm4h+Z1BLftynErlVjLgP8bpKhn8OBtHDCl3tK4VeUbg7vOD+tuEy2wQ5HZyoLF1fNvF/PowVyd3jd/m73SiYLrUGw3a4V8gPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OXpKZL4R; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OXpKZL4R"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818631; x=1803354631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PDj67Fv7CBvZc78I7RRUIl5oyUv0NdaTnY0EWNfx6+Y=;
  b=OXpKZL4RALIbGr1rdbeqT9ZM3omVCcYLuZGaF2N3qXlBDfGynuoTYVM2
   t/v5Yz2tZ3/9jh17eItvLJMfIY3k76wQWskncvhhdgOgiN+EO+F7wXgPG
   q6NUyLReAqvV94X+kpJiC9sPKaAbzpoqgIhee9dZFezuxOQdRpoRJkl9l
   VnMHPEYRsrFauSe2VcoO5yBAH6J4WTbH+NlSmug6Gm9NeJ63Vho3uoLPH
   F8QcezbV5Mz6enWea48uJQANhHBA+8gOJhVacCoaVvRr7NdZFBUDDYi02
   2SuAlJC3V6R0SlJmaI72muteIywx94+EFwZAd2K6N8SxrWkvnEFHcu6Es
   Q==;
X-CSE-ConnectionGUID: 7JZVjLfDQOeDfomxp8jjqg==
X-CSE-MsgGUID: MOQrgbQbQpCVzacX8kdeog==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="141205347"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:25 +0800
IronPort-SDR: 699bce81_zArBMrdu14IRD0C2DdLG38VSHHD/Od1iy2oDq7qxW/P9P5e
 OiohEGXP2EmVBPgADaO+1fHwkNu0B3r3dQE551w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:25 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:25 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] fix module unload failures
Date: Mon, 23 Feb 2026 12:50:20 +0900
Message-ID: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the recent commit 7c3ad92d3d8f ("check: check reference count for
modprobe --remove --wait success case"), the test case nvme/060 started
printing the error message below:

  modprobe with --wait option succeeded but still nvmet has references

This error indicates that the nvmet modules failed to unload as
expected. While the root cause has existed for a long time, the trigger
commit exposed the problem. I took a look in the failure, and observed
the failure scenario as follows:

- The failure occurs when the test case is executed multiple times for
  different transport types. At the first step, nvme/060 is executed for
  the loop transport. Although nvme/060 was not designed to run for this
  transport type, its requirement check leaves two modules loaded: nvmet
  and nvme-loop.

- At the second step, when nvme/060 is executed for the rdma transport,
  the helper function _setup_nvmet() loads the nvmet-rdma module for
  testing. After the test completes, the helper function
  _cleanup_nvmet() attempts to unload the nvmet-rdma and nvmet modules.
  While it succeeds to unload the nvmet-rdma module, it fails to unload
  the nvmet module because the nvme-loop module is still using the nvmet
  module. Hence the error message.

From these observations, I identified two problems below.

1) The requirement check for the loop transport left the nvmet and nvme-
   loop modules loaded and it affected the following test. In the
   current implementation, the helper function _unload_modules() is
   called once, only after nvme/060 has been executed for all specified
   transport types. Instead, _unload_modules() should be called after
   each run of test test case for every transport. This ensures that the
   modules loaded for the requirement check are unloaded.

2) When _setup_nvmet() does not load the nvmet module, there is no need
   for _cleanup_nvmet() to attempts to unload it. _cleanup_nvmet()
   should unload a module only if it was loaded by _setup_nvmet().

This series addresses these two problems. The first patch fixes the
first problem. The other two patches fix the second problem.


Shin'ichiro Kawasaki (3):
  check: call _unload_modules for each test run
  common/rc: introduce _load_module()
  common/nvme: unload nvme modules only when loaded

 check       | 15 ++++++++++++---
 common/nvme | 14 ++++----------
 common/rc   | 12 ++++++++++++
 3 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.53.0

