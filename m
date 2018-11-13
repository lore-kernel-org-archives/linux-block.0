Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FA1C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697B022510
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697B022510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbeKNBOg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731502AbeKNBOf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:14:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 849C789AD7;
        Tue, 13 Nov 2018 15:16:01 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E2056090D;
        Tue, 13 Nov 2018 15:16:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V9 06/19] fs/buffer.c: use bvec iterator to truncate the bio
Date:   Tue, 13 Nov 2018 23:14:52 +0800
Message-Id: <20181113151505.15498-7-ming.lei@redhat.com>
In-Reply-To: <20181113151505.15498-1-ming.lei@redhat.com>
References: <20181113151505.15498-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 13 Nov 2018 15:16:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once multi-page bvec is enabled, the last bvec may include more than one
page, this patch use bvec_last_segment() to truncate the bio.

Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1286c2b95498..fa37ad52e962 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3032,7 +3032,10 @@ void guard_bio_eod(int op, struct bio *bio)
 
 	/* ..and clear the end of the buffer for reads */
 	if (op == REQ_OP_READ) {
-		zero_user(bvec->bv_page, bvec->bv_offset + bvec->bv_len,
+		struct bio_vec bv;
+
+		bvec_last_segment(bvec, &bv);
+		zero_user(bv.bv_page, bv.bv_offset + bv.bv_len,
 				truncated_bytes);
 	}
 }
-- 
2.9.5

