Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F691C68BE
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032586; cv=none; b=XQ+FwTGTpoAXSaQoBeh3GG92Qx98KD5ps4X6Mb8tSVYJ2nAsdQvjbSuZ/b3oVktMDFCLv5p3XK9iitBxRB0P7otdFIq3yqg++AsrG27JdphI573B2jt/Efs/AKA0xENg3T0vZrhGKfl7Z9Qehxuk80GfGrn9LylXVlPebxqrask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032586; c=relaxed/simple;
	bh=1FMT/9SGFbwrELndbYX55OXCNi7CrHJAqmkkuVZzUqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/4X11DAhJ1uXdyXENOQ5wuQDRN1+cRrtndFVic5SgeIrh7E1nSL4lPB+GeNQr9xe2HJBDQ17XWGZC0FKJ8ApGN7na2AWMJ915rq43h6EheqE2JMPBoxvkbCFO/Wx8Zdblw2lytHRBnbd9FqwpM/1k4PknDshACdzKCDDBX6M7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z1hJ5cpd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z1hJ5cpd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MCBRXsww87D93uJSIYFgDNjMcfOj/eO6ivZMNXMtVJc=; b=z1hJ5cpd9RLoYjguh3gpMHKev+
	DqJ9kT59GshTyZQLaBHNEMHleoZ59Yf2ByCKuqk6BMG9nouW7OmatZy61qu1+a+5euzsw/zU2AZK2
	ywYJ4pZOIriCq7OYtio7LCLtZcnpR1o4cHQORBYiqXnbb7yg2dVJgTYIdkfqip6agdD9fVwNlsJM9
	5i3mckU+AEZrOZyFc7d++x4AgfZlvSkLj0TkP/TVRbZAL2KCjlPCTVLtE0MFqtrOoV3FqZJcsWRV+
	f3KIRu/YFa/v/Kf4PekW+EGyQ6/ElIlcAX4AkIe1Zz+V7CNVYP2XgIVgw6rzrkCjtk3+Zim4wb2xI
	j0KEP5Sg==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQnQ-0000000Cykz-1m6l;
	Tue, 19 Nov 2024 16:09:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/6] block: return unsigned int from blk_lim_dma_alignment_and_pad
Date: Tue, 19 Nov 2024 17:09:20 +0100
Message-ID: <20241119160932.1327864-4-hch@lst.de>
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

The underlying limits are defined as unsigned int, so return that from
blk_lim_dma_alignment_and_pad as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1a6f4bc4a1c..74e3c611a4f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1458,7 +1458,8 @@ static inline bool bdev_iter_is_aligned(struct block_device *bdev,
 				   bdev_logical_block_size(bdev) - 1);
 }
 
-static inline int blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
+static inline unsigned int
+blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 {
 	return lim->dma_alignment | lim->dma_pad_mask;
 }
-- 
2.45.2

