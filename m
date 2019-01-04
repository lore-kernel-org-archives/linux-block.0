Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E787C43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 17:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26058218D3
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 17:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfADRGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:06:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfADRGr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Jan 2019 12:06:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F478C0B1B4F;
        Fri,  4 Jan 2019 17:06:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-70.rdu2.redhat.com [10.10.122.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B958106A79D;
        Fri,  4 Jan 2019 17:06:46 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, loberman@redhat.com,
        bvanassche@acm.org, John Pittman <jpittman@redhat.com>
Subject: [PATCH v2] null_blk: add zoned config support information
Date:   Fri,  4 Jan 2019 12:06:37 -0500
Message-Id: <20190104170637.8218-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 04 Jan 2019 17:06:47 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the kernel is built without CONFIG_BLK_DEV_ZONED, a modprobe
of the null_blk driver with zoned=1 fails with 'Invalid argument'.
This can be confusing to users, prompting a search as to why the
parameter is invalid. To assist in that search, add a bit more
information to the failure, additionally adding to the documentation
that CONFIG_BLK_DEV_ZONED is needed for zoned=1.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 Documentation/block/null_blk.txt | 3 ++-
 drivers/block/null_blk.h         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index ea2dafe49ae8..4cad1024fff7 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -88,7 +88,8 @@ shared_tags=[0/1]: Default: 0
 
 zoned=[0/1]: Default: 0
   0: Block device is exposed as a random-access block device.
-  1: Block device is exposed as a host-managed zoned block device.
+  1: Block device is exposed as a host-managed zoned block device. Requires
+     CONFIG_BLK_DEV_ZONED.
 
 zone_size=[MB]: Default: 256
   Per zone size when exposed as a zoned block device. Must be a power of two.
diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index b3df2793e7cd..cab4808f14bd 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -97,6 +97,7 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
+	pr_err("CONFIG_BLK_DEV_ZONED not enabled\n");
 	return -EINVAL;
 }
 static inline void null_zone_exit(struct nullb_device *dev) {}
-- 
2.17.2

