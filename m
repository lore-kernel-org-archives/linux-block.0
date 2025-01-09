Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524662F2D
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412682; cv=none; b=u8+NLAqE+AUcDeCQdSruCakRY4sLUfH9Twbeo8b98jq95eKGG45qxfuqMAZN0UmJOcBPZ/0DLTC2YsCjz1csze0+uIAxnlq9IlRbvo627L0cvXW/NTXTJph8SKoKJtcY16AtVPFZo++65DtAGqK9IiUjG5Th2RgCj7XOm3ITnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412682; c=relaxed/simple;
	bh=nEqJ0WxD/zLRSlCOPiKw+glf1EUJrVoshQBM1SSUHSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyxyU+9X94jDwSTsDT/flFwaG6TZtaTcia+yHMZ7/OLvo6jyDbuL+euKI7UpKDgIJZxJEqMbQ1MkpHduVtRvlJYkFHAcMVj7OT7gaFwTHsV7YbAZUoyh8hmSXMKIlqzUYszgO+/YAeITUFQADubkHMvDQZhcQUzENbx/hWmmzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPhQNvAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPhQNvAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D68FC4CED2;
	Thu,  9 Jan 2025 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736412681;
	bh=nEqJ0WxD/zLRSlCOPiKw+glf1EUJrVoshQBM1SSUHSo=;
	h=From:To:Cc:Subject:Date:From;
	b=LPhQNvAg0gqAh4J2fsiOAe9YbhgxTlXEZZr6yEt8jgIN2FSAhp7u6xzIWCxbj+VJZ
	 dCYBLmDFIvVgvAVwdOXqS+aREPlhxy5XCsk02wOjsD3vHabtyhQ2JtsUHYEf2zUblR
	 hbSt6y15wbdGtuUCL/8de0nUS7I/36HvoP7ySbnEkHj5vF1d4fofgRIpORYFnsqtEm
	 ZWLXUE+3ZUn1Q7jBjk7eK4VpsVF9whtRLszciOvIhz9rKfkpcLQbaFF49fM4qxdojx
	 n0MK1kanHSlbD4HYj8c7bopUSNEN523OyvFUkQoKLsON/UdghLw1AiPhVeHWdbl8nC
	 Y/8umazr4d6Gg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/2] New zoned loop block device driver
Date: Thu,  9 Jan 2025 17:50:35 +0900
Message-ID: <20250109085037.407926-1-dlemoal@kernel.org>
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

Changes from v1:
 - Corrected Kconfig description in patch 1 (outdated example was shown)
 - Added missing request sector update on completion of zone append
   request (I had not pushed that...)
 - Added reference to the documentation in the kconfig entry in patch 2

Damien Le Moal (2):
  block: new zoned loop block device driver
  Documentation: Document the new zoned loop block device driver

 Documentation/admin-guide/blockdev/index.rst  |    1 +
 .../admin-guide/blockdev/zoned_loop.rst       |  168 +++
 MAINTAINERS                                   |    8 +
 drivers/block/Kconfig                         |   19 +
 drivers/block/Makefile                        |    1 +
 drivers/block/zloop.c                         | 1334 +++++++++++++++++
 6 files changed, 1531 insertions(+)
 create mode 100644 Documentation/admin-guide/blockdev/zoned_loop.rst
 create mode 100644 drivers/block/zloop.c


base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
-- 
2.47.1

