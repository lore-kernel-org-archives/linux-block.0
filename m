Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16FC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44B121903
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeLWLKj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:10:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:49572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLKj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:10:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77648AF0B;
        Sun, 23 Dec 2018 11:10:37 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 05/11] bcache: fix input overflow to writeback_delay
Date:   Sun, 23 Dec 2018 19:09:31 +0800
Message-Id: <20181223110937.11559-6-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sysfs file writeback_delay is used to configure dc->writeback_delay
which is type unsigned int. But bcache code uses sysfs_strtoul() to
convert the input string, therefore it might be overflowed if the input
value is too large. E.g. input value is 4294967296 but indeed 0 is
set to dc->writeback_delay.

This patch uses sysfs_strtoul_clamp() to convert the input string and
set the result value range in [0, UINT_MAX] to avoid such unsigned
integer overflow.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 8dcafae6dd8a..16cd710f5f8b 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -277,7 +277,7 @@ STORE(__cached_dev)
 	sysfs_strtoul_bool(bypass_torture_test, dc->bypass_torture_test);
 	sysfs_strtoul_bool(writeback_metadata, dc->writeback_metadata);
 	sysfs_strtoul_bool(writeback_running, dc->writeback_running);
-	d_strtoul(writeback_delay);
+	sysfs_strtoul_clamp(writeback_delay, dc->writeback_delay, 0, UINT_MAX);
 
 	sysfs_strtoul_clamp(writeback_percent, dc->writeback_percent, 0, 40);
 
-- 
2.16.4

