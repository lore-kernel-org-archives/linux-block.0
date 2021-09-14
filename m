Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCDEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874B661163
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhINHMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbhINHMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 03:12:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF7C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KWp8vmMbO3DtgMY56aSxL6xJpVznvKrsjuA6ZN3BFII=; b=jvhcc4Dmh6JGN2s9dUbyLwHkPo
        guM0ns2j0mujP1pPqyVnJjMoTKEikOu0LCMVU2C34ED6HjKo4V+RM/kmH9N2Hgys5pmF7cWU08Wky
        RPpfe5+ZyPlnAw5qyulvOfPRDOEmXB+jJAEF9vUgSnW0TVgQTEQsscllqv3Q2RYA5viMDiDKZgLIP
        /fQrEAfKkCxaKBI8osl0XUGAZspM3E+9g5+VOw1r5VPRangFrZSxD2chuTT/by01Oon5vDvqY8njR
        RYjN/pAykXa/kkYIKYc9C/q3MkCvmsyv5jOxBhNMUZuG/40rBsgT2aaH2aQjHfBLSyw7aN5iKKg60
        stSkZhVA==;
Received: from [2001:4bb8:184:72db:7baf:b601:6734:7149] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ2Xx-00EMpg-FX; Tue, 14 Sep 2021 07:08:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com
Cc:     Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] block: check if a profile is actually registered in blk_integrity_unregister
Date:   Tue, 14 Sep 2021 09:06:55 +0200
Message-Id: <20210914070657.87677-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914070657.87677-1-hch@lst.de>
References: <20210914070657.87677-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While clearing the profile itself is harmless, we really should not clear
the stable writes flag if it wasn't set due to a registered integrity
profile.

Reported-by: Lihong Kou <koulihong@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69a12177dfb62..48bfb53aa8571 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -426,8 +426,12 @@ EXPORT_SYMBOL(blk_integrity_register);
  */
 void blk_integrity_unregister(struct gendisk *disk)
 {
+	struct blk_integrity *bi = &disk->queue->integrity;
+
+	if (!bi->profile)
+		return;
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
-	memset(&disk->queue->integrity, 0, sizeof(struct blk_integrity));
+	memset(bi, 0, sizeof(*bi));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
 
-- 
2.30.2

