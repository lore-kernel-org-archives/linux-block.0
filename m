Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F22C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbiGNSIY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiGNSIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:18 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7F68701
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:15 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so9387422pjm.2
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Usd565CphaHnnMO5gvU0zWQWvZUr5Uop/OKdo69q5eQ=;
        b=ifiofiqx3x+oimIqAJ6QE5keQUIuVNqNUPnNFbi+DyApLBPuELAqstTeS6g29ruHrn
         h8oAy6uZ/ObWp5/CcFVBHwwIHvX9u81fCYluoYDTyUueRcI1b+NNWNNKm4ysXHaljjjp
         h0Lv0eTaU7C5pdLaaYNqpz54zMbvKy+MAhi+oQh8ctI5r2Z36VKNJuFKGsOV3MHc9rxV
         +lf1T8au5DHgXksYZmRzsa0pyMc9tDaKFKbjwCF5yFH8fWL/bVn6qjcKidOM1Iy6+lPG
         ZWDms/fui6wly7BjVHt1n+gU5JNUvacKRbn7Pd7NYWG8hzpo7zugmrteFgf5O8TrCeU4
         0d0w==
X-Gm-Message-State: AJIora+x+ajyhYb4vCu8PhfTO75qOxrQPx5k42QIDXioLMvKXBtQisy7
        3nEAJm9pcLFWNWl5uC5VZMg=
X-Google-Smtp-Source: AGRyM1sGl9KxASrw4rdQSOQh5ZVCYPVsY5udiKIWUcVYCV7Sp9qUs0mHqA9SHlPEyWM+gH60u56MfQ==
X-Received: by 2002:a17:902:f7c1:b0:16b:de8e:dca6 with SMTP id h1-20020a170902f7c100b0016bde8edca6mr9233810plw.99.1657822095156;
        Thu, 14 Jul 2022 11:08:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 24/63] dm/ebs: Change 'int rw' into 'enum req_op op'
Date:   Thu, 14 Jul 2022 11:06:50 -0700
Message-Id: <20220714180729.1065367-25-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using type 'enum req_op' instead of 'int'.
Make the role of the 'rw' arguments more clear by renaming these into
'op' (operation). This patch does not change any functionality since
REQ_OP_READ = READ = 0 and REQ_OP_WRITE = WRITE = 1.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Heinz Mauelshagen <heinzm@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-ebs-target.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 0221fa63f888..223e8e1a7a13 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -61,7 +61,8 @@ static inline bool __ebs_check_bs(unsigned int bs)
  *
  * copy blocks between bufio blocks and bio vector's (partial/overlapping) pages.
  */
-static int __ebs_rw_bvec(struct ebs_c *ec, int rw, struct bio_vec *bv, struct bvec_iter *iter)
+static int __ebs_rw_bvec(struct ebs_c *ec, enum req_op op, struct bio_vec *bv,
+			 struct bvec_iter *iter)
 {
 	int r = 0;
 	unsigned char *ba, *pa;
@@ -81,7 +82,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, int rw, struct bio_vec *bv, struct bv
 		cur_len = min(dm_bufio_get_block_size(ec->bufio) - buf_off, bv_len);
 
 		/* Avoid reading for writes in case bio vector's page overwrites block completely. */
-		if (rw == READ || buf_off || bv_len < dm_bufio_get_block_size(ec->bufio))
+		if (op == REQ_OP_READ || buf_off || bv_len < dm_bufio_get_block_size(ec->bufio))
 			ba = dm_bufio_read(ec->bufio, block, &b);
 		else
 			ba = dm_bufio_new(ec->bufio, block, &b);
@@ -95,7 +96,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, int rw, struct bio_vec *bv, struct bv
 		} else {
 			/* Copy data to/from bio to buffer if read/new was successful above. */
 			ba += buf_off;
-			if (rw == READ) {
+			if (op == REQ_OP_READ) {
 				memcpy(pa, ba, cur_len);
 				flush_dcache_page(bv->bv_page);
 			} else {
@@ -117,14 +118,14 @@ static int __ebs_rw_bvec(struct ebs_c *ec, int rw, struct bio_vec *bv, struct bv
 }
 
 /* READ/WRITE: iterate bio vector's copying between (partial) pages and bufio blocks. */
-static int __ebs_rw_bio(struct ebs_c *ec, int rw, struct bio *bio)
+static int __ebs_rw_bio(struct ebs_c *ec, enum req_op op, struct bio *bio)
 {
 	int r = 0, rr;
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
 	bio_for_each_bvec(bv, bio, iter) {
-		rr = __ebs_rw_bvec(ec, rw, &bv, &iter);
+		rr = __ebs_rw_bvec(ec, op, &bv, &iter);
 		if (rr)
 			r = rr;
 	}
@@ -205,10 +206,10 @@ static void __ebs_process_bios(struct work_struct *ws)
 	bio_list_for_each(bio, &bios) {
 		r = -EIO;
 		if (bio_op(bio) == REQ_OP_READ)
-			r = __ebs_rw_bio(ec, READ, bio);
+			r = __ebs_rw_bio(ec, REQ_OP_READ, bio);
 		else if (bio_op(bio) == REQ_OP_WRITE) {
 			write = true;
-			r = __ebs_rw_bio(ec, WRITE, bio);
+			r = __ebs_rw_bio(ec, REQ_OP_WRITE, bio);
 		} else if (bio_op(bio) == REQ_OP_DISCARD) {
 			__ebs_forget_bio(ec, bio);
 			r = __ebs_discard_bio(ec, bio);
