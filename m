Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B8C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 09:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C08061992
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 09:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCZJAv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 05:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhCZJAk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 05:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616749239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LXutSwyyQzPe30QNJw6DHp7SemMsSu6BpNSDFhJkYm8=;
        b=aHpein2EnqNJXRX4zTGA2m/B5lsBF++wbt4tnp9/mSZFKHfx/dw/F2Zg8OeJpz+R4hrr1y
        4I+1JULZuwxuTNSiC6IIxpDr7LRCYTtLq/VNXaAmoGSZcCTptvui6AAIXqnASAhTmgViqT
        aHh+SmbCM2nxJJst2nhePNC0eJLjdK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-FumlWxIoMjaRi-YOJ9QwQQ-1; Fri, 26 Mar 2021 05:00:37 -0400
X-MC-Unique: FumlWxIoMjaRi-YOJ9QwQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01719EC1A1;
        Fri, 26 Mar 2021 09:00:36 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAC99891C3;
        Fri, 26 Mar 2021 08:59:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
Subject: [PATCH] block: not create too many partitions
Date:   Fri, 26 Mar 2021 16:59:54 +0800
Message-Id: <20210326085954.474119-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") drops
check on max supported partitions number, and allows partition with
bigger partition number to be added. However, ->bd_partno is defined
as u8, so partition index of xarray table may not match with ->bd_partno.
Then delete_partition() may delete one unmatched partition, and caused
use-after-free.

Cc: Bart Van Assche <bvanassche@acm.org>
Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
Another fix is to define ->bd_partno as u32, not sure if we need to
support so many partitions.

 block/partitions/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a7558917c47..933d47105b64 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -322,6 +322,10 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	const char *dname;
 	int err;
 
+	/* disk_max_parts() is zero during initialization, ignore if so */
+	if (disk_max_parts(disk) && (partno + 1) > disk_max_parts(disk))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Partitions are not supported on zoned block devices that are used as
 	 * such.
-- 
2.29.2

