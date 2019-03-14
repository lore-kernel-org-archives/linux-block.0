Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E7FC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9C72087C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 11:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="SVCv1u4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCNLRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:17:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35937 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfCNLQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 07:16:59 -0400
Received: by mail-io1-f66.google.com with SMTP id f6so4712927iop.3
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=F2ZJbXmXrrlOgvvLJYZ7cq707ju4+a5/+b8kIdjbDks=;
        b=SVCv1u4kEfCOW9u4LoRl5z3pnJyO3TTsV/LO7M4WMLAX0flJfrZIoxJYEdyHjiU90P
         4xgnfS0o0MBnMXIospJEWMWwQByBVSZSIjib7JExJjp6ayAphEx5PhQZPHfKlOwHY+CH
         lZQqUh4azA6aGRtxKOns1zIqoADqaRgRCVxgUudya8Hu7tLRmM5rQTd7n4545rQ8g/QE
         ITgd0X/qitb4MujkmQkMywNFARq46rCxfOhzz+QAHaRoUROF2TMmmHl4Pj6ZnvCYMCAx
         SwLHT7aPN/w4X8rSZ30YgELt8CPbUN2o4KhtvTMTqA4v54ARmnZLjDGxAryFTUuPI+Ox
         sCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2ZJbXmXrrlOgvvLJYZ7cq707ju4+a5/+b8kIdjbDks=;
        b=JeGmv7lhyECtOqinSSXvaPNHg6ppkkyd6o4fXeL9jFlQioO+XmDGJHdtuyVrvvGNy+
         3Br8uuRgvgTivcSq2GrRPX10aO+gXr9f2YqDeCXleC4tNEHHcS2Ui+JMbxDMY/nTCwhg
         yPIQFiZWO2BrL/xHv+3JETZU8WSDVyujVGKfaMJEDSq5tPMAA0OBo2+ZWqmVdoPDRXzS
         EjrRy7tiE7H2s/fVodtMUptUXwbhX0vWmHI1QojkjjZapDrRa14G/nLX7eZTDpNjLERd
         eV12uDeB5sCUUxPBqqO6DuQF83nJfoJFSwsR01dngv1g7lHgJ+YaxHK9lc2ESlOYJ4bb
         HuUw==
X-Gm-Message-State: APjAAAV+7gH0WRort/NN0HA0zJT1Zw5ff+mHX7YnMnXlVBSNsLy1l4oM
        vownGIQBpjlHPmBA5ar457RgyA==
X-Google-Smtp-Source: APXvYqxThrI0ol3n3hpfFF/3qRGFHO5XapnY81T2jQEu6oy9MNDwJqvkl7kmi6Z4nSV7eej0cFWdhg==
X-Received: by 2002:a6b:8f96:: with SMTP id r144mr12036198iod.153.1552562218897;
        Thu, 14 Mar 2019 04:16:58 -0700 (PDT)
Received: from ch-lap-hans.cnexlabs.com ([194.62.216.132])
        by smtp.gmail.com with ESMTPSA id e11sm6265185iog.79.2019.03.14.04.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:16:58 -0700 (PDT)
From:   hans@owltronix.com
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     javier@javigon.com, Igor Konopko <igor.j.konopko@intel.com>,
        Klaus Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH RFC] lightnvm: pblk: fix crash in pblk_end_partial_read due to multipage bvecs
Date:   Thu, 14 Mar 2019 12:16:37 +0100
Message-Id: <20190314111637.20236-1-hans@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Ever since '07173c3ec276 ("block: enable multipage bvecs")' we
need to handle bios with multipage bvecs in pblk.

Currently, a multipage bvec results in a crash[1].
Fix this by using bvec iterators in stead of direct bvec indexing.

Also add a dcache flush, for the same reasons as in:
'6e6e811d747b ("block: Add missing flush_dcache_page() call")'

[1] https://github.com/OpenChannelSSD/linux/issues/61

Reported-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

---

RFC to get more eyes on this - note that we're doing something
very similar to bio_copy_data_iter.

This works in my QEMU setup, and I'll start more regression testing now.

 drivers/lightnvm/pblk-read.c | 50 ++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 1f9b319c9737..b8eb6bdb983b 100644
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
2.17.1

