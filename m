Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D09C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F6820863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F6820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLAJdT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeLAJdT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB9B43138BA5;
        Fri, 30 Nov 2018 22:22:32 +0000 (UTC)
Received: from localhost (unknown [10.16.197.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41A9918C5A;
        Fri, 30 Nov 2018 22:22:30 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 1/6] dm: dont rewrite dm_disk(md)->part0.in_flight
Date:   Fri, 30 Nov 2018 17:22:21 -0500
Message-Id: <20181130222226.77216-2-snitzer@redhat.com>
In-Reply-To: <20181130222226.77216-1-snitzer@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 30 Nov 2018 22:22:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

generic_start_io_acct and generic_end_io_acct already update the variable
in_flight using atomic operations, so we don't have to overwrite them
again.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a733e4c920af..a8ae7931bce7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -663,8 +663,7 @@ static void start_io_acct(struct dm_io *io)
 	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
 			      &dm_disk(md)->part0);
 
-	atomic_set(&dm_disk(md)->part0.in_flight[rw],
-		   atomic_inc_return(&md->pending[rw]));
+	atomic_inc(&md->pending[rw]);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
@@ -693,7 +692,6 @@ static void end_io_acct(struct dm_io *io)
 	 * a flush.
 	 */
 	pending = atomic_dec_return(&md->pending[rw]);
-	atomic_set(&dm_disk(md)->part0.in_flight[rw], pending);
 	pending += atomic_read(&md->pending[rw^0x1]);
 
 	/* nudge anyone waiting on suspend queue */
-- 
2.15.0

