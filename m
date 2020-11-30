Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C083C64E7B
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B8620663
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="ONWJ7pQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgK3Daa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 22:30:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10519 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgK3Daa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707779; x=1638243779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbiHUyaUtN1lM/VRyvOM4VWz5z/jZqsgAj2Gp0q3iN4=;
  b=ONWJ7pQ0P5HVIq8w8RlZjUIOwYYd7TAJKiL0cWV5U8OMDuW5kl9yc0Bt
   Fgs/IG8fuKsbkobqhP+C+3yTJPfVGsTm2d1xUuF+ZisUXdocLV9J93Gqj
   yvrOIAp2DKilm2kn1OkRLOGGkljH6XYU7GqPp8PuBMioM+TDDXVS7YdlF
   CUqhzP4MH1MQh58JSaH0TFdBzNWgbj6YBtSPcuJRgdyLtONvzGRL4GkrU
   Fx96xHxwYcRubnqbupk31GrueEGlC30yP1K3PRmbE8yQX3Jpn0nEKsIGL
   G2sEI6DJLHt0C/trkvv1PPIZlbWpkFanr2p60WKBfc/3KyEGrKnRJV/KJ
   Q==;
IronPort-SDR: UtUSb2Wf8Bop/UGiqnW622zqSVci9BSMk8aw9qgkE6BgBbC+hdn8MxZ4rI/aqLBG361P82GSfL
 ApYd7HeKeukexx8GafLxnB3/8Q30kAUgY2X5FzbzYgZ213oGoDgp4vZ/6bW6BXluhWKLWoq30R
 5RCmiop41Klgr42/the02C75IqWR2zfhQ/fLF60DphexdIuMw+COhZ5zMoCjrdLZUBqrfpHBux
 RLJkXbVpycnHr6fI4SjmefYDKkipeZcH2Xw6wLPtpV7HGd5PMEIw5G65kUvy99pDSp7frTRddh
 cRA=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="257450805"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:41:20 +0800
IronPort-SDR: fWvj0cSG3nkANOnpL4KtZPNsTvKuaPs/lNm1nmMH3mcPd/WkqRJ/npHNiReoiRxhdhHpc2wuOP
 NeXaIbZ5UHamzT6qZy8cIBFlOuLChnRX4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:15:02 -0800
IronPort-SDR: GazJEliYlREQMQuOCVUEF9CAajpza3ubcbWR5sBmkfF2VRciHRbrsmjlR389fDQZ4o9PP5SJeU
 LFsLbRIPjoFA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:24 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/9] block: export __bio_iov_append_get_pages()
Date:   Sun, 29 Nov 2020 19:29:01 -0800
Message-Id: <20201130032909.40638-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In this prep patch we exoprt the __bio_iov_append_get_pages() so that
NVMeOF target can use the core logic of building Zone Append bios for
REQ_OP_ZONE_APPEND without repeating the code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c         | 3 ++-
 include/linux/bio.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..de356fa28315 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1033,7 +1033,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
-static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
+int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
@@ -1079,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_advance(iter, size - left);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__bio_iov_append_get_pages);
 
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..47247c1b0b85 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -446,6 +446,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
+int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
-- 
2.22.1

