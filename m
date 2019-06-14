Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBCEC31E4D
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811AB20850
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfFNNOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:14:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727766AbfFNNOs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:14:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4267AAE07;
        Fri, 14 Jun 2019 13:14:47 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        stable@vger.kernel.org
Subject: [PATCH 11/29] bcache: ignore read-ahead request failure on backing device
Date:   Fri, 14 Jun 2019 21:13:40 +0800
Message-Id: <20190614131358.2771-12-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When md raid device (e.g. raid456) is used as backing device, read-ahead
requests on a degrading and recovering md raid device might be failured
immediately by md raid code, but indeed this md raid array can still be
read or write for normal I/O requests. Therefore such failed read-ahead
request are not real hardware failure. Further more, after degrading and
recovering accomplished, read-ahead requests will be handled by md raid
array again.

For such condition, I/O failures of read-ahead requests don't indicate
real health status (because normal I/O still be served), they should not
be counted into I/O error counter dc->io_errors.

Since there is no simple way to detect whether the backing divice is a
md raid device, this patch simply ignores I/O failures for read-ahead
bios on backing device, to avoid bogus backing device failure on a
degrading md raid array.

Suggested-and-tested-by: Thorsten Knabe <linux@thorsten-knabe.de>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index c25097968319..4d93f07f63e5 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -58,6 +58,18 @@ void bch_count_backing_io_errors(struct cached_dev *dc, struct bio *bio)
 
 	WARN_ONCE(!dc, "NULL pointer of struct cached_dev");
 
+	/*
+	 * Read-ahead requests on a degrading and recovering md raid
+	 * (e.g. raid6) device might be failured immediately by md
+	 * raid code, which is not a real hardware media failure. So
+	 * we shouldn't count failed REQ_RAHEAD bio to dc->io_errors.
+	 */
+	if (bio->bi_opf & REQ_RAHEAD) {
+		pr_warn_ratelimited("%s: Read-ahead I/O failed on backing device, ignore",
+				    dc->backing_dev_name);
+		return;
+	}
+
 	errors = atomic_add_return(1, &dc->io_errors);
 	if (errors < dc->error_limit)
 		pr_err("%s: IO error on backing device, unrecoverable",
-- 
2.16.4

