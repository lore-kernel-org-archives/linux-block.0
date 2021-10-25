Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90A160FDA
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhJYC5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 22:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232301AbhJYC5l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 22:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635130519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFan7nTdgfoFap6cQpEwBX1t4meF6S1iT44x4AnXqtA=;
        b=eq4K8P9N9LSweOVUfsFK5tIALgJDk+ZtTVwmmCVrn2Y4ZQXsWIQl0KPXzIjZ40W3Yc+vJu
        HbJQUtXWK4U0kx2ppKFwDn0Bmo4zF903edikCSTKIMmIObdk8FfwA1OZYKYjXCPRRRja0m
        /Xpkh9NNYwJhohxYMkklupv+4GlfrpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-HOEtoLDpNR6cG_067Q44ZA-1; Sun, 24 Oct 2021 22:55:15 -0400
X-MC-Unique: HOEtoLDpNR6cG_067Q44ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86B511006AA3;
        Mon, 25 Oct 2021 02:55:14 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF59360CA1;
        Mon, 25 Oct 2021 02:55:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/4] zram: replace fsync_bdev with sync_blockdev
Date:   Mon, 25 Oct 2021 10:54:26 +0800
Message-Id: <20211025025426.2815424-5-ming.lei@redhat.com>
In-Reply-To: <20211025025426.2815424-1-ming.lei@redhat.com>
References: <20211025025426.2815424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When calling fsync_bdev(), zram driver guarantees that the bdev won't be
opened by anyone, then there can't be one active fs/superblock over the
zram bdev, so replace fsync_bdev with sync_blockdev.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dba93b8ce511..9609e2b31d5a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1790,7 +1790,7 @@ static ssize_t reset_store(struct device *dev,
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	/* Make sure all the pending I/O are finished */
-	fsync_bdev(bdev);
+	sync_blockdev(bdev);
 	zram_reset_device(zram);
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
@@ -1991,7 +1991,7 @@ static int zram_remove(struct zram *zram)
 		;
 	} else {
 		/* Make sure all the pending I/O are finished */
-		fsync_bdev(bdev);
+		sync_blockdev(bdev);
 		zram_reset_device(zram);
 	}
 
-- 
2.31.1

