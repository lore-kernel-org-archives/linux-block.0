Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446CFC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEPWdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEPWda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:30 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99245FCF
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:29 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1aad5245632so1386215ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276409; x=1686868409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Meycj9u3JfaVnzaUnu3BPLSoAESUUt4GW23IhKc0tM8=;
        b=P/O1A28Qjnynqzvfg3mQPe/XpbP/QD1KOK2LO98KxRycYyIMsjFVgCmCVAiCW1Wc3z
         Mqm0j+xa+NHrrCbbhS1rA1i3695r2YWS0ArI6VaQ2HYaeb6OH8WtHrwmojDjsKJpeozE
         GqppYZGa1rlz2snHFeT6VChn6vmllTayrGsdh0NvbiiM0YarXXaqWzXi7q7XHv2IvPVm
         a7EsBHhz4Xk4cDCtayBwpTGdwwRaD79zjsv4R9gI3PG/mB7T+G0FTM0QzxoX5EoISfcJ
         LB0HpkbG+9dCXtIP2vRBo3oGUNpb6CsGVHIBVp3ql+KILCOWlP/jfX8+n/6oK65pjO7h
         Qe2A==
X-Gm-Message-State: AC+VfDyGHv8JjahVfrXNvoz8bsuUYp1Fvc+h9IvUUyq8phrmhlKagLMv
        5x1yrl4uYho1ldQAICNYtt1wJrKnbj4=
X-Google-Smtp-Source: ACHHUZ6LHCr6ZwFWNTQjkRstZ5Jro1YbUmD9kAc0Se55zORWO3TMiJtQwIHximvuFu0kpomW/i9rgg==
X-Received: by 2002:a17:903:22cd:b0:1a2:19c1:a974 with SMTP id y13-20020a17090322cd00b001a219c1a974mr46891606plg.68.1684276409051;
        Tue, 16 May 2023 15:33:29 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 01/11] block: Simplify blk_req_needs_zone_write_lock()
Date:   Tue, 16 May 2023 15:33:10 -0700
Message-ID: <20230516223323.1383342-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the blk_rq_is_passthrough() check because it is redundant:
blk_req_needs_zone_write_lock() also calls bdev_op_is_zoned_write()
and the latter function returns false for pass-through requests.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fce9082384d6..835d9e937d4d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -57,9 +57,6 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
  */
 bool blk_req_needs_zone_write_lock(struct request *rq)
 {
-	if (blk_rq_is_passthrough(rq))
-		return false;
-
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
