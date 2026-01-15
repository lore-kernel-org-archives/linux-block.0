Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57E30BBBF
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468265; cv=none; b=g85jBl6I5ZjqxzpYN5qjTGUhfnlay7eIIwvRzD6jbP3FQFOVxigCPs27a9v468qCOsapSapXgeHUhKQAIUFHzHbN4p2p6wA1rwBNoytE2v8hvJ28cZs5EUx6eTFKMpxUYt+xVWH+7LtJIs7O01NvscZvmBnb1syAN27muiVNgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468265; c=relaxed/simple;
	bh=mgqMlLFrrjCirlG8KN3wiXu9EpNS4EH0OsbI72ARyHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElUP8Dvmep/ColpHvM7QRRZUyA1vO75t/V5FyASdWZGCgy2MoNrwoZc6LAwgfD2nwAJAGrfGEMYwuFRpxsT5dbXgz7qQY44RTkxHcaI74dgOPpFpldBuwOYX69vFiaX7RUKAv0Ir215K5MRVhZ0m/OS7kWL4zy0NjVLkJqdpSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KZo/mkTS; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KZo/mkTS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768468264; x=1800004264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mgqMlLFrrjCirlG8KN3wiXu9EpNS4EH0OsbI72ARyHY=;
  b=KZo/mkTS/PsxfLhPqChVTmK9Eud36902m4Ho1HZt0xbTEw3qZJoNXKwS
   TMuuL7xzriDBFN77Sl0TzSmFcnQt8WDV8iFC22mftLxmNKllrZvYXjSxL
   FDUrHsP02moXdIadkjpcqEQk/s+dT9RWGcDXM7qO8SUOUYJ/9n2IM55up
   MGHgW3u72TkHRQpivzsa9UZ/V8CtgiDgmGL6ijUPB8xGbH+kiSCNvPPjH
   dkCh/U4akuw+cWLQWdfm4VnWR0BHfRdyI96fxk2NBiZ+LIdOrKMZ3VFNr
   nOhQtqLmKuJFZpYYxeFnhy+Y2eueJ61El7G2bBmCrADhgXDelzoreCGJz
   Q==;
X-CSE-ConnectionGUID: lRz2Vok9Q96ORSJs/p6/KA==
X-CSE-MsgGUID: z1IswAY7Tuq0wSpckcUwbg==
X-IronPort-AV: E=Sophos;i="6.21,226,1763395200"; 
   d="scan'208";a="138836168"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2026 17:11:03 +0800
IronPort-SDR: 6968af27_IDscoq4oF7stI8PKdSCvOdZQWlZ6FvNRoKrjMNvYJnNXzo4
 w7jQr0r0cC+e3YTrvh679/BrRqL4B25V0xDa0pQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2026 01:11:04 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2026 01:11:03 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v7 0/3] replace module removal with patient module removal
Date: Thu, 15 Jan 2026 18:10:58 +0900
Message-ID: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series was originally authored by Luis Chamberlain [0][1]. I
reworked and post it as this series.

[0] https://lore.kernel.org/all/20221220235324.1445248-2-mcgrof@kernel.org/T/#u
[1] https://lore.kernel.org/linux-block/20251126171102.3663957-1-mcgrof@kernel.org/

Original cover letter:

We now have the modprobe --wait upstream so use that if available.

The patient module remover addresses race conditions where module removal
can fail due to userspace temporarily bumping the refcount (e.g., via
blkdev_open() calls). If your version of kmod supports modprobe --wait,
we use that. Otherwise we implement our own patient module remover.

* Changes from v6
- 1st patch: dropped the hank to replace two _unload_module() calls in srp/rc
- 2nd patch: modified to keep _unload_module() as it is

* Changes from v5
- Dropped the 2nd patch
- 1st patch: replaced _unload_module() calls in srp/rc

* Changes from v4
- 1st patch: moved the new functions from "common/rc" to "check"
- 1st patch: reflected comments by Bart
- 2nd patch: moved the srp/rc hunk from the 1st patch
- Added the 3rd and the 4th patches

Luis Chamberlain (1):
  check,common,srp/rc: replace module removal with patient module
    removal

Shin'ichiro Kawasaki (2):
  check: reimplement _unload_modules() with _patient_rmmod()
  check: check reference count for modprobe --remove --wait success case

 check                      | 128 ++++++++++++++++++++++++++++++++++++-
 common/multipath-over-rdma |  10 +--
 common/null_blk            |   5 +-
 common/nvme                |   8 +--
 common/scsi_debug          |  12 +---
 tests/srp/rc               |   4 +-
 6 files changed, 140 insertions(+), 27 deletions(-)

-- 
2.52.0

