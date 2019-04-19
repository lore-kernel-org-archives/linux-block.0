Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40227C282DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E31222CC
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfDSSYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:24:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbfDSSXr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E51C5AFB4;
        Fri, 19 Apr 2019 16:05:47 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 07/16] bcache: add comments for kobj release callback routine
Date:   Sat, 20 Apr 2019 00:05:00 +0800
Message-Id: <20190419160509.66298-8-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bcache has several routines to release resources in implicit way, they
are called when the associated kobj released. This patch adds code
comments to notice when and which release callback will be called,
- When dc->disk.kobj released:
  void bch_cached_dev_release(struct kobject *kobj)
- When d->kobj released:
  void bch_flash_dev_release(struct kobject *kobj)
- When c->kobj released:
  void bch_cache_set_release(struct kobject *kobj)
- When ca->kobj released
  void bch_cache_release(struct kobject *kobj)

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 036bffad0bfe..400af446c372 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1174,6 +1174,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 	return 0;
 }
 
+/* when dc->disk.kobj released */
 void bch_cached_dev_release(struct kobject *kobj)
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
@@ -1326,6 +1327,7 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
 
 /* Flash only volumes */
 
+/* When d->kobj released */
 void bch_flash_dev_release(struct kobject *kobj)
 {
 	struct bcache_device *d = container_of(kobj, struct bcache_device,
@@ -1496,6 +1498,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
 	return true;
 }
 
+/* When c->kobj released */
 void bch_cache_set_release(struct kobject *kobj)
 {
 	struct cache_set *c = container_of(kobj, struct cache_set, kobj);
@@ -2023,6 +2026,7 @@ static const char *register_cache_set(struct cache *ca)
 
 /* Cache device */
 
+/* When ca->kobj released */
 void bch_cache_release(struct kobject *kobj)
 {
 	struct cache *ca = container_of(kobj, struct cache, kobj);
-- 
2.16.4

