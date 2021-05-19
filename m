Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D4C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 17:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6E961019
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 17:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhESRxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 13:53:53 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:39913 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhESRxw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 13:53:52 -0400
Received: by mail-pj1-f48.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so3931587pjp.4
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 10:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lD/Lgoh2nB1cYE78Z6b0L8aWk9CbKl0Y1i42yGy55PA=;
        b=Ous20v3sfLeQ2C49W1jf9O86LhjgDN0lx/XLBF5wH5e+v+Ae6K6beyebS3nJ28Ey0A
         J1Od7R86JxREQZpG5QvHzM0DDgB/n4u5yPgWymKr7YVNGBgi6cTMYWKTBUtVwbgS2pJm
         kRgiTnUwU+Wa2R0inv6nux9yKTkOEaDsR6ibDqUB87KvOKKCjWXp7W20sj8o4p6sVJKo
         NzfD2hoUNzs8AI01AuSm+4gLv7PcwxI6MCpzNJMxRLVdmA/OyapsSxElbtXx/vXlvF6y
         WTZMHvk5EYXEDOhgJUR/XBsZKJwRt4v/yNJU/kTIotTODguxNP4BhAvrTfiipIKeIwiV
         fIxA==
X-Gm-Message-State: AOAM530lidfqxDj77saqbE3TvZVqbUYLlIGEMB4F7sNoIEzZXx1xnFEo
        4vArd8Wb6BJn7iI7AGwS2yw=
X-Google-Smtp-Source: ABdhPJzeZ8mbsgtJWFeGLNkqRXVUjbcG3BKLFctqdrZCaVmE0qWBmxZCw/oBujNdi5912SWjjIBnTA==
X-Received: by 2002:a17:90a:b382:: with SMTP id e2mr134053pjr.171.1621446752250;
        Wed, 19 May 2021 10:52:32 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:db5a:2bf3:3617:be1c])
        by smtp.gmail.com with ESMTPSA id q24sm120849pjp.6.2021.05.19.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:52:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] block: Update blk_update_request() documentation
Date:   Wed, 19 May 2021 10:52:26 -0700
Message-Id: <20210519175226.8853-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Although the original intent was to use blk_update_request() in stacking
block drivers only, it is used much more widely today. Reflect this in the
documentation block above this function. See also:
* commit 32fab448e5e8 ("block: add request update interface").
* commit 2e60e02297cf ("block: clean up request completion API").
* commit ed6565e73424 ("block: handle partial completions for special
  payload requests").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 689aac2625d2..b65da5a33e20 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1385,26 +1385,22 @@ void blk_steal_bios(struct bio_list *list, struct request *rq)
 EXPORT_SYMBOL_GPL(blk_steal_bios);
 
 /**
- * blk_update_request - Special helper function for request stacking drivers
+ * blk_update_request - Complete multiple bytes without completing the request
  * @req:      the request being processed
  * @error:    block status code
- * @nr_bytes: number of bytes to complete @req
+ * @nr_bytes: number of bytes to complete for @req
  *
  * Description:
  *     Ends I/O on a number of bytes attached to @req, but doesn't complete
  *     the request structure even if @req doesn't have leftover.
  *     If @req has leftover, sets it up for the next range of segments.
  *
- *     This special helper function is only for request stacking drivers
- *     (e.g. request-based dm) so that they can handle partial completion.
- *     Actual device drivers should use blk_mq_end_request instead.
- *
  *     Passing the result of blk_rq_bytes() as @nr_bytes guarantees
  *     %false return from this function.
  *
  * Note:
- *	The RQF_SPECIAL_PAYLOAD flag is ignored on purpose in both
- *	blk_rq_bytes() and in blk_update_request().
+ *	The RQF_SPECIAL_PAYLOAD flag is ignored on purpose in this function
+ *      except in the consistency check at the end of this function.
  *
  * Return:
  *     %false - this request doesn't have any more data
