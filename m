Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A891C282CE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 07:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B36208E3
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 07:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="nIyDu4ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDHHd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:33:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45344 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHHd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 03:33:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id f19so3675548edw.12
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=t1PKzZaRhiqJLeho8v9j47dffEHuqgIyns02qb8Yva0=;
        b=nIyDu4ger7JrVRQZHKCARQmIqc3Kz/1dOc8jSrygjQ5hDwDBE5k5XTtdaE58/wFR7P
         SLqP4kFYAtnU2JG7kFUeqFAhzGsCNBStnPxyEoREyqF6YFdRM9v+ls1RFwq9gHKD+nkf
         ZQlMICnodxYfqwauL25aVK30vjkZszU4+d5mAqavwfQ6wWzgy50ThmMsFxHFUQM2Boqb
         4JId33v6JQuq6m9IitFm1Yr6b4TMzwxIQRDkZajn5vcb1PzZBWzFt1Sv+6N7VebHcTHv
         k2hsGI2Du0NEoKd/n35ZzpJfjHRkobNGiRcNeZYqO0nICe/YCwPtKqkggzxohjHx7Xcw
         PHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t1PKzZaRhiqJLeho8v9j47dffEHuqgIyns02qb8Yva0=;
        b=pWK1hOhp2xhzLu7EknLkZNsM9WXkIOooWpjesOG4VyZiQVzR0F+FKpuvnUQKrv8bQP
         y/gURIeQwgiNFaVLdIC+oJrFZGq2sN4VmN+6KlYxiBKRFPWnVCXAo2pC7PIJCE3XNXqF
         cvgbAjtSKAAO/F74IhD7XDUk+JFi7hr5vty+F9RhlsOULvvy6yPuMvBzoen2FjxYssLo
         wGCRTaAL7QKiPBvOYtrPrE5wSbQbzod5S0m0z9MTFDa3vn7RC9ulv3auUHNk0wrm6i2g
         ry8cNG6VDq/T1DXQr7MjVPFOwWZz/HpAjcKC18EVHHhz2MsAQ8dQrNkjbR62jkhLEmPA
         dvuQ==
X-Gm-Message-State: APjAAAWScdYo1L2EZnw9eMZDXK9WqF86PTBe5UWKeCwzqAbUPNei9J1u
        NZ6urzmmJUVtHMzYXYUxRggksQ==
X-Google-Smtp-Source: APXvYqy+vV2iCCp6JCbO7VZFWHXzO570ZYehHYRFdLZ1m6DKloHSmJ8zhGbCDMHgAiJc7eU3EV6teA==
X-Received: by 2002:a17:906:3e8f:: with SMTP id a15mr16105976ejj.189.1554708804750;
        Mon, 08 Apr 2019 00:33:24 -0700 (PDT)
Received: from ch-lap-hans.cnexlabs.com (soho-cph.cust-cnex.dsd101.net. [194.62.216.132])
        by smtp.gmail.com with ESMTPSA id f5sm8630128ede.94.2019.04.08.00.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 00:33:24 -0700 (PDT)
From:   hans@owltronix.com
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     javier@javigon.com, Igor Konopko <igor.j.konopko@intel.com>,
        Klaus Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix crash in pblk_end_partial_read due to multipage bvecs
Date:   Mon,  8 Apr 2019 09:33:08 +0200
Message-Id: <20190408073308.3082-1-hans@owltronix.com>
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

It ain't pretty, but let's fix the breakage while waiting for Igor's
partial read cleanup to be ready.

 drivers/lightnvm/pblk-read.c | 50 ++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f08f7d9bd3be..27f8a76d8bd8 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -230,14 +230,14 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
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
@@ -256,33 +256,39 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 
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

