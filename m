Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003DC4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 06:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3DB61368
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 06:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhHYGA6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238194AbhHYGAy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 02:00:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6766561368;
        Wed, 25 Aug 2021 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629871209;
        bh=GVzMjVcvd7OSPgh3uqbGyGKV25w6xWDrV98w2wH1Diw=;
        h=From:To:Cc:Subject:Date:From;
        b=dCHpN0GVvTearzLaRTznaE/AdqMfw1ke80idU0GmN38QbTTjbY1jQv6LiSvsyh5R7
         /3OQi3KrJhSGxyZVhNoGQbE7KwNMo+gCMxyehAvSmDzfWY4Bm/X9rdr1jnZO8VRaeK
         VlnzsjHbdAcGxGtE6gvnpfWWd5UoffTRFqdl6lLAmHTRr/DE4+6c11ucK2DXoIL38k
         6xAkwRa754fG9pJIpV3w/OR07Ra8a8IeeProM2VQQwn1D85oGwTU2XeFojgF+w0XhA
         pJIlGXQSnck/+joWhqGd6o6aT+CM/GshnDrz2ovGRt8frjxPZtpENAyeeGhj5N9WWR
         RwgJg8UhH7BoA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>
Subject: [PATCH] blk-crypto: fix check for too-large dun_bytes
Date:   Tue, 24 Aug 2021 22:59:18 -0700
Message-Id: <20210825055918.51975-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

dun_bytes needs to be less than or equal to the IV size of the
encryption mode, not just less than or equal to BLK_CRYPTO_MAX_IV_SIZE.

Currently this doesn't matter since blk_crypto_init_key() is never
actually passed invalid values, but we might as well fix this.

Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index c5bdaafffa29f..103c2e2d50d67 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -332,7 +332,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 	if (mode->keysize == 0)
 		return -EINVAL;
 
-	if (dun_bytes == 0 || dun_bytes > BLK_CRYPTO_MAX_IV_SIZE)
+	if (dun_bytes == 0 || dun_bytes > mode->ivsize)
 		return -EINVAL;
 
 	if (!is_power_of_2(data_unit_size))
-- 
2.32.0

