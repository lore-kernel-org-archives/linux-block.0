Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E933DA7C5
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820957; cv=none; b=SIozokqPa6LXLSXXbu2BKGDfSMLIkzvYB/cGIqBBFaNj++ZiDDsOt+stMAyyTFG2MpLr7vEFfzS1uBgSGLLy0zlsvyrnMEf4XDOYq7AcnyiUjwI3GBrXU8aNB4i6Z7G0w8c21DzD8ITvrSG7S7mIGI2eZgCFut/QTVxwC1dm5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820957; c=relaxed/simple;
	bh=yc0LKnsHybjC5NDBbuF2+K/tgH+QIL9EnDIrBv3hfLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBIDyIsoW6XnCWgOssQ33emTMYfk/tIx5YahOXjA6dOR5CTS3Di4AiUrlsuLB1CW64/doj9ynyfqQ2sR61/XujUsCNAQ8KpplIgkjkrU3PZY4WTHKv4UTo6WC+7gfmC8kNsEyOzyXNVZIz+4aP0sFxr9wRDdQQntKwff5yLESzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SDu3HHxW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDu3HHxW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fOp+yLcg9y/RjYfSLPLZnDh5KliqdCFGocDgl3HsUFs=; b=SDu3HHxWjWDo/NT25i2vOP14jW
	CyJQMISM3mLG9M04EUvgQcQ8gS2w/4aVfLldVssGX27jEyDFAsx/YQZgVZuDqvpbo46B4dGvlQoNr
	dLMKsQUorOpGMcLiGN+x116v+0UlnET7dFKaq7HT3yjjx82MZyv29yyLAF6QQDvVzTnDFEdlhNG3+
	DYsIyaljnvuk6aXmWx5QbMdHRl1ldGHJB/x8XUyVE1e5LRdjzDjcLw8bYmqgbUf6zmge953dpZJoJ
	nSr/Zp4XZ+EFpG2HOsbCKCpTpLbmVR2Rq72fPVwdXv5M7zdLOGAbVq3arqz5dUcCjXawCOPtycPKg
	fMkPlxug==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkaV-00000007LuL-3tgv;
	Fri, 15 May 2026 04:55:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: remove dead code and export
Date: Fri, 15 May 2026 06:55:29 +0200
Message-ID: <20260515045547.3790129-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series removes some minor dead code and dead exports in the block code.

Diffstat:
 block/bio.c            |   44 ++++++++++++++++++--------------------------
 block/blk-core.c       |    2 --
 block/blk.h            |    2 ++
 include/linux/bio.h    |    9 +--------
 include/linux/blkdev.h |    1 -
 5 files changed, 21 insertions(+), 37 deletions(-)
