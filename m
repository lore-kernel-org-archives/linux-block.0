Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375218C031;
	Fri, 18 Oct 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238068; cv=none; b=DU/sLaKoLHmBT2QDBG/xxDiAP+H9luUR+t5D4KZ6Ryv5LPD1XC8pJs2MZLtWL664a9V8zOetjzGPir3qPKGmp7xPKwygvWb/kXGm+gWZsBkftZBOMqMdVXWMAsj95ImFl741cKdFck/dFaqNWtpff+rmKHdTQfn3W9WaaIF18o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238068; c=relaxed/simple;
	bh=C3amggeE6f0YWqgreyBQl44LY0xcRHzZJvlc3nAImog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivP698EOMTiKWE2uqNgsHFrpHNF8rAJ8ggR4zL6Go3Doelkc8CSiZQTLv0+llGmVf+qdQzLxQOrx+xrKgVo0p5CgBMmV6/2dXqroi2zb5jGYz3OCNpCNQ1fGyWxYdonwkowP2fZfYelTWQeZnWr2shtXoEacHPv0MnQyuJ/OEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUMpcNcF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUMpcNcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729238067; x=1760774067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C3amggeE6f0YWqgreyBQl44LY0xcRHzZJvlc3nAImog=;
  b=UUMpcNcFaXxbDA2WAQsV0gaQ38+9zZVwPvO2wpwNqUYIJfAsMGi7sLcm
   /kRmUwF+BzV7IZEwqLYN13q+68L4CaAKadgiKwcNPWpiXHP5v+h7iSWDw
   4mLGfnJC/tyQaKh01KJteO8MDgfC3JLgLAVPKp37rB12eR8FeIZ4wxuLw
   EMv4NxXI5WxLj4X4H6rAavA+htW0OsaIgV0nUX0F42elKYJA/dD2X2guO
   J5UA2EhajbEglIXPUTH0eo+iCpQvqc0E4GUiZsBMyXiSL7XI7vfIJdy5m
   Qm6vEzoEMgK1yTK/Qw0S5Cc6EFPg6Fd14Sje98hqqnuHAopPQ6AxUwfLa
   g==;
X-CSE-ConnectionGUID: etixMqv/RDacBSZuuzmDiQ==
X-CSE-MsgGUID: YYKSmS+yS6qISsCZW4kyEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28549554"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28549554"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:54:26 -0700
X-CSE-ConnectionGUID: XTQIMnySQc2MEHKg+RdnDg==
X-CSE-MsgGUID: c5vVUu/2R6mZuBgdQ+o0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79604062"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.169])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:54:23 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/2] blk-mq: add CPU latency limit control
Date: Fri, 18 Oct 2024 10:30:36 +0300
Message-ID: <20241018075416.436916-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Try #2 of the patches here. I sent earlier an RFC version against block/bio
[1], and then an isolated patch for NVMe driver only [2].

After feedback from maintainers, I've reworked the patches again to block
layer, this time to multiqueue support only. Once a blk-mq request is about
to be dispatched to the driver layer, the PM QoS variables for active CPUs
are tweaked based on configuration, and a timeout is launched as a delayed
work that drops the PM QoS limits once the queue is idle. The mechanism is
disabled by default, and only enabled once user activates it via the
provided sysfs knobs.

Some measurement data provided below as a reference for the
results, measured with 'fio' on an Intel Icelake Xeon platform, with an
extra NVMe card on the system. Both latency and bandwidth values are
provided, to showcase that the latency is reduced and bandwidth is not
impacted negatively due to overhead. C6 residency measurement is not
very accurate in my test leading to somewhat glitchy result on its
value (c6%).

key:
  slat: start latency max, in us
  clat: completion latency max, in us
  lat: overall latency max, in us
  bw: min-avg-max bandwidth values
  c6%: c6 (deep idle) residency for the active CPU during the test

cpu_lat_limit_us=10 (enabled)
  slat: 63, clat: 107, lat: 115, bw: 1177-1367-1397, c6%: 11.9
  slat: 30, clat: 129, lat: 137, bw: 1196-1380-1409, c6%: 0.9
  slat: 60, clat: 101, lat: 109, bw: 1193-1372-1407, c6%: 0.9
  slat: 29, clat: 135, lat: 143, bw: 1184-1369-1398, c6%: 1.0
  slat: 29, clat: 112, lat: 120, bw: 1188-1368-1397, c6%: 1.0
cpu_lat_limit_us=-1 (disabled)
  slat: 106, clat: 281, lat: 353, bw: 1183-1363-1403, c6%: 79.9
  slat: 107, clat: 270, lat: 319, bw: 1192-1370-1406, c6%: 79.8
  slat: 156, clat: 269, lat: 323, bw: 1187-1363-1398, c6%: 80.4
  slat: 106, clat: 267, lat: 316, bw: 1183-1367-1402, c6%: 80.5
  slat: 108, clat: 247, lat: 313, bw: 1186-1368-1404, c6%: 80.0
  slat: 107, clat: 274, lat: 323, bw: 1188-1361-1399, c6%: 80.0

-Tero

[1] https://lore.kernel.org/lkml/ZtHWkn2FJhAa+Vvo@fedora/T/
[2] https://lore.kernel.org/lkml/20241004101014.3716006-1-tero.kristo@linux.intel.com/

