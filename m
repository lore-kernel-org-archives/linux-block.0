Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5828BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 01:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7386113D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 01:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTB6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhJTB6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 21:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634694994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=freyuG48ucRP6h2e8+iworwUl5TwR3fT12ETkCRsZlI=;
        b=TfVcDKlxDKmE16T41e8skku+95eGh/5KN6g42WCKvprmrkcb5OXh53Hu3kpEw/ik6QJWOX
        LCubrXta2DTdI9O60W+VeaoyUW7vslN3kG1l2vB79TZy1Q9QQQNJVPgWjh/kVz8YdpThDr
        bfyHoqIpLlepxWKNq7eQ5X3P/skWyX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-mcfFYADuMQicWSea3cNWvg-1; Tue, 19 Oct 2021 21:56:30 -0400
X-MC-Unique: mcfFYADuMQicWSea3cNWvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E31362FD;
        Wed, 20 Oct 2021 01:56:29 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5FEA6A8F5;
        Wed, 20 Oct 2021 01:56:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/4] zram: avoid race between zram_remove and disksize_store
Date:   Wed, 20 Oct 2021 09:55:47 +0800
Message-Id: <20211020015548.2374568-4-ming.lei@redhat.com>
In-Reply-To: <20211020015548.2374568-1-ming.lei@redhat.com>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
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
index 8883de7aa3d7..6078d1dae44a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2002,6 +2002,13 @@ static int zram_remove(struct zram *zram)
 	/* del_gendisk drains pending reset_store */
 	WARN_ON_ONCE(claimed && zram->claim);
 
+	/*
+	 * disksize store may come between zram_reset_device and del_gendisk, so
+	 * run the last reset for avoiding leak anything allocated in
+	 * disksize_store().
+	 */
+	zram_reset_device(zram);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;
-- 
2.31.1

