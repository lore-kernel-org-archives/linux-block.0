Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A3FC282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F7420818
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBIEyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:54:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:57924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfBIEyM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:54:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06CC2ABA1;
        Sat,  9 Feb 2019 04:54:11 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 16/19] bcache: fix input overflow to journal_delay_ms
Date:   Sat,  9 Feb 2019 12:53:08 +0800
Message-Id: <20190209045311.15677-17-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

c->journal_delay_ms is in type unsigned short, it is set via sysfs
interface and converted by sysfs_strtoul() from input string to
unsigned short value. Therefore overflow to unsigned short might be
happen when the converted value exceed USHRT_MAX. e.g. writing
65536 into sysfs file journal_delay_ms, c->journal_delay_ms is set to
0.

This patch uses sysfs_strtoul_clamp() to convert the input string and
limit value range in [0, USHRT_MAX], to avoid the input overflow.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index d292eb757ac4..201e85bbe3eb 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -821,7 +821,9 @@ STORE(__bch_cache_set)
 		}
 	}
 
-	sysfs_strtoul(journal_delay_ms,		c->journal_delay_ms);
+	sysfs_strtoul_clamp(journal_delay_ms,
+			    c->journal_delay_ms,
+			    0, USHRT_MAX);
 	sysfs_strtoul_bool(verify,		c->verify);
 	sysfs_strtoul_bool(key_merging_disabled, c->key_merging_disabled);
 	sysfs_strtoul(expensive_debug_checks,	c->expensive_debug_checks);
-- 
2.16.4

