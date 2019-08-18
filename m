Return-Path: <SRS0=gctd=WO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC80C3A589
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 10:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B654C21773
	for <linux-block@archiver.kernel.org>; Sun, 18 Aug 2019 10:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RxyBQGTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfHRKvI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Aug 2019 06:51:08 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:55966 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRKvI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Aug 2019 06:51:08 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 06:51:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=QisNdYsoeTN1WygRtH
        888heRcRCfaFJynN2qtkQ9Gag=; b=RxyBQGTbXO+YfyWSH03HvOTuvmsoriBHld
        EN4Khf0UFDZVDoN4odMLyiwSeyH774ceY8f+ErL2XRikupLwOH4IabK1y7QnnHNr
        WyeCFEhm7NUkseD0lKtyzoRprLwfJAS13ZVBoAvtQbb1YrFt/MCBt1vtKmynxcPW
        a6393r/D4=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp3 (Coremail) with SMTP id G9xpCgD33kz3KVldXa7aCg--.296S3;
        Sun, 18 Aug 2019 18:35:53 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] block/bio-integrity: fix mismatched alloc free
Date:   Sun, 18 Aug 2019 18:35:14 +0800
Message-Id: <1566124514-3507-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: G9xpCgD33kz3KVldXa7aCg--.296S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1UuFyUtr17GFyfXry8uFg_yoWfCFX_Ga
        yv9395ArnavFs7Cw12yFy7Ar4vqF4rXr1rXFy2qrWaqFyxAr98AwnrXrn5XF4xWr97Wrnx
        urWvqwnFqw17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjDUU5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAkVclSIcA-HPQAAs3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function kmalloc rather than mempool_alloc is called to allocate
memory when the memory pool is unavailable. However, mempool_alloc is
used to release the memory chunck in both cases when error occurs. This
patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 block/bio-integrity.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index fb95dbb..011dfc8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -75,7 +75,10 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 
 	return bip;
 err:
-	mempool_free(bip, &bs->bio_integrity_pool);
+	if (!bs || !mempool_initialized(&bs->bio_integrity_pool))
+		kfree(bip);
+	else
+		mempool_free(bip, &bs->bio_integrity_pool);
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
-- 
2.7.4

