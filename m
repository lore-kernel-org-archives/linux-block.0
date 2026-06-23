Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2937DAB3
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225009; cv=none; b=bGzNtccg7ZuC2NMZ4x3xznh+BV/N6OzOPpmI3e0DQ7dcMDVfyhbODZ1WJ6djoVuUvSIo9Z+WzGVLgrnxMZWl4AmQdwHoNDJU39BHIc7DZZYfsVllYLweClW8Kbqz3hRAJBIY2dz4XoBUKUE6HXS7KavpQjACgQS3yAFMaEZ8fOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225009; c=relaxed/simple;
	bh=BqtS78Ol0DNdx5hXPMKKZp5HBFfgG6C6GehNPqVQBD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEOUt7F3sFmCq69nEZVuZmPkHQFt8zwnnly6T53o7zdXtdZ8Ab+1Z878ijVOLiLdl7MJzf4vmJnQIJxFkZByk/2PC/Vf6HO9CNR2YofJxcepFLbcR53TQ7m4t/3g9TFchgRnTIB5yTpBEHnhltZ1VOVD751SVqJnKRs1nnSxu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UPrNyuai; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UPrNyuai"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TCYh1Dosu4xE29kr3XhnyRLFKJbfOijtEMsNiy+YuKk=; b=UPrNyuai0ZUnotif2nYL4tDuQt
	5l7DUAURRaBLvchn1QKS/WcnAaGg0+jR+YravJEWUFQrQnP2btlZPbwPi0PoIYdO19Ybha763yPG/
	XmKVXjAGKJGAgs6sYyM9JQJ7H9n3HKhoX56dJP4uE0CsXWrz2Z7yyIoCCmCon6mzHjBpIJlYDjTQp
	6UaHggr5gR6YccrZEG482S9uZA5XhQpZf8S2TCeHW//WJYoGR0cbOesy37sMljY0rlVnk8Pjr+t+7
	8TCkMsetq27UAR6BbmfJ32cp7n5ePv7pZRh8mu3igDCs7GIyr6lTy7hTiWf7tsQEWpuM8tTW9Jtgj
	z9/PjuLA==;
Received: from [2001:4bb8:2f6:ef61:5b2b:8638:3844:9408] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc28d-00000006Raq-2hpQ;
	Tue, 23 Jun 2026 14:30:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action
Date: Tue, 23 Jun 2026 16:29:49 +0200
Message-ID: <20260623142957.1839474-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623142957.1839474-1-hch@lst.de>
References: <20260623142957.1839474-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise zone append commands will miss their integrity data.  While
this works "fine" for auto-PI, it break file system PI and non-PI
metadata.

With this fix 512-byte block PI and non-PI metadata work fine on native
and emulated Zone Append.  4k block size PI works fine with the
"block: fix integrity offset/length conversions" series from
Caleb Sander Mateos.

Fixes: df3c485e0e60 ("block: switch on bio operation in bio_integrity_prep")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 488eba228c6e..9fb722ace0a8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -38,6 +38,7 @@ unsigned int __bio_integrity_action(struct bio *bio)
 		}
 		return BI_ACT_BUFFER | BI_ACT_CHECK;
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		/*
 		 * Flush masquerading as write?
 		 */
-- 
2.53.0

