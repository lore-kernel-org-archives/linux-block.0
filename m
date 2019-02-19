Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A9C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A4D2147A
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfBSOa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:30:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55387 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfBSOa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 09:30:57 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gw6QB-0005ZK-Db; Tue, 19 Feb 2019 14:30:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] block: don't dereference a potential null bio pointer until is has been null checked
Date:   Tue, 19 Feb 2019 14:30:55 +0000
Message-Id: <20190219143055.11633-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The bio pointer is being null checked hence it can be potentially
null, however earlier it is being derefefenced on the assignment of
front_seg_size.  Avoid the dereference issue by only assigning
front_seg_size after bios has been null sanity checked.

Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/blk-merge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bed065904677..1bec20fbe465 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -379,6 +379,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 		return 1;
 	}
 
+	front_seg_size = bio->bi_seg_front_size;
 	fbio = bio;
 	seg_size = 0;
 	nr_phys_segs = 0;
-- 
2.20.1

