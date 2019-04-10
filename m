Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7DBC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 17:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3102063F
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 17:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="puxKlU07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfDJR5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:57:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41596 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbfDJR5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 13:57:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so2953433lja.8
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEw+KO2/ka8nKlM3JMAkOLDxT8xAxL50hihSpr0VWC4=;
        b=puxKlU07gNV3QUgf1ZXEnEdM5Ip7pvi3eCYsldM+D5+C+YWicqYoef35yl8fXQO2u3
         5o8zzdYr0esWOKglNpbGkaPO+EGg+qIcA24H9g1Lty2yg3jRVDwwqOwoX5rNGLaSrTQs
         snqijvwq+EJzz4n9zAOc8yxXGXm0pZh2M0oo+sHkgHZaTeoYrabFujtm8zXi5yBNKcDC
         R1l7xn//9rodLBtfyOvq53wgZm5VIfQVw+Zz8XUAXUxaydX1jdI9DOf5KLoCTFYWfiLl
         ebppf6XPN8Ka0eHujjH9NSkGAelCgzhE+GmvitmXIgDVn9chBMx+PpILMi9gHmrqolIh
         E5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEw+KO2/ka8nKlM3JMAkOLDxT8xAxL50hihSpr0VWC4=;
        b=RzmShgv3wjbcWb42CsqMFZv4KF5TFuQ+/3eSxWhkrkM5lX2/WA70h4AdLsC2ETKTh9
         BaRUFVZ7Hc+UAW7qpePulnYl7q2PdmlERj+kMVcRzgoxcMyv/feQTtskQRsLSvp1opyw
         c3j0MqL4LewL0iNZVxjNNow7s3nOlzaT1LBm4AkoE4SginuM3n8xRGOJ/0oYa4BtkWWo
         R/MvtCVQ+6VmJV1royV+Z6OuuEghAneYr49kaJ2jhe4JQohXNY5zHYzSJuWnoAfx4g0B
         Odd4y1o882/mbBvIO0waU9tWpv7gjm11iF/fdLH7xwNTWcsGN6M+WPDWo1S017pctW7j
         qcMQ==
X-Gm-Message-State: APjAAAUFlWFForqHz3hXlg9N1YZYikX/rfqPbyhnp90hHb5tiFFXM6ur
        qAS3ENxV8LGaBQyMizFPCFYj7Q==
X-Google-Smtp-Source: APXvYqwHdcmP9bf9wwpn9Jb7eJ2yB2f9t+TlsSC239drRYIGErjUkw8D8aGE10HOFkqBJEDgPlef0g==
X-Received: by 2002:a2e:8446:: with SMTP id u6mr23207712ljh.71.1554919022671;
        Wed, 10 Apr 2019 10:57:02 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r20sm7357190ljj.22.2019.04.10.10.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:57:01 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL] lightnvm: pblk: fix crash in pblk_end_partial_read due to multipage bvecs
Date:   Wed, 10 Apr 2019 19:56:43 +0200
Message-Id: <20190410175643.11000-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The introduction of multipage bio vectors broke pblk's partial read
logic due to it not being prepared for multipage bio vectors.

Use bio vector iterators instead of direct bio vector indexing.

Fixes: 07173c3ec276 ("block: enable multipage bvecs")
Reported-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Updated description.
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---

 drivers/lightnvm/pblk-read.c | 50 ++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 3789185144da..0b7d5fb4548d 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -231,14 +231,14 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	struct pblk_sec_meta *meta;
 	struct bio *new_bio = rqd->bio;
 	struct bio *bio = pr_ctx->orig_bio;
-	struct bio_vec src_bv, dst_bv;
 	void *meta_list = rqd->meta_list;
-	int bio_init_idx = pr_ctx->bio_init_idx;
 	unsigned long *read_bitmap = pr_ctx->bitmap;
+	struct bvec_iter orig_iter = BVEC_ITER_ALL_INIT;
+	struct bvec_iter new_iter = BVEC_ITER_ALL_INIT;
 	int nr_secs = pr_ctx->orig_nr_secs;
 	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
 	void *src_p, *dst_p;
-	int hole, i;
+	int bit, i;
 
 	if (unlikely(nr_holes == 1)) {
 		struct ppa_addr ppa;
@@ -257,33 +257,39 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 
 	/* Fill the holes in the original bio */
 	i = 0;
-	hole = find_first_zero_bit(read_bitmap, nr_secs);
-	do {
-		struct pblk_line *line;
+	for (bit = 0; bit < nr_secs; bit++) {
+		if (!test_bit(bit, read_bitmap)) {
+			struct bio_vec dst_bv, src_bv;
+			struct pblk_line *line;
 
-		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
-		kref_put(&line->ref, pblk_line_put);
+			line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
+			kref_put(&line->ref, pblk_line_put);
 
-		meta = pblk_get_meta(pblk, meta_list, hole);
-		meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
+			meta = pblk_get_meta(pblk, meta_list, bit);
+			meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
 
-		src_bv = new_bio->bi_io_vec[i++];
-		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
+			dst_bv = bio_iter_iovec(bio, orig_iter);
+			src_bv = bio_iter_iovec(new_bio, new_iter);
 
-		src_p = kmap_atomic(src_bv.bv_page);
-		dst_p = kmap_atomic(dst_bv.bv_page);
+			src_p = kmap_atomic(src_bv.bv_page);
+			dst_p = kmap_atomic(dst_bv.bv_page);
 
-		memcpy(dst_p + dst_bv.bv_offset,
-			src_p + src_bv.bv_offset,
-			PBLK_EXPOSED_PAGE_SIZE);
+			memcpy(dst_p + dst_bv.bv_offset,
+				src_p + src_bv.bv_offset,
+				PBLK_EXPOSED_PAGE_SIZE);
 
-		kunmap_atomic(src_p);
-		kunmap_atomic(dst_p);
+			kunmap_atomic(src_p);
+			kunmap_atomic(dst_p);
 
-		mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
+			flush_dcache_page(dst_bv.bv_page);
+			mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
 
-		hole = find_next_zero_bit(read_bitmap, nr_secs, hole + 1);
-	} while (hole < nr_secs);
+			bio_advance_iter(new_bio, &new_iter,
+					PBLK_EXPOSED_PAGE_SIZE);
+			i++;
+		}
+		bio_advance_iter(bio, &orig_iter, PBLK_EXPOSED_PAGE_SIZE);
+	}
 
 	bio_put(new_bio);
 	kfree(pr_ctx);
-- 
2.19.1

