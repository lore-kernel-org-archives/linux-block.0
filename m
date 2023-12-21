Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869CAD51
	for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R4/sIwAt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=woJEwd47saaGmSFPNVomhlIxKHfl8FKXd64XSDyXrFk=; b=R4/sIwAtJ93Yiv8/aD8qJuWeML
	mNAiWJfCyOYTo2mq2l8CvCaNoh5BzgU2C3dOupWfa5XOQ4cMhCDmZrh/JmYc5k7G25/yAalROJeth
	asGeTZ3Dag7wECIUqQBE1zI56zlcmCYTxttH1yKaPGwRyUiIrVdKqm5Y/zlwJNeU2CSre6fEaey56
	ymA4CpC8Ns86jSfpmYxpdofoNdyi4F5Q7/PbOclHD7NVVz9vpGoNcTF/XKgmZqiSvpma7tOzZ3W06
	mOekIjWi6NS5oznumnB7dWKwHXsAY8xd5ueEbYsoQ1ArftcMc0bsxr/vaUmn52BKAIr3jxAwUnQ1j
	+yPO4mAg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGBbS-001kBF-2F;
	Thu, 21 Dec 2023 05:28:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: export disk_clear_zoned
Date: Thu, 21 Dec 2023 06:28:14 +0100
Message-Id: <20231221052815.1063146-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

disk_clear_zoned can be called from a modular block driver like sd, so
export it.

Fixes: d73e93b4dfab ("block: simplify disk_set_zoned")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 580a58e53efd77..c59d44ee6b236e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -635,3 +635,4 @@ void disk_clear_zoned(struct gendisk *disk)
 
 	blk_mq_unfreeze_queue(q);
 }
+EXPORT_SYMBOL_GPL(disk_clear_zoned);
-- 
2.39.2

