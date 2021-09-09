Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F4C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 05:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920746115B
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 05:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350781AbhIIFiO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 01:38:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38112 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350776AbhIIFiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 01:38:14 -0400
Received: from localhost.localdomain (unknown [171.61.210.53])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1E90A20B6C51;
        Wed,  8 Sep 2021 22:37:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E90A20B6C51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1631165825;
        bh=DgQXEsYLYwB5kRXEn217ARkxV0Yono9qI9u8Z8JlDp8=;
        h=From:To:Cc:Subject:Date:From;
        b=HkysfVKkXpHnxKBTmVjRD2DKcuGhQLIkIn6l1BXBZtYNMAqm/uWrOSWJhfjxiOS6e
         no4QHsBU43vyF5FyqFNyKeRKO85iT+2JhRJKjoEaK8w39RikoHcRK46llottKqO0Y9
         YQU/9Vro5RjNyv1wsyjaIRi6jQOdou44bmfyxkbE=
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk
Subject: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Date:   Thu,  9 Sep 2021 11:06:53 +0530
Message-Id: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are use-cases like replication where need to hook the blk I/O
operations for devices and perform specific operation and fallback to
its original I/O operations.
Prior to v5.9 there was make_request_fn and then blk_mq_submit_bio
exported apis, which provided infrastructure to drivers to develop these
features. However in v5.10-rc1 with below commit the API was removed
from the export list.

Previous commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.10-rc1&id=681cc5e8667e8579a2da8fa4090c48a2d73fc3bb

This patch exports the blk_mq_submit_bio symbol to provide flexibility
to the drivers.

Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65d3a63aecc6..40a9b085f029 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2283,6 +2283,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	blk_queue_exit(q);
 	return BLK_QC_T_NONE;
 }
+EXPORT_SYMBOL_GPL(blk_mq_submit_bio);
 
 static size_t order_to_size(unsigned int order)
 {
-- 
2.25.1

