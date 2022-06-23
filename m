Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B4ACCA47F
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiFWTBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiFWTBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:36 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237E47542
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:44 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id jh14so1402212plb.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQy39SeZG+twTO0WI2+BNN0Zr2MVVoRDZTiM6bUMTPA=;
        b=QFusToGjAdAEVBrYN4ovQ+fEJR9d6IkVZu5gxKe2H5m19ULngSjmd+Q6VkodAZfDOD
         wyGizcH8VLmvseA3Zwg/eStIVJNF5WpwGzgERVI/83cpNGQZV6P6B1qf7RNXieytfmWH
         RFbsEIrsBttyoO3UNZDq0egYz4TUJpAkQTprwjcciZiYAS7mkeRdys/y9f5LvSdV5rU7
         cWfxIS02zIWBJDb0bMzHMiKhHEm/CyOxWqkufANl0LUu5dqJLZMfg/rhIt1FLXXXd4il
         y7Qb5f0ZhX79nbzxoHRlpXHk/0IiKEU660m70C3bi3FuvnwNK65zpkEurZR9UQkZHdRE
         YwAQ==
X-Gm-Message-State: AJIora9fC0QcVJrR8FX+jfn/cSLnbh+brw7slp0ExiHbvhTng1QdplHi
        UwEELUlxkrIUMbzi4KJE1w8=
X-Google-Smtp-Source: AGRyM1tlFQmhRkX75or0mRdHKyQ61yB3qSw3aYRddBPMUlT+OCLOiidwnLDhXqUZ0U1IIRpfSk6wvQ==
X-Received: by 2002:a17:90b:4d88:b0:1ec:aa96:ac92 with SMTP id oj8-20020a17090b4d8800b001ecaa96ac92mr5328730pjb.196.1656007604118;
        Thu, 23 Jun 2022 11:06:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 44/51] fs/iomap: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:21 -0700
Message-Id: <20220623180528.3595304-45-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
the combination of a request operation and request flags.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/iomap/direct-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d098adba443..18a3d9357dce 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -52,7 +52,7 @@ struct iomap_dio {
 };
 
 static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
-		struct iomap_dio *dio, unsigned short nr_vecs, unsigned int opf)
+		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {
 	if (dio->dops && dio->dops->bio_set)
 		return bio_alloc_bioset(iter->iomap.bdev, nr_vecs, opf,
@@ -212,10 +212,10 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * mapping, and whether or not we want FUA.  Note that we can end up
  * clearing the WRITE_FUA flag in the dio request.
  */
-static inline unsigned int iomap_dio_bio_opflags(struct iomap_dio *dio,
+static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		const struct iomap *iomap, bool use_fua)
 {
-	unsigned int opflags = REQ_SYNC | REQ_IDLE;
+	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
 	if (!(dio->flags & IOMAP_DIO_WRITE)) {
 		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
@@ -244,7 +244,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
-	unsigned int bio_opf;
+	blk_opf_t bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
