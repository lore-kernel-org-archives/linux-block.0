Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D8BC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8291E64E6F
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBXEAa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhBXEAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 23:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614139136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtfQQCnSFSuFYurXQqBEBDrftjlvJqpZVtMEbRYONZo=;
        b=cOAINJmTSbjJilYedEet0X1F9Fcw4MNx0nnN75Ty6skPrxFvhzdNft65BjwChKBuAqZRZ8
        +al41xmCfnH6gceOstQCkeFG8JrHYGZ3LrwrqvkTTcY6wrPS4MKWH2h907IJJbuqBO3BzL
        Ft5JZHbBz5OC46+XdmGlS3BwxHjT3o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-XPMZrcXzMa2r_0PLJNnPEA-1; Tue, 23 Feb 2021 22:58:52 -0500
X-MC-Unique: XPMZrcXzMa2r_0PLJNnPEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 413488799E0;
        Wed, 24 Feb 2021 03:58:51 +0000 (UTC)
Received: from localhost (ovpn-13-84.pek2.redhat.com [10.72.13.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8060610016F0;
        Wed, 24 Feb 2021 03:58:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Ewan Milne <emilne@redhat.com>
Subject: [PATCH V2 2/4] block: store partition flags into block_device
Date:   Wed, 24 Feb 2021 11:58:28 +0800
Message-Id: <20210224035830.990123-3-ming.lei@redhat.com>
In-Reply-To: <20210224035830.990123-1-ming.lei@redhat.com>
References: <20210224035830.990123-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for checking if partition is changed.

Cc: Ewan Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c   | 1 +
 include/linux/blk_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 430ff7863556..07981f663f66 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -352,6 +352,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 
 	bdev->bd_start_sect = start;
 	bdev_set_nr_sectors(bdev, len);
+	bdev->bd_part_flags = flags;
 
 	if (info) {
 		err = -ENOMEM;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..4d43b80cb9e9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -40,6 +40,7 @@ struct block_device {
 #endif
 	struct kobject		*bd_holder_dir;
 	u8			bd_partno;
+	u8			bd_part_flags;
 	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
 
-- 
2.29.2

