Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F8C63777
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 09:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DEF22244
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 09:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFzQRblb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKTJz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbgKTJz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 04:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605866125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=POpy7SHsUAv1R+CzOrYR2DiWlpqqsvEiE11Fwp/XNi8=;
        b=PFzQRblb637eWvA/IuAFDnClzxTU29WhEXY2BUD4Y7lQ0bpgrCMPTo/RnnCeyaUN6TtAHW
        +I/dpoMNsEBN/IIHWHNyAZzkzce1d18C+QMUn2XjQ7h5dautbtQbV3QJX6KxxtZh+Gv/qy
        onvh/VfVqxS9X2gE4TruykyWqF0toG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-_T2wPljKOhevcJEl76oliA-1; Fri, 20 Nov 2020 04:55:23 -0500
X-MC-Unique: _T2wPljKOhevcJEl76oliA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 359D2803F59;
        Fri, 20 Nov 2020 09:55:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BD7360BE2;
        Fri, 20 Nov 2020 09:55:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 0AK9tDcf001257;
        Fri, 20 Nov 2020 04:55:13 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 0AK9tDGq001253;
        Fri, 20 Nov 2020 04:55:13 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 20 Nov 2020 04:55:12 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Mike Snitzer <msnitzer@redhat.com>,
        John Dorminy <jdorminy@redhat.com>
Subject: [PATCH] dm-settings: fix a possible integer overflow in
 blk_queue_max_hw_sectors
Message-ID: <alpine.LRH.2.02.2011200451180.28876@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a possible overflow due to shift left.
Also, replace the constant "9" with SECTOR_SHIFT.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/blk-settings.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/block/blk-settings.c
===================================================================
--- linux-2.6.orig/block/blk-settings.c	2020-11-19 21:20:18.000000000 +0100
+++ linux-2.6/block/blk-settings.c	2020-11-20 10:50:15.000000000 +0100
@@ -151,8 +151,8 @@ void blk_queue_max_hw_sectors(struct req
 	struct queue_limits *limits = &q->limits;
 	unsigned int max_sectors;
 
-	if ((max_hw_sectors << 9) < PAGE_SIZE) {
-		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
+	if (max_hw_sectors < 1 << (PAGE_SHIFT - SECTOR_SHIFT)) {
+		max_hw_sectors = 1 << (PAGE_SHIFT - SECTOR_SHIFT);
 		printk(KERN_INFO "%s: set to minimum %d\n",
 		       __func__, max_hw_sectors);
 	}
@@ -161,7 +161,7 @@ void blk_queue_max_hw_sectors(struct req
 	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
 	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
 	limits->max_sectors = max_sectors;
-	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
+	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - SECTOR_SHIFT);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 

