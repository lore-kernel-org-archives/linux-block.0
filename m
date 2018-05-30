Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block/020: not pass shared_tags to null_blk
Date: Wed, 30 May 2018 13:10:38 +0800
Message-Id: <20180530051038.9192-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The issue isn't related with shared tag, and it can be
triggered in case 'shared_tags' is set as 0.

Remove this so that this test can be run in older kernel, and
avoid to cause misunderstanding.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/020 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/020 b/tests/block/020
index 40a8151c90a8..36140136369b 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -31,7 +31,7 @@ test() {
 
 	modprobe -r null_blk
 	modprobe null_blk queue_mode=2 irqmode=2 completion_nsec=2000000 \
-		shared_tags=1 submit_queues=4 hw_queue_depth=1
+		submit_queues=4 hw_queue_depth=1
 
 	local scheds
 	# shellcheck disable=SC2207
-- 
2.9.5
