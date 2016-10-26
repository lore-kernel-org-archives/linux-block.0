Return-Path: <prvs=9107f69a83=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <kernel@kolivas.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/8] writeback: use WRITE_BG for kupdate and background writeback
Date: Wed, 26 Oct 2016 14:52:10 -0600
Message-ID: <1477515135-16469-4-git-send-email-axboe@fb.com>
In-Reply-To: <1477515135-16469-1-git-send-email-axboe@fb.com>
References: <1477515135-16469-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If we're doing background type writes, then use the appropriate
write command for that.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 include/linux/writeback.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 78b87c517b5f..f12f0b34daca 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -104,6 +104,8 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
 {
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		return WRITE_SYNC;
+	else if (wbc->for_kupdate || wbc->for_background)
+		return WRITE_BG;
 
 	return 0;
 }
-- 
2.7.4
