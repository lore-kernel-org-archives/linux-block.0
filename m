Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC725B08D
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811562; cv=none; b=oze5zUX09R6LB7xhN9AR6KuFrgmAKN5/jmh/ThznA9XNlGQsMIluLlt7v4wmbByaAF8Z8zLEt+Wwt2uJa2u1gEYpP53ySykaPjY6RTejFVrnSnBPHTJO1m0eaA7bTqFHDGQnrPr+n/FdhoRvnT+23DblvMHEqtKxDn7BrSWqKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811562; c=relaxed/simple;
	bh=ZuMQyHRk6qcUXPFvuhYS+JL8I47LX6ay78CyNVOzjuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulkA5uqWT5ud5qCiswlHws3t4R3bqGrorYG8CCsNd7TKCUYcFJdgkYAXeRosnewfAhHiUQ/g/HEtc0IQwkJvrziJD8togfcFGK1SvMC4i8UoZROj0WRPlLW7v/xG9dhZ6igYYsMmKPeqI6UYs3njiLqLkTkNLBnmYZQeDQl+6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fIfRWZMk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fIfRWZMk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rKwQJpaOhcIzdb5CS5MqW/g+LHk4ktH0Fwvbg7z9LhE=; b=fIfRWZMkYIEs86BVKgBIgnOuGt
	zkELbdsGT2ZAVxxeNr5kijFcQePvQsl+S3DZTkuR5+luk/O7Y96bYaKgsIvO0x4+2lVonrn/W0E05
	9f+n5ovIS/fHWokKxjcF0tLhnje5sN8FIxvFpngjar+2C1ddtlNMT2kvQ2TO9BkAXmMW3aAewAUCE
	aglxJUKNS2/JlyWTCC1VwBgHXTU2hrhR1ydmc31C9JEt+0aR8zbpZAmZL2RHvKSn0mkM/ldddTWpU
	tKBXPewrIjba/aQgXiXWmz8scE3J0SWe6ZINgqrSvM3qcoT3mZK6dw0yGFLSb2z60z3SVlbrhfWOa
	SKd9NAuQ==;
Received: from 2a02-8389-2301-9f00-e8f6-a58b-9f49-a02b.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:e8f6:a58b:9f49:a02b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGG2S-0000000AYsC-0orJ;
	Mon, 12 Oct 2026 13:26:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	dlemoal@kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH] zloop: explicitly mention full zone when writing to it
Date: Mon, 12 Oct 2026 15:25:56 +0200
Message-ID: <20261012132556.1307034-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Don't print the impossibly large write pointer, but directly mention
the full zone when a write to one is received.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 394dc2408ed7..f8988f9b5d04 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -603,8 +603,12 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 		}
 	} else {
 		if (cmd->sector != zone->wp) {
-			pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
-			       zone_no, cmd->sector, zone->wp);
+			if (zone->wp == ULLONG_MAX)
+				pr_err("Zone %u: write to full zone: sect %llu\n",
+				       zone_no, cmd->sector);
+			else
+				pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
+				       zone_no, cmd->sector, zone->wp);
 			ret = -EIO;
 			goto out_unlock;
 		}
-- 
2.53.0

