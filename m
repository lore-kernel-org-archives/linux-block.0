Return-Path: <prvs=80586c83e0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/8] writeback: use WRITE_BG for kupdate and background writeback
Date: Wed, 7 Sep 2016 08:46:45 -0600
Message-ID: <1473259610-3295-4-git-send-email-axboe@fb.com>
In-Reply-To: <1473259610-3295-1-git-send-email-axboe@fb.com>
References: <1473259610-3295-1-git-send-email-axboe@fb.com>
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
index 608afd39b1c2..e53abf2bf2d8 100644
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
