Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B815C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7C2084E
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 17:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgBYROx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:14:53 -0500
Received: from mx1.emlix.com ([188.40.240.192]:54140 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbgBYROx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 12:14:53 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 12:14:52 EST
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B27595F906;
        Tue, 25 Feb 2020 18:09:32 +0100 (CET)
From:   =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
To:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
Subject: [PATCH] dm integrity: reinitialize __bi_remaining when reusing bio
Date:   Tue, 25 Feb 2020 18:07:44 +0100
Message-Id: <20200225170744.10485-1-dg@emlix.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In cases where dec_in_flight has to requeue the integrity_bio_wait work
to transfer the rest of the data, the __bi_remaining field of the bio
might already have been decremented to zero. Reusing the bio without
reinitializing that counter to 1 can then result in integrity_end_io
being called too early when the BIO_CHAIN flag is set, f.ex. due to
blk_queue_split. In our case this triggered the BUG() in
blk_mq_end_request when the hardware signalled completion of the bio
after integrity_end_io had modified it.

Signed-off-by: Daniel Glöckner <dg@emlix.com>
---
 drivers/md/dm-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b225b3e445fa..8cea2978fc24 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1438,6 +1438,7 @@ static void dec_in_flight(struct dm_integrity_io *dio)
 		if (likely(!bio->bi_status) && unlikely(bio_sectors(bio) != dio->range.n_sectors)) {
 			dio->range.logical_sector += dio->range.n_sectors;
 			bio_advance(bio, dio->range.n_sectors << SECTOR_SHIFT);
+			atomic_set(&bio->__bi_remaining, 1);
 			INIT_WORK(&dio->work, integrity_bio_wait);
 			queue_work(ic->wait_wq, &dio->work);
 			return;
-- 
2.17.1

