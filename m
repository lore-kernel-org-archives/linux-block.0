Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA5C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C67208CA
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfFNNOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:14:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:45408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbfFNNOZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:14:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38D06AB8C;
        Fri, 14 Jun 2019 13:14:24 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 05/29] bcache: remove retry_flush_write from struct cache_set
Date:   Fri, 14 Jun 2019 21:13:34 +0800
Message-Id: <20190614131358.2771-6-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In struct cache_set, retry_flush_write is added for commit c4dc2497d50d
("bcache: fix high CPU occupancy during journal") which is reverted in
previous patch.

Now it is useless anymore, and this patch removes it from bcache code.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h | 1 -
 drivers/md/bcache/sysfs.c  | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index e30a983a68cd..ae87cb01401e 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -706,7 +706,6 @@ struct cache_set {
 
 	atomic_long_t		reclaim;
 	atomic_long_t		flush_write;
-	atomic_long_t		retry_flush_write;
 
 	enum			{
 		ON_ERROR_UNREGISTER,
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 6cd44d3cf906..a67e1e57ea68 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -85,7 +85,6 @@ read_attribute(state);
 read_attribute(cache_read_races);
 read_attribute(reclaim);
 read_attribute(flush_write);
-read_attribute(retry_flush_write);
 read_attribute(writeback_keys_done);
 read_attribute(writeback_keys_failed);
 read_attribute(io_errors);
@@ -691,9 +690,6 @@ SHOW(__bch_cache_set)
 	sysfs_print(flush_write,
 		    atomic_long_read(&c->flush_write));
 
-	sysfs_print(retry_flush_write,
-		    atomic_long_read(&c->retry_flush_write));
-
 	sysfs_print(writeback_keys_done,
 		    atomic_long_read(&c->writeback_keys_done));
 	sysfs_print(writeback_keys_failed,
@@ -910,7 +906,6 @@ static struct attribute *bch_cache_set_internal_files[] = {
 	&sysfs_cache_read_races,
 	&sysfs_reclaim,
 	&sysfs_flush_write,
-	&sysfs_retry_flush_write,
 	&sysfs_writeback_keys_done,
 	&sysfs_writeback_keys_failed,
 
-- 
2.16.4

