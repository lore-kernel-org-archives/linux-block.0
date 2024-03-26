Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E512AAD7
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433271; cv=none; b=BqSzbRGSGBEIV0b35wMakpby8hWciI2a5MpRu8T1QP5wHAeuqhZupV1ihHftDf9G8EoprleV6a/XdtrIMizZ66g15uDCCUKUqWhj1kN2iR0rr9gcoDs3h6SxvdZ+DleUykiwudCdO/AW4SBG8M3DazZbqC44VHGQu5SBBWGaJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433271; c=relaxed/simple;
	bh=6DMUaFcRyIInJRqmVPSjfAdGUz9nPQHMawqBpdivlzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gnh5oiISMjupu3luxC6a7In9sg/xfQph8a0C6jVZhLcIpOK3AtjfFGjauefwcCTprRjFIF49llzNdmpR3ogR1+wCxfM+P6SSi7eUwkO38xFfkG9Hifq7dQH9Hfaggxm+DeSZ2JTiGSmlsN9/8FqF3+lyZszV1QcfoS9AfOQY6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rdl0G3/6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rdl0G3/6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2kTXl0MJ252W5PIw2oaR1WDM5TZ+byNd5dZslXKOJgI=; b=Rdl0G3/6dmiJqrpLXDHOfMFif/
	aZ8AZvJ5QKWnztV/lwgxd2hCpXs9fGrCP8u1m1Qerob0r+y4cLKC3DjehjEyLiIYa627wmCnI8QB5
	TCWdQxFqvFw9aIwuilDauFpeSAdw1rfycIQQwP4zpRzfMqvu48AAiUsrwFVv3cCEkdRrqtQLkub0v
	L+0DzOJbKpTTHhUzazdxqw7vQj6oIRNTI8i/LEeKLWP19wzZif9RCq/4E9gD4+w0j0u4cV/zOK500
	HNFDSbNyp0gra8qlfrghK6FLGup86qIi4gd71BeQlY17tXk8U1FbLP+rqlSL6Sb3YvNPuaEHlE8gY
	NgRYHGdw==;
Received: from [88.128.92.114] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rozyO-00000003ETC-0V4l;
	Tue, 26 Mar 2024 06:07:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] block: don't reject too large max_user_sectors in blk_validate_limits
Date: Tue, 26 Mar 2024 07:07:45 +0100
Message-Id: <20240326060745.2349154-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

We already cap down the actual max_sectors to the max of the hardware
and user limit, so don't reject the configuration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-settings.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 3c7d8d638ab59d..cdbaef159c4bc3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -146,8 +146,7 @@ static int blk_validate_limits(struct queue_limits *lim)
 	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
 				lim->max_dev_sectors);
 	if (lim->max_user_sectors) {
-		if (lim->max_user_sectors > max_hw_sectors ||
-		    lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
+		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
 	} else {
-- 
2.39.2

