Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9029CA
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001168; cv=none; b=toWhrK1S5oJmBR56tr0drmZlJ/qA3q4Kb1lVOVh6dVESfAwKA67+VqwA6rUlvnG36HDGztETAXlm1lcw6+GYWcHXpCjy0Y3yzSoKweSZY1UCFX5KWwbdXhQ3pUrPofck83NkYrfp6evO+87msvdMNMQirqXFLMEV815blX4z+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001168; c=relaxed/simple;
	bh=cBatbZr622U5CNCIH9TjzBORC/eHVZU15PkRfqEswy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScTEcVwKuM2vLs4cHSZm55gTg2TdNkAdRo0h1EANzUpJ0CWWw/OfbMv58wEDOZ+2ZhtFFn4uXXeAdkFdqtgX7H3ZrxOrCPD5sdQW02Imfc2Bh/Yc8i1X8SP3S2uil80/GGCE31XPv9Bw+SpDBBSwoXKzRUsCTO48YA4/5ywp1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RdmTGXHn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdmTGXHn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GKxgkXQzfx+n3tB2rjJOyveqCdtXchCNXCGE0ggBlRw=; b=RdmTGXHn3JkZJT19HFKqoaVZsI
	ifMgsUyAl84a7ogBTVliimr/1JdtBsSd1rLY1noHI2Cf89ewqPKwrIRGipNk1cqcUYxmVoLFbAcP/
	qW23/N6Q2W7QPZvPFrzJMWhQwXqSaL2c0G27+2oilk3MXPCWNkIhCCVT9DYGJLCwt4TfBzMcT4d/Y
	s96P8itN5rK1KsF6Q4zzzg7W17GCLneEOHMdseqpm7jkV7m5x1/9GpgtYX0qAtqffAbwZO7hDuGlp
	wLl4amUuPtTGVIZ7eQ+1ulVmQKBk6E/BTneLcqaTYXH+GmVtWUGNpM4bjMinUpWuoSvlurCPiB9El
	+OmM4+LA==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDIcf-0000000BdT5-47g8;
	Tue, 19 Nov 2024 07:26:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: return unsigned int from bdev_io_min
Date: Tue, 19 Nov 2024 08:26:02 +0100
Message-ID: <20241119072602.1059488-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The underlying limit is defined as an unsigned int, so return that from
bdev_io_min as well.

Fixes: ac481c20ef8f ("block: Topology ioctls")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 00212e96261a..4825469c2fa1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1261,7 +1261,7 @@ static inline unsigned int queue_io_min(const struct request_queue *q)
 	return q->limits.io_min;
 }
 
-static inline int bdev_io_min(struct block_device *bdev)
+static inline unsigned int bdev_io_min(struct block_device *bdev)
 {
 	return queue_io_min(bdev_get_queue(bdev));
 }
-- 
2.45.2

