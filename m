Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEC2C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D5D2192C
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 22:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1VSbI4gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBIWoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 17:44:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44621 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfBIWoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 17:44:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so3376378pfh.11
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 14:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v6QUJ8u3cDoof2s7HNJ3GlrNEcepg6Mv7Ef2S7gdtz8=;
        b=1VSbI4gLFrMqmAeY7Ot7eMr1DwkUDdgSQ3Kw0m7GbOyiL0lxXL6wXVQT2Q7a7OG08H
         6q+YbX0uUBhqf8ENz1VmUlF+Rttwe+XlkDCbL5ouBf/z13h8i8V24Ib2Sk+DmC11a+y0
         deCMM6AaU36q7/eiofggqXkON0CBtMg9j044vDtRG9Wfnzvtgd3NuulelH7E/FpsPlNl
         o/fgouIHjGYeUYxABRzbOptNUpxlwxfMBHerOzBZ4nqBuyy6y21eMW3CZSn0EKZjzZPw
         Hb3kooh5+MCxIuVGtVGKgDLmwJgboL3jwY/d4q+T+/prl82+PEbpX/nnLuPY1i9ao2H2
         sbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v6QUJ8u3cDoof2s7HNJ3GlrNEcepg6Mv7Ef2S7gdtz8=;
        b=WGbe5X212TwwXVg3MBVfClHoodB1F2OKaMilYNXg15+dlr01ERG6LBzThIq8ofxSVY
         HgoATXzaPnwY4BLvxuPl2e5q7fWQWkMQswl7Gt9m8MaImLBDcsj4WGA5Vhzf7bJCppeT
         lMovWT910sstMSnANLXrzkKbYjqZVsWbAI6abeW8PF1jXUk6yczSAqeKjx7Ce7DMqPo8
         mdk6TgHu4yMqc0/czQBx7gpRK/WUGjqVbdw2YopdjOx+VsUSXoRJZbvMHSwB5p+Bxf0I
         SSPGQW5tzRmhVoquIi/zXmltXN3oI6R1vOjUDUFaO0f8LBQFMYEylV6ZwBzp+elpTnCz
         vqTw==
X-Gm-Message-State: AHQUAual8nLYJ7IhIelUF3UUbs/9/+JZgwu7nSpioY5vkbaIhsQBcsMN
        J5+Fd9jTqNyUE13Se7TrOBu3F9LYUbXwmg==
X-Google-Smtp-Source: AHgI3IYkd5MRcmaYZ5ztowt1ZZFkw4ZeZLx47hcG/ClweGUusemnJvBURTSXx2L5s+mLbo/JKZhziw==
X-Received: by 2002:a63:1105:: with SMTP id g5mr2982546pgl.322.1549752271194;
        Sat, 09 Feb 2019 14:44:31 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b26sm8779147pfe.91.2019.02.09.14.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 14:44:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: queue flag cleanup
Date:   Sat,  9 Feb 2019 15:44:24 -0700
Message-Id: <20190209224424.7560-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209224424.7560-1-axboe@kernel.dk>
References: <20190209224424.7560-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have QUEUE_FLAG_DEFAULT defined, but it's not used anymore since
the legacy IO stack is gone. Kill it.

Sanitize the queue flags in general, they use spaces (for some
reason), and the space is pretty sparse. With the flags renumbered,
we can more clearly see how many we have available.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blkdev.h | 58 ++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 24ccab51085f..3603270cb82d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -572,37 +572,33 @@ struct request_queue {
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
-#define QUEUE_FLAG_STOPPED	1	/* queue is stopped */
-#define QUEUE_FLAG_DYING	2	/* queue being torn down */
-#define QUEUE_FLAG_BIDI		4	/* queue supports bidi requests */
-#define QUEUE_FLAG_NOMERGES     5	/* disable merge attempts */
-#define QUEUE_FLAG_SAME_COMP	6	/* complete on same CPU-group */
-#define QUEUE_FLAG_FAIL_IO	7	/* fake timeout */
-#define QUEUE_FLAG_NONROT	9	/* non-rotational device (SSD) */
-#define QUEUE_FLAG_VIRT        QUEUE_FLAG_NONROT /* paravirt device */
-#define QUEUE_FLAG_IO_STAT     10	/* do disk/partitions IO accounting */
-#define QUEUE_FLAG_DISCARD     11	/* supports DISCARD */
-#define QUEUE_FLAG_NOXMERGES   12	/* No extended merges */
-#define QUEUE_FLAG_ADD_RANDOM  13	/* Contributes to random pool */
-#define QUEUE_FLAG_SECERASE    14	/* supports secure erase */
-#define QUEUE_FLAG_SAME_FORCE  15	/* force complete on same CPU */
-#define QUEUE_FLAG_DEAD        16	/* queue tear-down finished */
-#define QUEUE_FLAG_INIT_DONE   17	/* queue is initialized */
-#define QUEUE_FLAG_NO_SG_MERGE 18	/* don't attempt to merge SG segments*/
-#define QUEUE_FLAG_POLL	       19	/* IO polling enabled if set */
-#define QUEUE_FLAG_WC	       20	/* Write back caching */
-#define QUEUE_FLAG_FUA	       21	/* device supports FUA writes */
-#define QUEUE_FLAG_DAX         23	/* device supports DAX */
-#define QUEUE_FLAG_STATS       24	/* track IO start and completion times */
-#define QUEUE_FLAG_POLL_STATS  25	/* collecting stats for hybrid polling */
-#define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
-#define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
-#define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
-#define QUEUE_FLAG_PCI_P2PDMA  29	/* device supports PCI p2p requests */
-
-#define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
-				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
-				 (1 << QUEUE_FLAG_ADD_RANDOM))
+#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
+#define QUEUE_FLAG_DYING	1	/* queue being torn down */
+#define QUEUE_FLAG_BIDI		2	/* queue supports bidi requests */
+#define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
+#define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
+#define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
+#define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
+#define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
+#define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+#define QUEUE_FLAG_DISCARD	8	/* supports DISCARD */
+#define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
+#define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
+#define QUEUE_FLAG_SECERASE	11	/* supports secure erase */
+#define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
+#define QUEUE_FLAG_DEAD		13	/* queue tear-down finished */
+#define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
+#define QUEUE_FLAG_NO_SG_MERGE	15	/* don't attempt to merge SG segments*/
+#define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
+#define QUEUE_FLAG_WC		17	/* Write back caching */
+#define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
+#define QUEUE_FLAG_DAX		19	/* device supports DAX */
+#define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
+#define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
+#define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
+#define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
+#define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
+#define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
-- 
2.17.1

