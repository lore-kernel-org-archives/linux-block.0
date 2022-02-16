Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 04:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiBPEqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:46:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbiBPEqF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 23:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 134E7F463D
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 20:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644986753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rC3/RJJxjSW0XJlMFo1Yyf9Kdg2z+iRpEsdfZikHRqc=;
        b=hVOPFcNqTtNL5VGtunUABEt5LJaB/SXp46eX3v1kW4A0n1qOJq3mMzVH7H1ZxXS4cmuXNX
        KtPbv/VvVkWshxPJ91svt/AVfBWGp8oG94CvNw4vSU2iT+bevZdHNaLnpeAviij4VMt+zq
        KDDKDgf5Z1FvumSiLuH12At1EP2NCs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-PcQTltXLOCu5PM_tpIgXeQ-1; Tue, 15 Feb 2022 23:45:49 -0500
X-MC-Unique: PcQTltXLOCu5PM_tpIgXeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B0011091DA1;
        Wed, 16 Feb 2022 04:45:48 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94B064CEE4;
        Wed, 16 Feb 2022 04:45:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 1/8] block: move submit_bio_checks() into submit_bio_noacct
Date:   Wed, 16 Feb 2022 12:45:07 +0800
Message-Id: <20220216044514.2903784-2-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-1-ming.lei@redhat.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is more clean & readable to check bio when starting to submit it,
instead of just before calling ->submit_bio() or blk_mq_submit_bio().

Also it provides us chance to optimize bio submission without checking
bio.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5a4a59041629..d4a023667ac1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -797,9 +797,6 @@ static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	if (unlikely(!submit_bio_checks(bio)))
-		return;
-
 	if (!disk->fops->submit_bio)
 		blk_mq_submit_bio(bio);
 	else
@@ -893,6 +890,9 @@ static void __submit_bio_noacct_mq(struct bio *bio)
  */
 void submit_bio_noacct(struct bio *bio)
 {
+	if (unlikely(!submit_bio_checks(bio)))
+		return;
+
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-- 
2.31.1

