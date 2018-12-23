Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205B6C43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC47A21920
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeLWLK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:10:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:49652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLK6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:10:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1669AF0B;
        Sun, 23 Dec 2018 11:10:56 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 09/11] bcache: fix input overflow to journal_delay_ms
Date:   Sun, 23 Dec 2018 19:09:35 +0800
Message-Id: <20181223110937.11559-10-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
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
index 31e41cc3c162..032d108d3041 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -809,7 +809,9 @@ STORE(__bch_cache_set)
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

