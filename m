Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Minwoo Im <dn3108@gmail.com>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] null_blk: add an usage for shared tags in documentation
Date: Tue,  7 Nov 2017 23:18:27 +0900
Message-Id: <1510064307-20916-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

add usage explanation for a shared_tags of
commit 82f402fefa50f1675bf918bcd009981bd6b30ac8
("null_blk: add support for shared tags") to this documentation.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 Documentation/block/null_blk.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index b7161c8..e1d1aa9 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -77,3 +77,8 @@ use_lightnvm=[0/1]: Default: 0
 no_sched=[0/1]: Default: 0
   0: nullb* use default blk-mq io scheduler.
   1: nullb* doesn't use io scheduler.
+
+shared_tags=[0/1]: Default: 0
+  0: Tag set is not shared.
+  1: Tag set shared between devices for blk-mq.
+     Requires nr_devices to be bigger than 1.
-- 
2.7.4
