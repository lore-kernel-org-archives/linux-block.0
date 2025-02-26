Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF591DC997
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564379; cv=none; b=tYtzhiRDm7ss1glRgtHgcWpdolK7X9/+HQAH7zuZjJS+VcUoFSRpbVgZvRVXaQoP7OTBWnM/Tj5YhRL3zzJI8p1ZN+Z4VnmZKD7f3zwRNRVr61FtKNFyq1U10VvqgqzC9kiP4NhUYHxuBdk3N7qNGRa2Ju5eIH6IKGPGls9E5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564379; c=relaxed/simple;
	bh=53kULlICvtiDGpfsWDBwk4PmpP7Rmdvquw4+UzSJnhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5xRqW7bsCaAOFJEQJXeljJP7JkLkd/00qyP3tWTuvXrEIUpMmyPckPE5y4sTuUf+rmr7Ad//abnzdobwELzx//pdkhHyfw3ZtUGvpqPP8EB98P9x4UA5Fipcu5J8uJnhSmGjhC/mMlcw/ByQGeCUMDsGVUNcNz2emis+q1SeT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hfQigV0q; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hfQigV0q"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740564377; x=1772100377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=53kULlICvtiDGpfsWDBwk4PmpP7Rmdvquw4+UzSJnhw=;
  b=hfQigV0qXBpql+2Y5g3wDWhrqmWV9RdW82J83FCOHrka6n0fJn4Pj/BI
   lsjM8bUejZihP315bl4czHkkQDgkDpR/OSMFli8y2jtL9Fe0Uvlte5XVj
   /71yGYpOCb/KxAPfLwhn4Rjj2m9fJNc6qKurf8vzIqdW6Ur7ziG6uAShP
   WvBOHWtLAps0OOjoHuRke6VJAUjGCq7R0BMzNIW4ROQ95fppcsFTJi1Or
   76fQybxilSGaZnP75F4KrUwmI8mR2kKU8Xin6gJQ30j3OdPHDsaRBb3Db
   D1aWZ1jRHkpvFKDfC2YTrHE/whOVpygRgusLvNetJSYCcntT8EJ9SwGYQ
   A==;
X-CSE-ConnectionGUID: dylQFGo3T/iNsXrtsNYMfw==
X-CSE-MsgGUID: Sm4gdfoOT5eIYxL1kdo5lg==
X-IronPort-AV: E=Sophos;i="6.13,316,1732550400"; 
   d="scan'208";a="39484492"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 18:06:15 +0800
IronPort-SDR: 67bed9d3_7uImFKbc/zAJwICKTkCkvGtcgQqGaNUibht9LMmRRh2GPSP
 pzK6+3G566eFXLRVF9pZyx/yxRRL2Aw1LC8joxA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2025 01:07:32 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2025 02:06:15 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next v7 0/5] null_blk: improve write failure simulation
Date: Wed, 26 Feb 2025 19:06:08 +0900
Message-ID: <20250226100613.1622564-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens, please consider to apply this series to v6.15/block.

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
recovery. The third and the fourth patches prepare for the fifth patch.
The fifth patch adds the partial IO support and introduces the
'badblocks_partial_io' parameter.

Changes from v6:
* Confirmed the patches can be applied to linux-block/for-next branch
* Added "for-next" tag in the subject

Changes from v5:
* 3rd patch: Improved the commit message per comment on the list
* Added Reviewed-by tags

Changes from v4:
* 3rd patch: Moved null_handle_badblocks() call and rewrote commit message
* Added Reviewed-by tags

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
  null_blk: replace null_process_cmd() call in null_zone_write()
  null_blk: pass transfer size to null_handle_rq()
  null_blk: do partial IO for bad blocks

 drivers/block/null_blk/main.c     | 164 +++++++++++++++++++-----------
 drivers/block/null_blk/null_blk.h |   6 ++
 drivers/block/null_blk/zoned.c    |  20 +++-
 3 files changed, 129 insertions(+), 61 deletions(-)

-- 
2.47.0

