Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA471361D2
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217272; cv=none; b=fmgRx2l5ABtxzzVAGo3TI92k5qxFMTvd7yfAyG1qGtFICGGyWBBceSZ57WpZNLmZz8neY1S6+SPevaQvTUqpKn7toAArKedBJDKbVW790WV6RtZUrvU+FdxTMdAm/1TSArxGhZl/hii8S0zcJNKecdiY5qqjFugimPWM0/dbW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217272; c=relaxed/simple;
	bh=v/qlhKA2X8pXN/YVdza4NVfhFNyHZdI009PPt4Ub3wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1/H7cfmK1Ohxtu67TlIpw74SCljq9MPR6OC8cMP9g1PLth3PDrnfxVjuX6UXE+dYOzqnN4GbkGr2XMdBPpX1aqxQgTiXfeQ8d8O7hATBBi5Yc+JdZHPclJezCngf9yjo2jHfcwh8Bvh5C/49zQ5gz4G1cUpXQ/vS9++bKdIJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xOZV2Pgt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xOZV2Pgt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=i98gOzLS5jbHrAVkQ6fKQGZ/o7g0RfW2jZ0VdH78Lh8=; b=xOZV2PgtiSGBJC4pl3mt8EbYRY
	KSKvIoFLA3HqYqSWahbG3DJFqPk9Mm2erRV75Scemc9a95su0afOEiHMLWpIsmfdjFwTfVhBFCGqr
	DuaZAl68XhfoGjqvcwND5XXXQOxdidlIt2fkW5s2briSNZ228dWg/HidyVDptJQpd0ug9QQ2QMvps
	T04A/eDYqEV7ErFjcf5hSF/tHbQOl9RB2e2bTHz/V9O0ZjWAewBUjR8IX6iW5fcLXlqtb9JqDgQ2G
	LHRv8QoGDB8g63vg/alANk7BfUCPlB1/u3yyB5WFDYWXUN//mvPbtj3pB/lItCpJqw333oA3uzh14
	N0vRWIYg==;
Received: from [216.9.110.7] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfhUR-0000000Dt7K-3H6H;
	Thu, 29 Feb 2024 14:34:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH blktests] nbd/001: wait for the device node to show up before running parted
Date: Thu, 29 Feb 2024 06:34:27 -0800
Message-Id: <20240229143427.1046807-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The parted call can happen before the device is settled and thus fail.
Currently this happens very rarely for me (about 1 in 500 runs), but
a pending change to freeze the queues for updating the limits will make
it much more likely to hit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/nbd/001 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nbd/001 b/tests/nbd/001
index 9427f8e..5fd0d43 100755
--- a/tests/nbd/001
+++ b/tests/nbd/001
@@ -18,6 +18,8 @@ test() {
 	echo "Running ${TEST_NAME}"
 	_start_nbd_server
 	nbd-client -L -N export localhost /dev/nbd0 >> "$FULL" 2>&1
+	udevadm settle
+
 	parted -s /dev/nbd0 print 2>> "$FULL" | grep 'Disk /dev/nbd0'
 	lsblk --raw --noheadings /dev/nbd0
 
-- 
2.39.2

