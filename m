Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59283C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B1260234
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 16:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhBWQaH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232473AbhBWQaG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 11:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614097718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hEdmz9TmoqCfu4qyhdj28PLtLhLryIeyp1D9apTQzYs=;
        b=Syl2TCRK0wInF49TYmnJoiRWridsp/tc4o4lzTsUYs2JKXh4z9WBsbRYFYQ6+YgoZXgDCV
        /WdQD1HzGfYSLsJ0KkpOYLxT7CwOLTqiH2YQty3MiSQDOZhylj0O89E3SHmtn8NLGmSnnz
        50DNbzHLzjrnAjMXCrM0tsFbPm+bImU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-rTiTab6_OfqOd0YuUHsHfA-1; Tue, 23 Feb 2021 11:28:35 -0500
X-MC-Unique: rTiTab6_OfqOd0YuUHsHfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB27F8F508;
        Tue, 23 Feb 2021 16:28:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDE525D6AC;
        Tue, 23 Feb 2021 16:28:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 11NGSSLe028212;
        Tue, 23 Feb 2021 11:28:28 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 11NGSRxm028208;
        Tue, 23 Feb 2021 11:28:28 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 23 Feb 2021 11:28:27 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
cc:     Mike Snitzer <msnitzer@redhat.com>,
        Marian Csontos <mcsontos@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2] blk-settings: make sure that max_sectors is aligned on
 "logical_block_size" boundary
In-Reply-To: <YDSwyrLeiP/fKgZH@T590>
Message-ID: <alpine.LRH.2.02.2102231125170.27597@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2102221312070.5407@file01.intranet.prod.int.rdu2.redhat.com> <YDSwyrLeiP/fKgZH@T590>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Tue, 23 Feb 2021, Ming Lei wrote:

> I'd suggest to add a helper(such as, blk_round_down_sectors()) to round_down each
> one.

Yes - Here I'm sending the updated patch.

> -- 
> Ming

From: Mikulas Patocka <mpatocka@redhat.com>

We get I/O errors when we run md-raid1 on the top of dm-integrity on the
top of ramdisk.
device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8048, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8147, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8246, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8345, 0xbb

The ramdisk device has logical_block_size 512 and max_sectors 255. The
dm-integrity device uses logical_block_size 4096 and it doesn't affect the
"max_sectors" value - thus, it inherits 255 from the ramdisk. So, we have
a device with max_sectors not aligned on logical_block_size.

The md-raid device sees that the underlying leg has max_sectors 255 and it
will split the bios on 255-sector boundary, making the bios unaligned on
logical_block_size.

In order to fix the bug, we round down max_sectors to logical_block_size.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 block/blk-settings.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/block/blk-settings.c
===================================================================
--- linux-2.6.orig/block/blk-settings.c	2021-02-23 17:18:59.000000000 +0100
+++ linux-2.6/block/blk-settings.c	2021-02-23 17:23:58.000000000 +0100
@@ -481,6 +481,14 @@ void blk_queue_io_opt(struct request_que
 }
 EXPORT_SYMBOL(blk_queue_io_opt);
 
+static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lbs)
+{
+	sectors = round_down(sectors, lbs >> SECTOR_SHIFT);
+	if (sectors < PAGE_SIZE >> SECTOR_SHIFT)
+		sectors = PAGE_SIZE >> SECTOR_SHIFT;
+	return sectors;
+}
+
 /**
  * blk_stack_limits - adjust queue_limits for stacked devices
  * @t:	the stacking driver limits (top device)
@@ -607,6 +615,10 @@ int blk_stack_limits(struct queue_limits
 		ret = -1;
 	}
 
+	t->max_sectors = blk_round_down_sectors(t->max_sectors, t->logical_block_size);
+	t->max_hw_sectors = blk_round_down_sectors(t->max_hw_sectors, t->logical_block_size);
+	t->max_dev_sectors = blk_round_down_sectors(t->max_dev_sectors, t->logical_block_size);
+
 	/* Discard alignment and granularity */
 	if (b->discard_granularity) {
 		alignment = queue_limit_discard_alignment(b, start);

