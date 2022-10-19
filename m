Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB49C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiJSWYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJSWX7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:59 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A3180258
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:58 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id x188so20915621oig.5
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtRo0WR/0wJi6D1UbYgM0y9oYqjQT06GSB2djBWG90c=;
        b=F+7ADRLefDI+65uas3M5QN81sGruM+Wk4r2DcV6Gv0J4tSd+vq8B5ioZv/046iHyuA
         7F18aloGTXXWxC6aQRdEaLHH5ijKYvpqIJ3p4zC/2vI7Si6FXNLeh0UYStZZeFfb0UFp
         eCUopt461STO53eZNSZesjcK/ee7zG11W7QX1mYvtwLLbXFrDLE8kdjQ/frbaSv/FRZb
         1DHicv01PXl1emLsByIJtjw/FITLb/+CV/Ja+oFTAND/TxidHp/gJWdJuCTf4nUqTmQ4
         RkoPlc3K61rytRFlaPsdpOrnxVLRe0X+LXZHDZ8wCvWwckZ1WOWSDJrc3op92YcTNbGx
         Ag/A==
X-Gm-Message-State: ACrzQf10MusPQ6MmOldLuqBkxKIlmP270pA5YYkqWAhhuKXK/RmYOE4z
        KglJSWKapNB59JosxcpA1qOPGdfCw+4=
X-Google-Smtp-Source: AMsMyM7oE17QefRK/hwII/lAogVYWHIjem9DgYz03HhsBifHwlhb+mjof3W/H/hNqWxvO/8XhY/Ukw==
X-Received: by 2002:a17:90b:1808:b0:20c:8409:2007 with SMTP id lw8-20020a17090b180800b0020c84092007mr12398335pjb.226.1666218227132;
        Wed, 19 Oct 2022 15:23:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 07/10] block: Add support for segments smaller than the page size
Date:   Wed, 19 Oct 2022 15:23:21 -0700
Message-Id: <20221019222324.362705-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the necessary checks in the bio splitting code for splitting bios
into segments smaller than the page size.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 6 ++++--
 block/blk.h       | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 35a8f75cc45d..7badfbed09fc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -294,7 +294,8 @@ static struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
 		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
-			nsegs++;
+			/* single-page bvec optimization */
+			nsegs += blk_segments(lim, bv.bv_len);
 			bytes += bv.bv_len;
 		} else {
 			if (bvec_split_segs(lim, &bv, &nsegs, &bytes,
@@ -531,7 +532,8 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			    __blk_segment_map_sg_merge(q, &bvec, &bvprv, sg))
 				goto next_bvec;
 
-			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE)
+			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE &&
+			    bvec.bv_len <= q->limits.max_segment_size)
 				nsegs += __blk_bvec_map_sg(bvec, sglist, sg);
 			else
 				nsegs += blk_bvec_map_sg(q, &bvec, sglist, sg);
diff --git a/block/blk.h b/block/blk.h
index 342ba7d86e87..04328211ae3b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -312,7 +312,7 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 	}
 
 	/*
-	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
+	 * Check whether bio splitting should be performed.
 	 * This is a quick and dirty check that relies on the fact that
 	 * bi_io_vec[0] is always valid if a bio has data.  The check might
 	 * lead to occasional false negatives when bios are cloned, but compared
@@ -320,6 +320,7 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 	 * doesn't matter anyway.
 	 */
 	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
+		bio->bi_io_vec->bv_len > lim->max_segment_size ||
 		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
 }
 
