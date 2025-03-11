Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA723F374
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689845; cv=none; b=At/TZjQ7qL4z/Esk0UqTC73ExfywYlsJW+jJ6A/lnlox+ofSN2VozlalG+EVkuzGXPON97FEWI4l53vIytdLHAUgVsU8MHhgOFgbneQm/SdKWAVbs9J+Sj0H9j1kdMYJfT0DlNY7jgmB70HTIL+6sxGdpaIbB5jQV3gDohUU6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689845; c=relaxed/simple;
	bh=tOzGi1+oE4i2IJoUxhsL9xdE2CFvuKnrU3TH/IWp1Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNsS7OWnmUUHPjvzCM6yLnbBt7OmYu4kGihu1yqhj8W0E76PoueA6sMc+sskk3EevBBL6oGZSjKaMjTKo+lelA8E+mTgDRd7L33NcBOCS5kVxONjk02wSHscgxh+HisZMV5coIGTGCPT17WClGRC3amJCx+Slw0+yn+hmC2Ce80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IYOaGFx4; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IYOaGFx4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689843; x=1773225843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tOzGi1+oE4i2IJoUxhsL9xdE2CFvuKnrU3TH/IWp1Uw=;
  b=IYOaGFx4nZGvj9CioSJKnPkRJ7+LLlX0cv2SABrLZpxgtrIQuLoZVb+7
   /ktIFc5OXhIVRT5g/otkYhXqwwsumLCxxU8Z++6OZocQzsUPkXCGXuHQ9
   zdhChHbgDMnvwVGduHILk5yGNbFoEpMDF/LGTBVrSwgbgMrv80/0uxQHO
   ECIHnYYr5Y9nhFmc4YS0vEKQnLPLLS5HTtdDk3qqT7k9lSoW3eiv30+XM
   3EUzKC3H8P24Dq3VjI1sw7egO5+a37Nu9R2Qg00HbNYJvnB7mIguJx4R5
   VsiprFI1dtyt8+HgshIVxEZ5s3A1nGyHeJf+Ua2LRBUlo5LZun3THuN+2
   A==;
X-CSE-ConnectionGUID: lFU6rM7PRo60H2meMaVdZA==
X-CSE-MsgGUID: LTpROUtlSjGKBJZmoVJjQw==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="47078831"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:44:02 +0800
IronPort-SDR: 67d0061d_0B+tLYpA52qYl04Hi3Cwdk4GhWdPy/hVgyqCLdhTVm7tuxH
 CsF4Tad+G/Y1Qh5/vaaGfX8TqQosI6mCcgJTpww==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 02:45:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Mar 2025 03:43:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
Date: Tue, 11 Mar 2025 19:43:57 +0900
Message-ID: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
failure [1].

The test case injects errors to the NVMe driver and confirms the errors
are logged. The first half of the test checks it for non-passthrough
requests, and the second half checks for passthrough requests. The
commit made both halves fail.

This series addresses the test case failure. The first patch covers the
passthrough requests, and the second patch covers the non-passthrough
requests.

[1] https://lkml.kernel.org/linux-block/y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3/

Changes from v1:
* 1st patch: Added Reviewed-by tags
* 2nd patch: Replaced argument blk_status_t with boolean 'is_error'
             Added kerneldoc of blk_mq_add_to_batch() arguments

Shin'ichiro Kawasaki (2):
  nvme: move error logging from nvme_end_req() to __nvme_end_req()
  block: change blk_mq_add_to_batch() third argument type to bool

 drivers/block/null_blk/main.c |  4 ++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/core.c      | 12 ++++++------
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        | 11 ++++++++---
 6 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.47.0

