Return-Path: <prvs=80513f069d=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/8] writeback: use WRITE_BG for kupdate and background writeback
Date: Wed, 31 Aug 2016 11:05:46 -0600
Message-ID: <1472663151-18560-4-git-send-email-axboe@fb.com>
In-Reply-To: <1472663151-18560-1-git-send-email-axboe@fb.com>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
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
index e1fc25172397..7fb80c78f159 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -104,6 +104,8 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
 {
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		return WRITE_SYNC;
+	else if (wbc->for_kupdate || wbc->for_background)
+		return WRITE_BG;
 
 	return WRITE;
 }
-- 
2.7.4
