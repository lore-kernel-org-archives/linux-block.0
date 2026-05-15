Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4B3DA7C6
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 04:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820961; cv=none; b=avZQwLSLM6r1D/gc80F3TJI+qXdnuEK2JKTXwOqMNVDIihGYdU/F9UqnlfATG93ixc8aiI3jY9lmgLjEyz9Tuesli7a6c/NRU9P1Atc0XzyA6ZO7wqMweD2OCFp+nIwgYuKT+vmR/h+CyIwgo7qGJBiSv55U7BXwd8d+ES6xRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820961; c=relaxed/simple;
	bh=qGUzgIjDvXaxBn6ilKOPQ16Z3mKxrilNDii1KgfhNw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALP5bd+5I3huKibE7r2GATdK8QjwDM4RIXPwswhyAVY7lX5iRNlYxNgscb3T7y/oyZ8DUzeGWuqmJA7y7uX8p9l8B0EDqeAstnWIFL5Am7IZKG51AnMfrZASQq1QQ/4XN9k280PU7yjClvQBrAU/WmBYlAQPu/vvvJQBbZqFkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xRax2TmM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xRax2TmM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9wO1KifX0/cQm+PM9OGxXDAmffez9hQG9CnSYNQeWm4=; b=xRax2TmMmOt6cuoz4il8XO9VpS
	anneLsZW0Rty3zBKrAPsSgRK260QvNo8CXefuCzGTr0bfTzuk9VFCaxVHNRf057cKKbENHY0JJEuf
	OZI40q/NoTcBTVZ2v8lhbiTzzgVudIAtoKH4VJKdfvfRrPn0hRZWAyK/YNi5YXpx4EXR8/EC5H5Yg
	77oTpnfakOnDHroHpqqs5SJX1FsqhgbNIrLEEhTdvSKjkbERZK65a8P6x1+syyqYdKCJ6D4O29PN2
	dA/dexjVPvZ+tU3w2eqKDH99rqPfJy5Dozf03MLstIQY6ZgbmadQB3dMAKfMymG7FDj+EK9RlpnVk
	hxo8/suQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkad-00000007LwJ-3enI;
	Fri, 15 May 2026 04:56:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/5] block: unexport blk_io_schedule
Date: Fri, 15 May 2026 06:55:32 +0200
Message-ID: <20260515045547.3790129-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515045547.3790129-1-hch@lst.de>
References: <20260515045547.3790129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only used in built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..d7de87e86994 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1270,7 +1270,6 @@ void blk_io_schedule(void)
 	else
 		io_schedule();
 }
-EXPORT_SYMBOL_GPL(blk_io_schedule);
 
 int __init blk_dev_init(void)
 {
-- 
2.53.0

