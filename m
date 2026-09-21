Received: from mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32DE390987
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979896; cv=none; b=YZBg/6ECauujgTqBEgzYcE+vDXTFB+C2mb5IMe0ReNdgAD8BVvuB7lmxMvhEozzZ8jGuy+wpSw0mYPKwIj//QYkSyd69L3LXhcOoE/Lba+vY0bAG99yMfPMw8BEppVecc4I1+jX7fVeeR1uWm5AOFWDpYQbIStfRTpCibebEheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979896; c=relaxed/simple;
	bh=DIJ7cgApn0K70wpDhKxctu+FTAf8hiJPt+G9sqtwaG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skegG1ctxApK1H9EfLBRMxVEE0fJDuWHQGNaSuYafavsR1ww+wQtUKfhVfK1r/jmvja/j/xGY41ilDrZsVj7uyLm9k/PI6LgC/UANCKmxYhlm88Gpoc71qC7aujaJoNQ3YK5CDLZ3pQZPvO5aO6LJTlMGKvPXxCmP2xBpGpQiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRoccNxk; arc=none smtp.client-ip=95.215.58.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRoccNxk"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DIJ7cgApn0K70wpDhKxctu+FTAf8hiJPt+G9sqtwaG4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979891; v=1; x=1790584691;
 b=pRoccNxkS2OUoRDeN0e29rvPMV+Sj1w56a3tNWcQFuWgiYpeIkNRoLjeTJ6ns1E8s0cG05JM
 kPjN/uvFfkAZyrcFHIDrXpM2jVdH4tScPanwb3pIE6KPf2nyutwX1PCvcgRz6Whgj2oG/TyFosO
 8wi2NArAEh290CQgb7zdTY4Q=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 5dd44f618b7d12b2;
	Mon, 21 Sep 2026 08:38:11 +0000
X-Mizu-Trace-ID: 5dd44f618b7d12b2
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 0/4] fix NVMe multipath partition diskstats
Date: Mon, 21 Sep 2026 09:37:48 +0100
Message-ID: <20260921083752.1154316-1-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Currently the NVMe multipath partition diskstats are not maintained.
This is because the functionality to update the diskstats only updates
for the whole disk (and not per partition).

As an example:
$ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
...
$ more /proc/diskstats | grep nvme1
 259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
 259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
 259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0

Notice how all values are 0 for nvme1n1p1.

This series addresses that problem by first updating the gendisk code to
create the partition table for hidden disks, as suggested by Keith.

This is done by cloning the partition table from the multipath disk.

Secondly the NVMe multipath functionality to handle the diskstats is
modified to handle the gendisk partition, by looking up this partition
from the per-path disk partition.

Difference to v3:
- Add block device operation disk changed CB

Difference to v2:
- don't scan per-path disk, and clone from multipath disk instead

John Garry (4):
  block: support cloning partitions
  block: don't show partition diskstats for GENHD_FL_HIDDEN
  nvme-multipath: clone head disk partitions to per-path disks
  nvme-multipath: fix diskstats for partitions

 block/genhd.c                 |  3 +-
 block/partitions/core.c       | 43 ++++++++++++++++++
 drivers/nvme/host/multipath.c | 83 ++++++++++++++++++++++++++++++-----
 include/linux/blkdev.h        |  2 +
 4 files changed, 120 insertions(+), 11 deletions(-)

-- 
2.43.0

