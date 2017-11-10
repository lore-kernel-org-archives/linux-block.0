Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbdKJR3p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 12:29:45 -0500
Date: Fri, 10 Nov 2017 12:29:34 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
cc: Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com
Subject: [PATCH] brd: remove unused brd_mutex
Message-ID: <alpine.LRH.2.02.1711101228030.15978@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove unused mutex brd_mutex. It is unused since the commit ff26956875c2
("brd: remove support for BLKFLSBUF").

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -60,7 +60,6 @@ struct brd_device {
 /*
  * Look up and return a brd's page for a given sector.
  */
-static DEFINE_MUTEX(brd_mutex);
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
