Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901DFC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AFC61056
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhJOMTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238683AbhJOMTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 08:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634300263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fp//XthdA82FFRMKYMvAS8Gjzw2W/ECL+VWyRtHIKlE=;
        b=GsyrqJ6k+QayVjEBm5tdUNoT7wYVMUMrQRvb+9Rr3VwZeQxSdyVaehXHY+0E3+uLDOQjsN
        rGxIj5LU6ynzVUxgwMZCebnZHsszqL2frVc3Eu8yqDNOmHU9G0odjcbtuUbvzDHkOMtwGe
        4XmD+0rxhVeawabccDAyeEKzqxduDYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-iISm63wXM0WKjDH86aG43A-1; Fri, 15 Oct 2021 08:17:40 -0400
X-MC-Unique: iISm63wXM0WKjDH86aG43A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10265362F8;
        Fri, 15 Oct 2021 12:17:39 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DB525F4E5;
        Fri, 15 Oct 2021 12:17:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] zram: avoid race between zram_remove and disksize_store
Date:   Fri, 15 Oct 2021 20:16:52 +0800
Message-Id: <20211015121652.2024287-4-ming.lei@redhat.com>
In-Reply-To: <20211015121652.2024287-1-ming.lei@redhat.com>
References: <20211015121652.2024287-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After resetting device in zram_remove(), disksize_store still may come and
allocate resources again before deleting gendisk, fix the race by resetting
zram after del_gendisk() returns. At that time, disksize_store can't come
any more.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d374c0f46681..71c4ac26c57b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1973,6 +1973,13 @@ static int zram_remove(struct zram *zram)
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
 	del_gendisk(zram->disk);
+
+	/*
+	 * disksize store may come after the above zram_reset_device
+	 * returns, so run the last reset to avoid the race
+	 */
+	zram_reset_device(zram);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;
-- 
2.31.1

