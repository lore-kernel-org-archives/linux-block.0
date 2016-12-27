Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34056 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933003AbcL0QGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:06:55 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM)
Subject: [PATCH v1 03/54] kernel/power/swap.c: comment on direct access to bvec table
Date: Tue, 27 Dec 2016 23:55:52 +0800
Message-Id: <1482854250-13481-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 kernel/power/swap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 32e0c232efba..031e709c9fc4 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -238,6 +238,8 @@ static void hib_init_batch(struct hib_bio_batch *hb)
 static void hib_end_io(struct bio *bio)
 {
 	struct hib_bio_batch *hb = bio->bi_private;
+
+	/* single page bio, safe for multipage bvec */
 	struct page *page = bio->bi_io_vec[0].bv_page;
 
 	if (bio->bi_error) {
-- 
2.7.4

