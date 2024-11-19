Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D01C68BE
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032580; cv=none; b=XA8ukgn6l9hfGoglujgnnH1BjNlz3xuJnKa1KncTPVEvt2DKHPJXzFrRcJvbxQPWXXB4CP6AiPpCzQd2pMCEXv3E6RWROlEvyTyULzU1Hb2/egOy7r+J9fPLn43vjqRSzPOUKns8K4v4K0gbktMA/MXkv4TAlW1P7CYaoY5RAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032580; c=relaxed/simple;
	bh=CX/hbK90XosCbGDVWA38Wj2AlZx20pxZxfc3RP7m9ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFKmJUVpJBOVdNgmN8YmNaogSP/rSu+6HLssCNQ+IZmzuIgVoq13+0Wgm2pA/XfNh9nrqxYoL+dgQkLxGRY5+0nRjmraLko3F105uB8L0qVDRufRaGDaI1VQnT2Sa/eUo+TNzORY2Uo5B+i0dFh0ZXDplhp62gzmvxg6Gf5wx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fmJdReLj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fmJdReLj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bocFXVwJluQPCTpD8aaYWVdRdJkC1vZpyzPRsMg05dA=; b=fmJdReLjMRjOsgKqJek8bMbqT6
	q3UPvd0GXUV8XXyqoFOwzkED1Z/dOxyiURyQmTmqe9wZyV58dfHgMe7dtqZiJdsFKgnr9YoM0iNx9
	xsuDePCF7poUVYp1nsfvoTiYaKY7EaxfSRWt8HM3qZynGxApE2jEM85ntYXRdleNqSOFjjrweEvnp
	CYNYcxmL6ElJ2NlhQnN8KWhJa+uAmy9ubUPv18DzeXB5r3SEAR0R9l5RjCpCTKankCcI10GxhmAbm
	vnRH9B4fLAYGlHh4I+Mkyu35ADqrvAXE9DbjpYApi73o7OwQZbc3+epI1f+sJdSVMDIiQ+rFPKVW3
	98roxFFA==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQnK-0000000CykB-0oLl;
	Tue, 19 Nov 2024 16:09:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: return unsigned int from bdev_io_opt
Date: Tue, 19 Nov 2024 17:09:18 +0100
Message-ID: <20241119160932.1327864-2-hch@lst.de>
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
bdev_io_opt as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 195db38fda16..37439acfa34e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1271,7 +1271,7 @@ static inline unsigned int queue_io_opt(const struct request_queue *q)
 	return q->limits.io_opt;
 }
 
-static inline int bdev_io_opt(struct block_device *bdev)
+static inline unsigned int bdev_io_opt(struct block_device *bdev)
 {
 	return queue_io_opt(bdev_get_queue(bdev));
 }
-- 
2.45.2

