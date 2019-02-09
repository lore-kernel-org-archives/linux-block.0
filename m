Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E3C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF10520857
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBIEx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:53:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:57566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBIEx0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:53:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CB3BAF6F;
        Sat,  9 Feb 2019 04:53:25 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 02/19] bcache: not use hard coded memset size in bch_cache_accounting_clear()
Date:   Sat,  9 Feb 2019 12:52:54 +0800
Message-Id: <20190209045311.15677-3-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In stats.c:bch_cache_accounting_clear(), a hard coded number '7' is
used in memset(). It is because in struct cache_stats, there are 7
atomic_t type members. This is not good when new members added into
struct stats, the hard coded number will only clear part of memory.

This patch replaces 'sizeof(unsigned long) * 7' by more generic
'sizeof(struct cache_stats))', to avoid potential error if new
member added into struct cache_stats.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/stats.c b/drivers/md/bcache/stats.c
index 894410f3f829..ba1c93791d8d 100644
--- a/drivers/md/bcache/stats.c
+++ b/drivers/md/bcache/stats.c
@@ -111,7 +111,7 @@ void bch_cache_accounting_clear(struct cache_accounting *acc)
 {
 	memset(&acc->total.cache_hits,
 	       0,
-	       sizeof(unsigned long) * 7);
+	       sizeof(struct cache_stats));
 }
 
 void bch_cache_accounting_destroy(struct cache_accounting *acc)
-- 
2.16.4

