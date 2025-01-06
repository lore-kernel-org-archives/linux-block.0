Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F291DED4F
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173523; cv=none; b=NF3q/6iUzBe4lWOsY/4we2TXhvOHdpOCE+AKQhEvH0fctT2ci4/qT5ORO5ZMquM5nZFHL7nwZ/sUL6TkK6AkzedwACSDSsgET+e+G8h5peXxeZGJ30NtLML9IZ1LTnT5vQSxyxa3jNUhrwOAPXmn7Q5gjTLt++ehDbelygKFkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173523; c=relaxed/simple;
	bh=mDC0HKoA5eACfOp5I/+nMSje9z8qwgQWKIw6m5fK7eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfTFjlaS8Zy6IbavjCYWBr3a4c9CRh2Z4ryq0bq5IIPaePHmnyHPBzYCUj4fwWgyLxAEFK0bPV8v1P8rzwW03AHu4KpwHrhk9LMtjRFBNp8nTWlhzjl5CbWqDR9GKW7v/BB38qvF2gM9C76tYbteyRNGaWY4r66mRbfMXcvH3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeRfMqWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeRfMqWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280C6C4CED2;
	Mon,  6 Jan 2025 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736173523;
	bh=mDC0HKoA5eACfOp5I/+nMSje9z8qwgQWKIw6m5fK7eM=;
	h=From:To:Cc:Subject:Date:From;
	b=eeRfMqWK2l2OmPEFDdel2xnJYEc9DxA2kiUd6Xo5vi+CI+n0boAZopaYma/GppqGV
	 Qq4xaG1oicRrWtQLSnCrChHRXuiWfO5eyx4vf6WhGf/CYnbW7nShIyID4wh08cW2Y9
	 YSmNabG89qt7A24sA7jkWvd0MysbNa6riJ3xl4AArSaDMbE1IXDA0sFYutbzjpbf7+
	 spWpIor3+UT63lb8fdxxp/Lv6sLOLjLUobtokz2r4xeazrEsVQaqIBRnUQJLX5gnIm
	 r74oUFm/TFM3rtX04XNjDo86VY/hAa9n4my6GVArwrTTdhck1aHWX8ogc8WT8yvz47
	 gJnfrzOEP+5Bw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] New zoned loop block device driver
Date: Mon,  6 Jan 2025 23:24:37 +0900
Message-ID: <20250106142439.216598-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch implements the new "zloop" zoned block device driver
which allows creating zoned block devices using one regular file per
zone as backing storage.

The second patch adds documentation for this driver (overview and usage
examples).

About half of the code of the first patch is from Christoph Hellwig.

Damien Le Moal (2):
  block: new zoned loop block device driver
  Documentation: Document the new zoned loop block device driver

 Documentation/admin-guide/blockdev/index.rst  |    1 +
 .../admin-guide/blockdev/zoned_loop.rst       |  168 +++
 MAINTAINERS                                   |    8 +
 drivers/block/Kconfig                         |   16 +
 drivers/block/Makefile                        |    1 +
 drivers/block/zloop.c                         | 1330 +++++++++++++++++
 6 files changed, 1524 insertions(+)
 create mode 100644 Documentation/admin-guide/blockdev/zoned_loop.rst
 create mode 100644 drivers/block/zloop.c


base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
-- 
2.47.1

