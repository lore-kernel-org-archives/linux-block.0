Return-Path: <mpatocka@redhat.com>
Date: Thu, 3 May 2018 13:52:43 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] loop: enable compat ioctl LOOP_SET_BLOCK_SIZE
Message-ID: <alpine.LRH.2.02.1805031352070.32139@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Enable compat ioctl LOOP_SET_BLOCK_SIZE.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 89e4fdecb51c ("loop: add ioctl for changing logical block size")
Cc: stable@vger.kernel.org      # v4.14+

---
 drivers/block/loop.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/block/loop.c
===================================================================
--- linux-2.6.orig/drivers/block/loop.c	2018-05-03 19:48:04.000000000 +0200
+++ linux-2.6/drivers/block/loop.c	2018-05-03 19:48:32.000000000 +0200
@@ -1600,6 +1600,7 @@ static int lo_compat_ioctl(struct block_
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
 	case LOOP_SET_DIRECT_IO:
+	case LOOP_SET_BLOCK_SIZE:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
