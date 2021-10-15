Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F92FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0309561073
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhJOMTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238683AbhJOMTl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 08:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634300254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KrkMnkH86ewL6Zty6GHFELNmRB9MKUUu4ehy7pRGQFY=;
        b=Tu1et7MeiFdec0QUAM57YJFu8FyzlEV9OS897Dc0ipd92oWPD237d75PQZI98u7KgY/9HB
        /jjQ1Urmf8agvWnx+WMDCwuN24HUeFnSac0PFO+K5/mu4rPvEAZymaD6EDinAYM8b8MYyO
        hBVV5E7j58hQkqcSqXAhKDHPNzSROHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-r7_1ElU0PsOyzSw1DtaoLw-1; Fri, 15 Oct 2021 08:17:33 -0400
X-MC-Unique: r7_1ElU0PsOyzSw1DtaoLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50E721808308;
        Fri, 15 Oct 2021 12:17:32 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C783E5F4EE;
        Fri, 15 Oct 2021 12:17:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] zram: replace fsync_bdev with sync_blockdev
Date:   Fri, 15 Oct 2021 20:16:50 +0800
Message-Id: <20211015121652.2024287-2-ming.lei@redhat.com>
In-Reply-To: <20211015121652.2024287-1-ming.lei@redhat.com>
References: <20211015121652.2024287-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When calling fsync_bdev(), zram driver guarantees that the bdev won't be
opened by anyone, then there can't be one active fs/superblock over the
zram bdev, so replace fsync_bdev with sync_blockdev.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..6f6f6a3fee0e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1793,7 +1793,7 @@ static ssize_t reset_store(struct device *dev,
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	/* Make sure all the pending I/O are finished */
-	fsync_bdev(bdev);
+	sync_blockdev(bdev);
 	zram_reset_device(zram);
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
@@ -1984,7 +1984,7 @@ static int zram_remove(struct zram *zram)
 	zram_debugfs_unregister(zram);
 
 	/* Make sure all the pending I/O are finished */
-	fsync_bdev(bdev);
+	sync_blockdev(bdev);
 	zram_reset_device(zram);
 
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
-- 
2.31.1

