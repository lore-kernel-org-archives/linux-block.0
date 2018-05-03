Return-Path: <mpatocka@redhat.com>
Date: Thu, 3 May 2018 13:52:04 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] loop: enable compat ioctl LOOP_SET_DIRECT_IO
Message-ID: <alpine.LRH.2.02.1805031350520.32139@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Enable compat ioctl LOOP_SET_DIRECT_IO.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO")
Cc: stable@vger.kernel.org	# v4.4+

---
 drivers/block/loop.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/block/loop.c
===================================================================
--- linux-2.6.orig/drivers/block/loop.c	2018-04-30 00:30:38.000000000 +0200
+++ linux-2.6/drivers/block/loop.c	2018-05-03 18:49:44.000000000 +0200
@@ -1599,6 +1599,7 @@ static int lo_compat_ioctl(struct block_
 		arg = (unsigned long) compat_ptr(arg);
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
