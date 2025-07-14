Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9EEAD7
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503918; cv=none; b=YEDhkaZp0BcnT9yGRq5cYoJCT/RQvOVpwIICbKEUwDC2iY39ok7L8DZMiCZ/23juFdkyJkhvekcW1o6trHkp4WDWchm6LppUCQjZeqwde8iqSdngh0R8NLNd5h9kh2tKBC/qKZh+sit730mUmMBX7A7IyHtV493nQK8ryq3ItnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503918; c=relaxed/simple;
	bh=J6KdONKKuBU+5pQXEWOXVeDT4paHSUSzaYKwudgsk90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pgHpgxMq4DfchqAoYLIIUn08YP3/v0frJNH4DyYlR1T695lwqhGzghk/bvVBz2KCB1PIn4r5PDje8A6Krkwa6Z0rS25U80XCeJCkW++m6LWq7jKcQ4HMLOE1ZXl0fNAGTp0KoM3gfMbclKNgEtzHL4WM65QirMOHbnhfWXYvE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B3wCgCMW; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B3wCgCMW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752503916; x=1784039916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J6KdONKKuBU+5pQXEWOXVeDT4paHSUSzaYKwudgsk90=;
  b=B3wCgCMWYbZ0xtRYqGb1flFlOwYSVV50aQ+hnYJn8LMW50j7W8sOZ73W
   VuOrZMpZ4iu1iP4ZUbCJrIGjoDBVaLjrwLsKjqtn4kh2hHC2Uo1t+ytHn
   g7xXyjFADixeSkXA8D77haiXE6lmjsa3gW9gU3Po27LGO9WtbCUAcUgKK
   4ZZjAf+U9teBZrozFCVsWx6LwBLLcuw2yJd35T86VUJHAsOtN5kaEHQAo
   46P4P4Mqzkv9uyxBmhnno4fBxjml2o8eZ5TJYFBOeRGihXnFnb07MWi9i
   8PILBVCVV2YpMTzU0GmcPW2USV9ehSithNgo9/MOd+v1mEFO690HTum2l
   w==;
X-CSE-ConnectionGUID: rWmCXl2fQMGrGCFFzNkHFw==
X-CSE-MsgGUID: DZi/tO2dTaCz1KdJ+FZdWw==
X-IronPort-AV: E=Sophos;i="6.16,311,1744041600"; 
   d="scan'208";a="86591346"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 22:38:30 +0800
IronPort-SDR: 687507c7_nttO5+XeMnROQ64pJpYbogRG6jgqr8L9sb+84AE0MgrhP+l
 3QAPNg3qyCeBCZOdwZW7UEqn+UbchJh4bbg0uoA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 06:36:07 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2025 07:38:28 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/5] block: add tracepoints for ZBD specific operations
Date: Mon, 14 Jul 2025 16:38:20 +0200
Message-Id: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
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

