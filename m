Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154C36BCDC
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942915; cv=none; b=pbA4lpS/JIHAbrAwm7rkJzdVc8rXzH90pntZi5em6ByaUNg9HfyWT/7xL1ukpzNI8LlM+ogsCQdI2o3fV82A9BZ950UqAJ8el5YH+aaSP5zyAgQ3OTdKKPlEQ/J+GRZ/FBq6GSiwhSz73tbvA3k98bYdA7HLKlASBsIwabM3xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942915; c=relaxed/simple;
	bh=HVBKmrVsdGmgnMGeD8Gn4lG0MPDhcfGc2pYbvdQE25c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4dyTeZ+LOrcJ/AfVe0HzNCHAkYesq1o3XjLGnL1bIJLQ6ROD9S2pTMfVTVuMTDI03ZBz/sZgpt4lfxWDdtflM2ToaOE6dxJWtUl+aYf8Rpr/UMV92zGe2GkCuCp9s5j0eB8faIl/xmkZgm6GpkC8kXJ+myLk+WPVNyO0GuK78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jrXlLUdc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jrXlLUdc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GreePamL6Uif/plHUi8ppKeOShrjcE8S+rvczIAP8sc=; b=jrXlLUdcvE0/ieFYWJc+0xQLbB
	ZTzczsjPNrOo7A9/qImqy96zZsDSFfpHw925iHFNtkjNY/epZbZ2NzE6YqxzfpmsIAvXkQttQXyrg
	3wk1t4tx5p7PUo+fBjJDhB/ioWd5ZjpQWr5bMsvrivTEqeZP3ZDJ1sN44FnNmbRfBW1IQNTMhZeql
	Y5iRb+fk1TuYIUDqV+JqCq7mvMy1CAKOpm5G5Ls/ULNdELsWdn0d5mUJ3H/693ZmN5Z4olYXSZPLY
	2ERwBbzvGiYfiCCj+zbG8SeRY3sxwOyNDbHoNn6l/io6fUfqsqCPRlcHH1bZ6E8u2k6AVjrTKhxzj
	Qcas3UzQ==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutIQ-00000002CXO-0uII;
	Tue, 24 Feb 2026 14:21:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] zloop: check for spurious options passed to remove
Date: Tue, 24 Feb 2026 06:21:45 -0800
Message-ID: <20260224142153.368472-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224142153.368472-1-hch@lst.de>
References: <20260224142153.368472-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Zloop uses a command option parser for all control commands,
but most options are only valid for adding a new device.  Check
for incorrectly specified options in the remove handler.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 56e54d9791f1..51c043342127 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1174,7 +1174,12 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 	int ret;
 
 	if (!(opts->mask & ZLOOP_OPT_ID)) {
-		pr_err("No ID specified\n");
+		pr_err("No ID specified for remove\n");
+		return -EINVAL;
+	}
+
+	if (opts->mask & ~ZLOOP_OPT_ID) {
+		pr_err("Invalid option specified for remove\n");
 		return -EINVAL;
 	}
 
-- 
2.47.3

