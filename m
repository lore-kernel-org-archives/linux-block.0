Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1784C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 05:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEFB222D0
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 05:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKMFen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:34:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:54210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfKMFen (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 00:34:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74B3DB431;
        Wed, 13 Nov 2019 05:34:41 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 04/10] bcache: add more accurate error messages in read_super()
Date:   Wed, 13 Nov 2019 13:33:40 +0800
Message-Id: <20191113053346.63536-5-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113053346.63536-1-colyli@suse.de>
References: <20191113053346.63536-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previous code only returns "Not a bcache superblock" for both bcache
super block offset and magic error. This patch addss more accurate error
messages,
- for super block unmatched offset:
  "Not a bcache superblock (bad offset)"
- for super block unmatched magic number:
  "Not a bcache superblock (bad magic)"

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 7beccede5360..623fdaf10c4c 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -92,10 +92,11 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	pr_debug("read sb version %llu, flags %llu, seq %llu, journal size %u",
 		 sb->version, sb->flags, sb->seq, sb->keys);
 
-	err = "Not a bcache superblock";
+	err = "Not a bcache superblock (bad offset)";
 	if (sb->offset != SB_SECTOR)
 		goto err;
 
+	err = "Not a bcache superblock (bad magic)";
 	if (memcmp(sb->magic, bcache_magic, 16))
 		goto err;
 
-- 
2.16.4

