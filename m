Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0343345975
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607848; cv=none; b=eRpIQ1K13KC3p527GRqRLmerObW/WPSXmDIgbvvyD2qMmxVWzkR9WN1jWCRrjELMivM6V2ULti/ZT1GD+bkxKoewkJ4szN6nuHMPtFSF7IwW0C22QWAObBUxBh3ailV9sdcvWYKR4Dj++3DnhRoOuDyUSW0cESAoNzcpvCXnY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607848; c=relaxed/simple;
	bh=LWzkY52cx0OgubpMQI1Cia1CymcN8g3jPSZxdG7ZJ30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPErXaZgbHReruJEi0XX1Z5brjOblQieWGwnr1IjeEkYuqS+5mn1/+pI7nIwX/QFG0JNKBauO/wYuvr26E1xb8izjia/PsmOaxl71o1mu6egp8Um2i8/u+kPGCrKhMyyHgtn0UctzqCySJBrxd/ny+PpACxVTOTDxEPgVNQewX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVsAQJgy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVsAQJgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E4EC433C7;
	Thu, 22 Feb 2024 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708607847;
	bh=LWzkY52cx0OgubpMQI1Cia1CymcN8g3jPSZxdG7ZJ30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVsAQJgyEOzNTu5wiJ00c5rN3dFe1PMh27tqTKQrhv+XIv46VyxG+R3qE3tfG0t6p
	 vkX2xqD51NRWS2UDCyEsODOpjzH5zZ1ycvhdXVWqQzJHPNtp5IlOWrCx9XuJ5ayivV
	 4x+q6SRgHQpWhy+e2/E2kPDCPJMdYKNQlnUs/7rSkjEALRlcw1fil26ulLqiQydHs3
	 k54Yio1uop2UKq1hAFDtv/chWCgMrbx2tKHMqIQr4ZMwDIb78l5X2r6y4D9DRFf3Kv
	 AjpDtjLtBou1VjWizE+kobOSXa1ppfeooiuVIcJO1bofRuFrTn0OoU1US2vT9DpjIr
	 LwIc7OhrhVcWg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] block: Do not include rbtree.h in blk-zoned.c
Date: Thu, 22 Feb 2024 22:17:24 +0900
Message-ID: <20240222131724.1803520-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222131724.1803520-1-dlemoal@kernel.org>
References: <20240222131724.1803520-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block zone code does not use RB-tree. So remove the include of
linux/rbtree.h as it is not needed.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d343e5756a9c..fa930881b06b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -11,7 +11,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/rbtree.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/mm.h>
-- 
2.43.2

