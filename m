Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA19AC43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3AE206A3
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDZKpl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:45:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfDZKpk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 06:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2CD330BAC51;
        Fri, 26 Apr 2019 10:45:40 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1D8D5D717;
        Fri, 26 Apr 2019 10:45:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] iov_iter: fix iov_iter_type
Date:   Fri, 26 Apr 2019 18:45:21 +0800
Message-Id: <20190426104521.30602-3-ming.lei@redhat.com>
In-Reply-To: <20190426104521.30602-1-ming.lei@redhat.com>
References: <20190426104521.30602-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 26 Apr 2019 10:45:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 875f1d0769cd ("iov_iter: add ITER_BVEC_FLAG_NO_REF flag")
introduces one extra flag of ITER_BVEC_FLAG_NO_REF, and this flag
is stored into iter->type.

However, iov_iter_type() doesn't consider the new added flag, fix
it by masking this flag in iov_iter_type().

Fixes: 875f1d0769cd ("iov_iter: add ITER_BVEC_FLAG_NO_REF flag")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/uio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index f184af1999a8..2d0131ad4604 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -60,7 +60,7 @@ struct iov_iter {
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
-	return i->type & ~(READ | WRITE);
+	return i->type & ~(READ | WRITE | ITER_BVEC_FLAG_NO_REF);
 }
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
-- 
2.9.5

