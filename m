Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C9C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 03:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiBODca (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:32:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBODca (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 22:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B8D810D7
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 19:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644895940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rC3/RJJxjSW0XJlMFo1Yyf9Kdg2z+iRpEsdfZikHRqc=;
        b=Fq11uZ2AbTdgrs+Pfb2HmnBMKP+IR70YqWGw1iehylUWeZColCEE9TIrBduVOacubJLwyG
        kSTgUPGPiNm6QTnTqhriS5LDmXj2jl43JdSXQYukwdcLEvRqKxfPJTvKu4t6EHHDh/m1rr
        7lx2cDNyRpei2y4hAh3CpGDNTpuMDMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-SIwwZ_ceO6OAYbIVDllcxg-1; Mon, 14 Feb 2022 22:32:17 -0500
X-MC-Unique: SIwwZ_ceO6OAYbIVDllcxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AF97801B32;
        Tue, 15 Feb 2022 03:32:16 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C740E2D3;
        Tue, 15 Feb 2022 03:32:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 1/8] block: move submit_bio_checks() into submit_bio_noacct
Date:   Tue, 15 Feb 2022 11:30:43 +0800
Message-Id: <20220215033050.2730533-2-ming.lei@redhat.com>
In-Reply-To: <20220215033050.2730533-1-ming.lei@redhat.com>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

