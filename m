Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F11C68BE
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032582; cv=none; b=L+cxoSpisPFCkOhZQxGPcgm8qWxVXVgUPv5rkWH/Mbo4IW8yjMmOlMhuvwJBhW7t51EW4b8o5kt7FChmSKcKCjnzQapvGyuFt8Pn4LXL0I0BK4tYb8f7VVss8csLUE0hUXAq5l/RHCLt9BplMSmqznuam1sN8C9jLZRNaug7wyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032582; c=relaxed/simple;
	bh=MkPyC+VZFj+C/mW5jY4IYs/FywVgLPYYxAx72G9Fx3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKnlLUQf/vuhQ+bypQjpSGwupLdJUGsCqKeRGMdO9uTlEPoO3I0m8GzTepR/heWVoAghVRAidYkIkdUMAhS2hkVxv89Td/yICzJ4NwsMbsDWCMuDZtUuSwigMJQUStUuWoxmvgBBELb9vFJmJiifIKkiM+5+KagYQqSIOUgZd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AKJHIAGS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKJHIAGS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qGcHMkkLF3N9VE5b7TI2+bVVwgt3KGz6m79RIO5dlKM=; b=AKJHIAGS0w8KFVWO7YxLwx2KbK
	+K5SDMxgnFLLtYyOwroTcTfo7oruE2p+7oMi8Qv8QTNyF0Nu/nF2LpG0LWqIxhZKozdWMwwO37pgd
	stUhqXlM1nrd8xn6jqGjJtMN/6WzIy81ZPA2ps7xelSYnpVIRsOpzax3W1A6U3kr5qDmkcSOhgF4a
	sxh/k2e5T0WaaipUFch0zVdUEACDGOIaFr1+E/kfzZBYaigBZxqHzHJW7NZHOv8p7E46Xe2c0FOMH
	DhkudrWw/8sJ6u96iZ4Rm17rmrVTpfszQo6kZj9+O3OevcMf588n0GZpSTuziT7tGBYB4Y5EQP8Ke
	la/BXp4w==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQnM-0000000Cyke-2CfS;
	Tue, 19 Nov 2024 16:09:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: return unsigned int from queue_dma_alignment
Date: Tue, 19 Nov 2024 17:09:19 +0100
Message-ID: <20241119160932.1327864-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119160932.1327864-1-hch@lst.de>
References: <20241119160932.1327864-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The underlying limit is defined as an unsigned int, so return that from
queue_dma_alignment as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 37439acfa34e..d1a6f4bc4a1c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1417,7 +1417,7 @@ static inline bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 	return is_seq;
 }
 
-static inline int queue_dma_alignment(const struct request_queue *q)
+static inline unsigned int queue_dma_alignment(const struct request_queue *q)
 {
 	return q->limits.dma_alignment;
 }
-- 
2.45.2

