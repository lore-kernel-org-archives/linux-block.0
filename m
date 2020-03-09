Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3FCC18E5A
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B712465A
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Ua/AV2Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCIVmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:42:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34419 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgCIVmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:42:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id c21so13821883edt.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WPN6D+ixHFS4V2sd3bb6fpXub9mV2zJVFHpgTOskRBg=;
        b=Ua/AV2PwvKgWUM34wUoJYavx3VXuZxZmRSQ3UfUc1eMaiBCApznJvYfZLOqYQOwNyY
         SSs4NzBJqPSGf6yn/DajptwYYU7awTuE2IK09h2U2xU9ZzacgCSeWH2vJ0qasr9KJ7wK
         KpqsRM+7OkOHUxRauGt0x8d8wlfVrpxdCSKw+hms6RutrYJca1qTD09TIPbGTr99ZyJa
         n9JfuY8GFA3953N2Zd9WAvtHUfyyAJT/bLA+dXzXNtEzuXfe3LFtdztzQNKMoUAKIFtx
         Mzy0bBI09AcK2JrigAoNeEVvWtU4cPeemMptIVNSRRfMDLBeQXTNcUl8BE65bvOmFxVW
         F3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WPN6D+ixHFS4V2sd3bb6fpXub9mV2zJVFHpgTOskRBg=;
        b=D4gkSQBsw3oiVsV//LvcRMc+osLgh6uBKUCxoIKDEUdbTVcnWjVjlIsVq/U0BdbCdU
         iI331N/xKsj84jqJWOuxjXIEYnmkdC3OdzkKrGuOOdIFN95cWNtyV6e+cqg7QEVKisMa
         wNGZoaxeIzonw8/NUuI9UJ+4xqc0sOjPWM1rPLjWfEe7KbgbiqWnJPCt0/mHhl7yiMeT
         0esfshyW/4Wlv5y0qV1+4dnvMofv4ZSlA5bmd5mEtj3Pf2ErUHLuS2rXEtjJ6RnLLB0p
         pe1CnbkQtq+QL91p+e4t3NTLXvbhjfNwx2hnVmUWWZNyYAHHvYl6eTWaeSPK8mL1JUPf
         2KJQ==
X-Gm-Message-State: ANhLgQ1VlX/nAQlGvL/EDOukgfFADU7o7VAG8YMe0JTJ1zuX5V0aDKiX
        04nvOCkYz2/nN7mUin7phL+juQ==
X-Google-Smtp-Source: ADFU+vvtUoGn7yo/CVcin+6Ctu5uQRqaamKvendYKhUo+S37zAMeEibevK68oclcqYySFRzhbYj1JA==
X-Received: by 2002:a17:906:5901:: with SMTP id h1mr16863342ejq.108.1583790134313;
        Mon, 09 Mar 2020 14:42:14 -0700 (PDT)
Received: from nb01257.fritz.box ([2001:16b8:4824:700:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id g6sm3828488edm.29.2020.03.09.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:42:13 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 4/6] block: cleanup for _blk/blk_rq_prep_clone
Date:   Mon,  9 Mar 2020 22:41:36 +0100
Message-Id: <20200309214138.30770-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both cmd and sense had been moved to scsi_request, so remove
the related comments to avoid confusion.

And as Bart suggested, move _blk_rq_prep_clone into the only
caller (blk_rq_prep_clone).

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 883ffda216e4..4433f5276250 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1581,23 +1581,6 @@ void blk_rq_unprep_clone(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
 
-/*
- * Copy attributes of the original request to the clone request.
- * The actual data parts (e.g. ->cmd, ->sense) are not copied.
- */
-static void __blk_rq_prep_clone(struct request *dst, struct request *src)
-{
-	dst->__sector = blk_rq_pos(src);
-	dst->__data_len = blk_rq_bytes(src);
-	if (src->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		dst->rq_flags |= RQF_SPECIAL_PAYLOAD;
-		dst->special_vec = src->special_vec;
-	}
-	dst->nr_phys_segments = src->nr_phys_segments;
-	dst->ioprio = src->ioprio;
-	dst->extra_len = src->extra_len;
-}
-
 /**
  * blk_rq_prep_clone - Helper function to setup clone request
  * @rq: the request to be setup
@@ -1610,8 +1593,6 @@ static void __blk_rq_prep_clone(struct request *dst, struct request *src)
  *
  * Description:
  *     Clones bios in @rq_src to @rq, and copies attributes of @rq_src to @rq.
- *     The actual data parts of @rq_src (e.g. ->cmd, ->sense)
- *     are not copied, and copying such parts is the caller's responsibility.
  *     Also, pages which the original bios are pointing to are not copied
  *     and the cloned bios just point same pages.
  *     So cloned bios must be completed before original bios, which means
@@ -1642,7 +1623,16 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 			rq->bio = rq->biotail = bio;
 	}
 
-	__blk_rq_prep_clone(rq, rq_src);
+	/* Copy attributes of the original request to the clone request. */
+	rq->__sector = blk_rq_pos(rq_src);
+	rq->__data_len = blk_rq_bytes(rq_src);
+	if (rq_src->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
+		rq->special_vec = rq_src->special_vec;
+	}
+	rq->nr_phys_segments = rq_src->nr_phys_segments;
+	rq->ioprio = rq_src->ioprio;
+	rq->extra_len = rq_src->extra_len;
 
 	return 0;
 
-- 
2.17.1

