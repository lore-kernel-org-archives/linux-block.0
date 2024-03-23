Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CB1EB34
	for <linux-block@vger.kernel.org>; Sat, 23 Mar 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711210291; cv=none; b=nFti2RaiqFZ3HoQYqZIp6cFrrDtlG8eS5IdMdghh2I4ZivbJgPJRMTSctjVnJFCrX+KUEPcYyqIdHgzqEGdeoA0JXleNT0+/ulSjyH3zkIY0ESTaKc4Bke+LbtV7SlngZJby80OjmtXGyO7lt7iClIAxbyjk6ov5XDv9D1NCzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711210291; c=relaxed/simple;
	bh=rWhcbzwQd6R9rS3x+dE1gyVxbOyZBip+qIheG8D5z2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNjqfjqNRZMCBO6wjdefmMXnMA88bhpg2ZeR1quwuBSrr1ro5GpdEWKO6TIwAStNvFRW/tRFUXxJIHA7+deDLM+QJRnAoeW9gJ9v+NrTUNoxb1lm6MUG204OWJGwmQZR1PmH3bmKjcc3huuQATD64jB61fnDE8tKzsOFvzWpC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izm74HTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izm74HTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1713C433F1;
	Sat, 23 Mar 2024 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711210291;
	bh=rWhcbzwQd6R9rS3x+dE1gyVxbOyZBip+qIheG8D5z2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Izm74HTHhPVFR9dmYxdt5p7QSPmWITKRW87lYsZMyTx8y8iTGlJZKD3pfLnMDJJaO
	 8EBzVJH0y9DTwGEvq6cbC1bIfgf9rxLWXrUgeDhNVyjUZ+lKdwYj+hOIOFdQJXTvzC
	 FcRjNXO8gmO1YhxRAQVggtVaLpFw7u+yEyjKswLflahIZPuoni6VJrT/04JnzVyU7K
	 OaDSf9e61Kxl+z7v9ggkaFLQZcvN2qT4PZQDDq2hWmjkcaEp+yPWybFK3RVvggu5Xo
	 AyAVNX5JT4EkHWOfdzLnUCPjLmJXyRL3DjtcTJ8DjIjNVs5g1rerCyX0F6RFnslVA6
	 r/fowQoydAU9Q==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Date: Sat, 23 Mar 2024 17:11:19 +0100
Message-ID: <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240323-seide-erbrachten-5c60873fadc1@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner> 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; i=brauner@kernel.org; h=from:subject:message-id; bh=rWhcbzwQd6R9rS3x+dE1gyVxbOyZBip+qIheG8D5z2U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT++69RdiCmdMZ87rbTUy9MVFujNXczy13d0GzH1ic5d 4pPcfGf7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIsy3DX0HH7gvbJW+w7W+J VNt7sdcteRbTS5XYbSE/krzv8kx5/omR4VI5Tw7f4QPSj7b4t6yV1ijck/ScZeriqed39h4+6p0 jxQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
default this option is set. When it is set the long-standing behavior
of being able to write to mounted block devices is enabled.

But in order to guard against unintended corruption by writing to the
block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
off. In that case it isn't possible to write to mounted block devices
anymore.

A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
which disallows concurrent BLK_OPEN_WRITE access. When we still had the
bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
the mode was passed around. Since we managed to get rid of the bdev
handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
on whether the file was opened writable and writes to that block device
are blocked. That logic doesn't work because we do allow
BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.

So fix the detection logic. Use O_EXCL as an indicator that
BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
for pidfds where O_EXCL means that this is a pidfd that refers to a
thread. For userspace open paths O_EXCL will never be retained but for
internal opens where we open files that are never installed into a file
descriptor table this is fine.

Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
directly be raised by userspace. It is implicitly raised during
mounting.

Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
unset.

Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
Reported-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..f819f3086905 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -821,13 +821,12 @@ static void bdev_yield_write_access(struct file *bdev_file)
 		return;
 
 	bdev = file_bdev(bdev_file);
-	/* Yield exclusive or shared write access. */
-	if (bdev_file->f_mode & FMODE_WRITE) {
-		if (bdev_writes_blocked(bdev))
-			bdev_unblock_writes(bdev);
-		else
-			bdev->bd_writers--;
-	}
+
+	/* O_EXCL is only set for internal BLK_OPEN_RESTRICT_WRITES. */
+	if (bdev_file->f_flags & O_EXCL)
+		bdev_unblock_writes(bdev);
+	else if (bdev_file->f_mode & FMODE_WRITE)
+		bdev->bd_writers--;
 }
 
 /**
@@ -946,6 +945,13 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
 	else
 		WARN_ON_ONCE(true);
 
+	/*
+	 * BLK_OPEN_RESTRICT_WRITES is never set from userspace and
+	 * O_EXCL is stripped from userspace.
+	 */
+	if (mode & BLK_OPEN_RESTRICT_WRITES)
+		flags |= O_EXCL;
+
 	if (mode & BLK_OPEN_NDELAY)
 		flags |= O_NDELAY;
 
-- 
2.43.0

