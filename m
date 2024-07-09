Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8AC148
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508492; cv=none; b=aApB70d6N/UpuopHTl7DD4WVNjaV8+jxAC1nBo35CldaV5YvpI0pzBjI15GUaVj/HdA5qf6BX9eV9uAqKthct6rugR1VaNTqLKEROGBDN1YQ2MX78FqJ1KJvQyyNX/WTviS30PlyA9uEl1cE6CD2fkyZI0qYfsnDYyp6eo7p37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508492; c=relaxed/simple;
	bh=o7dGiZ2+LOZ3+aNWgLnJMbnVIhCdllE1wSzP1H24Scc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jd7fQh9Usg6ODFGMP/imuZwACvu0G53qC81znHDyoBg0qntGzabg8g85O4bwvILO9AjgdtszrlgkDHnLkzqB99vCOtCEGAW82PNZ2KJig5tx6La0nYh45ETRx1pwqrIj8IxTedFFNCDG/9DiRzRl2nCv7jdNZPfaN0rsa33TUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2nVTnOQm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2nVTnOQm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=icbV89yZ5l68ISCynYMQhQ856OclUAzpokbRcHXBjkw=; b=2nVTnOQmQYDKhGkDiqQ53tKYsE
	ZgEn0gutsCQda94DfTW2ZeEr4tGCqtCbbws1mGEAe4PV6i6PPMWWTEAZeMAzBc5/MBfp6zW+bzIOU
	akUTQmCDMaqZGWhZx4bNX+EW4Wei9UIr+uOfK0ymMdtGjAuMuSccXWwNpG5e4/l8A8cpQhHMe08Tz
	BDgQQUBdDvpKEOjWw+PhW4x1Y4ujXb8h3/ij9hBAi+ZBwEMq8spdxuk2fNxrY6LxpjPXVr0oG0oPd
	Lvu+bvbYkzpgOUtg8ZmvivPrWjvb82FfX/FmNACLArtEGiEWOFGWnmCZaD3okVz62HtTXvfi9IH+T
	QpxJr9Fg==;
Received: from 2a02-8389-2341-5b80-6f07-844f-67cc-150a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6f07:844f:67cc:150a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4qu-00000006AWy-0heh;
	Tue, 09 Jul 2024 07:01:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: [PATCH] block: take offset into account in blk_bvec_map_sg again
Date: Tue,  9 Jul 2024 09:01:25 +0200
Message-ID: <20240709070126.3019940-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The rebase of commit 09595e0c9d65 ("block: pass a phys_addr_t to
get_max_segment_size") lost adding the total to to the offset in
blk_bvec_map_sg.  Add it back.

Fixes: 09595e0c9d65 ("block: pass a phys_addr_t to get_max_segment_size")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Reported-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e41ea331809936..048d07a5091f79 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -491,8 +491,8 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 
 	while (nbytes > 0) {
 		unsigned offset = bvec->bv_offset + total;
-		unsigned len = get_max_segment_size(&q->limits, bvec_phys(bvec),
-			nbytes);
+		unsigned len = get_max_segment_size(&q->limits,
+				bvec_phys(bvec) + total, nbytes);
 		struct page *page = bvec->bv_page;
 
 		/*
-- 
2.43.0

