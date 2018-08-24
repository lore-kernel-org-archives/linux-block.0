Return-Path: <keescook@chromium.org>
Return-Path: <keescook@chromium.org>
Date: Fri, 24 Aug 2018 14:15:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <20180824211535.GA22251@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

As described in commit 96c6a32ccb55a ("include/asm-generic/bug.h: clarify
valid uses of WARN()"), this replaces a userspace-reachable WARN_ON()
with pr_warn_once(). The reachability is even noted in the existing
comment. This appears to be an "expected by unlikely" condition, so
getting rid of the WARN_ON() means kernel fuzzers will stop reporting
the problem. Additionally un-breaks the error string so it can more
easily be found with grep.

Reported-by: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 block/blk-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dee56c282efb..470c3cea8cb0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2166,11 +2166,9 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
 		char b[BDEVNAME_SIZE];
 
-		WARN_ONCE(1,
-		       "generic_make_request: Trying to write "
-			"to read-only block-device %s (partno %d)\n",
+		/* Older lvm-tools actually triggers this. */
+		pr_warn_once("Trying to write to read-only block-device %s (partno %d)\n",
 			bio_devname(bio, b), part->partno);
-		/* Older lvm-tools actually trigger this */
 		return false;
 	}
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
