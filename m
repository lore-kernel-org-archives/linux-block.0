Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ABAC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B00460EDF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhJYJtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232777AbhJYJrk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VOV3KJ4vllw7odMXpV9teLtbeGcoh4b6CY+OB6sTQA=;
        b=CnH662GblWMf9XVdCqSOYhAya26hv2ZmgVLy5zbD/rNPmAcgMuWAHtgvHisL/U+GL/5hBc
        retKfgIYTASkQ1TSfS6jSTzPPVwYHVuzCHJjBmckwnjETu+bequKFdUgwcDHgTO6N0JXVv
        fJGzuXz52TJxXTuZHIJAVu51S+JZYus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-RJ5gsZspOAGvBLzFNaKLfw-1; Mon, 25 Oct 2021 05:45:14 -0400
X-MC-Unique: RJ5gsZspOAGvBLzFNaKLfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 947EA10151E3;
        Mon, 25 Oct 2021 09:45:13 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D55CE60BF4;
        Mon, 25 Oct 2021 09:45:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 8/8] loop: use backing dio at default
Date:   Mon, 25 Oct 2021 17:44:37 +0800
Message-Id: <20211025094437.2837701-9-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have supported to fallback to buffered IO in case dio failure. Also
in reality, most of or quite a lot of IOs(such as FS IO) are actually aligned,
even though loop's logical block size isn't matched with backing
queue's.

So enable direct io at default.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e42c0e3601ac..df057dca7512 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2285,13 +2285,8 @@ static int loop_add(int i)
 
 	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
 
-	/*
-	 * By default, we do buffer IO, so it doesn't make sense to enable
-	 * merge because the I/O submitted to backing file is handled page by
-	 * page. For directio mode, merge does help to dispatch bigger request
-	 * to underlayer disk. We will enable merge once directio is enabled.
-	 */
-	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, lo->lo_queue);
+	/* use backing dio at default */
+	lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 
 	/*
 	 * Disable partition scanning by default. The in-kernel partition
-- 
2.31.1

