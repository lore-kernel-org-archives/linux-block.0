Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:44081 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752500AbdF3KQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:16:25 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id C61433E521C
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:17 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 0594BB400BA
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:06 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Eric Wheeler <git@linux.ewheeler.net>
Date: Wed, 19 Oct 2016 17:36:37 -0700
Subject: [PATCH 09/19] bcache: update bio->bi_opf bypass/writeback REQ_ flag
 hints
To: linux-block@vger.kernel.org
Message-Id: <20170629221206.C180710012A@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Bypass if:     bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND)

Writeback if:  op_is_sync(bio->bi_opf) || bio->bi_opf & (REQ_META|REQ_PRIO)

Signed-off-by: Eric Wheeler <bcache@linux.ewheeler.net>
---
 drivers/md/bcache/request.c   | 3 +++
 drivers/md/bcache/writeback.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index a95609f..4629b0c 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -386,6 +386,9 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 	     op_is_write(bio_op(bio))))
 		goto skip;
 
+	if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND))
+		goto skip;
+
 	/* If the ioprio already exists on the bio, use that.  We assume that
 	 * the upper layer properly assigned the calling process's ioprio to
 	 * the bio being passed to bcache. Otherwise, use current's ioc. */
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index cd82fe8..ea2f92e 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -81,7 +81,8 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 		return true;
 	}
 
-	return op_is_sync(bio->bi_opf) || in_use <= CUTOFF_WRITEBACK;
+	return op_is_sync(bio->bi_opf) || bio->bi_opf & (REQ_META|REQ_PRIO)
+		|| in_use <= CUTOFF_WRITEBACK;
 }
 
 static inline void bch_writeback_queue(struct cached_dev *dc)
-- 
1.8.3.1
