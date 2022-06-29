Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E11C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiF2Xce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiF2Xcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:32 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852BD31F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:31 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so996331pjj.5
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQZuS5NSmETy81QNOdGqbEx+IHqMsFuFHyc7HngHx6U=;
        b=pXqE5Mm5YUGGdF+5xcodo1S1E/MRLjHrrkdIgDrOPYtcGsTBOxjHaeFome5ohYXPS0
         zQY7uEqy5zgdlD3G77jguil393PkLwi+prlyqfRHxo+dltRfoS9iO9qM+/LyjyMT0XeN
         lMKMBSHkffVEHaLiunnGhYiFc5R3ygmo9roZ8vzTB1y4/osGT6AJ3JePMjhPxdxZD3tY
         6aMhi2VyIHeMcdFbwb9PHw0ZDxQDWCpFy9P88B1PfRi9fs0qbAxqc8P1NvpaS+vfw3Ki
         6xkEacwIyqs29pbYoX2VgU1gDhhOBNAGddyWWeMRaYvoUYGoYhTsKSW+N+i2Nu3q6yhg
         BwVw==
X-Gm-Message-State: AJIora/julvqQBdQPVSI1NlBct67yWi/iqHnIRbK1xR11fJyn/Dl/A86
        KlJi+JVUfKCD/7EXRvcL2TE=
X-Google-Smtp-Source: AGRyM1saNiXTXfzxPPd4Y5oxfTjiWLs3xwLy04onfST4YZ0oca7j60RmrptEltoI4JglEycbsSRboA==
X-Received: by 2002:a17:902:7d94:b0:168:f2b5:a989 with SMTP id a20-20020a1709027d9400b00168f2b5a989mr11679719plm.50.1656545550966;
        Wed, 29 Jun 2022 16:32:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>
Subject: [PATCH v2 24/63] dm/ebs: Change 'int rw' into 'enum req_op op'
Date:   Wed, 29 Jun 2022 16:31:06 -0700
Message-Id: <20220629233145.2779494-25-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
