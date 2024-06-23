Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FA18C335;
	Sun, 23 Jun 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150283; cv=none; b=HYLdnW+bMwfK6VfhbAYCXKd+Ob2W9i5HXgyz/iOgTDhE64ByMtWwjQYemxxNJIpDnAihchDCXhLyUZYvCKKCisHmcuI7eDrOadmO9ktueUbB+RR46I3GRy7EmLCbeHz8KY99c96KMqoBjOq2PSm5FNAyUHGi8Ve+B3ua811ChMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150283; c=relaxed/simple;
	bh=TIqYV/DnQm52v3SsiEvply4u33fseIDKi2tfoRZaOQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWLDhpjqg2ZnvZSTENXLTsGY1mFLBXDAq4L1OncOrOsFfWxNvS/KEthblYWid5e+VuermEIryWNefPwvx5vJJCVlJeESrqvsQSEnhMCcs2QtsCP2sAuzIJRtrYALrNM28P/z/H7gVoUfRR6xBFQoI5U7K6ecAb2PRh7ba8Xc+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1qb005i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1qb005i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84255C4AF07;
	Sun, 23 Jun 2024 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150283;
	bh=TIqYV/DnQm52v3SsiEvply4u33fseIDKi2tfoRZaOQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1qb005ijnbs6UgPT5vSDxr8BSLLsMEE68Yd8sQw0KiV+xrEBB2gYVwMc1WXLnwOI
	 FAQKXWYT+DwiDoGGM0kRWaMHfZIdYyf0MX5CO1SnekcM1ND6x9j1f10RefcUUuMzZ4
	 /WVYJ34MEXVq8HhLXt0ebK0ZzewXgaKYFRnI6aqSnUxZ/MTBTuCJk/seQZhe/FHsTB
	 GUE0xyldhWcoYHKutiGtaugofpGu8iZjSrgKQRXhdRKMGcQNqbC7k+5dwOgoBuxyvz
	 iJzdIPBvW0ukD4+DNjJxMUcyl8E6XN8OwMNOa/snFk/DG9qxssGOi/DucZc3CIpOJh
	 TxQMZuaesQhLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 21/21] loop: Disable fallocate() zero and discard if not supported
Date: Sun, 23 Jun 2024 09:43:54 -0400
Message-ID: <20240623134405.809025-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Cyril Hrubis <chrubis@suse.cz>

[ Upstream commit 5f75e081ab5cbfbe7aca2112a802e69576ee9778 ]

If fallcate is implemented but zero and discard operations are not
supported by the filesystem the backing file is on we continue to fill
dmesg with errors from the blk_mq_end_request() since each time we call
fallocate() on the loop device the EOPNOTSUPP error from lo_fallocate()
ends up propagated into the block layer. In the end syscall succeeds
since the blkdev_issue_zeroout() falls back to writing zeroes which
makes the errors even more misleading and confusing.

How to reproduce:

1. make sure /tmp is mounted as tmpfs
2. dd if=/dev/zero of=/tmp/disk.img bs=1M count=100
3. losetup /dev/loop0 /tmp/disk.img
4. mkfs.ext2 /dev/loop0
5. dmesg |tail

[710690.898214] operation not supported error, dev loop0, sector 204672 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.898279] operation not supported error, dev loop0, sector 522 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.898603] operation not supported error, dev loop0, sector 16906 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.898917] operation not supported error, dev loop0, sector 32774 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.899218] operation not supported error, dev loop0, sector 49674 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.899484] operation not supported error, dev loop0, sector 65542 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.899743] operation not supported error, dev loop0, sector 82442 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.900015] operation not supported error, dev loop0, sector 98310 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.900276] operation not supported error, dev loop0, sector 115210 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
[710690.900546] operation not supported error, dev loop0, sector 131078 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0

This patch changes the lo_fallocate() to clear the flags for zero and
discard operations if we get EOPNOTSUPP from the backing file fallocate
callback, that way we at least stop spewing errors after the first
unsuccessful try.

CC: Jan Kara <jack@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240613163817.22640-1-chrubis@suse.cz
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fea..95a468eaa7013 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -302,6 +302,21 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	return 0;
 }
 
+static void loop_clear_limits(struct loop_device *lo, int mode)
+{
+	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+
+	if (mode & FALLOC_FL_ZERO_RANGE)
+		lim.max_write_zeroes_sectors = 0;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		lim.max_hw_discard_sectors = 0;
+		lim.discard_granularity = 0;
+	}
+
+	queue_limits_commit_update(lo->lo_queue, &lim);
+}
+
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 			int mode)
 {
@@ -320,6 +335,14 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		return -EIO;
+
+	/*
+	 * We initially configure the limits in a hope that fallocate is
+	 * supported and clear them here if that turns out not to be true.
+	 */
+	if (unlikely(ret == -EOPNOTSUPP))
+		loop_clear_limits(lo, mode);
+
 	return ret;
 }
 
-- 
2.43.0

