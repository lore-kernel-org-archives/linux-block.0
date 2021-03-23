Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95241C433E4
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 08:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53337619C8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 08:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCWIPV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 04:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhCWIPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 04:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616487315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1wm+AvHpyrvrTAF75kQjdToXkB8LXKooRb8yh3T4dk=;
        b=SEeF/x01HDKjmjdUe06xa5wEWtLfIenNJjtOyG1/KnFXp9nOTz01mcs3zfMJ8Nt+QgXhg2
        SES4Tvdk3OpugzVs1tYLH1ylRCgUIlTsTVSf4OkTjVFUyVNHoHFM1QBWMzBcwza3nrsMy3
        fSKlL8QrlDBJy1R4Zjmr9ocrEJsqHYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-xruTtytLPLmq_cDyFLQDkQ-1; Tue, 23 Mar 2021 04:15:10 -0400
X-MC-Unique: xruTtytLPLmq_cDyFLQDkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DF47100746C;
        Tue, 23 Mar 2021 08:15:09 +0000 (UTC)
Received: from localhost (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E074171E2;
        Tue, 23 Mar 2021 08:15:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] blktrace: limit allowed total trace buffer size
Date:   Tue, 23 Mar 2021 16:14:40 +0800
Message-Id: <20210323081440.81343-3-ming.lei@redhat.com>
In-Reply-To: <20210323081440.81343-1-ming.lei@redhat.com>
References: <20210323081440.81343-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On some ARCHs, such as aarch64, page size may be 64K, meantime there may
be lots of CPU cores. relay_open() needs to allocate pages on each CPU
blktrace, so easily too many pages are taken by blktrace. For example,
on one ARM64 server: 224 CPU cores, 16G RAM, blktrace finally got
allocated 7GB in case of 'blktrace -b 8192' which is used by device-mapper
test suite[1]. This way could cause OOM easily.

Fix the issue by limiting max allowed pages to be 1/8 of totalram_pages().

[1] https://github.com/jthornber/device-mapper-test-suite.git

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/trace/blktrace.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c221e4c3f625..8403ff19d533 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -466,6 +466,35 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 	}
 }
 
+/* limit total allocated buffer size is <= 1/8 of total pages */
+static void validate_and_adjust_buf(struct blk_user_trace_setup *buts)
+{
+	unsigned buf_size = buts->buf_size;
+	unsigned buf_nr = buts->buf_nr;
+	unsigned long max_allowed_pages = totalram_pages() >> 3;
+	unsigned long req_pages = PAGE_ALIGN(buf_size * buf_nr) >> PAGE_SHIFT;
+
+	if (req_pages * num_online_cpus() <= max_allowed_pages)
+		return;
+
+	req_pages = DIV_ROUND_UP(max_allowed_pages, num_online_cpus());
+
+	if (req_pages == 0) {
+		buf_size = PAGE_SIZE;
+		buf_nr = 1;
+	} else {
+		buf_size = req_pages << PAGE_SHIFT / buf_nr;
+		if (buf_size < PAGE_SIZE)
+			buf_size = PAGE_SIZE;
+		buf_nr = req_pages << PAGE_SHIFT / buf_size;
+		if (buf_nr == 0)
+			buf_nr = 1;
+	}
+
+	buts->buf_size = min_t(unsigned, buf_size, buts->buf_size);
+	buts->buf_nr = min_t(unsigned, buf_nr, buts->buf_nr);
+}
+
 /*
  * Setup everything required to start tracing
  */
@@ -482,6 +511,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
+	/* make sure not allocate too much for userspace */
+	validate_and_adjust_buf(buts);
+
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
-- 
2.29.2

