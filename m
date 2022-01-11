Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8AAC433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 11:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbiAKL4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239120AbiAKL4R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 06:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641902176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TRUj6D24CLYDKaNUb7GPmGcYETfIOQHMelYKmybtjc=;
        b=MvTsONXx7brRCk5SFupCH8U3hz0Kvc3d1Zz7Yocsjt+gTj5q8RdNJNIxfxkF1/Wg5sHGvV
        EK4htb8SqBBEct+c2LjOKs9RYHB0PK9hWm8cCmB3wosfio69iIZ0hyrbYdbMeO5tVJM99z
        AeoqXCILhWkuV3+hbSUHo/Mvn0oecgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-vO-Vth7KMwWp0WCyrto7uA-1; Tue, 11 Jan 2022 06:56:10 -0500
X-MC-Unique: vO-Vth7KMwWp0WCyrto7uA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 916201083F67;
        Tue, 11 Jan 2022 11:56:09 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95F7F10595BA;
        Tue, 11 Jan 2022 11:55:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 1/7] block: move submit_bio_checks() into submit_bio_noacct
Date:   Tue, 11 Jan 2022 19:55:26 +0800
Message-Id: <20220111115532.497117-2-ming.lei@redhat.com>
In-Reply-To: <20220111115532.497117-1-ming.lei@redhat.com>
References: <20220111115532.497117-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is more clean & readable to check bio when starting to submit it,
instead of just before calling ->submit_bio() or blk_mq_submit_bio().

Also it provides us chance to optimize bio submission without checking
bio.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fd029c86d6ac..cca7fbe2a43b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -799,9 +799,6 @@ static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	if (unlikely(!submit_bio_checks(bio)))
-		return;
-
 	if (!disk->fops->submit_bio)
 		blk_mq_submit_bio(bio);
 	else
@@ -895,6 +892,9 @@ static void __submit_bio_noacct_mq(struct bio *bio)
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

