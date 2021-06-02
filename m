Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF51C47092
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D936121D
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 10:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFBKIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:08:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFBKIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 06:08:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1loNm7-0006tS-AK; Wed, 02 Jun 2021 10:06:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] null_blk: Fix null pointer dereference on nullb->disk on blk_cleanup_disk call
Date:   Wed,  2 Jun 2021 11:06:59 +0100
Message-Id: <20210602100659.11058-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error handling on a nullb->disk allocation currently jumps to
out_cleanup_disk that calls blk_cleanup_disk with a null pointer causing
a null pointer dereference issue. Fix this by jumping to out_cleanup_tags
instead.

Addresses-Coverity: ("Dereference after null check")
Fixes: 132226b301b5 ("null_blk: convert to blk_alloc_disk/blk_cleanup_disk")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d8e098f1e5b5..83d803cb57c8 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1856,7 +1856,7 @@ static int null_add_dev(struct nullb_device *dev)
 			goto out_cleanup_tags;
 		nullb->disk = alloc_disk_node(1, nullb->dev->home_node);
 		if (!nullb->disk)
-			goto out_cleanup_disk;
+			goto out_cleanup_tags;
 		nullb->disk->queue = nullb->q;
 	} else if (dev->queue_mode == NULL_Q_BIO) {
 		rv = -ENOMEM;
-- 
2.31.1

