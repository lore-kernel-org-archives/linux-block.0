Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B5C3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 02:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA422089E
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 02:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfHPCy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfHPCy2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 22:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01B603082DDD;
        Fri, 16 Aug 2019 02:54:28 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 121031719E;
        Fri, 16 Aug 2019 02:54:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        stable@vger.kernel.org, Mark Ray <mark.ray@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH V2] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Date:   Fri, 16 Aug 2019 10:54:17 +0800
Message-Id: <20190816025417.28964-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 16 Aug 2019 02:54:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is reported that sysfs buffer overflow can be triggered in case
of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs in
blk_mq_hw_sysfs_cpus_show().

So use cpumap_print_to_pagebuf() to print the info and fix the potential
buffer overflow issue.

Cc: stable@vger.kernel.org
Cc: Mark Ray <mark.ray@hpe.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index d6e1a9bd7131..4d0d32377ba3 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -166,20 +166,7 @@ static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
 
 static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 {
-	unsigned int i, first = 1;
-	ssize_t ret = 0;
-
-	for_each_cpu(i, hctx->cpumask) {
-		if (first)
-			ret += sprintf(ret + page, "%u", i);
-		else
-			ret += sprintf(ret + page, ", %u", i);
-
-		first = 0;
-	}
-
-	ret += sprintf(ret + page, "\n");
-	return ret;
+	return cpumap_print_to_pagebuf(true, page, hctx->cpumask);
 }
 
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
-- 
2.20.1

