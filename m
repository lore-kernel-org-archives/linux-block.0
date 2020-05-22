Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C2C433E1
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 12:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A6420756
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 12:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgEVMS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 08:18:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:52518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgEVMS5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 08:18:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 637A5AF0F;
        Fri, 22 May 2020 12:18:58 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC PATCH v4 3/3] bcache: reject writeback cache mode for zoned backing device
Date:   Fri, 22 May 2020 20:18:37 +0800
Message-Id: <20200522121837.109651-4-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522121837.109651-1-colyli@suse.de>
References: <20200522121837.109651-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we don't support writeback mode for zoned device as backing
device. So reject it by sysfs interface.

This rejection will be removed after the writeback cache mode support
for zoned device gets done.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/bcache/sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 323276994aab..41bdbc42a17d 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -359,6 +359,11 @@ STORE(__cached_dev)
 		if (v < 0)
 			return v;
 
+		if ((unsigned int) v == CACHE_MODE_WRITEBACK) {
+			pr_err("writeback mode is not supported for zoned backing device.\n");
+			return -ENOTSUPP;
+		}
+
 		if ((unsigned int) v != BDEV_CACHE_MODE(&dc->sb)) {
 			SET_BDEV_CACHE_MODE(&dc->sb, v);
 			bch_write_bdev_super(dc, NULL);
-- 
2.25.0

