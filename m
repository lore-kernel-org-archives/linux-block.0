Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C337713;
	Sun, 21 Jan 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868832; cv=none; b=aRwVA+srv5ScTzk0sug1oz6M77CKZ2dZOYXYOescMKaOXzOVkyYWJJfBrZV/Bqp/sfCt4lWW9A6NWqKoaZqa4rCwVl6VHAOoc8nULQYbrqbJYmCKE4Xbjq5BXj3aEjObP5r+8SWiJPsqZc4Xb4i5fVmOgz3Ol61RQnCIRWABUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868832; c=relaxed/simple;
	bh=uZiztjpinSS7Xdrx+6z3yfBDTTHpVfueyyjwSZhYKaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eopHBvg1iodqMpDfMtbmeSLfUv7CotjnhnT57vw//kzpiPqv8kBLMRCEtT0FfJJnUAGGwagWPz6KXcq8JcumDlEIFgtkAYGEqTfzXdMnmdKmnX6GfGVOL6dDfnyRCbijbv4WzPnmDL4Wp2ivl6Io4gpBQ0qkoj2ipPeASLFDd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id DBDBE1401CF; Sun, 21 Jan 2024 21:27:00 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com,
	syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] block: Fix WARNING in _copy_from_iter
Date: Sun, 21 Jan 2024 21:26:34 +0100
Message-Id: <20240121202634.275068-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reports a warning in _copy_from_iter because an
iov_iter is supposedly used in the wrong direction. The reason
is that syzcaller managed to generate a request with
a transfer direction of SG_DXFER_TO_FROM_DEV. This instructs
the kernel to copy user buffers into the kernel, read into
the copied buffers and then copy the data back to user space.

Thus the iovec is used in both directions.

Detect this situation in the block layer and construct a new
iterator with the correct direction for the copy-in.

Reported-by: syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000009b92c10604d7a5e9@google.com/t/
Reported-by: syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000003faaa105f6e7c658@google.com/T/
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 block/blk-map.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 8584babf3ea0..71210cdb3442 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -205,12 +205,19 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	/*
 	 * success
 	 */
-	if ((iov_iter_rw(iter) == WRITE &&
-	     (!map_data || !map_data->null_mapped)) ||
-	    (map_data && map_data->from_user)) {
+	if (iov_iter_rw(iter) == WRITE &&
+	     (!map_data || !map_data->null_mapped)) {
 		ret = bio_copy_from_iter(bio, iter);
 		if (ret)
 			goto cleanup;
+	} else if (map_data && map_data->from_user) {
+		struct iov_iter iter2 = *iter;
+
+		/* This is the copy-in part of SG_DXFER_TO_FROM_DEV. */
+		iter2.data_source = ITER_SOURCE;
+		ret = bio_copy_from_iter(bio, &iter2);
+		if (ret)
+			goto cleanup;
 	} else {
 		if (bmd->is_our_pages)
 			zero_fill_bio(bio);
-- 
2.40.1

