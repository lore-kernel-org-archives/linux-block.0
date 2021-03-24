Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB7FC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B5B61A11
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhCXMVA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233068AbhCXMUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616588446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAFhuRF90lDbAWGqBKZGRvEM6liedrg94jTST/HbeI0=;
        b=VDIv9XvjBVDzlVlgWn6ZV5y8o0NBWZrm8NJX3TGunSrJXBeeA2387RBc++BBoUwGxZliEA
        j2CI+pZhROtbddIP2nFWfYSra3dCHdNK4vxubCLsI8PVgVnGTLvgLCuQ2CBJhyv+k55hN0
        N45SH7SnprOH7KY5+q+3nIoIfUUz2gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-TIdxWxcIPxCLLcPtDXRhww-1; Wed, 24 Mar 2021 08:20:44 -0400
X-MC-Unique: TIdxWxcIPxCLLcPtDXRhww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2241718C89CF;
        Wed, 24 Mar 2021 12:20:43 +0000 (UTC)
Received: from localhost (ovpn-13-127.pek2.redhat.com [10.72.13.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3945D735;
        Wed, 24 Mar 2021 12:20:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 06/13] block: add new field into 'struct bvec_iter'
Date:   Wed, 24 Mar 2021 20:19:20 +0800
Message-Id: <20210324121927.362525-7-ming.lei@redhat.com>
In-Reply-To: <20210324121927.362525-1-ming.lei@redhat.com>
References: <20210324121927.362525-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a hole at the end of 'struct bvec_iter', so put a new field
here and we can save cookie returned from submit_bio() here for
supporting bio based polling.

This way can avoid to extend bio unnecessarily.

Meantime add two helpers to get/set this field.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h          | 10 ++++++++++
 include/linux/bvec.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 424949f2226d..7e16419904fa 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -402,4 +402,14 @@ static inline void blk_create_io_context(struct request_queue *q,
 		bio_poll_ctx_alloc(ioc);
 }
 
+static inline unsigned int bio_get_private_data(struct bio *bio)
+{
+	return bio->bi_iter.bi_private_data;
+}
+
+static inline void bio_set_private_data(struct bio *bio, unsigned int data)
+{
+	bio->bi_iter.bi_private_data = data;
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..547ad7526960 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,6 +43,14 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
+
+	/*
+	 * There is a hole at the end of bvec_iter, add one new field to hold
+	 * something which isn't related with 'bvec_iter', so that we can
+	 * avoid extending bio. So far this new field is used for bio based
+	 * polling, we will store returning value of submit_bio() here.
+	 */
+	unsigned int		bi_private_data;
 };
 
 struct bvec_iter_all {
-- 
2.29.2

