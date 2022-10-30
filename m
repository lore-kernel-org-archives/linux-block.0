Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14743C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJ3KHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJ3KHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1A1F2
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xmMlCrIcZq7VVCyqOPwWLAPkcTjxjyDNcGCDFV+BENg=; b=bSSCOi4931a/j8MidS/6nF/O6n
        64kJNhpcOtNDa8BUphXU2Za/TYSDsK5fhvIQPpPtAWWckq0Hp1RjHAH1RObeEkgvVolUg5UdfqGC5
        o9eytFKCZKXWDIAK3Pa/+F1oxNRXJEOfqi6qjtVD2TT1q11uQz2C1yv8cSbyxwnhRp6r+m01jBaDC
        FqI3A480+3nCkYcKfGQy4TJf3yl4vOi3nG6Gc7TQ+pcd44Yg85cT+ieUqRpDCkbnPJep8sd/Hv05S
        xE7c7ArSUEEQl4IM5NDBx1LD8ZynLpEhNDItKjM3cdJGMn/d6JSHomVmh4kpCcg7WOlq6zI+73vMa
        QVmYTgIA==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5E4-00F8LV-DT; Sun, 30 Oct 2022 10:07:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/7] block: exit elv_iosched_show early when I/O schedulers are not supported
Date:   Sun, 30 Oct 2022 11:07:10 +0100
Message-Id: <20221030100714.876891-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the tag_set has BLK_MQ_F_NO_SCHED flag set we will never show any
scheduler, so exit early.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index d0e48839f6764..92096e5aabd36 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -777,7 +777,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	struct elevator_type *__e;
 	int len = 0;
 
-	if (!queue_is_mq(q))
+	if (!elv_support_iosched(q))
 		return sprintf(name, "none\n");
 
 	if (!q->elevator)
@@ -791,8 +791,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 			len += sprintf(name+len, "[%s] ", elv->elevator_name);
 			continue;
 		}
-		if (elv_support_iosched(q) &&
-		    elevator_match(__e, __e->elevator_name,
+		if (elevator_match(__e, __e->elevator_name,
 				   q->required_elevator_features))
 			len += sprintf(name+len, "%s ", __e->elevator_name);
 	}
-- 
2.30.2

