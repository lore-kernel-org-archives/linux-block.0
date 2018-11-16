Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A9AC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C51921019
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C51921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeKPKqw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:46:52 -0500
Received: from 109-183-129-149.customers.tmcz.cz ([109.183.129.149]:46224 "EHLO
        leontynka.twibright.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPKqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 05:46:52 -0500
Received: from debian.vm ([192.168.192.2])
        by leontynka.twibright.com with smtp (Exim 4.89)
        (envelope-from <mpatocka@redhat.com>)
        id 1gNRdD-0001CU-6X; Fri, 16 Nov 2018 01:05:08 +0100
Received: by debian.vm (sSMTP sendmail emulation); Fri, 16 Nov 2018 01:05:06 +0100
Message-Id: <20181116000506.568964151@debian.vm>
User-Agent: quilt/0.65
Date:   Fri, 16 Nov 2018 01:04:17 +0100
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Mike Snitzer <msnitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 1/3] dm: move dm_stats_account_io before generic_end_io_acct
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=dm-stats-ordering.patch
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that the statistics are not updated while the device is
suspended. So, we move statistics update before generic_end_io_acct.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-dm/drivers/md/dm.c
===================================================================
--- linux-dm.orig/drivers/md/dm.c	2018-11-15 21:56:36.000000000 +0100
+++ linux-dm/drivers/md/dm.c	2018-11-15 21:56:36.000000000 +0100
@@ -674,6 +674,11 @@ static void end_io_acct(struct dm_io *io
 	struct bio *bio = io->orig_bio;
 	unsigned long duration = jiffies - io->start_time;
 
+	if (unlikely(dm_stats_used(&md->stats)))
+		dm_stats_account_io(&md->stats, bio_data_dir(bio),
+				    bio->bi_iter.bi_sector, bio_sectors(bio),
+				    true, duration, &io->stats_aux);
+
 	/*
 	 * make sure that atomic_dec in generic_end_io_acct is not reordered
 	 * with previous writes
@@ -687,11 +692,6 @@ static void end_io_acct(struct dm_io *io
 	 */
 	smp_mb__after_atomic();
 
-	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio_data_dir(bio),
-				    bio->bi_iter.bi_sector, bio_sectors(bio),
-				    true, duration, &io->stats_aux);
-
 	/* nudge anyone waiting on suspend queue */
 	if (unlikely(waitqueue_active(&md->wait))) {
 		if (!md_in_flight(md))

