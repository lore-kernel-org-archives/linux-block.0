Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA915383C
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121398; cv=none; b=LY9tsx34XYX8G6PRPmLwikSc8VMMyrqH3GwyOKqtb1ElHu70YcYp08GKxWlZsw5rd1v53jvWy4a5/7gIO0UZ8bb6c1st4TOHr3d09Cnc7ofgZmNSfP9bj9StAT//Ss6R/0u64GGqLcHc7YDzk0UcFoToKSm0/cuYN2JzrGI2gFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121398; c=relaxed/simple;
	bh=b61QRsKrcyExfiUBHDKOh55337NzNl3Y5uiFW5WtyZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rus4HvCMU4sFMnG9rtsBx5qBH9xNRtLyCJIY0oCVZAo6XdFU6Kz8p8HF3/1euasloJg40ePcm/P1APiPT0r/sLvrEKBYfJHKmxJh9+eitCCu2U4+BLWYcV/tSozxKoflZeBYdZRlEtv2iKo6DQ5ljHbh/hZDl9s8z9yTnRaAil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d9JKBjb1; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d9JKBjb1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735121396; x=1766657396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b61QRsKrcyExfiUBHDKOh55337NzNl3Y5uiFW5WtyZc=;
  b=d9JKBjb1RO0e1U07zCeoYksiA0m6Ut0/ZAf/9hnrBWLyFd+X+sSQ9QkK
   5T2DwLTMzsv2E/EMS1BQqG7Ve3pe9i/FM2xYnC9lYWJrzImRT7BgH9VwX
   R3VFJSLtpCBOgphvs7ZnpsdR+8NmSscLXWstLNJKHbtGiuOZU1XV5FszO
   lopqJ6tME1vuTylEUxxDSoRVW/4m2bNwNk40E7jfEt0qAmlUY3AIfSmrx
   5+UzVNL/9L0tEslmILa/cv9/gdHP4tae0Snt6WfW71kX067HXZF0aEdX8
   PudQPIz0PkFvfa64rcFmP35oJo47e3FC3abcUybL9tTPzhPAE0G3u1xRx
   A==;
X-CSE-ConnectionGUID: Aa6g6D0YS8uf4+iKdhBuzA==
X-CSE-MsgGUID: 3aRH9wTiRw6xhrPDoOGocg==
X-IronPort-AV: E=Sophos;i="6.12,263,1728921600"; 
   d="scan'208";a="35812593"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2024 18:09:50 +0800
IronPort-SDR: 676bcc7a_93FJN2GLxUyUi2RG4oLIEB/9ZjPfgIQF4bOzXQEQXH0Helk
 6cBvT32F6Pjop/jfuLQyEb2gwOOBHm9mQmdraew==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2024 01:12:27 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2024 02:09:49 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v2 0/4] null_blk: improve write failure simulation
Date: Wed, 25 Dec 2024 19:09:45 +0900
Message-ID: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, null_blk has 'badblocks' attribute to simulate IO failures
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
is a preparation to make new feature addition simpler. The second and
the third patches add partial IO support. The last patch introduces
'badblocks_once' attribute to simulate bad blocks recovery.

Changes from v1:
* Added the first patch which avoids the long, multi-line features string

Shin'ichiro Kawasaki (4):
  null_blk: generate null_blk configfs features string
  null_blk: do partial IO for bad blocks
  null_blk: move write pointers for partial writes
  null_blk: introduce badblocks_once parameter

 drivers/block/null_blk/main.c     | 135 ++++++++++++++++++++----------
 drivers/block/null_blk/null_blk.h |   7 ++
 drivers/block/null_blk/zoned.c    |  10 +++
 3 files changed, 110 insertions(+), 42 deletions(-)

-- 
2.47.0

