Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286248;
	b=T/ixlopY8Bk3wZt4ygl4+5tR95xbCca90HG2qKJZ9J8baoOwS8txMFtSQa2FeSEzWRwX
	 aN11d1wKKKActqTKcd9xExkOoDYV5Zut/3msaQH2g1eShG2oX7R457AmvjamFdNRs9hhw
	 Iz7umj92S+vbf8KRmbkZk2MX5Gbs7CCr6LKRLqBNQuAszfWspgU3sXAlsR304Gb++ahHB
	 iIJLUAe8kbYY57KVXxTtTOgRZbUMeKY5BNQK1DsciiScbZgWpcIraYCK6Xio4p+NqXB6x
	 +ZTGgy1lOlL8Pk+mxLK7jOitzmxqyVv7K6NEp3opCLI+9zS9wxs86dTewJL5x8Gv27Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286248;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-SRS-Rewrite;
	bh=IUTqnO460UMVA71IfKZIhLRgDeyaa2GPyL7wFz45XTg=;
	b=tvYG5ak7/HQ0otxFg7zJU+g84lPnaRbWpb5UuHXBxKRhGY3dPU0fOwGjDeeX0MRO/Zes
	 QOBKubIVlKT3sVppJAh17+ZDL/pzYxifvtMqYIZfJooazN33VAnUrNqndVUQ1eicteWIR
	 +dZB7LWB810I4q8qf1mahTxZo9QWlJ3Rm6XZk2eXj2Oer4MIMVsSH2H02/rkCXVpYRA3u
	 LlQLtgZLt7NBqpaTbgqaPLYFaCREs6ErlCt049bO7nFnxyFdiHGaq1sBcB7rxEGuObl9L
	 hg+JnQM/jYe6bU8lUDJ5ItAZhpL3sfuJhnGdZBPP2V/yNzGIEo9pudI4egkQOCUQfMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=lst.de;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1+tX0nHC;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF1606A31D
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DF1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1+tX0nHC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IUTqnO460UMVA71IfKZIhLRgDeyaa2GPyL7wFz45XTg=; b=1+tX0nHCKUso4ViwwepExjt+NU
	g2kLtX3anXh4/Y6wAfxZcgcoIQVn9WyoGegs6RHEv0MnqBbRlQ8L9buT1MzVRneV2DS5IsGiNwj9+
	RNVOusnds9GRqGHHPDyFxHldqUo60z6S6W8PXl+0FlwcWkrVO1ODwzxW1Oq0wrgDlTFGUcwPJp4qL
	BsLEKz3P8Mmgaq5yGJrM/efOsPgEPXarzqBpCvcQ2IUDYJicLi7dXubnYRLOCsuJpLSPXNRIy44X3
	v1pCuCFn+ub1AX450Jzdq7uDijOhtgyrYmzf6tLtPpX3KzEFanjgq10HMqswVKessbdMgx8JbS0ev
	nVSe+BhA==;
Received: from 2a02-8389-2301-9f00-31e8-efb6-e973-61ca.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:31e8:efb6:e973:61ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRfi-00000009btT-3EX1;
	Thu, 29 Oct 2026 15:04:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] zloop: fput file after failed zone init
Date: Thu, 29 Oct 2026 16:03:34 +0100
Message-ID: <20261029150353.2503201-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029150353.2503201-1-hch@lst.de>
References: <20261029150353.2503201-1-hch@lst.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Clean up after failure in zloop_init_zone, as the caller only cleans up
the zones before the current one.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 3dc484e3c700..f0aca9d43851 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1135,7 +1135,7 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 	if (zlo->block_size) {
 		ret = zloop_get_block_size(zlo, zone);
 		if (ret)
-			return ret;
+			goto out_fput;
 	}
 
 	if (zone_no < zlo->nr_conv_zones) {
@@ -1150,14 +1150,14 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 		ret = vfs_getattr(&zone->file->f_path, &stat, STATX_SIZE, 0);
 		if (ret < 0) {
 			pr_err("Failed to get zone %u file stat\n", zone_no);
-			return ret;
+			goto out_fput;
 		}
 		file_sectors = stat.size >> SECTOR_SHIFT;
 
 		if (restore && file_sectors != zlo->zone_size) {
 			pr_err("Invalid conventional zone %u file size (%llu sectors != %llu)\n",
 			       zone_no, file_sectors, zlo->zone_capacity);
-			return ret;
+			goto out_fput;
 		}
 
 		ret = vfs_truncate(&zone->file->f_path,
@@ -1165,15 +1165,21 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 		if (ret < 0) {
 			pr_err("Failed to truncate zone %u file (err=%d)\n",
 			       zone_no, ret);
-			return ret;
+			goto out_fput;
 		}
 	} else {
 		/* Sequential zone file. */
 		mutex_lock(&zone->lock);
 		ret = zloop_update_seq_zone(zlo, zone_no);
 		mutex_unlock(&zone->lock);
+		if (ret)
+			goto out_fput;
 	}
 
+	return 0;
+
+out_fput:
+	fput(zone->file);
 	return ret;
 }
 
-- 
2.53.0

