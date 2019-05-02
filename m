Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12116C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 19:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54862087F
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 19:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vz1HuF/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBTsV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 15:48:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38983 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBTsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 15:48:16 -0400
Received: by mail-io1-f65.google.com with SMTP id m7so1011729ioa.6
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7pqAbbGmAH866hhv2CWn1/a2UtcPAW35gnabgPgAghM=;
        b=Vz1HuF/BEHGs0vrltc6iayVJQYApNpNTqqkksa0tqS9J+cfl+8iwJkC7evwIqAQPil
         oE5IzvlOtvBEqMFdDqeTYEFPuyFfuix54qOswATJfvuRLQQdArgg4Yj4+37qL5saYyAc
         Dli+gR1IkxZnPNcewgApt32EdFZps9j1ViQTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7pqAbbGmAH866hhv2CWn1/a2UtcPAW35gnabgPgAghM=;
        b=LUux8j/gMRUmFD3VNb8ShiSFwzyiAl/xjdHqJbFSAcFl9NxaCWNr84qJMGvcnStn3r
         qlGWLK3e8+SdDyxOsICjWgSa31T3MtEqV+JLpFwilGBURsiHgSDAyMn7xVla0dBFvOYa
         ERGfCBNKf14qRRWju2E3grG7huI0l3DycC7QyY8chXpke+o5nQB0fc4bqHtrjtGcpWAF
         z1urkIBhLI89QYtiKd87nLVEt6L6RkUZ4+YCeHLpPDS5xiik65AgaamI8iWOE57lTPKQ
         OIi/oHNYV8U+lI4KgWUDtuCItH8LOPe/QmYZPzlUhuTJ3C+iviAUyIqoEPna6ISnbPm3
         6BVg==
X-Gm-Message-State: APjAAAVSvR1nCQLBn32ps3gHpUr8zScXkaAWRyCFzsjBCn+a8R4/TmKq
        39HUihqDuHIwzDw/+yKcXvpknUcsY5mLzQ==
X-Google-Smtp-Source: APXvYqwwLQP25fP1ExsutjkA8ZN9vEmRnbaeAXWEvPdG6Tywh9Q0UgEXO2AlPxYBPxtE3Rjrrtt8hw==
X-Received: by 2002:a5d:8f82:: with SMTP id l2mr4094494iol.110.1556826495625;
        Thu, 02 May 2019 12:48:15 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t127sm78565itb.32.2019.05.02.12.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:48:14 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-block@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Fix function name in comment
Date:   Thu,  2 May 2019 13:48:11 -0600
Message-Id: <20190502194811.200677-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The comment was out of date.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9516304a38ee..0e467ff440a2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2062,7 +2062,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		list_del_init(&page->lru);
 		/*
 		 * Remove kmemleak object previously allocated in
-		 * blk_mq_init_rq_map().
+		 * blk_mq_alloc_rqs().
 		 */
 		kmemleak_free(page_address(page));
 		__free_pages(page, page->private);
-- 
2.21.0.593.g511ec345e18-goog

