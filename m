Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB48C433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281BB20679
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bud8UMHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFAMhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgFAMhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 08:37:19 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD2C061A0E;
        Mon,  1 Jun 2020 05:37:19 -0700 (PDT)
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B906A2E150E;
        Mon,  1 Jun 2020 15:37:17 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id ai6aEALE3J-bGICEg7u;
        Mon, 01 Jun 2020 15:37:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591015037; bh=4hRg9MCRpNZccDrLqlIWiCiQ6475nINTgczAmQWqMOs=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=bud8UMHhYef3bRfb9uNwEFOltll5+Dvg3jOm9Z3wH09FN14zy3bnVUx+H45M1cz5i
         /oE5ny7AHRo8QeTrKkL19r0gR7ttOSCGxQSGU+6kWQABFZoO/P+CEPDlkdne/3YR5e
         xz9oJ8oG6fzCU/SjZZE8JAUhtIcTcFY2LJux/gyw=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6420::1:8])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ugeF6tCqFx-bGWetb0e;
        Mon, 01 Jun 2020 15:37:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 3/3] dm: add support for REQ_NOWAIT and enable for target
 dm-linear
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>
Date:   Mon, 01 Jun 2020 15:37:16 +0300
Message-ID: <159101503621.180989.6036577504611218020.stgit@buzz>
In-Reply-To: <159101473169.180989.12175693728191972447.stgit@buzz>
References: <159101473169.180989.12175693728191972447.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add dm target feature flag DM_TARGET_NOWAIT which tells that target
has no problem with REQ_NOWAIT.

Set limits.nowait_requests if all targets and backends handle REQ_NOWAIT.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/md/dm-linear.c        |    5 +++--
 drivers/md/dm-table.c         |    3 +++
 drivers/md/dm.c               |    4 +++-
 include/linux/device-mapper.h |    6 ++++++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index e1db43446327..00774b5d7668 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -228,10 +228,11 @@ static struct target_type linear_target = {
 	.name   = "linear",
 	.version = {1, 4, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
-	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_ZONED_HM,
+	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
+		    DM_TARGET_ZONED_HM,
 	.report_zones = linear_report_zones,
 #else
-	.features = DM_TARGET_PASSES_INTEGRITY,
+	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0a2cc197f62b..f4610f79ebd6 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1500,12 +1500,15 @@ int dm_calculate_queue_limits(struct dm_table *table,
 	unsigned int zone_sectors = 0;
 
 	blk_set_stacking_limits(limits);
+	limits->nowait_requests = 1;
 
 	for (i = 0; i < dm_table_get_num_targets(table); i++) {
 		blk_set_stacking_limits(&ti_limits);
 
 		ti = dm_table_get_target(table, i);
 
+		ti_limits.nowait_requests = dm_target_supports_nowait(ti->type);
+
 		if (!ti->type->iterate_devices)
 			goto combine_limits;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index db9e46114653..767cd4d70341 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1794,7 +1794,9 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
 		dm_put_live_table(md, srcu_idx);
 
-		if (!(bio->bi_opf & REQ_RAHEAD))
+		if (bio->bi_opf & REQ_NOWAIT)
+			bio_wouldblock_error(bio);
+		else if (!(bio->bi_opf & REQ_RAHEAD))
 			queue_io(md, bio);
 		else
 			bio_io_error(bio);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index af48d9da3916..4d4af1eeeba4 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -252,6 +252,12 @@ struct target_type {
 #define DM_TARGET_ZONED_HM		0x00000040
 #define dm_target_supports_zoned_hm(type) ((type)->features & DM_TARGET_ZONED_HM)
 
+/*
+ * A target handles REQ_NOWAIT
+ */
+#define DM_TARGET_NOWAIT		0x00000080
+#define dm_target_supports_nowait(type) (!!((type)->features & DM_TARGET_NOWAIT))
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;

