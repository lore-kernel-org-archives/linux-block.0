Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD6299519;
	Mon,  5 May 2025 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483551; cv=none; b=O/ZC6mSqqGlwtj1n5iUGvYbRgPrwAIi1r2XGxxfTBVA4KY8GSGhxVqUMseNOnIFx4fkoBCcYpsethZh48UiLmLVF7OqbvKKnv20SkD2y431tsoPSmpcS6lLCSLb8hJDkCH01qox3mgZj8ITPyD/tEgt/XRzdLnQrol36BHoVPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483551; c=relaxed/simple;
	bh=QL4gmOou27FiA2cyq+YVbRH0eLxZ83fsLyKYsmU9g7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QnL7XL92Fn8FjoG+3wvejCyGMvy7fzMrf7Xe6HpgTzYRZ956eWEwVNT4s8FnydZuLhMH8j71pUDSITOBVP0qK+aCQCLZXRAI7PsgRJA9p0aBFStmimllK4KMrr/QKD5p3D1HvUh+fL5FDgCghv8knCRs/JgdLATVcQMrqbR4Wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+GSQ5t+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+GSQ5t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B7C4CEEE;
	Mon,  5 May 2025 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483551;
	bh=QL4gmOou27FiA2cyq+YVbRH0eLxZ83fsLyKYsmU9g7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+GSQ5t+G/5k0RHwnrNknxjLq15VeXPHoc1cvaWFvkKz0hzpPBkd2uAo2Rhp9ejQF
	 RkEC0RV/cAjqD3cD78V21DqI+plI7/3uiRvOLICuD3ZEsaiBbv7q7uT1igMg1D8PzR
	 /F1SEAXOOr4y9KRZ9HUUlQOCAT8tTdXlz92maP0JKq6R5tbJOwuqPpkhivMGL68z3a
	 P0pkjUn0DurzHG9BOayIQhgeaJUedS9AF0/WJACAd5pfCn72h+5aYoMo5bCDISVJAF
	 xwQtVWCwdBN3sFxaPu9zcmm7TogZqGpDUZpX2CYd8Ezzpx1tLNM2w+QPI0AH8lvlEN
	 w+h7b2Lg/SE9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 111/642] loop: move vfs_fsync() out of loop_update_dio()
Date: Mon,  5 May 2025 18:05:27 -0400
Message-Id: <20250505221419.2672473-111-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 86947bdc28894520ed5aab0cf21b99ff0b659e07 ]

If vfs_flush() is called with queue frozen, the queue freeze lock may be
connected with FS internal lock, and lockdep warning can be triggered
because the queue freeze lock is connected with too many global or
sub-system locks.

Fix the warning by moving vfs_fsync() out of loop_update_dio():

- vfs_fsync() is only needed when switching to dio

- only loop_change_fd() and loop_configure() may switch from buffered
IO to direct IO, so call vfs_fsync() directly here. This way is safe
because either loop is in unbound, or new file isn't attached

- for the other two cases of set_status and set_block_size, direct IO
can only become off, so no need to call vfs_fsync()

Cc: Christoph Hellwig <hch@infradead.org>
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
Closes: https://lore.kernel.org/linux-block/359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn/T/#u
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250318072955.3893805-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7668b79d8b0a9..1a90d7bd212e6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -205,8 +205,6 @@ static bool lo_can_use_dio(struct loop_device *lo)
  */
 static inline void loop_update_dio(struct loop_device *lo)
 {
-	bool dio_in_use = lo->lo_flags & LO_FLAGS_DIRECT_IO;
-
 	lockdep_assert_held(&lo->lo_mutex);
 	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
 		     lo->lo_queue->mq_freeze_depth == 0);
@@ -215,10 +213,6 @@ static inline void loop_update_dio(struct loop_device *lo)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
-
-	/* flush dirty pages before starting to issue direct I/O */
-	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
-		vfs_fsync(lo->lo_backing_file, 0);
 }
 
 /**
@@ -545,6 +539,13 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
 		goto out_err;
 
+	/*
+	 * We might switch to direct I/O mode for the loop device, write back
+	 * all dirty data the page cache now that so that the individual I/O
+	 * operations don't have to do that.
+	 */
+	vfs_fsync(file, 0);
+
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
@@ -1023,6 +1024,13 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
+	/*
+	 * We might switch to direct I/O mode for the loop device, write back
+	 * all dirty data the page cache now that so that the individual I/O
+	 * operations don't have to do that.
+	 */
+	vfs_fsync(file, 0);
+
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-- 
2.39.5

