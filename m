Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33AAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B169E60F4F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhJYC50 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 22:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232280AbhJYC5Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 22:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635130503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AE0JY6csuXHuv4AM42+KRRY1fWa7BR0iAL/p8wT8I/8=;
        b=EbdNglyPahV46o18aOQ41jBNu6FBsvov7lQdrlC0AOVpeFdL7AExp//lwllU1Kl6MjCBoh
        riHmEjYY4K/m4ECVsQztaEZGleArOolBKV9qXlgJoqooJeXL3VYmDRdyJ3U9I2teKcBbt7
        8KDx/1eUv2OF+gJ/fgoNtIzySHLC9h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-gh3LXyuHM9el8AtAnQEg4Q-1; Sun, 24 Oct 2021 22:55:00 -0400
X-MC-Unique: gh3LXyuHM9el8AtAnQEg4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0569D1808302;
        Mon, 25 Oct 2021 02:54:59 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D39585D705;
        Mon, 25 Oct 2021 02:54:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/4] zram: avoid race between zram_remove and disksize_store
Date:   Mon, 25 Oct 2021 10:54:25 +0800
Message-Id: <20211025025426.2815424-4-ming.lei@redhat.com>
In-Reply-To: <20211025025426.2815424-1-ming.lei@redhat.com>
References: <20211025025426.2815424-1-ming.lei@redhat.com>
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
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8883de7aa3d7..dba93b8ce511 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2002,6 +2002,13 @@ static int zram_remove(struct zram *zram)
 	/* del_gendisk drains pending reset_store */
 	WARN_ON_ONCE(claimed && zram->claim);
 
+	/*
+	 * disksize_store() may be called in between zram_reset_device()
+	 * and del_gendisk(), so run the last reset to avoid leaking
+	 * anything allocated with disksize_store()
+	 */
+	zram_reset_device(zram);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;
-- 
2.31.1

