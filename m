Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BB1C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEQRpg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEQRpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:32 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B47AD32
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:01 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-643465067d1so835480b3a.0
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345472; x=1686937472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3LBuBNIBav3dorAz0aTtKrVDkeCIbggzsfXX9pDkGI=;
        b=SN18Xo4dZzS4di4QjhjZgJeuEN78tqdRXI0znMkEgHZgDtBNZlO9/U1Nu2+Gm3dy9Q
         U7ZdmZ8hh1/ASIVQahntj7gctRBE/5xKPrIPBS0ON32JSYMuxQZl1Dfw1t6nv5b8K6uq
         RZQF6+YMZjiMgD1DvAR7YYQPW3pIjz+dH8AYmPMcZ7J6bzgOcXl4ieLp6yJqhCiAMDTS
         zSILaB8c7KSZzO3L3sa52jMx2TrrVvpJr38qlzJwf4aHQehIB8pE/ItukggWgtrPdRFL
         fuN4flMDZHvvwyM17CtlD1vp+F2kOai9/opzzqXfwgJPNwTVxJgKB3EiA8aRAR+cQ67j
         4xAA==
X-Gm-Message-State: AC+VfDxpxEvxNLTBMev//AGHc9UXAt+m0ugL8YbaykXAYG1tBcbBtCqY
        im3x1+XDELgDT9Xgyg88+ec=
X-Google-Smtp-Source: ACHHUZ7lIMa/tihI4ODOWbQDaIGekQ1wf8tLslyCeJPJJyKQv7a+SFfdmyb3XkqrWa1EFpECgeyUrw==
X-Received: by 2002:a05:6a00:1943:b0:63d:3981:313d with SMTP id s3-20020a056a00194300b0063d3981313dmr624829pfk.10.1684345472380;
        Wed, 17 May 2023 10:44:32 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 02/11] block: Simplify blk_req_needs_zone_write_lock()
Date:   Wed, 17 May 2023 10:42:20 -0700
Message-ID: <20230517174230.897144-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the blk_rq_is_passthrough() check because it is redundant:
blk_req_needs_zone_write_lock() also calls bdev_op_is_zoned_write()
and the latter function returns false for pass-through requests.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
 
