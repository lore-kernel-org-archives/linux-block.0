Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1894D10E
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="23S4kMe1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ig6q/WRlylpr2ECGi3quQ5DzvbBtw2/5pe5ySz3iXeI=; b=23S4kMe1T2ckTs9hVkRNQJxBds
	rW68cb/1AakLBiZO5RCvAEgmzvLO7jKOhdYQCeXECNpNldNy0NPy9e7bfwxWRCac/A31YLjpwm7di
	hHsfgkehZhkHQiwMHp8PlqAzG2jtn8WAJMvXYtdnJvDH0YzOdnzs3L01Ju04aY5wxrZQzgWIMbBc/
	GnvcaTrM3JozFXAepLrfvRnwLzHx//Zq/3JRcqOVHCPxb4OSD/rY3O11pkscICK2/67ErDc0904+s
	R0sdH5P6+m/K0fNdV7ayRpXBfjqHycfFvqK+phYTHiy8ctzFgXvXuc1ra6SnWXC6Wt+BesezxftSI
	9nYilA6A==;
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3WP-00ByMv-2y;
	Tue, 26 Dec 2023 09:14:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] loop: don't update discard limits from loop_set_status
Date: Tue, 26 Dec 2023 09:14:05 +0000
Message-Id: <20231226091405.206166-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231226091405.206166-1-hch@lst.de>
References: <20231226091405.206166-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

loop_set_status doesn't change anything relevant to the discard and
write_zeroes setting, so don't bother calling loop_config_discard.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 371a318e691d02..794bc92da165c3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1303,8 +1303,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		loop_set_size(lo, new_size);
 	}
 
-	loop_config_discard(lo);
-
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-- 
2.39.2

