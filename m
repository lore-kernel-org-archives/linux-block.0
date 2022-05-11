Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213CCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 23:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbiEKXwC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiEKXwA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 19:52:00 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA236FD35
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 16:52:00 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id q4so3316123plr.11
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 16:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUq8MZkIMGIKAY5+/hGDiBiXrJeyYwQcdrQV4P7taLM=;
        b=sqf3hGzKggiZtUklsSeEYj75KDmSEIdOz+96z5bhFJTqqXIrpbrOFQSZ+939FdVPz1
         Vl/FuzlDRtHLo7NXPdK8QS5ipKhActIPLDLb99Fv2PLU50UWJYjs6MmqsVbvttOC2Q+D
         1nMVX+G3vhlCJwwSMzBRahXTH5zA+FjPE6ToX1h1RYEposliMereraFUIwNQgwOLV5mt
         AL5a2/useu6NMM9MHJNh/KRHnbs44Xb4yGVlmR/ldwmYWHgejXd2gYI9NU2748OIO1kN
         uAcEGXwnGCSC6F27WUKNI8KH3obtnSaAmRaC+4UbGIM21B7jZsWiaQOLE/KeYFgCZdmT
         puig==
X-Gm-Message-State: AOAM533ShhdDj9JRSXO32p0kHJ2j3BFxz5rZz8tEqREFgirTh0bszj2J
        QV9CVtPBFc5htTt5oDtdNAsbWRjeMHg=
X-Google-Smtp-Source: ABdhPJx8FVebMGLiyygYds4lrXDMoIixv4qquCSashpdWjbE//KtDesJTFkXk+yzbwbBORvqUx8WTw==
X-Received: by 2002:a17:90b:4f4c:b0:1dc:acba:9f3 with SMTP id pj12-20020a17090b4f4c00b001dcacba09f3mr7977053pjb.159.1652313119761;
        Wed, 11 May 2022 16:51:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:78c5:5d65:4254:a5e])
        by smtp.gmail.com with ESMTPSA id k130-20020a628488000000b0050dc762819bsm2335941pfd.117.2022.05.11.16.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:51:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Fix the bio.bi_opf comment
Date:   Wed, 11 May 2022 16:51:52 -0700
Message-Id: <20220511235152.1082246-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit ef295ecf090d modified the Linux kernel such that the bottom bits
of the bi_opf member contain the operation instead of the topmost bits.
That commit did not update the comment next to bi_opf. Hence this patch.

From commit ef295ecf090d:
-#define bio_op(bio)    ((bio)->bi_opf >> BIO_OP_SHIFT)
+#define bio_op(bio)    ((bio)->bi_opf & REQ_OP_MASK)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Fixes: ef295ecf090d ("block: better op and flags encoding")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk_types.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c62274466e72..6308c960573d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -246,9 +246,8 @@ typedef unsigned int blk_qc_t;
 struct bio {
 	struct bio		*bi_next;	/* request queue link */
 	struct block_device	*bi_bdev;
-	unsigned int		bi_opf;		/* bottom bits req flags,
-						 * top bits REQ_OP. Use
-						 * accessors.
+	unsigned int		bi_opf;		/* bottom bits REQ_OP, top bits
+						 * req_flags.
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
