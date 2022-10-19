Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488CC4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJSWXn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJSWXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:41 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C603FA22
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:41 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1499330pjq.3
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwLF3+FGTXezfMGh6ucvbpDhiesrgJ8WjP6B79pcIyU=;
        b=sd7PhWWX9eSiJhiQUvvQa8bXhPf0BWzBwzfgLNCDcROuLGqZYfq6PIxb1uOLx9RW6h
         uVK4ktwkcjLQRqqWM6bB0FwTH+49nCEDNCD0Ya64sSKD+CTlMkwm2vxl6U3bkJl7KsSo
         qAAU6J3MNxIpo5w1uHJSTBQR6IChFkg69orJHETUcSOBBkFHu6KNfQgHvcwkQU0vccX2
         36jkKRXmx8tcW4+M2WFy0cfJAlRjkFDWpvVYp7NohPGFdoGnESA/cxcnSc608W3uPVSM
         DstRJ0u40GO6c9w7x3wkAljfMz1bukL5dKkpQdIRBTEy7sz+E13Dn6cyqHM3EhOmfU1Y
         pxCA==
X-Gm-Message-State: ACrzQf1SyvJoNhT3KOjlbTNdVYJLNWL8CaTSNBuuS7kpUXxQxDK5Sgfe
        /rlsejqWm1+awFF8XXqTugODoQFuti8=
X-Google-Smtp-Source: AMsMyM7Faj4jDeKS6YueUe/n7MHIoF6FqRW4CXN0+V/wgvxjvIHYUWOgiPevmMhsVSO3enrinOew2Q==
X-Received: by 2002:a17:90b:4f46:b0:20d:1fe8:dcd2 with SMTP id pj6-20020a17090b4f4600b0020d1fe8dcd2mr47656074pjb.235.1666218220471;
        Wed, 19 Oct 2022 15:23:40 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/10] block: Micro-optimize get_max_segment_size()
Date:   Wed, 19 Oct 2022 15:23:17 -0700
Message-Id: <20221019222324.362705-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch removes a conditional jump from get_max_segment_size(). The
x86-64 assembler code for this function without this patch is as follows:

206             return min_not_zero(mask - offset + 1,
   0x0000000000000118 <+72>:    not    %rax
   0x000000000000011b <+75>:    and    0x8(%r10),%rax
   0x000000000000011f <+79>:    add    $0x1,%rax
   0x0000000000000123 <+83>:    je     0x138 <bvec_split_segs+104>
   0x0000000000000125 <+85>:    cmp    %rdx,%rax
   0x0000000000000128 <+88>:    mov    %rdx,%r12
   0x000000000000012b <+91>:    cmovbe %rax,%r12
   0x000000000000012f <+95>:    test   %rdx,%rdx
   0x0000000000000132 <+98>:    mov    %eax,%edx
   0x0000000000000134 <+100>:   cmovne %r12d,%edx

With this patch applied:

206             return min(mask - offset, (unsigned long)lim->max_segment_size - 1) + 1;
   0x000000000000003f <+63>:    mov    0x28(%rdi),%ebp
   0x0000000000000042 <+66>:    not    %rax
   0x0000000000000045 <+69>:    and    0x8(%rdi),%rax
   0x0000000000000049 <+73>:    sub    $0x1,%rbp
   0x000000000000004d <+77>:    cmp    %rbp,%rax
   0x0000000000000050 <+80>:    cmova  %rbp,%rax
   0x0000000000000054 <+84>:    add    $0x1,%eax

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 58fdc3f8905b..35a8f75cc45d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -186,6 +186,14 @@ static inline unsigned get_max_io_size(struct bio *bio,
 	return max_sectors & ~(lbs - 1);
 }
 
+/**
+ * get_max_segment_size() - maximum number of bytes to add as a single segment
+ * @lim: Request queue limits.
+ * @start_page: See below.
+ * @offset: Offset from @start_page where to add a segment.
+ *
+ * Returns the maximum number of bytes that can be added as a single segment.
+ */
 static inline unsigned get_max_segment_size(const struct queue_limits *lim,
 		struct page *start_page, unsigned long offset)
 {
@@ -194,11 +202,10 @@ static inline unsigned get_max_segment_size(const struct queue_limits *lim,
 	offset = mask & (page_to_phys(start_page) + offset);
 
 	/*
-	 * overflow may be triggered in case of zero page physical address
-	 * on 32bit arch, use queue's max segment size when that happens.
+	 * Prevent an overflow if mask = ULONG_MAX and offset = 0 by adding 1
+	 * after having calculated the minimum.
 	 */
-	return min_not_zero(mask - offset + 1,
-			(unsigned long)lim->max_segment_size);
+	return min(mask - offset, (unsigned long)lim->max_segment_size - 1) + 1;
 }
 
 /**
