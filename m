Return-Path: <mpatocka@redhat.com>
Date: Wed, 21 Mar 2018 12:42:25 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Mike Snitzer <msnitzer@redhat.com>
cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-alpha@vger.kernel.org
Subject: [PATCH] block: use 32-bit blk_status_t on Alpha
Message-ID: <alpine.LRH.2.02.1803211239490.23314@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Early alpha processors cannot write a single byte or word; they read 8
bytes, modify the value in registers and write back 8 bytes.

The type blk_status_t is defined as one byte, it is often written
asynchronously by I/O completion routines, this asynchronous modification
can corrupt content of nearby bytes if these nearby bytes can be written
simultaneously by another CPU.

- one example of such corruption is the structure dm_io where
  "blk_status_t status" is written by an asynchronous completion routine
  and "atomic_t io_count" is modified synchronously
- another example is the structure dm_buffer where "unsigned hold_count"
  is modified synchronously from process context and "blk_status_t
  write_error" is modified asynchronously from bio completion routine

This patch fixes the bug by changing the type blk_status_t to 32 bits if
we are on Alpha and if we are compiling for a processor that doesn't have
the byte-word-extension.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# 4.13+

---
 include/linux/blk_types.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/include/linux/blk_types.h
===================================================================
--- linux-2.6.orig/include/linux/blk_types.h	2018-02-14 20:24:42.038255000 +0100
+++ linux-2.6/include/linux/blk_types.h	2018-03-21 15:04:54.969999000 +0100
@@ -20,8 +20,13 @@ typedef void (bio_end_io_t) (struct bio
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
+ * Alpha cannot write a byte atomically, so we need to use 32-bit value.
  */
+#if defined(CONFIG_ALPHA) && !defined(__alpha_bwx__)
+typedef u32 __bitwise blk_status_t;
+#else
 typedef u8 __bitwise blk_status_t;
+#endif
 #define	BLK_STS_OK 0
 #define BLK_STS_NOTSUPP		((__force blk_status_t)1)
 #define BLK_STS_TIMEOUT		((__force blk_status_t)2)
