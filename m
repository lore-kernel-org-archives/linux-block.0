Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3A8C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CFC20857
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCIBhw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:37:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfCIBhw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 20:37:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A07E283F44;
        Sat,  9 Mar 2019 01:37:52 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 084625FCB5;
        Sat,  9 Mar 2019 01:37:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] block: pass page to xen_biovec_phys_mergeable
Date:   Sat,  9 Mar 2019 09:37:32 +0800
Message-Id: <20190309013737.27741-2-ming.lei@redhat.com>
In-Reply-To: <20190309013737.27741-1-ming.lei@redhat.com>
References: <20190309013737.27741-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sat, 09 Mar 2019 01:37:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

xen_biovec_phys_mergeable() only needs .bv_page of the 2nd bio bvec
for checking if the two bvecs can be merged, so pass page to
xen_biovec_phys_mergeable() directly.

No function change.

Cc: ris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h            | 2 +-
 drivers/xen/biomerge.c | 5 +++--
 include/xen/xen.h      | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 5d636ee41663..e27fd1512e4b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -75,7 +75,7 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 
 	if (addr1 + vec1->bv_len != addr2)
 		return false;
-	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2))
+	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
 		return false;
 	if ((addr1 | mask) != ((addr2 + vec2->bv_len - 1) | mask))
 		return false;
diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
index f3fbb700f569..05a286d24f14 100644
--- a/drivers/xen/biomerge.c
+++ b/drivers/xen/biomerge.c
@@ -4,12 +4,13 @@
 #include <xen/xen.h>
 #include <xen/page.h>
 
+/* check if @page can be merged with 'vec1' */
 bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
-			       const struct bio_vec *vec2)
+			       const struct page *page)
 {
 #if XEN_PAGE_SIZE == PAGE_SIZE
 	unsigned long bfn1 = pfn_to_bfn(page_to_pfn(vec1->bv_page));
-	unsigned long bfn2 = pfn_to_bfn(page_to_pfn(vec2->bv_page));
+	unsigned long bfn2 = pfn_to_bfn(page_to_pfn(page));
 
 	return bfn1 + PFN_DOWN(vec1->bv_offset + vec1->bv_len) == bfn2;
 #else
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0e2156786ad2..39a97f2eff75 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -44,6 +44,6 @@ extern struct hvm_start_info pvh_start_info;
 
 struct bio_vec;
 bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
-		const struct bio_vec *vec2);
+		const struct page *page);
 
 #endif	/* _XEN_XEN_H */
-- 
2.9.5

