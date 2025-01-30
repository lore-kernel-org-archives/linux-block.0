Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F01474DA
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225633; cv=none; b=GlzhrWL4UBFWCjh4BASHhkHCauloQLTomEYmywZ8Eu21VI51EyGxdIpPDoJgYiOKkwDfT0PcyXtWIVaNhqYjIzn0S5n1xjxXzJpmsSdcB0dw90vWid09dmOqPhLotUpILhkfuE6Ve3w/0JrepX7NcmeYmEL6Yr/NSpahf242JIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225633; c=relaxed/simple;
	bh=o5uUF57OHCbQZuAJjf/hGqkqrUhfw55bKkKQn3k967Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXyunfv4UCphxceexAc7QJ+ifspt9633O91LM9T8oUah8LV4Tbx4qoenXC4MgnobTnFGmLDKfa76U/HAYFSR4FeLX+Br6/sLUuy4yybtQHFFidC2Wm6FNcrJo7/Co9hI02juLwaNy2FLHf0obIPJBes4w/K5fKjLyxdu8INmlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YRkjI+C2; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YRkjI+C2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738225632; x=1769761632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5uUF57OHCbQZuAJjf/hGqkqrUhfw55bKkKQn3k967Q=;
  b=YRkjI+C2fQULNkm7QmvLKirsPHFb4If+UL/vO+FlCod4QPGYxNYKEcd0
   qXkUKGMnLqH6LfpS02LVytK4ZfUAF2JkDPdfkALSuBuwBGylQIM4ZuG8d
   mARg8sNYTah1o3lVFRdaBrQDlT+BMeHiaU5fRNm22I5RO7Zo/YiqxLoOc
   fsltd1jQyvi6PWMW8z4dyG062jEN5xtL5H3KTCXFlnmq7DcOtKMaCX2Ko
   mEUnLSXgRD6sESp4AQ8e506IxKPDevEf0ZVK5cjTZfRjyQFsKLzRRb5iC
   +NvBEdgZL39ydGY+i0sBNDHoMXxMSRp+2Oq4OZRbLRJa/J2HdK+bCQzKg
   Q==;
X-CSE-ConnectionGUID: HDDZM4FLSVmpiyIepWOYyw==
X-CSE-MsgGUID: UJrJH52yT4CjPTemwAWxgg==
X-IronPort-AV: E=Sophos;i="6.13,244,1732550400"; 
   d="scan'208";a="38377842"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2025 16:27:05 +0800
IronPort-SDR: 679b2a37_ggqZv4PB5q4k8JbXNbwxN//6oaeALpC4i4iM/gRY1E+Useq
 R9TIoRK+7gNgYUpid1C4YN2IbYYqL36uH/vRIrw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2025 23:28:56 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2025 00:27:05 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v6 0/5] null_blk: improve write failure simulation
Date: Thu, 30 Jan 2025 17:26:58 +0900
Message-ID: <20250130082703.1330857-1-shinichiro.kawasaki@wdc.com>
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

