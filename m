Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <jbacik@fb.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: iolatency: avoid 64-bit division
Date: Tue, 10 Jul 2018 17:21:34 +0200
Message-Id: <20180710152146.2371336-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

On 32-bit architectures, dividing a 64-bit number needs to use the
do_div() function or something like it to avoid a link failure:

block/blk-iolatency.o: In function `iolatency_prfill_limit':
blk-iolatency.c:(.text+0x8cc): undefined reference to `__aeabi_uldivmod'

Using div_u64() gives us the best output and avoids the need for an
explicit cast.

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/blk-iolatency.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index a35a1f580337..56ddb2c68752 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -798,8 +798,7 @@ static u64 iolatency_prfill_limit(struct seq_file *sf,
 	if (!dname || !iolat->min_lat_nsec)
 		return 0;
 	seq_printf(sf, "%s target=%llu\n",
-		   dname,
-		   (unsigned long long)iolat->min_lat_nsec / NSEC_PER_USEC);
+		   dname, div_u64(iolat->min_lat_nsec, NSEC_PER_USEC));
 	return 0;
 }
 
-- 
2.9.0
