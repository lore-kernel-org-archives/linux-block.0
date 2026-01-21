Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D845091F
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980733; cv=none; b=ChEUNoCt1Rexu0Y/Hu8BhKJ49byxyaDBa97AfO29UBIWHUZLnBmupCpzDPbPbxChvZBHQA9rZiii92t85xpEspkLnY6+wdaZBbCCjwEC4poK5EvM2egS0cI7khnZOztv9DGsxvySRiZ2fP/tl1wmMt0qGF5XMZv1R8Y7LPWm+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980733; c=relaxed/simple;
	bh=kyAdrB61hovYL3jRb9H3XHEoS/IqJBzDBRM9BNZ/M4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9ia1w0I4BqCz0I9jKPgbnBkFsiEvmwJV47cAKw6QohwCQtb9dPxy4QyleTkE0XuKr7XoWFYIjR6Kaj5glJzyr0EEmbzMnHVxZywJ/+DvmtH+CM3lkuPhuGGotjm6O0Wxs3NsGQ0a/yfYtMcx++u3nBNqOF2W2Eju9Ql+tgRzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JEX/PqtD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JEX/PqtD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mUSe5g85SF8j4uZB7QlTkJX+dC/ZCiFM7BH08KfC/C0=; b=JEX/PqtDrNYEJ41hRR1rh8H92T
	mgMRcb3Cib0qH/mbvNyqslwB2eNPUfVf+n2g2dvJicOazGJUVydRwJNPQ4C/j5I0rVafR9AYTDmaP
	mHtkQiEPgN7Bqs7MRZjkGi2axkxITsZcJV3YONgItgfPIldi+8kJ/tRzQe922ylB8uNLPzwIQri0a
	6VUiocofE9ITsilv3/SqaGu7zKJMx51DNUWVOX8N2ZYLVkZjY+gIIA3a5Hw2LqX6wqe+rqP64+cRC
	x1/1bX3CN3ZsxQjF5Lpa8JOHm3/AVz+q0DK889xfc0CmBrDC5DRCC0XFgrvfwpNP+ekeZoRFb3K1Q
	IHyc7a7g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viShE-000000051Si-3yj7;
	Wed, 21 Jan 2026 07:32:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: dlemoal@kernel.org,
	linux-block@vger.kernel.org,
	aalbersh@redhat.com
Subject: [PATCH for-6.19] block: make the new blkzoned UAPI constants discoverable
Date: Wed, 21 Jan 2026 08:31:49 +0100
Message-ID: <20260121073203.234429-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The Linux 6.19 merge window added the new BLKREPORTZONESV2 ioctl, and
with it the new BLK_ZONE_REP_CACHED and BLK_ZONE_COND_ACTIVE constants.

The two constants are defined as part of enums, which makes it very
painful for userspace to discover if they are present in the installed
system headers.

Use the #define to the same name trick to make them trivially
discoverable using CPP directives.

Fixes: 0bf0e2e46668 ("block: track zone conditions")
Fixes: b30ffcdc0c15 ("block: introduce BLKREPORTZONESV2 ioctl")
Reported-by: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/blkzoned.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index e33f02703350..663836120966 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -81,7 +81,8 @@ enum blk_zone_cond {
 	BLK_ZONE_COND_FULL	= 0xE,
 	BLK_ZONE_COND_OFFLINE	= 0xF,
 
-	BLK_ZONE_COND_ACTIVE	= 0xFF,
+	BLK_ZONE_COND_ACTIVE	= 0xFF, /* added in Linux 6.19 */
+#define BLK_ZONE_COND_ACTIVE	BLK_ZONE_COND_ACTIVE
 };
 
 /**
@@ -100,7 +101,8 @@ enum blk_zone_report_flags {
 	BLK_ZONE_REP_CAPACITY	= (1U << 0),
 
 	/* Input flags */
-	BLK_ZONE_REP_CACHED	= (1U << 31),
+	BLK_ZONE_REP_CACHED	= (1U << 31), /* added in Linux 6.19 */
+#define BLK_ZONE_REP_CACHED	BLK_ZONE_REP_CACHED
 };
 
 /**
-- 
2.47.3

