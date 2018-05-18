Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 09/10] block: Export bio check/set pages_dirty
Date: Fri, 18 May 2018 03:49:15 -0400
Message-Id: <20180518074918.13816-18-kent.overstreet@gmail.com>
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 5c81391100..6689102f5d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1610,6 +1610,7 @@ void bio_set_pages_dirty(struct bio *bio)
 			set_page_dirty_lock(page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 static void bio_release_pages(struct bio *bio)
 {
@@ -1693,6 +1694,7 @@ void bio_check_pages_dirty(struct bio *bio)
 		bio_put(bio);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 void generic_start_io_acct(struct request_queue *q, int rw,
 			   unsigned long sectors, struct hd_struct *part)
-- 
2.17.0
