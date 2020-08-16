Return-Path: <SRS0=mZfT=B2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05D6C433DF
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 23:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F802078A
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 23:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3yhAN6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgHPXjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Aug 2020 19:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgHPXjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Aug 2020 19:39:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD732C061385;
        Sun, 16 Aug 2020 16:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hDyJ1Di9zrAXsJ7O0IestEWT/X//JS1ILYRNIJtyQ1A=; b=W3yhAN6j+71YZbrLM+VkZSG3Tg
        3PSXNyhuTsrJIg/54aVol9EMVjywTDd1HG1XtEmlvczXTQAt5e82a6J4OXPMI2ffySREx0d8ghLpk
        +7Xb+GAxxXMkQsW7mMggphNu3hR8igHk6DeArCF+DATR9Q2z4BnHJSY5zJ7o22lH4eEpcrweN4FH3
        nizlIr62CIk2X69Jk/CFn3PJiX0JbQJ+Fjst+H8+Vqxyh/dy6lTW9sNTV6JIkY80ub3lVGK7gy21w
        pO93MBBQEPXr2FOtVrCzH5DDSGTx4U+hCzIxbQ21bM8jtrEwUvSnf9wApM8bp8jiSJ6UfooYrJDPF
        am5D+55A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7SFZ-0006tt-Ft; Sun, 16 Aug 2020 23:39:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2] block: blk-mq.c: fix @at_head kernel-doc warning
Date:   Sun, 16 Aug 2020 16:39:34 -0700
Message-Id: <20200816233934.1573-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a new kernel-doc warning in block/blk-mq.c:

../block/blk-mq.c:1844: warning: Function parameter or member 'at_head' not described in 'blk_mq_request_bypass_insert'

Fixes: 01e99aeca397 ("blk-mq: insert passthrough request into hctx->dispatch directly")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: André Almeida <andrealmeid@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
---
v2: correct Fixes: Commit-ID + Cc: to author.

 block/blk-mq.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-59-rc1.orig/block/blk-mq.c
+++ lnx-59-rc1/block/blk-mq.c
@@ -1834,6 +1834,7 @@ void __blk_mq_insert_request(struct blk_
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
+ * @at_head: true if the request should be inserted at the head of the list.
  * @run_queue: If we should run the hardware queue after inserting the request.
  *
  * Should only be used carefully, when the caller knows we want to
