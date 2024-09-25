Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13681A42C8;
	Wed, 25 Sep 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264372; cv=none; b=beSrUd2MbCgB8G3Q7sviXFd18lNIdPbIPaC9UnK71vCQ4iMYNlamiXMGG9kOu/SCiow6gFLoF11/axDlMNHe0BDcWHtBCZhDeqBqXYlmiHb1+WFSTI8G8E53feKAHFlum1fGle154poB7ddlltGbO+tB4V+2I9Pwwk9AAOaSqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264372; c=relaxed/simple;
	bh=XIaR4b2RFvnT3nnhN99ZcSyml2A2aiinREcuo00Y1VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbMPit1NrqC5Z+lUuQzqLGzAYv0pkHNbh61Ls5WsutsBWspquZ7XqIQkDhEiCaxJYXkIyGJLRjCDO5Jyp0u7P2gJni6tsnjhb4ONSCg+rSZVeTzAmFZ2J5dkZyDVw4LvjYVWPMt7SObx5NjlL50FzbZbQbW7MvvRq1dYcA2kekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnRfL3fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnRfL3fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847B9C4CEC7;
	Wed, 25 Sep 2024 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264371;
	bh=XIaR4b2RFvnT3nnhN99ZcSyml2A2aiinREcuo00Y1VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnRfL3fpLtdeBgqUvA9NI4o24rZuyMnh92kwJypwG5Kop/KP+VgpwrrI/l6fJXZhO
	 piQYiV3sjGOtjE2c7sbEN7RW5nYUKLAW+jZCJzJoSAEUaZujNJxZgmcKPTiwquZ8ym
	 YX3bx/1yuZrX9DxYWe0kStBbyosPI8I59trqnyaNG6+Z8EBDKQvavt9bIkP6oRB5D8
	 66ncGHvdixxb96sq+3MJ+RA/rzxZ7Lf6BF0sroavcRAZhfOkmf0b5zmL4jwLDybgvo
	 DNb/xXa5GqEfmCqTjCWiMYGK+Pmw1y4JPJLgngRv0jF23aFFuEJapeniI8Rrh3EUQj
	 a7W6oIL2J0ILA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 071/244] block: fix integer overflow in BLKSECDISCARD
Date: Wed, 25 Sep 2024 07:24:52 -0400
Message-ID: <20240925113641.1297102-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 697ba0b6ec4ae04afb67d3911799b5e2043b4455 ]

I independently rediscovered

	commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155
	block: fix overflow in blk_ioctl_discard()

but for secure erase.

Same problem:

	uint64_t r[2] = {512, 18446744073709551104ULL};
	ioctl(fd, BLKSECDISCARD, r);

will enter near infinite loop inside blkdev_issue_secure_erase():

	a.out: attempt to access beyond end of device
	loop0: rw=5, sector=3399043073, nr_sectors = 1024 limit=2048
	bio_check_eod: 3286214 callbacks suppressed

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/r/9e64057f-650a-46d1-b9f7-34af391536ef@p183
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index e8e4a4190f183..44257bdfeacbf 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -126,7 +126,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (err)
 		goto fail;
 
@@ -163,7 +163,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
-	uint64_t start, len;
+	uint64_t start, len, end;
 	uint64_t range[2];
 	int err;
 
@@ -178,11 +178,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	len = range[1];
 	if ((start & 511) || (len & 511))
 		return -EINVAL;
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
-- 
2.43.0

