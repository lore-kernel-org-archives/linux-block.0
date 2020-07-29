Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C2AC433E3
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 01:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804CE22BEB
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 01:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595987467;
	bh=HuNGtf+QiT3i3ZfjMR+UMTcddc9pCBYv+A5ANtBYJOo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lr8eq98iPJsCYBNxUVyxMYk83AnpbLIxMoKvKOhEAcPLmGsOgSuR7KWdx7nsBTHBA
	 KSFPA70zlrjFMmtmXrCpS3AqVjet9ir2CqcFA8MVYS+W6E7GxRkkgSu9bjhRk1SXjw
	 X2eTA8R+cGH3/QyizuxAe7+EfwYl6hnbSO/v4HzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgG2BvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:51:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40528 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgG2BvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 21:51:06 -0400
Received: by mail-io1-f67.google.com with SMTP id l17so22889925iok.7;
        Tue, 28 Jul 2020 18:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Q2EY9e3cTo0JOR4/27Xy901b/9YvW+sJJFfNc7uEPg=;
        b=T4GWiig56pLW8HRB8E+TR3ocxiqsm1WaoeXUUQ8+uI/UyLPxyQB3vjyaiUhC9DB7xa
         LhUwkWy2H9qKo2WIgv7na/AINlbG7G9EdIhd2/9ErSzEkqJqspDN6GO1Bm3KABh0FgzH
         DNibqmUaHrGvwMzu3D31HckwtSquEqjNxLAYyivo0DUTw4gP/usEJbwuvPKdWFggm/xs
         vUybXLRviwS3b+tVcpq5fOFuUBr3w9LwOALFs7HMvadauiZssrgXup9Wgw45mNSz+aR7
         zgUxrMGd841ZohCCoIZa6JFZlhajT8p4GeiooTL85dwv+Y/OT+I/intVf6hq+MxbFu7Q
         zHUg==
X-Gm-Message-State: AOAM530PooXqtJpBRJzVKQr60hlgYj2xbUYFKP8BBP155reusPYcxGVl
        bm+SSNK6YnkEjInzlb8k4Aw=
X-Google-Smtp-Source: ABdhPJz1/m95VGzk/wgnRayACeeYLmHUXNGesxghAXu8giycAYZpIw2852f7wF/1ZHW9++qcPDTHZA==
X-Received: by 2002:a02:4083:: with SMTP id n125mr35630122jaa.83.1595987465469;
        Tue, 28 Jul 2020 18:51:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c9sm341219ilm.57.2020.07.28.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:51:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3B12240945; Wed, 29 Jul 2020 01:51:03 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] block: fix possible race on blk_get_queue()
Date:   Wed, 29 Jul 2020 01:51:01 +0000
Message-Id: <20200729015101.31534-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The queue can flip to dying after we check if it is dying,
and then we call __blk_get_queue(). This is a purely
theoretical race, but just fix it. We do this by
Using the atomic kobject_get_unless_zero() first, and
*then* check if the queue is dying *after*.

This issue was found while doing patch review on the
recent blktrace fixes [0].

[0] https://lore.kernel.org/linux-block/20200415123434.GU11244@42.do-not-panic.com/

Reported-by: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

This goes tested against blktest without finding a regression.

 block/blk-core.c | 14 ++++++++++----
 block/blk.h      |  5 +++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..febdd8e8d409 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -605,12 +605,18 @@ EXPORT_SYMBOL(blk_alloc_queue);
  */
 bool blk_get_queue(struct request_queue *q)
 {
-	if (likely(!blk_queue_dying(q))) {
-		__blk_get_queue(q);
-		return true;
+	struct kobject *obj;
+
+	obj = __blk_get_queue(q);
+	if (!obj)
+		return false;
+
+	if (unlikely(blk_queue_dying(q))) {
+		blk_put_queue(q);
+		return false;
 	}
 
-	return false;
+	return true;
 }
 EXPORT_SYMBOL(blk_get_queue);
 
diff --git a/block/blk.h b/block/blk.h
index 49e2928a1632..bdbc9b084d5b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -39,9 +39,10 @@ blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
 	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
 }
 
-static inline void __blk_get_queue(struct request_queue *q)
+static inline struct kobject * __must_check
+__blk_get_queue(struct request_queue *q)
 {
-	kobject_get(&q->kobj);
+	return kobject_get_unless_zero(&q->kobj);
 }
 
 static inline bool
-- 
2.27.0

