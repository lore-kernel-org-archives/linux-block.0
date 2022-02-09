Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1317C43219
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 09:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiBIJlt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:41:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiBIJhp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 04:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22A36C0043F6
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 01:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Es9ByrKbc53VTbUiBQsT+t2lklsc816Yl6Ml3jPpuUk=;
        b=eBA0eDai8ic8OcoK5Xsb8G5bsKeDhhWgLHGbvrVVhfChkSsLaAhm3PZ4HyKAe2LX3XYwms
        zu4YKP4jXWFXm08gSQrsq9kyH330zWD3+X6vKt4vkVgico4KhupvWQgEkPC4zw9kUe0odi
        eORb00WNF+ljxzsJLNJIhycZDuENAAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-7MaGvZW2Noa-eIPzGXLlbA-1; Wed, 09 Feb 2022 04:15:12 -0500
X-MC-Unique: 7MaGvZW2Noa-eIPzGXLlbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CD001091DAC;
        Wed,  9 Feb 2022 09:15:11 +0000 (UTC)
Received: from localhost (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B468F5DBB4;
        Wed,  9 Feb 2022 09:15:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/7] block: move submit_bio_checks() into submit_bio_noacct
Date:   Wed,  9 Feb 2022 17:14:23 +0800
Message-Id: <20220209091429.1929728-2-ming.lei@redhat.com>
In-Reply-To: <20220209091429.1929728-1-ming.lei@redhat.com>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
index be8812f5489d..bf989b1b3bea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -800,9 +800,6 @@ static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	if (unlikely(!submit_bio_checks(bio)))
-		return;
-
 	if (!disk->fops->submit_bio)
 		blk_mq_submit_bio(bio);
 	else
@@ -896,6 +893,9 @@ static void __submit_bio_noacct_mq(struct bio *bio)
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

