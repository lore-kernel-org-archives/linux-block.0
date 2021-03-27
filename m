Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1AEC433DB
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 07:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4969E619BA
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 07:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhC0HNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Mar 2021 03:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230195AbhC0HNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Mar 2021 03:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616829209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NN9H+E5nsi8FFWKFc8ZnNr235pTqhDDHF7D9hA5SFS0=;
        b=OcBstZC8CiEMU0ti+VyWikwV2Ff40GiS4uESakqMZ7U6+8pGevFdoS5PEMBxpQwXeSYcXY
        txSFOAuZHm6/Cw+Eo+7e7h+O7GgzlpKYe1Q6vpdzDALVe4bMSBGfEXZH9142O7b0PtrjQa
        vw78BwOzaOBOpNZHmIOGG0fpikWZySc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-lMIM7vRUPRSsXPHQ0kRgHA-1; Sat, 27 Mar 2021 03:13:24 -0400
X-MC-Unique: lMIM7vRUPRSsXPHQ0kRgHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D3CF180FCA6;
        Sat, 27 Mar 2021 07:13:21 +0000 (UTC)
Received: from localhost (ovpn-12-65.pek2.redhat.com [10.72.12.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 623F11869D;
        Sat, 27 Mar 2021 07:13:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
Subject: [PATCH V2] block: not create too many partitions
Date:   Sat, 27 Mar 2021 15:13:09 +0800
Message-Id: <20210327071309.553557-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
V2:
	- don't check disk_max_parts() which is supposed to not zero

 block/partitions/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a7558917c47..46f055bc7ecb 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -322,6 +322,13 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	const char *dname;
 	int err;
 
+	/*
+	 * disk_max_parts() won't be zero, either GENHD_FL_EXT_DEVT is set
+	 * or 'minors' is passed to alloc_disk().
+	 */
+	if (partno >= disk_max_parts(disk))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Partitions are not supported on zoned block devices that are used as
 	 * such.
-- 
2.29.2

