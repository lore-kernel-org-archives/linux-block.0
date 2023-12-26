Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D64D102
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T21L2t2n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tx7MkBLcISE3yqmbH4qXe0DGz7vVUIH9Y4wF2ghAjC4=; b=T21L2t2nJx/Hfe0nXJL7NpfC8S
	JvA5mfjnKdKvMYjuHKIqIVsN+1lntraU7dT+PGaq/gYsCuh3MLWmnN5h433/rUHIZTPs76uufwRQB
	yMeQWaCD02BJlkxtJpXFFWKSrPzw1gwyil61SrMs6xTfYX7BKtjdnqB7J9RysF1AfytHCoA2OE4US
	nFuzH/bn5Tu+73uwkFqecikxnHexIFcmgOfAurYboxtNLtxS12Y8qS22pUIWsjfZHnyfx4RAOyCaG
	sqVhJP1guw4MYJmtg8s9U3Kex5v+q7ZLJPvzNyjWWxjIOKZien/l09bmbxG3CI9w5+beJRHjS1iWt
	AJLB36VQ==;
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3Vq-00ByL7-2l;
	Tue, 26 Dec 2023 09:14:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] loop: remove a pointless blk_queue_max_hw_sectors call
Date: Tue, 26 Dec 2023 09:14:04 +0000
Message-Id: <20231226091405.206166-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

BLK_DEF_MAX_SECTORS is (as the name implies) already the default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5bc2b4fcfa772d..371a318e691d02 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2038,8 +2038,6 @@ static int loop_add(int i)
 	}
 	lo->lo_queue = lo->lo_disk->queue;
 
-	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
-
 	/*
 	 * By default, we do buffer IO, so it doesn't make sense to enable
 	 * merge because the I/O submitted to backing file is handled page by
-- 
2.39.2

