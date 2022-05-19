Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52305C433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 13:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiESNCQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiESNCO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 09:02:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752466691
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 06:02:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9F6B01F8C4;
        Thu, 19 May 2022 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652965330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g/NyQW0PgmxbN/ktkxnOLe1myVVGQZV/92ddefD0e4k=;
        b=auKRNZazGHPW1Vr30Tdb3HFH0doQqoR/XZDW++pLKwbbDhIwH6fh06nGVsbEdZ/uhkf+qs
        6WnoPaUTnx1eXO9mjck1SPLHulpBGeP6wnga3TLzUs4jjB5W4eBXQwA8TXyiTb0td11TJT
        3G+iv2ur1qu81Ud7myDS/crDRGvxuGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652965330;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g/NyQW0PgmxbN/ktkxnOLe1myVVGQZV/92ddefD0e4k=;
        b=zchiIdIzvOIzHBzQjjmV9bolUkttsD3HtTttirkRqPoe90qMv/D5AVj03d5iOZ8x1h4Rui
        MkgVe9M0Dnw+SDDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 91FF82C141;
        Thu, 19 May 2022 13:02:10 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 842735194575; Thu, 19 May 2022 15:02:10 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] blk-cgroup: provide stubs for blkcg_get_fc_appid()
Date:   Thu, 19 May 2022 15:02:07 +0200
Message-Id: <20220519130207.6492-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blk-cgroup.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 9f40dbc65f82..4756f4d2b8e7 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -33,6 +33,9 @@ void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css);
 struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio);
 
+int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
+char *blkcg_get_fc_appid(struct bio *bio);
+
 #else	/* CONFIG_BLK_CGROUP */
 
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
@@ -44,9 +47,15 @@ static inline struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
 {
 	return NULL;
 }
+static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id,
+				     size_t app_id_len)
+{
+	return -EINVAL;
+}
+static inline char *blkcg_get_fc_appid(struct bio *bio)
+{
+	return NULL;
+}
 #endif	/* CONFIG_BLK_CGROUP */
 
-int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
-char *blkcg_get_fc_appid(struct bio *bio);
-
 #endif	/* _BLK_CGROUP_H */
-- 
2.29.2

