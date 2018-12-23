Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A9FC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2F121903
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 11:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeLWLKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:10:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:49550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWLKe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 06:10:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C958DAF0B;
        Sun, 23 Dec 2018 11:10:32 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 04/11] bcache: use sysfs_strtoul_bool() to set bit-field variables
Date:   Sun, 23 Dec 2018 19:09:30 +0800
Message-Id: <20181223110937.11559-5-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181223110937.11559-1-colyli@suse.de>
References: <20181223110937.11559-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When setting bcache parameters via sysfs, there are some variables are
defined as bit-field value. Current bcache code in sysfs.c uses either
d_strtoul() or sysfs_strtoul() to convert the input string to unsigned
integer value and set it to the corresponded bit-field value.

The problem is, the bit-field value only takes the lowest bit of the
converted value. If input is 2, the expected value (like bool value)
of the bit-field value should be 1, but indeed it is 0.

The following sysfs files for bit-field variables have such problem,
	bypass_torture_test,	for dc->bypass_torture_test
	writeback_metadata,	for dc->writeback_metadata
	writeback_running,	for dc->writeback_running
	verify,			for c->verify
	key_merging_disabled,	for c->key_merging_disabled
	gc_always_rewrite,	for c->gc_always_rewrite
	btree_shrinker_disabled,for c->shrinker_disabled
	copy_gc_enabled,	for c->copy_gc_enabled

This patch uses sysfs_strtoul_bool() to set such bit-field variables,
then if the converted value is non-zero, the bit-field variables will
be set to 1, like setting a bool value like expensive_debug_checks.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 29564bcb76c3..8dcafae6dd8a 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -274,9 +274,9 @@ STORE(__cached_dev)
 
 	sysfs_strtoul(data_csum,	dc->disk.data_csum);
 	d_strtoul(verify);
-	d_strtoul(bypass_torture_test);
-	d_strtoul(writeback_metadata);
-	d_strtoul(writeback_running);
+	sysfs_strtoul_bool(bypass_torture_test, dc->bypass_torture_test);
+	sysfs_strtoul_bool(writeback_metadata, dc->writeback_metadata);
+	sysfs_strtoul_bool(writeback_running, dc->writeback_running);
 	d_strtoul(writeback_delay);
 
 	sysfs_strtoul_clamp(writeback_percent, dc->writeback_percent, 0, 40);
@@ -804,12 +804,12 @@ STORE(__bch_cache_set)
 	}
 
 	sysfs_strtoul(journal_delay_ms,		c->journal_delay_ms);
-	sysfs_strtoul(verify,			c->verify);
-	sysfs_strtoul(key_merging_disabled,	c->key_merging_disabled);
+	sysfs_strtoul_bool(verify,		c->verify);
+	sysfs_strtoul_bool(key_merging_disabled, c->key_merging_disabled);
 	sysfs_strtoul(expensive_debug_checks,	c->expensive_debug_checks);
-	sysfs_strtoul(gc_always_rewrite,	c->gc_always_rewrite);
-	sysfs_strtoul(btree_shrinker_disabled,	c->shrinker_disabled);
-	sysfs_strtoul(copy_gc_enabled,		c->copy_gc_enabled);
+	sysfs_strtoul_bool(gc_always_rewrite,	c->gc_always_rewrite);
+	sysfs_strtoul_bool(btree_shrinker_disabled, c->shrinker_disabled);
+	sysfs_strtoul_bool(copy_gc_enabled,	c->copy_gc_enabled);
 
 	return size;
 }
-- 
2.16.4

