Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30238C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1128961040
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJYC5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 22:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232250AbhJYC5L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 22:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635130489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E22BEZISqI+m8U8CL0bHRSqqXn2CunwBHAAxX2ofm5s=;
        b=Oeu6ZbqqU7h3uZotsumsn6PzxRAIGdPgK4asG66AZaZH8XS9EOQmzA3SOtC+lgE/illq2F
        qTFXBTzLeH6P+xrmXyTaVaB0og4YAZH7XYuRXrMXTLuwEt7HaV6TNpXroHvNzxWC9ixbnt
        VJox5/IiTeL65KIOqIOGijuZZ58FmEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-E8ziSHdBMrqcvyFAWT3FAw-1; Sun, 24 Oct 2021 22:54:46 -0400
X-MC-Unique: E8ziSHdBMrqcvyFAWT3FAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D561006AA2;
        Mon, 25 Oct 2021 02:54:45 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB1B5C1CF;
        Mon, 25 Oct 2021 02:54:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/4] zram: fix race between zram_reset_device() and disksize_store()
Date:   Mon, 25 Oct 2021 10:54:23 +0800
Message-Id: <20211025025426.2815424-2-ming.lei@redhat.com>
In-Reply-To: <20211025025426.2815424-1-ming.lei@redhat.com>
References: <20211025025426.2815424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the ->init_lock is released in zram_reset_device(), disksize_store()
can come in and try to allocate meta, but zram_reset_device() is freeing
free meta, so cause races.

Link: https://lore.kernel.org/linux-block/20210927163805.808907-1-mcgrof@kernel.org/T/#mc617f865a3fa2778e40f317ddf48f6447c20c073
Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a68297fb51a2..25d781dc5fef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1704,12 +1704,13 @@ static void zram_reset_device(struct zram *zram)
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
-	up_write(&zram->init_lock);
 	/* I/O operation under all of CPU are done so let's free */
 	zram_meta_free(zram, disksize);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	zcomp_destroy(comp);
 	reset_bdev(zram);
+
+	up_write(&zram->init_lock);
 }
 
 static ssize_t disksize_store(struct device *dev,
-- 
2.31.1

