Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A594C001B0
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHKNxT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKNxS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 09:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00532D78
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691761955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qf6Ic09Y1qGMG460Va8GOjb/vJlHu0f0gtfrpU1SYGw=;
        b=FGdb19zmi2OZhOavxaYB8soVFslHvROIGwc3DWdc7vpaPtwAnyf5jIZsou33g2Ij//n/Oh
        JJebKlo40jI7wwZA0VgGoXZmIKx5iXmjCCSbkYtNVILE1CcaNAk1WKE0SVs3GEVEngENO0
        f843nTdNdU412vgCVJRc0SzSy0IlebU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-aFM0sSvQO32mjAkHo1E5tw-1; Fri, 11 Aug 2023 09:52:32 -0400
X-MC-Unique: aFM0sSvQO32mjAkHo1E5tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5402C85C70B;
        Fri, 11 Aug 2023 13:52:32 +0000 (UTC)
Received: from localhost (unknown [10.72.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E19B1121314;
        Fri, 11 Aug 2023 13:52:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] ublk: fix 'warn: variable dereferenced before check 'req'' from Smatch
Date:   Fri, 11 Aug 2023 21:52:16 +0800
Message-Id: <20230811135216.420404-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The added check of 'req_op(req) == REQ_OP_ZONE_APPEND' should have been
done after the request is confirmed as valid.

Actually here, the request should always been true, so add one
WARN_ON_ONCE(!req), meantime move the zone_append check after
checking the request.

Cc: Andreas Hindborg <a.hindborg@samsung.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3650ef209344..be76db54db1f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1400,11 +1400,13 @@ static void ublk_commit_completion(struct ublk_device *ub,
 
 	/* find the io request and complete */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
+	if (WARN_ON_ONCE(unlikely(!req)))
+		return;
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
 
-	if (req && likely(!blk_should_fake_timeout(req->q)))
+	if (likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
 }
 
-- 
2.40.1

