Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB251DE4EA
	for <linux-block@vger.kernel.org>; Sat, 25 Jan 2025 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768552; cv=none; b=kfBP6ZOZoBOX1+JD+N8mmJpvgjvt9NTe2v7ZaapnDKZlMkPHFxn6T1KFQ/Ph4EaEKwZte/x8O37W/xLtxp8R7uIdqchmugh3FVQdmbhd92MZaDMiArh+vu/GH8cbBjxQrXrKO3/Eope+Rn2clKnFhBPckSZYThaPVq+0gzAO2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768552; c=relaxed/simple;
	bh=IAs4tz9TAZjxKmr/w3h/EXDqCxy8fntJfmuvyt8iXn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRXlaGpUDVdK+4eUkW3Ies9WgnEUTDUm04Jku2wERw3j4UQZLkpKKugyGvJAbzOG7DRS4HVZhiZ+M3PNpRCMtgS95OCP7+wwcUPNo4f/k3P7JW4hR8dvOozEzjPpa7OhykTW+Duzou8RS8wjXdLWs4h2qpqSfyzAzgRg1TeFaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QwnGPbMM; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QwnGPbMM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737768550; x=1769304550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IAs4tz9TAZjxKmr/w3h/EXDqCxy8fntJfmuvyt8iXn8=;
  b=QwnGPbMMUQWI11gfOvph4god8rsbEf/DB3BWKnNvnku+xa4mWEDzL2ar
   OB4fZO7XwxZj0y5tBOWMACBfW+/o5Ch5HbYdNPkh78XQ32SqqibZ1YN9E
   RtzdwpaPkoh1hCnnmuzH5a1Ci/RcV7qT2k7luTURsrD9KqGFUnJAtIsK6
   MQVc6hWtjJuJ63vHWU2yWmjJwa59BK/L9LfvMRxFPF30jBRKNGw0PLPLC
   D+UqmfYe+dpIX1cLk3MRQI8x7sFGtj2puid1/H9YoR5cvLZpUQBg774b7
   wp9RQzcbsED0PnaEeA1bcQub1YhMYdi7wmeCY27jtp3bBXl+ECdYDoNWS
   g==;
X-CSE-ConnectionGUID: Dv1GrvpyQmSYPv/ceTML4w==
X-CSE-MsgGUID: Byb/4rEWTfW1PYi6kWZnNA==
X-IronPort-AV: E=Sophos;i="6.13,232,1732550400"; 
   d="scan'208";a="37973934"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2025 09:29:09 +0800
IronPort-SDR: 679430cb_E4GYU8XjaEs8pb+KyT+1R1EsT86Iagz8HUnLbWy82gAJ1xE
 r7SpRt6nDs2oYOemDrzhWnyMphlPkV/Ah2VvsUg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2025 16:31:08 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2025 17:29:09 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v5 0/5] null_blk: improve write failure simulation
Date: Sat, 25 Jan 2025 10:29:03 +0900
Message-ID: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
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
recovery. The third and the fourth patches prepare for the fifth patch.
The fifth patch adds the partial IO support and introduces the
'badblocks_partial_io' parameter.

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

