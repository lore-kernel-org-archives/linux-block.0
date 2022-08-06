Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA5C19F2D
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 15:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiHFPUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiHFPUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 11:20:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6BD5
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 08:20:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u133so4615641pfc.10
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Is5g6lb6jj60GAOGQvztYldquLbOFIsb6gndMPsDvCc=;
        b=sO3dKXLjxpIn9RdifvvGk/uZk0/RRqOTSVDvgRUOJ4a5OWL30gQdJVFvqqTiNLHgyW
         VL5U38tIyPRdqlQXRypNjxw2HtiQVkpqUP123TY1K8bzgaWIoXj/GaWGdN9xIBRjBPaV
         /Tk3B31Oz1VsA2vhV5VdeahH4HnX+VNpSQHDvhN8GnhGtGRLdGGm1q0cMQAvhfPnQfT9
         arbXf7mvGlildykuwYS6zfj2pT3hyrkxg0mH1gcnCjsW270sGP6WX/r8Ge9ck7KXCA5c
         WC1WxfkF7za3W0hErq6l7NnQq8gP2IcWo2cO7njz5ytreh5k6GA5R4fLgFmnV08myiUt
         hMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Is5g6lb6jj60GAOGQvztYldquLbOFIsb6gndMPsDvCc=;
        b=HFd5nBpnssGiW7qfc0JjjxbGXpgKaZenu9rlGK3Y6kXoabaPqK+g4T9IrRYJ+XnW/V
         rOebJvyN6MiYT1pYL+ABIfHJJNpxI1l/lKGn2ENdyqza+sxWaF0f3CvAE8qYOXzyYFSL
         N4QBhDL83bW+GonuAP4cY9GVCb9DJkr5OPu7J+WhnREgR/39kaWdZru+HLJtoSKqaIiB
         HDQV6dPtG/WRYP6DrdgrdRLxGcbPgLcDvDyxH/oiC6TcwFufMKSNl0ztKSDnQdgczkbm
         cwn+ETCElAszwGjbKlbHhVkiQNQYg91fQEro6vw/w5+O5WjBYuq2xAeR5n3M99DIPWFe
         36xg==
X-Gm-Message-State: ACgBeo2bUFWOkpg8gCaeb4GtSWy0qpAWhCAiGryvmD0RIVmZUJmksPsB
        fcrBbpe6o6756tzhC5xmImxUQzWl/MdEbg==
X-Google-Smtp-Source: AA6agR7HJzNOrYBhoT1aLsMsaWj5XkSpXpzxmOlKhG8ioFFEc4F2Zm/mDN3jZjCASytKKUI2Q02wrQ==
X-Received: by 2002:a05:6a00:c96:b0:52e:979c:dd63 with SMTP id a22-20020a056a000c9600b0052e979cdd63mr10713198pfv.50.1659799209858;
        Sat, 06 Aug 2022 08:20:09 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b0016d1f6d1b99sm5158661plw.49.2022.08.06.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 08:20:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     joshi.k@samsung.com, kbusch@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] block: enable bio caching use for passthru IO
Date:   Sat,  6 Aug 2022 09:20:03 -0600
Message-Id: <20220806152004.382170-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220806152004.382170-1-axboe@kernel.dk>
References: <20220806152004.382170-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdev based polled O_DIRECT is currently quite a bit faster than
passthru on the same device, and one of the reaons is that we're not
able to use the bio caching for passthru IO.

If REQ_POLLED is set on the request, use the fs bio set for grabbing a
bio from the caches, if available. This saves 5-6% of CPU over head
for polled passthru IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-map.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4043c5809cd4..5da03f2614eb 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -231,6 +231,16 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	return ret;
 }
 
+static void bio_map_put(struct bio *bio)
+{
+	if (bio->bi_opf & REQ_ALLOC_CACHE) {
+		bio_put(bio);
+	} else {
+		bio_uninit(bio);
+		kfree(bio);
+	}
+}
+
 static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		gfp_t gfp_mask)
 {
@@ -243,10 +253,19 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (!iov_iter_count(iter))
 		return -EINVAL;
 
-	bio = bio_kmalloc(nr_vecs, gfp_mask);
-	if (!bio)
-		return -ENOMEM;
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
+	if (rq->cmd_flags & REQ_POLLED) {
+		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
+
+		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
+					&fs_bio_set);
+		if (!bio)
+			return -ENOMEM;
+	} else {
+		bio = bio_kmalloc(nr_vecs, gfp_mask);
+		if (!bio)
+			return -ENOMEM;
+		bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
+	}
 
 	while (iov_iter_count(iter)) {
 		struct page **pages;
@@ -304,8 +323,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
  out_unmap:
 	bio_release_pages(bio, false);
-	bio_uninit(bio);
-	kfree(bio);
+	bio_map_put(bio);
 	return ret;
 }
 
@@ -610,8 +628,7 @@ int blk_rq_unmap_user(struct bio *bio)
 
 		next_bio = bio;
 		bio = bio->bi_next;
-		bio_uninit(next_bio);
-		kfree(next_bio);
+		bio_map_put(next_bio);
 	}
 
 	return ret;
-- 
2.35.1

