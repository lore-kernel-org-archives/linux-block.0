Return-Path: <mpatocka@redhat.com>
Date: Mon, 3 Sep 2018 18:05:42 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Ilya Dryomov <idryomov@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>, WGH <wgh@torlan.ru>,
        linux-block@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] block: don't warn when calling fsync on read-only block
 devices
In-Reply-To: <222ce989-dbb9-b994-a97f-4dce04f5bc69@kernel.dk>
Message-ID: <alpine.LRH.2.02.1809031725530.27063@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808221217030.30929@file01.intranet.prod.int.rdu2.redhat.com> <222ce989-dbb9-b994-a97f-4dce04f5bc69@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>



On Wed, 22 Aug 2018, Jens Axboe wrote:

> On 8/22/18 10:23 AM, Mikulas Patocka wrote:
> > It is possible to call fsync on a read-only handle (for example, fsck.ext2 
> > does it when doing read-only check), and this call results in kernel 
> > warning. This bug was introduced by the commit 721c7fc701c7 "block: fail 
> > op_is_write() requests to read-only partitions".
> 
> Similar patch is already queued up, it'll go into Linus's tree before
> -rc1.
> 
> -- 
> Jens Axboe

I think you mean the patch b089cfd95d32638335c551651a8e00fd2c4edb0b, but 
it doesn't work.

The first problem is that bio_op returns the opcode, but op_is_flush 
expects flags as its parameter. bio_op strips off the flags, and so the 
condition op_is_flush is never true and the warning is not shut off.

Anoher problem is that the flags REQ_FUA and REQ_PREFLUSH may be 
superimposed on regular write bio and in that case the warning should be 
triggered. We want to shut the warning off only if bio_sectors is zero 
(i.e. if the flush request is not superimposed on regular write).

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] block: don't warn when doing fsync on read-only devices

It is possible to call fsync on a read-only handle (for example, fsck.ext2
does it when doing read-only check), and this call results in kernel
warning.

The patch b089cfd95d32 ("block: don't warn for flush on read-only device")
attempted to disable the warning, but it is buggy and it doesn't
(op_is_flush tests flags, but bio_op strips off the flags).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 721c7fc701c7 ("block: fail op_is_write() requests to read-only partitions")
Cc: stable@vger.kernel.org	# 4.18

---
 block/blk-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/block/blk-core.c
===================================================================
--- linux-2.6.orig/block/blk-core.c	2018-09-03 23:32:38.550000000 +0200
+++ linux-2.6/block/blk-core.c	2018-09-03 23:33:11.960000000 +0200
@@ -2163,9 +2163,12 @@ static inline bool bio_check_ro(struct b
 {
 	const int op = bio_op(bio);
 
-	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
+	if (part->policy && op_is_write(op)) {
 		char b[BDEVNAME_SIZE];
 
+		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
+			return false;
+
 		WARN_ONCE(1,
 		       "generic_make_request: Trying to write "
 			"to read-only block-device %s (partno %d)\n",
