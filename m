Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F29CC38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0A42083B
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEGH4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 03:56:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbgEGH4A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:56:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95A0B72A110D85664A36;
        Thu,  7 May 2020 15:55:58 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:51 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Alasdair Kergon" <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, dm-devel <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 08/10] md: use sectors_to_npage() and npage_to_sectors() to clean up code
Date:   Thu, 7 May 2020 15:50:58 +0800
Message-ID: <20200507075100.1779-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200507075100.1779-1-thunder.leizhen@huawei.com>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

1. Replace ">> (PAGE_SHIFT - 9)" with sectors_to_npage()
2. Replace "<< (PAGE_SHIFT - 9)" with npage_to_sectors()

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/md/dm-table.c    |  2 +-
 drivers/md/raid1.c       |  2 +-
 drivers/md/raid10.c      |  2 +-
 drivers/md/raid5-cache.c | 11 +++++------
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0a2cc197f62b..e1f176bda528 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1964,7 +1964,7 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 #endif
 
 	/* Allow reads to exceed readahead limits */
-	q->backing_dev_info->io_pages = limits->max_sectors >> (PAGE_SHIFT - 9);
+	q->backing_dev_info->io_pages = sectors_to_npage(limits->max_sectors);
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index cd810e195086..44ffe1b6d77a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2129,7 +2129,7 @@ static void process_checks(struct r1bio *r1_bio)
 	int vcnt;
 
 	/* Fix variable parts of all bios */
-	vcnt = (r1_bio->sectors + PAGE_SIZE / 512 - 1) >> (PAGE_SHIFT - 9);
+	vcnt = sectors_to_npage(r1_bio->sectors + PAGE_SIZE / 512 - 1);
 	for (i = 0; i < conf->raid_disks * 2; i++) {
 		blk_status_t status;
 		struct bio *b = r1_bio->bios[i];
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ec136e44aef7..948afe720fca 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2029,7 +2029,7 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 	fbio->bi_iter.bi_idx = 0;
 	fpages = get_resync_pages(fbio)->pages;
 
-	vcnt = (r10_bio->sectors + (PAGE_SIZE >> 9) - 1) >> (PAGE_SHIFT - 9);
+	vcnt = sectors_to_npage(r10_bio->sectors + (PAGE_SIZE >> 9) - 1);
 	/* now find blocks with errors */
 	for (i=0 ; i < conf->copies ; i++) {
 		int  j, d;
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 9b6da759dca2..0b9cd810466a 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -832,8 +832,7 @@ static void r5l_append_payload_meta(struct r5l_log *log, u16 type,
 	payload = page_address(io->meta_page) + io->meta_offset;
 	payload->header.type = cpu_to_le16(type);
 	payload->header.flags = cpu_to_le16(0);
-	payload->size = cpu_to_le32((1 + !!checksum2_valid) <<
-				    (PAGE_SHIFT - 9));
+	payload->size = cpu_to_le32(npage_to_sectors(1 + !!checksum2_valid));
 	payload->location = cpu_to_le64(location);
 	payload->checksum[0] = cpu_to_le32(checksum1);
 	if (checksum2_valid)
@@ -1042,7 +1041,7 @@ int r5l_write_stripe(struct r5l_log *log, struct stripe_head *sh)
 
 	mutex_lock(&log->io_mutex);
 	/* meta + data */
-	reserve = (1 + write_disks) << (PAGE_SHIFT - 9);
+	reserve = npage_to_sectors(1 + write_disks);
 
 	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH) {
 		if (!r5l_has_free_space(log, reserve)) {
@@ -2053,7 +2052,7 @@ r5l_recovery_verify_data_checksum_for_mb(struct r5l_log *log,
 						  le32_to_cpu(payload->size));
 			mb_offset += sizeof(struct r5l_payload_data_parity) +
 				sizeof(__le32) *
-				(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
+				sectors_to_npage(le32_to_cpu(payload->size));
 		}
 
 	}
@@ -2199,7 +2198,7 @@ r5c_recovery_analyze_meta_block(struct r5l_log *log,
 
 		mb_offset += sizeof(struct r5l_payload_data_parity) +
 			sizeof(__le32) *
-			(le32_to_cpu(payload->size) >> (PAGE_SHIFT - 9));
+			sectors_to_npage(le32_to_cpu(payload->size));
 	}
 
 	return 0;
@@ -2916,7 +2915,7 @@ int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh)
 
 	mutex_lock(&log->io_mutex);
 	/* meta + data */
-	reserve = (1 + pages) << (PAGE_SHIFT - 9);
+	reserve = npage_to_sectors(1 + pages);
 
 	if (test_bit(R5C_LOG_CRITICAL, &conf->cache_state) &&
 	    sh->log_start == MaxSector)
-- 
2.26.0.106.g9fadedd


