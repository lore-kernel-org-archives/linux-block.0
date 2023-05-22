Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672EAC77B75
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjEVW0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjEVW0I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:08 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AEFE
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:02 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-25355609a04so5061579a91.0
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794362; x=1687386362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nPIyQM82Riwdn1TbgeyQbxnpAye3accjbnW9cFcS6c=;
        b=hZLNpub7CENnuIXMlSS+AeXuLmog71SxT6sOh76ZtLH+AQBup166NcyN1Gmd8r03P3
         iWJD7P8gesyqBgYlSvg16j8WbMCT8kCX/Zd3B1eTEKBOSiXbfRpNvKGiekhGNg7XA2Nh
         VNJKlLbnnycD0/C9qJnm/Kaf2at2NH6z4ZV3H0N6iNVRl0XLNfv4w1nhLIQLzRMPENwB
         3cdDqZTgezUVcghE6K0A8lNnbOzgzKw7NU9z/9Mev4NcaZ4nRlllKK9iMie+bdr1Nk9O
         uBxpTN+7L3dUJjo7u909CdwZgYeuR6XPhgbGn1OwMaIT+OgyBToxafMZzbPaSwrEjEaV
         hxvQ==
X-Gm-Message-State: AC+VfDz4UxAqTIRSE3DhAnKil20xc9cGG7Lax3lwPrgWxhLIHTw7tsug
        mP+yjtlW8e7gZhwfEsXurpUbUfI2ok0=
X-Google-Smtp-Source: ACHHUZ6frK3Vck1xd4xgJco2Yq49QX9leNTtKTTYBT94vLK8jSA2iDbq1xBDSViiXi1zrG8pDyqjPw==
X-Received: by 2002:a17:90a:984:b0:253:7f10:a077 with SMTP id 4-20020a17090a098400b002537f10a077mr11312184pjo.34.1684794362384;
        Mon, 22 May 2023 15:26:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 2/9] block: Prepare for supporting sub-page limits
Date:   Mon, 22 May 2023 15:25:34 -0700
Message-ID: <20230522222554.525229-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce variables that represent the lower configuration bounds. This
patch does not change any functionality.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1d8d2ae7bdf4..95d6e836c4a7 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -123,10 +123,11 @@ EXPORT_SYMBOL(blk_queue_bounce_limit);
 void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_sectors)
 {
 	struct queue_limits *limits = &q->limits;
+	unsigned int min_max_hw_sectors = PAGE_SIZE >> SECTOR_SHIFT;
 	unsigned int max_sectors;
 
-	if ((max_hw_sectors << 9) < PAGE_SIZE) {
-		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
+	if (max_hw_sectors < min_max_hw_sectors) {
+		max_hw_sectors = min_max_hw_sectors;
 		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);
 	}
 
@@ -281,8 +282,10 @@ EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
  **/
 void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
-	if (max_size < PAGE_SIZE) {
-		max_size = PAGE_SIZE;
+	unsigned int min_max_segment_size = PAGE_SIZE;
+
+	if (max_size < min_max_segment_size) {
+		max_size = min_max_segment_size;
 		pr_info("%s: set to minimum %u\n", __func__, max_size);
 	}
 
