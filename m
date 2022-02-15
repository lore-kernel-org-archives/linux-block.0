Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CEFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 10:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiBOKF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:05:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiBOKF5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 05:05:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220724F
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 02:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qYt3ZRzuNpc/iVF9KpXQfh6CaJwRkNUI9Fcucnd17Kw=; b=TOK4G84fmgSdBeKMwZBqanqZi9
        U0VS/vYayRKqpHG+yUOx5NkfjIR4qRGwVzfj1Bm5RNt7vvgJyJxKi665Xh+7RPh01JVdSwlB6plOo
        pmmyTv+TgVrXbN28Fh08Q6cnHbd2occRUp9ojQMCwIYx3bkk+GjfL3rmrP6DLmgAATiQVixeT+bb+
        V0UpkQEoSWpm86S9jn2spT84+VgplHJFud0BZpsJnKUf8gzmovx1wG9gfippJioPz2Pzjg3CqCHkR
        x+YsgBarnkCegAX3S8zAXN1Y9qgVSpRr5JiXhsJm4L5pGElmLjh7/BTKNHKepHJJSpV+JkSy4NlJx
        59tOnNOw==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuiP-002E1A-AE; Tue, 15 Feb 2022 10:05:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/5] blk-mq: make the blk-mq stacking code optional
Date:   Tue, 15 Feb 2022 11:05:36 +0100
Message-Id: <20220215100540.3892965-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215100540.3892965-1-hch@lst.de>
References: <20220215100540.3892965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code to stack blk-mq drivers is only used by dm-multipath, and
will preferably stay that way.  Make it optional and only selected
by device mapper, so that the buildbots more easily catch abuses
like the one that slipped in in the ufs driver in the last merged
window.  Another positive side effects is that kernel builds without
device mapper shrink a little bit as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig      | 3 +++
 block/blk-mq.c     | 2 ++
 drivers/md/Kconfig | 1 +
 3 files changed, 6 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 205f8d01c6952..168b873eb666d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -230,6 +230,9 @@ config BLK_PM
 config BLOCK_HOLDER_DEPRECATED
 	bool
 
+config BLK_MQ_STACKING
+	bool
+
 source "block/Kconfig.iosched"
 
 endif # BLOCK
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6c59ffe765fde..db62d34afb637 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2840,6 +2840,7 @@ void blk_mq_submit_bio(struct bio *bio)
 				blk_mq_try_issue_directly(rq->mq_hctx, rq));
 }
 
+#ifdef CONFIG_BLK_MQ_STACKING
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for the new queue limits
@@ -3017,6 +3018,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(blk_rq_prep_clone);
+#endif /* CONFIG_BLK_MQ_STACKING */
 
 /*
  * Steal bios from a request and add them to a bio list.
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index b5ea378e66cb1..998a5cfdbc4e9 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -204,6 +204,7 @@ config BLK_DEV_DM
 	tristate "Device mapper support"
 	select BLOCK_HOLDER_DEPRECATED if SYSFS
 	select BLK_DEV_DM_BUILTIN
+	select BLK_MQ_STACKING
 	depends on DAX || DAX=n
 	help
 	  Device-mapper is a low level volume manager.  It works by allowing
-- 
2.30.2

