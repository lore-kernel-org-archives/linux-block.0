Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF7433B1
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483128; cv=none; b=qmHAiWrLjfVlMjweKP8LzUO8JiL55gHGtpXpJX6dHJ/c/spganHYf3n5k8kXleAMmFIVoDy7jhhZJQIYhy5v0xUviLxiAMPzTpMksWIUphv3egyrtQ1vMuTBmc/LaeEjbqKInlTwqHu7iHIneQKzqHvLMKCH1sLq5oKZfzTcIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483128; c=relaxed/simple;
	bh=IZ+tTDQycYIHtNv/Sa0hTo0ZBv2bOI0KeQTCm6pQvEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MwpQSs7aAWg4yE3t/MNzfYroOMGlrwl8CMdi4BbeGFyri5TX1a6aiN7JsGXCQ9thsHFfz2wG/5wrb4gn8b6DWuGcI+RMP3jNOW9G1M/5DZiLh3Hq6GRGWufkJLQzZ3lmGYqg4k1VPI2+FtZ9Pn2K+R9/fG5Xfx9C6yBIdrdeB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ukXvIZje; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ukXvIZje"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=owZti9WPF3PNyiDP5DDnK2bXGmpmq159Noo6pTk10Us=; b=ukXvIZjeSMUGud/+TjUsLvJ6g1
	N1gZi078J35mZzenZpo4lTdjhe/D5jCPCRDtNCL9yE8XOzodttw9dTFxF9m927qM+DBO2GM4sp/Hu
	O57MFlFFVPATcEEdZGVJCWTp0MDbbEglWH9I78FPiCrRoVgqjICZnyqkw547JKIgtI19zd/fcU7J3
	47bpQUu9iMuUY4hId93TawFl+vmBr73qSBgXTDxnXih+Ex9Po8KdZRVXHg4RXD+9E/pHFn5kOdBR2
	RRhdC4yxp1FMaWe56+WFka+VBGRIqjHsYmQHeUQce4qO2cV27bRX8/bFAehj7pDeKChNdyRC3UCZf
	JlFoCwKg==;
Received: from [213.208.157.40] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rtb-0000000DJoa-3XbE;
	Thu, 24 Apr 2025 08:25:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	=?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] block: never reduce ra_pages in blk_apply_bdi_limits
Date: Thu, 24 Apr 2025 10:25:21 +0200
Message-ID: <20250424082521.1967286-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When the user increased the read-ahead size through sysfs this value
currently get lost if the device is reprobe, including on a resume
from suspend.

As there is no hardware limitation for the read-ahead size there is
no real need to reset it or track a separate hardware limitation
like for max_sectors.

This restores the pre-atomic queue limit behavior in the sd driver as
sd did not use blk_queue_io_opt and thus never updated the read ahead
size to the value based of the optimal I/O, but changes behavior for
all other drivers.  As the new behavior seems useful and sd is the
driver for which the readahead size tweaks are most useful that seems
like a worthwhile trade off.

Fixes: 804e498e0496 ("sd: convert to the atomic queue limits API")
Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
 block/blk-settings.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6b2dbe645d23..4817e7ca03f8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -61,8 +61,14 @@ void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 	/*
 	 * For read-ahead of large files to be effective, we need to read ahead
 	 * at least twice the optimal I/O size.
+	 *
+	 * There is no hardware limitation for the read-ahead size and the user
+	 * might have increased the read-ahead size through sysfs, so don't ever
+	 * decrease it.
 	 */
-	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
+	bdi->ra_pages = max3(bdi->ra_pages,
+				lim->io_opt * 2 / PAGE_SIZE,
+				VM_READAHEAD_PAGES);
 	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
 }
 
-- 
2.47.2

