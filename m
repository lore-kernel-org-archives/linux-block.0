Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF457C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 08:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833E164E4D
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 08:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhBWIxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 03:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231152AbhBWIxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 03:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614070341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PZhMvwqAMAF9KgtQScdkaBrG6s7RqE4qWpKb+pwxY1A=;
        b=grgvOUqW7jGhP4Xlzo6tjqsmULdH+QbDmhtsHHxeLznh8+dfmoZTwYyEXqsdCJ1aiuKkcG
        8tl2cmlBxZln9AC/UllRgJTrtSqcjF/ZgjH/qwFDH+zYDl3WvU2hiAzrf5eYx0EdUkpLTM
        uHDrnWBl/j74mFMAAUCBgOvs9gNbk1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-Q44K5qBQNLuxeWYNBL1Lmw-1; Tue, 23 Feb 2021 03:51:47 -0500
X-MC-Unique: Q44K5qBQNLuxeWYNBL1Lmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B85E2835E26;
        Tue, 23 Feb 2021 08:51:46 +0000 (UTC)
Received: from localhost (ovpn-12-246.pek2.redhat.com [10.72.12.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E938C1972B;
        Tue, 23 Feb 2021 08:51:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: fix logging on capacity change
Date:   Tue, 23 Feb 2021 16:50:15 +0800
Message-Id: <20210223085015.832088-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Local variable of 'capacity' stores the previous disk capacity, and
'size' variable records the latest disk capacity, so swap them for
fixing logging on capacity change.

Cc: Christoph Hellwig <hch@lst.de>
Fixes: a782483cc1f8 ("block: remove the nr_sects field in struct hd_struct")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 36ff45bbaaaf..dbb92e24ef65 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -74,7 +74,7 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 		return false;
 
 	pr_info("%s: detected capacity change from %lld to %lld\n",
-		disk->disk_name, size, capacity);
+		disk->disk_name, capacity, size);
 
 	/*
 	 * Historically we did not send a uevent for changes to/from an empty
-- 
2.29.2

