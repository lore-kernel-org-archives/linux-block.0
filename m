Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648D5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiFWTBd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiFWTBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:11 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06C010E67E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:30 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id r66so184873pgr.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDrUbGX6pJvpKfdPLgsIQ+aIpWdnNjzAWz8vQdxyqAM=;
        b=sDS+9nignxwwTbKnxpcS0Chce2jdTsxo43HBFdaHlDRRQN0HnP0+2X7V0YlN6OzaRq
         TXywXYYSFtMM/pMn+e2ZLgXpDAfVQVSJO1HHBI/zsxnLO3nZ891Yo5VY3yNIn9i7xD0n
         FozSbxHeOGdfAILBlux5t27uKtxwCwqNvWiuhui/8DO1tP+nxWGfWKhvahPDaiGmxO3R
         nUqEWX+mwBryuaUgzKp8us/2KyuagYQ0yPbEd4vEJbO519zMygVQpd/Hz7kAhGIfDAcK
         VNMFWwcFba+4tkeb+OcZ+3CxhzcEBAacmW1dsk4iasyohpmS7YbjnRruJG01ZIwSVSaJ
         LNpA==
X-Gm-Message-State: AJIora9Ct7bBDZpjyN/s7nhjveQR9LDqo5GemMaqD4LKugTUGhyaKk0/
        whBgTMRoMB32EOfbXj70JQM=
X-Google-Smtp-Source: AGRyM1vYnG3menuGI91AwfsD9P0Kr4/+Gx/XA6p1FCITgG2/oPQ1YYMbQi5OL/EsjTUaoc4ccnH4nA==
X-Received: by 2002:a63:2b16:0:b0:3fa:faf9:e6d7 with SMTP id r22-20020a632b16000000b003fafaf9e6d7mr8442209pgr.325.1656007590051;
        Thu, 23 Jun 2022 11:06:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 35/51] mm: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:12 -0700
Message-Id: <20220623180528.3595304-36-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for block
layer request flags.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/writeback.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index b8c9610c2313..3f045f6d6c4f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -101,9 +101,9 @@ struct writeback_control {
 #endif
 };
 
-static inline int wbc_to_write_flags(struct writeback_control *wbc)
+static inline blk_opf_t wbc_to_write_flags(struct writeback_control *wbc)
 {
-	int flags = 0;
+	blk_opf_t flags = 0;
 
 	if (wbc->punt_to_cgroup)
 		flags = REQ_CGROUP_PUNT;
