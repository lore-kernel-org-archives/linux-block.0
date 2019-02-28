Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F9C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03DA2171F
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfB1M3h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:29:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbfB1M3h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 07:29:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AB0130BDE4C;
        Thu, 28 Feb 2019 12:29:37 +0000 (UTC)
Received: from localhost (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71CD417D01;
        Thu, 28 Feb 2019 12:29:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: fix mp_bvec_for_each_page
Date:   Thu, 28 Feb 2019 20:29:27 +0800
Message-Id: <20190228122927.3495-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 28 Feb 2019 12:29:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mp_bvec_for_each_page() may miss the 1st page in case that the bvec
ends before last byte of the 1st PAGE.

So fix it by checking against the last page.

Fixes: 05d5585e42a399700 ("block: introduce mp_bvec_for_each_page() for iterating over page")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 98a140fa4dac..85894d5000a1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -197,7 +197,7 @@ static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
 
 #define mp_bvec_for_each_page(pg, bv, i)				\
 	for (i = (bv)->bv_offset / PAGE_SIZE;				\
-		(i < (((bv)->bv_offset + (bv)->bv_len) / PAGE_SIZE)) && \
+		(i <= (((bv)->bv_offset + (bv)->bv_len - 1) / PAGE_SIZE)) && \
 		(pg = bvec_nth_page((bv)->bv_page, i)); i += 1)
 
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.9.5

