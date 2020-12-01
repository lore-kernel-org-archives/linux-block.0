Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75BBC8300F
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621B520725
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="khAtHA/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLAEPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:15:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13185 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgLAEPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796133; x=1638332133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbiHUyaUtN1lM/VRyvOM4VWz5z/jZqsgAj2Gp0q3iN4=;
  b=khAtHA/6pHAkidZdzAz48666wBU/8U7w0Agdof7Fa1HMjDIBSLxSVAfi
   IrSTRqgWu+qKXbB989VxBX7AJk3CNrMrfH3E3+Iw91eNVUgnYdrH3LiQj
   cmfN57OwOM4rTjlVCP2xlQXCkrTBsJLcuiJw6I0V3DLtQvt9nZpQJOnBP
   mncYOlF8ygXJp3Jjo0K50z3/CUwYqFR0xM9P8KPF1T0Bk9uYaMKIqVNZo
   3/Ult+yyYXYKmr0tzuJfqfbO+rx6uEUMkGc9Ss48w1J5xY1o4LZA+7F9s
   Y1OxVIaaQe1zg/B0Fnxz4howDGiTLV88Kwo7YyzY7Fni5MM4nRVOBYJQQ
   A==;
IronPort-SDR: ADdpqweOsyhpZffTrbyyt5moCDLw4dB5rrqCPyYzfi1Lz75O9zn9VeLEwcgB7DSezvuVqGcxmK
 Ea17mY/3pIbPdiDyK8uV0bzVzF7MMG/6fKXAT20DngvwlbtDPOYOuQCpDNOhgaRLoBZy49whxQ
 Iu2GUWFxYRUTkT0E5JYfsEV0zgazdKXHS0StkTmm3LBrMD2qWNpS2bVe/uZ0yi8d/o3f8YakD8
 A7dRj0HTljXQAzvKIN10FW8XmYEV+73qnbr+6UuxXOuaNyRRx6sb1u6oRZzOq/MNxYw4YCmJ8F
 UiA=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="155078130"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:28 +0800
IronPort-SDR: LSc8Yh8lyafz2yBIO5cDtM2zkReDGuK5V3cC/3fkqBA56f9msty3Khmal6URecByw9NEK0d9HP
 IbyOx2C64axqo4WxkMoreRjc1fpPWA0BM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:58:40 -0800
IronPort-SDR: VgyZr1dQ9IL+lQ3EYcsF1xF7+2m6lLNNxK3KWDsAtNWYHmk1L6m/D3IuS2lpPizuVBeEj6m33O
 8nuMzvl3jPaA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:28 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 1/9] block: export __bio_iov_append_get_pages()
Date:   Mon, 30 Nov 2020 20:14:08 -0800
Message-Id: <20201201041416.16293-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
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

