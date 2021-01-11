Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E352C433E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5759A224B8
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 03:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbhAKDIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 22:08:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbhAKDH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 22:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610334393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MBzSgwf0LNOhHOwxx62z4urBuJuGkAD6hDiQ/z/tuI=;
        b=PPYT8RWcf6Q7IuM8TUVrK8kRBAyEuPBj8mVrdQMLzlJvMRXRxAC+k1nSZNaoVatgcmU0PF
        mtUMOqCkJsqSsPmeLUQ+eCu/ds2E8MHFWFbRRwQB+5sFH9tgtj7Lv8reskK0knKzjMfOk5
        7GasBL5OvkC+FEQEmuQeiy6uCc2NMAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-YeXz0X4bPheEh8braN9oDQ-1; Sun, 10 Jan 2021 22:06:31 -0500
X-MC-Unique: YeXz0X4bPheEh8braN9oDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D311A1966320;
        Mon, 11 Jan 2021 03:06:30 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 890556EF4B;
        Mon, 11 Jan 2021 03:06:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/6] block: set .bi_max_vecs as actual allocated vector number
Date:   Mon, 11 Jan 2021 11:05:55 +0800
Message-Id: <20210111030557.4154161-5-ming.lei@redhat.com>
In-Reply-To: <20210111030557.4154161-1-ming.lei@redhat.com>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec_alloc() may allocate more bio vectors than requested, so set
.bi_max_vecs as actual allocated vector number, instead of the requested
number. This way can help fs build bigger bio because new bio often won't
be allocated until the current one becomes full.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 496aa5938f79..37e3f2d9df99 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -505,12 +505,13 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 			goto err_free;
 
 		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
+		bio->bi_max_vecs = bvec_nr_vecs(idx);
 	} else if (nr_iovecs) {
 		bvl = bio->bi_inline_vecs;
+		bio->bi_max_vecs = inline_vecs;
 	}
 
 	bio->bi_pool = bs;
-	bio->bi_max_vecs = nr_iovecs;
 	bio->bi_io_vec = bvl;
 	return bio;
 
-- 
2.28.0

