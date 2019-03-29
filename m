Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46405C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B062173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfC2HIZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728796AbfC2HIZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 03:08:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E8D0308CF80;
        Fri, 29 Mar 2019 07:08:25 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12E1661B6A;
        Fri, 29 Mar 2019 07:08:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 02/10] block: avoid to break XEN by multi-page bvec
Date:   Fri, 29 Mar 2019 15:07:55 +0800
Message-Id: <20190329070803.10958-3-ming.lei@redhat.com>
In-Reply-To: <20190329070803.10958-1-ming.lei@redhat.com>
References: <20190329070803.10958-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 29 Mar 2019 07:08:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

XEN has special page merge requirement, see xen_biovec_phys_mergeable().
We can't merge pages into one bvec simply for XEN.

So move XEN's specific check on page merge into __bio_try_merge_page(),
then abvoid to break XEN by multi-page bvec.

Cc: ris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b64cedc7f87c..b2423e7aae08 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -776,6 +776,8 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 
 		if (vec_end_addr + 1 != page_addr + off)
 			return false;
+		if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
+			return false;
 		if (same_page && (vec_end_addr & PAGE_MASK) != page_addr)
 			return false;
 
-- 
2.9.5

