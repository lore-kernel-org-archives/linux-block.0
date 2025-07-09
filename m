Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908682D8368
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061639; cv=none; b=l99Q8A0oGCrqbJcDAK2oUfpAgkuUT4O/QTk7fEz/HnetyvqFn18H/rIDD60/flqURt8wXzvGp8N95N72N/8dRfDaNPHbY3PqtirW4Mw2NTrrhBGb5+z2KHqfRztY8K8WmYOeFKcIy0P3S5sw5QoIq8J8esE4jBi5yScMsKnd9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061639; c=relaxed/simple;
	bh=yPrZyp6L0EDubHFT9+G8MgFYTqOrCUtEep8UOVwyPzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDZFVP3ho5F9nuzRi/U/MkgbzSTexFvTbfXH+GiXEjDtt1pVAN3zlbiqydsmJgFYeeuwm576vCOQbvZlU2tUmFBAwPAMOjLF3pP/X1CibLQAxp3l+Gvsymp85x9EBL0wSTCRYXl5qtAH+Wr2dKPhYT8zg1+yf+QvjlMkzV6DX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YONin1+B; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YONin1+B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752061637; x=1783597637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yPrZyp6L0EDubHFT9+G8MgFYTqOrCUtEep8UOVwyPzw=;
  b=YONin1+Bh41Xg0mW+Qjyn/4lrf8Yl6CMFdOBRcygTiFQ9XA8cyeS6Tr/
   dm783uaPcOB3f+kSXOK2jIfrWBBAwxPN+lkrTxGA95TDA9lNd384vYo88
   Gk3eWprnVFkxEOEhxMo00+xWGhm67udCbbkV6eCb1Z9lnb+Ozjr7teLK8
   O1q5pcheSDouWrO/TdCSj6o0t/yDW1BtmjwhM1m5YY7+pvJCnqZWbfp5O
   /QBpZikY13dE8tIjXPUl2Te/WCsToFlxaSmaT2aTkVnfGkkA8gGqox2In
   SM7i7Ja+kWUBAGln1B8pSWHgXcgy81B3GmoW8ywXCm6ZQtx/yUyttfRwZ
   w==;
X-CSE-ConnectionGUID: 7bHZrereRx+Qes5IGMYJ5Q==
X-CSE-MsgGUID: vjiTwvJUSmCzVCl3nbDMjg==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="91096340"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 19:47:11 +0800
IronPort-SDR: 686e4828_HEe/Vk9N/JOLkbK4Gd9fMCDQezE1aYrArKQrUPfo17zmqh4
 OSdCb//ux3sm+i4f1doEWlog5gql7ZxOTldjUgA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 03:44:56 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2025 04:47:10 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] block: add tracepoints for ZBD specific operations 
Date: Wed,  9 Jul 2025 13:46:59 +0200
Message-Id: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tracepoints for operations specific to zoned block devices. 

These tracepoints are also the foundation for adding zoned block device
support to blktrace, which will be sent in a follow up.

But even without the immediate support for ZBD operations in blktrace, these
tracepoints have prooven to be effective in debugging issues with filesystems
on zoned block devices.

Johannes Thumshirn (5):
  blktrace: add zoned block commands to blk_fill_rwbs
  block: split blk_zone_update_request_bio into two functions
  block: add tracepoint for blk_zone_update_request_bio
  block: add tracepoint for blkdev_zone_mgmt
  block: add trace messages to zone write plugging

 block/blk-mq.c               |  6 ++-
 block/blk-zoned.c            | 23 ++++++++++
 block/blk.h                  | 31 ++++++-------
 include/trace/events/block.h | 89 ++++++++++++++++++++++++++++++++++++
 kernel/trace/blktrace.c      | 21 +++++++++
 5 files changed, 151 insertions(+), 19 deletions(-)

-- 
2.50.0

