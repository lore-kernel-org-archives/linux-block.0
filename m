Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD2CCCA47E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiF2XcY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiF2XcX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:23 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A30730B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:22 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id k14so15492368plh.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTvUUdR2VcUGSErAJREfJsS7lYmatYHjz2rOkb6zX9Q=;
        b=5HTR6K3n+2Vnh9OU9ZcDkp3BDoDfEFft9JRoxqsk/K6jd3CzRpOD1HGkDP5mJqiJBd
         P/GeKPBbmuxfSAnWpP3oFsj47rLG7xNZ+wqsnMvxAVYYxwkN1lpGuoERwCyQOYIajM6B
         XwoC/jIivgGf5P334piCF/F6ayM5IR2T93nxMUTxeMgXuMW+Cw0jPF4SpJKd6eSd9CiS
         kurJGzNu070/0a36WlS7193qooTCa4tl4IumA7Q1kZutTNFWiYoPbOwYltP27qspGX13
         dGA9WSvQsm2o6e40BaRsAaDAOKOaPM/bDuL4cKs7tbVN4KlAVjhgOZRkyEsLdGe14WIC
         mhSw==
X-Gm-Message-State: AJIora/liZwlbMOLFFeIww7b3rP3PLE8vmyGECc6tuZankXIX9F/LkkX
        UPZ3QkAnBU88MK8Pw0JoNm8YXvTUNAg=
X-Google-Smtp-Source: AGRyM1u4Ob2jd92KXrMKqqmugaXEUwUhFqrTwwaY9RjakXsD/DbVUAw/7DSylg7JDs1oBgk5fzM8Og==
X-Received: by 2002:a17:902:e541:b0:16b:89b3:5848 with SMTP id n1-20020a170902e54100b0016b89b35848mr11081046plf.39.1656545541993;
        Wed, 29 Jun 2022 16:32:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 18/63] block/zram: Use enum req_op where appropriate
Date:   Wed, 29 Jun 2022 16:31:00 -0700
Message-Id: <20220629233145.2779494-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type where
appropriate.

Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a35b86c58aa2..4abeb261b833 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1523,7 +1523,7 @@ static void zram_bio_discard(struct zram *zram, u32 index,
  * Returns 1 if IO request was successfully submitted.
  */
 static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
-			int offset, unsigned int op, struct bio *bio)
+			int offset, enum req_op op, struct bio *bio)
 {
 	int ret;
 
