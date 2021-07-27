Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9868CC4320A
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868EE60FE4
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhG0GEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbhG0GEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:04:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51507C061757;
        Mon, 26 Jul 2021 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RUZ53JRW+Y40jSDld/pmd24FvGrlJLI/Shilr+kOgJg=; b=YWh+6nhQFFioCIPOaLPmYk6kUA
        6phgr4hvpipWGMY5WrLgPeEkB4uW8VA0j+vWp4vEq1BZNK3fLeCviChI1wxCr7TwSCv5JWjAve9II
        6LiDrbLg9EvwFqJecik6Js3rUHufaJkZCKAtHgCTh/CCckjbWYm2ycqNvMDDtmJc/3lZtu3c/COHQ
        PrHJ/uenZTh4fQX9SCZ73Uvve3rGaZHG0pnsvLWsdXj02XrzVj14JwVTLYySR1D0FSALY2mC+BDX4
        ipM5mIrqBnfstMrXMkmCLkoVIHbzrvT5G9hKOhyhskrtjV0UZEPDO8JZgpTKFnUurL4fj8SlbgA8Z
        6/VrJBfQ==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8G9o-00EiaK-P7; Tue, 27 Jul 2021 06:01:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 03/15] bvec: add a bvec_kmap_local helper
Date:   Tue, 27 Jul 2021 07:56:34 +0200
Message-Id: <20210727055646.118787-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a helper to call kmap_local_page on a bvec.  There is no need for
an unmap helper given that kunmap_local accept any address in the mapped
page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/bvec.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 883faf5f1523..f8710af18eef 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -7,6 +7,7 @@
 #ifndef __LINUX_BVEC_H
 #define __LINUX_BVEC_H
 
+#include <linux/highmem.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/limits.h>
@@ -183,4 +184,16 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
+/**
+ * bvec_kmap_local - map a bvec into the kernel virtual address space
+ * @bvec: bvec to map
+ *
+ * Must be called on single-page bvecs only.  Call kunmap_local on the returned
+ * address to unmap.
+ */
+static inline void *bvec_kmap_local(struct bio_vec *bvec)
+{
+	return kmap_local_page(bvec->bv_page) + bvec->bv_offset;
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.30.2

