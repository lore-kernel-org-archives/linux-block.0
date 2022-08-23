Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D78DC32772
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 13:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiHWN7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Aug 2022 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242042AbiHWN64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 09:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D68C234367
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661252655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZ81h+ZrsPW2wF2BBI4v1LOK7N5yMkJj0mXTKgl7zUU=;
        b=Z+rIAzKiqlrGarzhNWCx6G6hgSNtACzpvf3DZ54jImIDiY3dK4xMncUDDrsHtc8glYp4Po
        SK3lrWIz15n12TmOk16el4vbsL+4YUrXqJwW1Goejp2k+8QNB7NXYOU1oPoaoZlfL2thNP
        lWC0ZA9WqmAp4Eq1I+XkuszjzQZqTec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-R8bba1gKOT2iHtP8toM-5A-1; Tue, 23 Aug 2022 06:38:24 -0400
X-MC-Unique: R8bba1gKOT2iHtP8toM-5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F5A98039B7;
        Tue, 23 Aug 2022 10:38:22 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D80E18EA8;
        Tue, 23 Aug 2022 10:38:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: don't add partitions if GD_SUPPRESS_PART_SCAN is set
Date:   Tue, 23 Aug 2022 18:38:19 +0800
Message-Id: <20220823103819.395776-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit b9684a71fca7 ("block, loop: support partitions without scanning")
adds GD_SUPPRESS_PART_SCAN for replacing part function of
GENHD_FL_NO_PART. But looks blk_add_partitions() is missed, since
loop doesn't want to add partitions if GENHD_FL_NO_PART was set.
And it causes regression on libblockdev (as called from udisks) which
operates with the LO_FLAGS_PARTSCAN.

Fixes the issue by not adding partitions if GD_SUPPRESS_PART_SCAN is
set.

Fixes: b9684a71fca7 ("block, loop: support partitions without scanning")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index fc1d70384825..b8112f52d388 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -596,6 +596,9 @@ static int blk_add_partitions(struct gendisk *disk)
 	if (disk->flags & GENHD_FL_NO_PART)
 		return 0;
 
+	if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
+		return 0;
+
 	state = check_partition(disk);
 	if (!state)
 		return 0;
-- 
2.31.1

