Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A9C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299032085A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfCQKBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:01:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQKBb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 06:01:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C1CB3002074;
        Sun, 17 Mar 2019 10:01:31 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92E985C6C1;
        Sun, 17 Mar 2019 10:01:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 02/10] block: avoid to break XEN by multi-page bvec
Date:   Sun, 17 Mar 2019 18:01:04 +0800
Message-Id: <20190317100112.8106-3-ming.lei@redhat.com>
In-Reply-To: <20190317100112.8106-1-ming.lei@redhat.com>
References: <20190317100112.8106-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 17 Mar 2019 10:01:31 +0000 (UTC)
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
index 71a78d9fb8b7..d8f48188937c 100644
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

