Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958D20124B;
	Thu,  1 Aug 2024 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471500; cv=none; b=uoJ0C+dnFDz+jKcd1/J/owCiLNzq+NIvx+ztWJ5u/Pmp66BiM9WOP5HO9jRAw/uxJ+lm/Jx4vU5CsbSC4rEw58Ib4Qy0mPr9ffUqny1ekIEtUpoULzdphlaU2Ir/VotYjIt2eCBTcjjaF5t7JKjWa9sFRq9bOjPXZiU7mkRawaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471500; c=relaxed/simple;
	bh=uBph3efFG9HrQy6rP0uFdUZbaR0H4P06F2wEw3Aha88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxHoNEecMa0n9TANHskmBJijWPBs4JwQX9oDezroPVoexJ0qJ+2hj09JA4dPr0RoSdhcRZuol7QzCIq6Sf5B+3iQ+PgaqZFEzTvdKYYA0gPiMWKoFWLEoRsRFCuNrBdJ/J6enOEFPZMli/G7W89Lkk1ZbQ8iLOfYoSF3U6x8fVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUOH9RY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUOH9RY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AFBC116B1;
	Thu,  1 Aug 2024 00:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471500;
	bh=uBph3efFG9HrQy6rP0uFdUZbaR0H4P06F2wEw3Aha88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUOH9RY8y/IU2eX0hdCsxmDsTkS/YWlUTQIW3exDkImuW9daGzVX1eoI2H31Tej26
	 yVr627jOAv8LYnH1WNgMV96wg7ozb14MQ2Oyko28IcUx8ouIg61cu1nMpfQ9tqdBN6
	 KW+l6edfMXjaFSTXOknjXQ7t2A5LMC0dazDRB4q4R71JTWcRsn0eg4dMgVvXzzDca5
	 aOAdrZcVLRz8Jihz9GIF0T5Ju+SVdLKzA6UlJ6RhANRwWiIdU3XMPRYRhk6v9rkhL4
	 4blN5Q4v35ceyTQHJEK52eXg2c7JgG7mj3JNZh3bOdxmqcT4qF2GqRvWuFOUtZS5oW
	 2e6FU3xoDaPQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 114/121] block: factor out a blk_write_zeroes_limit helper
Date: Wed, 31 Jul 2024 20:00:52 -0400
Message-ID: <20240801000834.3930818-114-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 73a768d5f95533574bb8ace34eb683a88c40509e ]

Contrary to the comment in __blkdev_issue_write_zeroes, nothing here
checks for a potential bi_size overflow.  Add a helper mirroring
the secure erase code for the check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20240701165219.1571322-6-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-lib.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 442da9dad0421..297bcf6896930 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -103,24 +103,28 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+static sector_t bio_write_zeroes_limit(struct block_device *bdev)
+{
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+
+	return min(bdev_write_zeroes_sectors(bdev),
+		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
+}
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
 {
 	struct bio *bio = *biop;
-	unsigned int max_sectors;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
-
-	/* Ensure that max_sectors doesn't overflow bi_size */
-	max_sectors = bdev_write_zeroes_sectors(bdev);
-
-	if (max_sectors == 0)
+	if (!bdev_write_zeroes_sectors(bdev))
 		return -EOPNOTSUPP;
 
 	while (nr_sects) {
-		unsigned int len = min_t(sector_t, nr_sects, max_sectors);
+		unsigned int len = min_t(sector_t, nr_sects,
+				bio_write_zeroes_limit(bdev));
 
 		bio = blk_next_bio(bio, bdev, 0, REQ_OP_WRITE_ZEROES, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
-- 
2.43.0

