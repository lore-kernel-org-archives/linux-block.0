Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B49C3A589
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 01:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD98F2184E
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 01:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fqHzFLxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfHSBLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:11:12 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:56622 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSBLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Aug 2019 21:11:11 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 21:11:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=AhlZq954DUs1td47Fp
        1YzSTZ4wsM4BL8ljtYCpk7jqE=; b=fqHzFLxv2+v/O2kxlBHQBazdO8j4C/U2g3
        7IiWVcWp6JTJQzCEw7b2x9wZk+MF9L6WhiulOJH9b3OP/Xeb0MfVGPP8FI1V44sK
        8XQ5hdC3uc+CSyZ3hTa2Af27IfDtSN6IBbyW+N9/Y+GsP8k8dJ6ouD0KDMm7BBQ3
        VsIX2kdpo=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp4 (Coremail) with SMTP id HNxpCgDHeKB981ld3QyRCw--.171S3;
        Mon, 19 Aug 2019 08:55:37 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>, stable@vger.kernel.org
Subject: [PATCH V2] block: fix a mismatched alloc free in bio_alloc_bioset
Date:   Mon, 19 Aug 2019 08:55:20 +0800
Message-Id: <1566176120-19924-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HNxpCgDHeKB981ld3QyRCw--.171S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4xGF43JF4fCF4DJw1UJrb_yoWfAFb_Ka
        10qrs7JFykXFW7CwnFkrW8Zr409rWfGr48uF13t3y3Jry5GFn3ZwnFqr95Wrs7CrWxuFyY
        v395WF15tr17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb6wZ3UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZAkWclQHGZll7gAAsR
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function kmalloc is called to allocate memory if bs is NULL.
However, mempool_free is used to release the memory chunk even if bs is
NULL in the error hanlding code. This patch checks bs and use the
correct function to release memory.


Fixes: 3f86a82aeb ("block: Consolidate bio_alloc_bioset(), bio_kmalloc()")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Cc: stable@vger.kernel.org
---
V2: add Fixes and Cc tags
---
 block/bio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 299a0e7..c5f5238 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -515,7 +515,10 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 	return bio;
 
 err_free:
-	mempool_free(p, &bs->bio_pool);
+	if (!bs)
+		kfree(p);
+	else
+		mempool_free(p, &bs->bio_pool);
 	return NULL;
 }
 EXPORT_SYMBOL(bio_alloc_bioset);
-- 
2.7.4

