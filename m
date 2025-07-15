Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF32D63F1
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580422; cv=none; b=CbdfocJSmsvYLsgmICrVDkUPfT+/PFLBcosMzniGXxq/r+m6TbsEEvQ5uwbDBPhDulV90SHbW885JIm/ciO7L9BPygttOs4aVpz2XH7kR7BAW+lsHe9ax55wiOh7OcHYDa8MU42nwf1VYFIanU29bekbV2aak+LNUrD4GI7WD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580422; c=relaxed/simple;
	bh=VMj9pnyVSXJ79e/VdW9GaN+ZZY4ZnP5tyBgqomXG76s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0/7f5TOqNztygrGnSaB8be5aQo+P5G/YZ3q8TcOaH7cXvnD/7XHMOrcb/pD3P2ol1dahs3b52lA10U2kqdfWgbzwOr8LYMTqF0kNoSM5q2ilSYY7hpiSMwPGJmj0lbu0/iv4xMopq+gwyxGXQe4wUnrdglggMGZbtXNTyQ8Jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JaFb9poX; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JaFb9poX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752580418; x=1784116418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VMj9pnyVSXJ79e/VdW9GaN+ZZY4ZnP5tyBgqomXG76s=;
  b=JaFb9poXN0g/U1dtnpsn4Ri7SO08sN85fmiWIKYI0/Tu3JMCzVdBFxUK
   y9MuwZjjim9UVu9woaUispOHnFY2nmdtzc/iFVAUvch3H0PMzDmT+hK1Z
   Csp/QLtjmEx9mf2zlz4zHle2/fAWBd8ydW/m6nbFpD3+cYK8XmsTi6Snm
   ETM8KC1+1G6z5NcrvrTFgBOGkhBXe6nUeHNoLHEhzO3rTLa0fhinhh5PP
   5ThA5j4Scr5UzL/xqVP2w0zTaFEnxo2kAY3eF9pc6LuGmoY5xewA6XojM
   rzlXsiiUzRA4dCO7flMEI0DrA3w+2lwzQ/tVrBW17Yfd/uYhVsyjoQh4v
   A==;
X-CSE-ConnectionGUID: jw5JnlhvSd+Ma8oNneMpjA==
X-CSE-MsgGUID: xOQ3y3+dQdCV1exL95m81w==
X-IronPort-AV: E=Sophos;i="6.16,313,1744041600"; 
   d="scan'208";a="87768574"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2025 19:53:35 +0800
IronPort-SDR: 6876329f_CHBMjYBUMxIgwwdZuxxGLkwv0KxHaeJbwqZ98Dq4pTK6JrN
 k3pCZ3oZy3JQ8cSyzyzp6xwG3UEd/uSs6XMM7Ag==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 03:51:11 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2025 04:53:35 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/5] block: add tracepoints for ZBD specific operations
Date: Tue, 15 Jul 2025 13:53:19 +0200
Message-Id: <20250715115324.53308-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tracepoints are also the foundation for adding zoned block device
support to blktrace, which will be sent in a follow up.

But even without the immediate support for ZBD operations in blktrace, these
tracepoints have prooven to be effective in debugging issues with filesystems
on zoned block devices.

Changes to v2:
- Fixup commit message (Bart)
- Fixup indentation (Bart)
- s/nr_segs/nr_sectors/ (Bart)
- Collected Reviewd-by's

Link to v1:
https://lore.kernel.org/linux-block/20250714143825.3575-1-johannes.thumshirn@wdc.com

Changes to v1:
- WARN_ON() overflow of rwbs[] array (Bart)
- Use 'ZRA' for REQ_OP_ZONE_RESET_ALL (Damien)
- Use bio_sector() (Damien)

Link to v1:
https://lore.kernel.org/linux-block/20250709114704.70831-1-johannes.thumshirn@wdc.com


Johannes Thumshirn (5):
  blktrace: add zoned block commands to blk_fill_rwbs
  block: split blk_zone_update_request_bio into two functions
  block: add tracepoint for blk_zone_update_request_bio
  block: add tracepoint for blkdev_zone_mgmt
  block: add trace messages to zone write plugging

 block/blk-mq.c               |  6 ++-
 block/blk-zoned.c            | 23 +++++++++
 block/blk.h                  | 31 ++++++------
 include/trace/events/block.h | 91 +++++++++++++++++++++++++++++++++++-
 kernel/trace/blktrace.c      | 25 ++++++++++
 5 files changed, 156 insertions(+), 20 deletions(-)

-- 
2.50.0

