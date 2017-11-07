Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Minwoo Im <dn3108@gmail.com>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] null_blk: fix default values in documentation
Date: Tue,  7 Nov 2017 22:23:01 +0900
Message-Id: <1510060981-24352-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

null_blk.c has initial value of
(1) nr_devices as 1.
(2) completion_nsec as 10,000ns, not 10.000ns.
documentation should be updated for fixes above.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 Documentation/block/null_blk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index b7161c8..fcf7f84 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -38,7 +38,7 @@ gb=[Size in GB]: Default: 250GB
 bs=[Block size (in bytes)]: Default: 512 bytes
   The block size reported to the system.
 
-nr_devices=[Number of devices]: Default: 2
+nr_devices=[Number of devices]: Default: 1
   Number of block devices instantiated. They are instantiated as /dev/nullb0,
   etc.
 
@@ -52,7 +52,7 @@ irqmode=[0-2]: Default: 1-Soft-irq
   2: Timer: Waits a specific period (completion_nsec) for each IO before
      completion.
 
-completion_nsec=[ns]: Default: 10.000ns
+completion_nsec=[ns]: Default: 10,000ns
   Combined with irqmode=2 (timer). The time each completion event must wait.
 
 submit_queues=[1..nr_cpus]:
-- 
2.7.4
