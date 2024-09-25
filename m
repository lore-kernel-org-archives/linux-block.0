Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867C1D54C8;
	Wed, 25 Sep 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265647; cv=none; b=sLsaY0a00y8EUk0NSmvvVsOUerlfIKmbBfhX31kfzvGOlUfdLD6twbJtiwikM8uV8opQX0Bqo0gmBhtvbJkoBnEt+khFT3UlV0exUM/2nisDhuYyoILt4QDkszyNEbgSkKqR+hOnHBdCEQamL8+ZPt/Rk76TBzzZwolxHo9n35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265647; c=relaxed/simple;
	bh=QxlZ2PrFW2tXaV1J6jD8fqp4l9WrQ7MTgXtobGQEn1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRdLW3nhafCJqfpeeMrLKLpm9VTS8DFLaatlTNiNvE3yItEe9tUc7SIngTeiM91a5bXNEdOUWnFrQKbKYSl0/DbldaDoX5hwJIPoCo7CUEmC+T7wribDPHB9IXXpBx9Z3oLyYiujTmqmekPvEeEOUZu4ZxVHV/VhRyZ/p98orys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlwpkb6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlwpkb6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F82C4CEC3;
	Wed, 25 Sep 2024 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265647;
	bh=QxlZ2PrFW2tXaV1J6jD8fqp4l9WrQ7MTgXtobGQEn1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlwpkb6GdsPBGt6oxgOwUqNdYzS2IJQz8rqj7Vlu/Oi70kFCDcPeQZ4C/wzYI0A5B
	 LyblrxLH3iZjk0WwTnTb4IH0XwDyUUnIOkEJ9cw326eu8xhLgeAyM8GFuglybuqJNT
	 dvosYOLKVGge+psypSD/XKSRTwjZftwflPsSpzR92MwPjGrcriTotiITB8jxneC7Sb
	 7I2ea6Rf1gBpePeHHW7RWJwyP6cCRq8k+FPjrrHHLO1CxLAeVlzSgD/2qmM6qp1klk
	 QkYV6xbpyywuwxA9oQrF2PBYG/EKgVMrtgqf/Ox13bhGqdUoGK3HGQgCySbxOh8eAS
	 UvMDCCIPlXhkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 058/197] block: fix integer overflow in BLKSECDISCARD
Date: Wed, 25 Sep 2024 07:51:17 -0400
Message-ID: <20240925115823.1303019-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index d570e16958961..4515d4679eefd 100644
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

