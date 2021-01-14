Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87769C4332E
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E6B23B84
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbhANPsh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbhANPsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:32 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110B4C06179B
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id 32so3441835plf.3
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=g2xCDGkf1QV8m2oT6FSaZhKIqRrYyoL3mQeF9dlubXk=;
        b=P8luqrH5fshKRy49UY321ccjqfMF+1nPrvcMgYsQRGwWvzW/T10vlEN+9nLbYE+bLf
         NsB5qJP6UoUga+wSwzCUgpPYoUTykzMHGpgY54Dk0ey2sF18Cai0yXtv6Pn8xgAJgqSN
         D0cvYGOQWpyl2O1Qp1p61+R5otk3CSYbHjPKSRCmZBe7yxYdsyxWWNC3O5uxD9+azrUS
         me2JZj16nNfGby1IxHjCh6NMlxx2RqfWyGNkkEI8zh4PzJfRJz1NlS5l0zN82Qps7rRB
         SD8uLJwWUCRC2jsiIthRvO1rU8da7j0B1yjDT/4oMNOmUTBcrWG6RaWlYYxQ369Wsd8O
         SwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g2xCDGkf1QV8m2oT6FSaZhKIqRrYyoL3mQeF9dlubXk=;
        b=lHWFVMB8/OylhJ4RR+CutNk/Q/5jHKJh4igPoMbJDZVM/EZ/f64GEcQHvxZShEPJbW
         JvNUFxyYm1ntLUmwVSzlHt2OW4JUmenwdu3P9DvTN86kMe00whYF9xdHsMI6Gkc6LPlt
         /pRIpHgNzs2Swse5BsZKR+FQewUGS/JVhMfQCrcLljnfvRZsJc6o3yQNJaASb20FLqKE
         m1OjIaYhjnbX7rm71LAoOjvQnZko3FW8AYoBdCAHT9jeWz1KQBSy9F1V7U68i7yNnnWv
         IvPbI9xodnVVq4B4RdcqkZoxk1zM9pux+TnqTQ1oGAQ10LJUmR24qR8Pl82UQJaihNPn
         1ITA==
X-Gm-Message-State: AOAM5337lHrfpkspViMX6N0o76XtDt5weY/xH//kZKXajEOGiTxx9D7A
        FBc9p+5/znWmu+PJLAZjICv1dL9moSK0f5PHxhy+S+PQjvou9SdALJPW7kUdC6HvufokGRmjV10
        +YGVpD5IbQfV27oXmpIxNcocJdxkOpv6KbJUNIsNMs5Orli4Ymsi5+g8D4UogD+pcXdyX
X-Google-Smtp-Source: ABdhPJwoueZO6ismwa6iFeqnJ2iy7LZ1F+RkesR2OnxUVW0OhtcSuObGIvf/i3mP2BWIbkcszBYJMxFg97c=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:aa7:96d9:0:b029:1a1:c2c4:bdb8 with SMTP id
 h25-20020aa796d90000b02901a1c2c4bdb8mr7961145pfq.72.1610639259410; Thu, 14
 Jan 2021 07:47:39 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:21 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-6-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 5/7] block: respect blk_crypto_bio_sectors_alignment() in blk-merge
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make blk_bio_segment_split() respect blk_crypto_bio_sectors_alignment()
when calling bio_split(). The number of sectors is rounded down to the
required alignment just before the call to bio_split(). This makes it
possible for nsegs to be overestimated, but this solution is a lot
simpler than trying to calculate the exact number of nsegs required
for the aligned number of sectors. A future patch will attempt to
calculate nsegs more accurately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a23a91e12e24..45cda45c1066 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -236,6 +236,8 @@ static bool bvec_split_segs(const struct request_queue *q,
  * following is guaranteed for the cloned bio:
  * - That it has at most get_max_io_size(@q, @bio) sectors.
  * - That it has at most queue_max_segments(@q) segments.
+ * - That the number of sectors in the returned bio is aligned to
+ *   blk_crypto_bio_sectors_alignment(@bio)
  *
  * Except for discard requests the cloned bio will point at the bi_io_vec of
  * the original bio. It is the responsibility of the caller to ensure that the
@@ -292,6 +294,9 @@ static int blk_bio_segment_split(struct request_queue *q,
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;
 
+	sectors = round_down(sectors, blk_crypto_bio_sectors_alignment(bio));
+	if (WARN_ON(sectors == 0))
+		return -EIO;
 	*split = bio_split(bio, sectors, GFP_NOIO, bs);
 	return 0;
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

