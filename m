Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33735 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755095AbdCPQO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2017 12:14:28 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v3 06/14] md: raid1: retrieve page from pre-allocated resync page array
Date: Fri, 17 Mar 2017 00:12:27 +0800
Message-Id: <20170316161235.27110-7-tom.leiming@gmail.com>
In-Reply-To: <20170316161235.27110-1-tom.leiming@gmail.com>
References: <20170316161235.27110-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now one page array is allocated for each resync bio, and we can
retrieve page from this table directly.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/raid1.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 0e64beb60e4d..b1345aa4efd8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1992,6 +1992,7 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 	struct mddev *mddev = r1_bio->mddev;
 	struct r1conf *conf = mddev->private;
 	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
+	struct page **pages = get_resync_pages(bio)->pages;
 	sector_t sect = r1_bio->sector;
 	int sectors = r1_bio->sectors;
 	int idx = 0;
@@ -2025,7 +2026,7 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				 */
 				rdev = conf->mirrors[d].rdev;
 				if (sync_page_io(rdev, sect, s<<9,
-						 bio->bi_io_vec[idx].bv_page,
+						 pages[idx],
 						 REQ_OP_READ, 0, false)) {
 					success = 1;
 					break;
@@ -2080,7 +2081,7 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				continue;
 			rdev = conf->mirrors[d].rdev;
 			if (r1_sync_page_io(rdev, sect, s,
-					    bio->bi_io_vec[idx].bv_page,
+					    pages[idx],
 					    WRITE) == 0) {
 				r1_bio->bios[d]->bi_end_io = NULL;
 				rdev_dec_pending(rdev, mddev);
@@ -2095,7 +2096,7 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				continue;
 			rdev = conf->mirrors[d].rdev;
 			if (r1_sync_page_io(rdev, sect, s,
-					    bio->bi_io_vec[idx].bv_page,
+					    pages[idx],
 					    READ) != 0)
 				atomic_add(s, &rdev->corrected_errors);
 		}
@@ -2171,6 +2172,8 @@ static void process_checks(struct r1bio *r1_bio)
 		struct bio *pbio = r1_bio->bios[primary];
 		struct bio *sbio = r1_bio->bios[i];
 		int error = sbio->bi_error;
+		struct page **ppages = get_resync_pages(pbio)->pages;
+		struct page **spages = get_resync_pages(sbio)->pages;
 
 		if (sbio->bi_end_io != end_sync_read)
 			continue;
@@ -2179,11 +2182,8 @@ static void process_checks(struct r1bio *r1_bio)
 
 		if (!error) {
 			for (j = vcnt; j-- ; ) {
-				struct page *p, *s;
-				p = pbio->bi_io_vec[j].bv_page;
-				s = sbio->bi_io_vec[j].bv_page;
-				if (memcmp(page_address(p),
-					   page_address(s),
+				if (memcmp(page_address(ppages[j]),
+					   page_address(spages[j]),
 					   sbio->bi_io_vec[j].bv_len))
 					break;
 			}
-- 
2.9.3
