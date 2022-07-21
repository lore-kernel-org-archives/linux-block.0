Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E505CCA488
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 08:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiGUIRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiGUIRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 04:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F0317D7A7
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658391421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0SPfH2BWJkpanSxq7rE5tTbBwqO4A2429/d/nLl2VPU=;
        b=JYABFd5U7MvdgimfFPf3Hleli7Jqj8MKGuftDvcgnC5iM10jj6EWdugUNbNGKM+GD4Z4b7
        xG4w3b1CUrBsVZNIdGP4NZYEo8d1UtjTog5SPEBg84q/Odrl+gqrUQ6E+N5q/5I8YGd9m7
        6BZ2hUspZAYzwTtWKpFf6ybzb+1CMoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-1F5jba5ANuKocSszfjhXKw-1; Thu, 21 Jul 2022 04:16:59 -0400
X-MC-Unique: 1F5jba5ANuKocSszfjhXKw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59995185A7BA;
        Thu, 21 Jul 2022 08:16:59 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77606492C3B;
        Thu, 21 Jul 2022 08:16:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH] block: warn if throttle group is null
Date:   Thu, 21 Jul 2022 16:16:52 +0800
Message-Id: <20220721081652.568440-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If BLK_DEV_THROTTLING is enabled, bio->bi_blkg shouldn't be NULL, so
warn if it is found as NULL, then return false and bypass throttling.

It helps Mike to figure out one dm-raid problem.

Cc: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index c1b602996127..55e93b3f3205 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -174,6 +174,9 @@ static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
+	if (WARN_ON_ONCE(!tg))
+		return false;
+
 	/* no need to throttle bps any more if the bio has been throttled */
 	if (bio_flagged(bio, BIO_THROTTLED) &&
 	    !(tg->flags & THROTL_TG_HAS_IOPS_LIMIT))
-- 
2.31.1

