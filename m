Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC972DEA72
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413023; cv=none; b=Po7/7nONy0LdF3B4b8+9uQ63lXQFIfo/0KzSDqgjDH76BITAqzAEJBGsW5BLgGgsNwpZYz6Bbx+uCeVczI1M3cmBrhr0RjaRxiKHMm7pxdtP2kPfpgyf6c6N7nCeuDYGENeCybyWEcHSMkfwU7pB0ijXLiiYh1+ICTg/d1TYiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413023; c=relaxed/simple;
	bh=lXYGTacTKU2X3HTu0tU4YzywwI19ODIQ8VoiUwC2eDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBe9BiVVLRi1CzTBLIEZCmgGP6KOAeiEzZ43pNDr2jEDGSY932LrIDacrgOhGTQjteiAMu8vrYpiaXpf5wvoFp1BTGO+3UaHqSvBglabtiZk0TW6Frrz+RPApncnQGB7oNhVZihNZq/aT0BrdeDhGBziVxmshFti6EvP6yriV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv0LDjjd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv0LDjjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6C6C4CEF7;
	Thu,  6 Nov 2025 07:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762413021;
	bh=lXYGTacTKU2X3HTu0tU4YzywwI19ODIQ8VoiUwC2eDo=;
	h=From:To:Cc:Subject:Date:From;
	b=bv0LDjjdRxe0J+gA3z2IURhvudNNO+mxecXwaRMUbpW/8D1Ab2v/gJyYoHBsicy+S
	 3gr/xrMBUWRRTPN64ga8+Yf7cHUTLZD6dwXPPYlGZZZgxW+BUaxpuv5EpMsU5neJV6
	 JTVgq9euIfaiGo5D8DKsyGRyQWA/+37Lhzb1QBNomHqhUNbIxx1qf0+Tqxp8zECe/B
	 QwTfWD6TSFx7AGuGFlDT9cQwnMVqdt3LrHSo6IP9wnAO7Kacv9uHBAxgHO+kTTIirp
	 PDPRtc7K6H6nN3TT4eJSIJcLhXzNLFQYnN7wqM0RUUPfFU3F76QSz5CzdTLQrhSfRy
	 8k94GTYsf54mw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] Zone related cleanups
Date: Thu,  6 Nov 2025 16:06:25 +0900
Message-ID: <20251106070627.96995-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple more patches to go on top of the cached report zone support.
The first one removes blk_zone_wp_offset() to simplify the code. The
second patch introduces bdev_zone_start() as a replacement to using
ALIGN_DOWN() for getting the start sector of a zone.

Damien Le Moal (2):
  block: remove blk_zone_wp_offset()
  block: introduce bdev_zone_start()

 block/blk-zoned.c      | 68 +++++++++++++++++++++---------------------
 include/linux/blkdev.h |  6 ++++
 2 files changed, 40 insertions(+), 34 deletions(-)

-- 
2.51.1

