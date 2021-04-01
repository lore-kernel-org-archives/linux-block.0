Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E856C43462
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 02:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F2961090
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 02:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhDACVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233241AbhDACVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 22:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617243672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiAZ1LG/jl/FrJlJpKhJ5cneSmOPmuiOZBkRQiXX7gg=;
        b=EmbqQIPqIjhOf67dDHqczjfiXSQuMr4Ie02ROqPaOuyrxYn8K/ci+AquUNWeCAuGHFrnT8
        bHBkJH32i4clEAbyXsTDJ+7AUrcUHfa0Dzb7W8lkpTzwEfwGPr6wCgyW8uN6OJSU69FWwA
        Ahy4+Js3hqF0xdTwGIpAkfdRItgvW/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-SPLVO393PYWPV9WuelaiJg-1; Wed, 31 Mar 2021 22:21:10 -0400
X-MC-Unique: SPLVO393PYWPV9WuelaiJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE1A681746B;
        Thu,  1 Apr 2021 02:21:09 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 781E06E70D;
        Thu,  1 Apr 2021 02:20:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 05/12] block: add new field into 'struct bvec_iter'
Date:   Thu,  1 Apr 2021 10:19:20 +0800
Message-Id: <20210401021927.343727-6-ming.lei@redhat.com>
In-Reply-To: <20210401021927.343727-1-ming.lei@redhat.com>
References: <20210401021927.343727-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a hole at the end of 'struct bvec_iter', so put a new field
here and we can save cookie returned from submit_bio() here for
supporting bio based polling.

This way can avoid to extend bio unnecessarily.

Meantime add two helpers to get/set this field.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h          | 10 ++++++++++
 include/linux/bvec.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 35901cee709d..c1d8456656df 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -395,4 +395,14 @@ static inline void blk_create_io_poll_context(struct request_queue *q)
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

