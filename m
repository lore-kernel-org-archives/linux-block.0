Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62831181319
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708362; cv=none; b=goW0GZtXpvH0zicfelKt7xtD8N4MwT0ZKuUb/SPi8ghxVIy2YhoJoV2hpwe+Dsx5Wynl4Lvob63cYA/YhPdyjJRB2W4S/QzxJVNj+tN6fxcuB3BEYCFYVejqmfLXAzivg9Cryj0beMAAOPZ9Km/9sY3LNLFlEVkZ5zShB+vGK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708362; c=relaxed/simple;
	bh=nKOQbmAsvRgnkJlMIxmUUs3nh180UwytsivOS6qm4gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LW5dr1TRw84jk2xDcNK4Ne5ilelnuRBbKrPHQIZv6DIpTPVeEoNChAOi84VC34Jsn/jkrEOtGNL5naMDJ+j4xsHBrtFLIkEqo7nM0WmppPvH4sofbfGi9c95yOGSb36arecGf+6kqypsnptqK8fUgSD7itQClDRRYYsc9kI54h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW7ST2nZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW7ST2nZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA59C32782;
	Tue, 14 May 2024 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708362;
	bh=nKOQbmAsvRgnkJlMIxmUUs3nh180UwytsivOS6qm4gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sW7ST2nZRp4Av9CDL8V23mKnU7oTtIBdSSH61U5juZ85jhYI+AcUuJKbZ8oRTzzkc
	 yNzxKK04R56Tm3y4e28RkiPrEbCjfZS9/rLwb4I7MV6ZXQ7MmVTh6u7pfieQ92F7DO
	 JyVO4PcvvMBLHvwiZzc85ECea34JQ4fyngtKlc694M9DEETWI0uONbN2er/1L2HiY3
	 LW0i56JD1gVAA3zrZ8pwzjXJQkJRrwzLIJ2DrOWCD8shEQMcmTgu8IFnkDA3IkpMR/
	 kAa1oA9n0aLYaoxUxQ3bOLMGXQaQFsNAcuxdMJfWHf0XAyGgRCOy018ASzpyzF9b9/
	 ThDAJLpycXuAw==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/6] blk-merge: split bio by max_segment_size, not PAGE_SIZE
Date: Tue, 14 May 2024 19:38:57 +0200
Message-Id: <20240514173900.62207-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bvecs can be larger than a page, and the block layer handles
this just fine. So do not split by PAGE_SIZE but rather by
the max_segment_size if that happens to be larger.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4e3483a16b75..570573d7a34f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,6 +278,7 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
+	unsigned bv_seg_lim = max(PAGE_SIZE, lim->max_segment_size);
 
 	bio_for_each_bvec(bv, bio, iter) {
 		/*
@@ -289,7 +290,7 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
-		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+		    bv.bv_offset + bv.bv_len <= bv_seg_lim) {
 			nsegs++;
 			bytes += bv.bv_len;
 		} else {
-- 
2.35.3

