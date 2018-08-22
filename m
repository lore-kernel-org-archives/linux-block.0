Return-Path: <mpatocka@redhat.com>
Date: Wed, 22 Aug 2018 12:23:03 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Ilya Dryomov <idryomov@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>, WGH <wgh@torlan.ru>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: don't warn when calling fsync on read-only block
 devices
Message-ID: <alpine.LRH.2.02.1808221217030.30929@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

It is possible to call fsync on a read-only handle (for example, fsck.ext2 
does it when doing read-only check), and this call results in kernel 
warning. This bug was introduced by the commit 721c7fc701c7 "block: fail 
op_is_write() requests to read-only partitions".

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 721c7fc701c7 ("block: fail op_is_write() requests to read-only partitions")
Cc: stable@vger.kernel.org	# 4.18

---
 block/blk-core.c              |    3 +++
 drivers/md/dm-verity-target.c |   33 +++++++++++++++++----------------
 2 files changed, 20 insertions(+), 16 deletions(-)

Index: linux-2.6/block/blk-core.c
===================================================================
--- linux-2.6.orig/block/blk-core.c	2018-08-15 16:47:18.930000000 +0200
+++ linux-2.6/block/blk-core.c	2018-08-22 16:37:19.680000000 +0200
@@ -2155,6 +2155,9 @@ static inline bool bio_check_ro(struct b
 	if (part->policy && op_is_write(bio_op(bio))) {
 		char b[BDEVNAME_SIZE];
 
+		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
+			return false;
+
 		WARN_ONCE(1,
 		       "generic_make_request: Trying to write "
 			"to read-only block-device %s (partno %d)\n",
