Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F00AFA3741
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiJYTS3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiJYTSK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 15:18:10 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE17F13B
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:09 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso12775207pjc.5
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxDMVtziYIGxWaFYH3gvqXTu3N1ivBxtwyOrLeXXUvE=;
        b=0XvMSIAdfHLhH9tlY3478xzMBcdnN51b5XoHEGaii9DtOZJrn1pBpeoAKHvCc2qEuz
         9Fec7QdiFOQYvVTjoLbEezeSrMDDZCtURkIPp7IFUNCnCbnyzWcR0KiY7MSpm6k/2k/c
         UQ5GykG2oCV3iriXgYWcQe39SwuyGVBifozlDvUuZZeBF5N5KmfpxhYIKCg2qdhfg9Hu
         aRrZNT6nmPMpDqCQA6lg0bCBNW7TEaawtgqRzwbu6aLJ7l6KLEaqUhk0xZBp+pGvwcb/
         zvxhVnDyzmcA1yCP6V5B1bSqNlfgQLRpD50sW7x5eufwzr0EYoMveoLwe/Bk5RQJbD4J
         reVQ==
X-Gm-Message-State: ACrzQf0b3Mu1vgzx6TJY5rTeGyb7JIXODeQcOpsBLi29/qgJWkFgOket
        FuEGh849hShR7shXGKpn1L8=
X-Google-Smtp-Source: AMsMyM5fiZHrRi+QKWWPcfRom+zjyRX/6bNNB4Wj7Q6j5/fuFJGyQK3u7zxwDYQ2otwHmH1AqzRioQ==
X-Received: by 2002:a17:902:dad1:b0:183:243c:d0d0 with SMTP id q17-20020a170902dad100b00183243cd0d0mr40292275plx.157.1666725489505;
        Tue, 25 Oct 2022 12:18:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:58c7:bc96:4597:61cd])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902d89700b00186a8beec78sm1540737plz.52.2022.10.25.12.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:18:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/3] block: Micro-optimize get_max_segment_size()
Date:   Tue, 25 Oct 2022 12:17:55 -0700
Message-Id: <20221025191755.1711437-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221025191755.1711437-1-bvanassche@acm.org>
References: <20221025191755.1711437-1-bvanassche@acm.org>
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>
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
