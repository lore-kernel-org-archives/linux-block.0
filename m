Return-Path: <prvs=011358c635=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/8] writeback: mark background writeback as such
Date: Tue, 1 Nov 2016 15:08:46 -0600
Message-ID: <1478034531-28559-4-git-send-email-axboe@fb.com>
In-Reply-To: <1478034531-28559-1-git-send-email-axboe@fb.com>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If we're doing background type writes, then use the appropriate
background write flags for that.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 include/linux/writeback.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 50c96ee8108f..c78f9f0920b5 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -107,6 +107,8 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
 {
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		return REQ_SYNC;
+	else if (wbc->for_kupdate || wbc->for_background)
+		return REQ_BACKGROUND;
 
 	return 0;
 }
-- 
2.7.4
