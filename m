Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0364187FEC
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447327; cv=none; b=Gn8oY81eYGffvWBYl3tMd68juFWMDB0bbpr+sJv/Xv6a+KXSni0fCwm04IQkqkyDhsA27sJ5uIfOwLe/62XQeeXiE7fInHUUjH+Y+m/BLxg/Zf2zH4fnwA3khN0/0sBE7jvbOjbboJIvRSqOQat+m033suPgfkvLDA1Rj3Qd2iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447327; c=relaxed/simple;
	bh=VeoBS2h/DHvja8EHuk54E5aBfLpf132auAbgUYthzw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIZY9HPqvZYiARklcFm9ec5nNB664i3MmGw1/0IAK8MHXYkIk+siHY9Ze8POpKKQoD/63MHWaqfkCYatvLgPyUFpgtrLP2v8GyJKzbG9FAib6YRE9laqLRXiOxLU+c80bnVbq6fbOp8GZJTNmgJ9x2uk2acaWkDPnYqU5DspvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OQj02f3H; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OQj02f3H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737447325; x=1768983325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VeoBS2h/DHvja8EHuk54E5aBfLpf132auAbgUYthzw0=;
  b=OQj02f3HQLsWs4S8FkT9ejMfkl1hMd1qZsJkgA/WTxKb3GBOEfFxABxw
   rbNdS3PLOim3Hb3F8Ftv/h54L34v5GBIY2zBicE+HTf7SuNPXK9Weojth
   58d8ujYw7Alzvm8M8Um7JznkZwmrpztSVM349MpHRF16TJhlih75LvVT1
   QAIKVkO9kxVV93KmWykFoaLyWSO3S//L7mSsxR98UJKwlh2iJ8+YNY3kS
   luiqzpDVNEQGgd4fnlZq+0vrKReoFVDN4jqji/dZp0QvtvKrnsC5EE0dO
   2Lp7dUZCm3IsidIEgzN+MWBAhUK5J8nEtkAzc8zQFmGgXVg0PP4OMdbla
   Q==;
X-CSE-ConnectionGUID: lWS7x49sQVqNGjyy625MyQ==
X-CSE-MsgGUID: /nS0ZBNrQVG8iprzUilJ3Q==
X-IronPort-AV: E=Sophos;i="6.13,221,1732550400"; 
   d="scan'208";a="36182066"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2025 16:15:19 +0800
IronPort-SDR: 678f4a01_37GAWv776PeZDVapfIRib8ICWCiMmcdrsiUIkGWFADnp8gV
 ruzAeif8U4Fb2uUkDqPu0NZ5U/ilw/PLYlMJ6Mw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2025 23:17:22 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jan 2025 00:15:18 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v4 0/5] null_blk: improve write failure simulation
Date: Tue, 21 Jan 2025 17:15:12 +0900
Message-ID: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, null_blk has 'badblocks' parameter to simulate IO failures
for broken blocks. This helps checking if userland tools can handle IO
failures. However, this badblocks feature has two differences from the
IO failures on real storage devices. Firstly, when write operations fail
for the badblocks, null_blk does not write any data, while real storage
devices sometimes do partial data write. Secondly, null_blk always make
write operations fail for the specified badblocks, while real storage
devices can recover the bad blocks so that next write operations can
succeed after failure. Hence, real storage devices are required to check
if userland tools support such partial writes or bad blocks recovery.

This series improves write failure simulation by null_blk to allow
checking userland tools without real storage devices. The first patch
is a preparation to make new feature addition simpler. The second patch
introduces the 'badblocks_once' parameter to simulate bad blocks
recovery. The third patch fixes a bug, and the fourth patch adds a
function argument to prepare for the fifth patch. The fifth patch adds
the partial IO support and introduces the 'badblocks_partial_io'
parameter.

Changes from v3:
* 4th patch: Renamed null_handle_rq() to null_handle_data_transfer()
* 5th patch: Improved comments of null_handle_badblocks()
* Added Reviewed-by tags

Changes from v2:
* 1st patch: Reflected comments on the list
* 2nd patch: Moved the 4th patch in v2 series to 2nd
             Reduced if-block nest level
* 3rd patch: Added to fix zone resource management bug
* 4th patch: Added to prepare for the next patch
* 5th patch: Rewritten to care zone resource management
             Introduced badblocks_patial_io parameter

Changes from v1:
* Added the first patch which avoids the long, multi-line features string

Shin'ichiro Kawasaki (5):
  null_blk: generate null_blk configfs features string
  null_blk: introduce badblocks_once parameter
  null_blk: fix zone resource management for badblocks
  null_blk: pass transfer size to null_handle_rq()
  null_blk: do partial IO for bad blocks

 drivers/block/null_blk/main.c     | 164 +++++++++++++++++++-----------
 drivers/block/null_blk/null_blk.h |   6 ++
 drivers/block/null_blk/zoned.c    |  20 +++-
 3 files changed, 129 insertions(+), 61 deletions(-)

-- 
2.47.0

