Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9022BC64E7A
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AB0207BC
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r8gFSLjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgKZClC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:41:02 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20425 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgKZClC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358461; x=1637894461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbiHUyaUtN1lM/VRyvOM4VWz5z/jZqsgAj2Gp0q3iN4=;
  b=r8gFSLjpObTuHkKAEP0J0agB/iNIurK7HlqtCF4LY5tBGWVRlPKZLeyI
   pcC6z4NPu4sbLI/AveBjt7qwcE8/CvRUHP1Jc2+RF8hbJK5xw0i/CJgxI
   jU3T47XwRpBhqaPbxXIYetU1fN0E+JCTQG0IW3cbozNoP8DP9v3v6TuIT
   QQh+F7Ov2AFKiRLqwi/nR9yp7cWMxnWZrw56mgVeVvhuNZx4lUYLr3Rho
   0F03DR4sWOtB/5jxgOAMstz0ZxwUvEdTdMRabh5UVEe9ns0mzBNEn9aPI
   udRUPIJhUkNwd1wkZjsGc47gTarCZdJRngfeyyVrUHO7bQ34vwHYE+fZI
   Q==;
IronPort-SDR: 2oN+GLjobd4zx7hs33B2wTlW+1cCDMCC5l1zdTCkm+/iooZXHF5vpc/VXz++iIkXkuDgf1Y3Mm
 1foVhD+IYbs3YiduCnBJIBoqrUu3CCOOgP87rl8Kj2i+c07qNO5siJK7/rQ9SU3l3sT4BpwrqF
 GrzRs/w6iw1eOEYHyEs8vMXIpv9qQHODXXnIY3xi1A/3MjimGSLObTdika0WzKheLHeM0iyxhG
 ohFBj9c01BW18Jfja2lTW5hEZ714+FuTpEq4Bned7kJQFhHErqk+vVmTsveXC8bUnFoGdHnWsG
 K4M=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="157983081"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:01 +0800
IronPort-SDR: E5OiGdNwnRyIC+EZcyCsjUlbISmQUZCOXZM5H0EjwT7/RviSFVvC6Y6usivNaSo+rq35uMjanS
 yjzy6DBAfHzSwWVAftJwH2qbRCUA8PhQM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:25:23 -0800
IronPort-SDR: ZyEMxOWvdD8XQuA7Y526ukWDP9tbl0QoTpA+aWhZCWlxv1AvF4tvB2OK9OVNecmJu91Cw24OXG
 FgeDloELiWEw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:01 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/9] block: export __bio_iov_append_get_pages()
Date:   Wed, 25 Nov 2020 18:40:35 -0800
Message-Id: <20201126024043.3392-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
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

