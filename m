Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B38C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA064E6F
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBXEAa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231818AbhBXEA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 23:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614139139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHSXDo9mD4eH/G723x6kBQManvhXFhnAHnvz/FOMDGk=;
        b=d0ZcQ3o3THyaofFWS436E9FVsllE4GVH5wRmxKrKL8c3GFanY2/f/pfNySfBibyincDhs+
        f4ftB9fTiYXs6MeeA3VR6vRsW2JUQUqCdILFFAfPcGdaXIdUMQbwAfoX7VtNVZUKNKHZRb
        ldjeWHyo2y9wkZ3TzCID4lHUsAE/Fxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ICN5jDvcPLel_wvGmugy5g-1; Tue, 23 Feb 2021 22:58:57 -0500
X-MC-Unique: ICN5jDvcPLel_wvGmugy5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF51107ACE4;
        Wed, 24 Feb 2021 03:58:56 +0000 (UTC)
Received: from localhost (ovpn-13-84.pek2.redhat.com [10.72.13.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3113D5D9D3;
        Wed, 24 Feb 2021 03:58:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH V2 3/4] block: re-organize blk_add_partitions
Date:   Wed, 24 Feb 2021 11:58:29 +0800
Message-Id: <20210224035830.990123-4-ming.lei@redhat.com>
In-Reply-To: <20210224035830.990123-1-ming.lei@redhat.com>
References: <20210224035830.990123-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No functional change, make code more readable, just split
blk_add_partitions() into two helpers.

Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c | 50 +++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 07981f663f66..288ca362ccbd 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -603,17 +603,19 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 	return true;
 }
 
-int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+static int __blk_check_partitions(struct gendisk *disk,
+		struct block_device *bdev, struct parsed_partitions **s)
 {
-	struct parsed_partitions *state;
-	int ret = -EAGAIN, p;
+	struct parsed_partitions *state = NULL;
+	int ret = -EAGAIN;
 
 	if (!disk_part_scan_enabled(disk))
-		return 0;
+		goto out;
 
 	state = check_partition(disk, bdev);
 	if (!state)
-		return 0;
+		goto out;
+
 	if (IS_ERR(state)) {
 		/*
 		 * I/O error reading the partition table.  If we tried to read
@@ -651,15 +653,45 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 			goto out_free_state;
 	}
 
+out:
+	*s = state;
+	return 0;
+
+out_free_state:
+	free_partitions(state);
+	*s = NULL;
+	return ret;
+}
+
+static int __blk_add_partitions(struct gendisk *disk,
+		struct block_device *bdev, struct parsed_partitions *state)
+{
+	int p;
+
 	/* tell userspace that the media / partition table may have changed */
 	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 
-	for (p = 1; p < state->limit; p++)
+	for (p = 1; p < state->limit; p++) {
 		if (!blk_add_partition(disk, bdev, state, p))
-			goto out_free_state;
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+{
+	struct parsed_partitions *state;
+	int ret;
+
+	ret = __blk_check_partitions(disk, bdev, &state);
+	if (ret != 0)
+		return ret;
+	if (!state)
+		return 0;
+
+	ret = __blk_add_partitions(disk, bdev, state);
 
-	ret = 0;
-out_free_state:
 	free_partitions(state);
 	return ret;
 }
-- 
2.29.2

