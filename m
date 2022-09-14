Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807E9ECAAD3
	for <linux-block@archiver.kernel.org>; Wed, 14 Sep 2022 20:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiINU4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiINUz7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 16:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843AD82758
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663188956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gCHAFBYNs84QgdB15/2hBJH6h8Vt4rafGAo1L6Deqzc=;
        b=hFGOWO2uXdtyr21VVXpEwzXfAMycLVxeVOi6WPhWHpsjkRCEzE/YSh5dvVVhEDASSDiztj
        kEIheLEw9KXY1P1LWjyVvMo+Vsa69r0tMELgtNmQ7xPSZZ4AeN93kFXo1RLs/vUGM9OTIJ
        k6/Zq3aFObtOx3Q4DPCkukznsGxpqKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-kn8QgeynNE-hOtd5KAyflQ-1; Wed, 14 Sep 2022 16:55:52 -0400
X-MC-Unique: kn8QgeynNE-hOtd5KAyflQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CDF8185A792;
        Wed, 14 Sep 2022 20:55:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1FAE1121315;
        Wed, 14 Sep 2022 20:55:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28EKtpgb014908;
        Wed, 14 Sep 2022 16:55:51 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28EKtpFd014904;
        Wed, 14 Sep 2022 16:55:51 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 14 Sep 2022 16:55:51 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Coly Li <colyli@suse.de>,
        David Sterba <dsterba@suse.com>, Chao Yu <chao@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] blk-lib: fix blkdev_issue_secure_erase
Message-ID: <alpine.LRH.2.02.2209141549480.28100@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's a bug in blkdev_issue_secure_erase. The statement
"unsigned int len = min_t(sector_t, nr_sects, max_sectors);"
sets the variable "len" to the length in sectors, but the statement
"bio->bi_iter.bi_size = len" treats it as if it were in bytes.
The statements "sector += len << SECTOR_SHIFT" and "nr_sects -= len <<
SECTOR_SHIFT" are thinko.

This patch fixes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v5.19
Fixes: 44abff2c0b97 ("block: decouple REQ_OP_SECURE_ERASE from REQ_OP_DISCARD")

---
 block/blk-lib.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6/block/blk-lib.c
===================================================================
--- linux-2.6.orig/block/blk-lib.c
+++ linux-2.6/block/blk-lib.c
@@ -309,6 +309,11 @@ int blkdev_issue_secure_erase(struct blo
 	struct blk_plug plug;
 	int ret = 0;
 
+	/* make sure that "len << SECTOR_SHIFT" doesn't overflow */
+	if (max_sectors > UINT_MAX >> SECTOR_SHIFT)
+		max_sectors = UINT_MAX >> SECTOR_SHIFT;
+	max_sectors &= ~bs_mask;
+
 	if (max_sectors == 0)
 		return -EOPNOTSUPP;
 	if ((sector | nr_sects) & bs_mask)
@@ -322,10 +327,10 @@ int blkdev_issue_secure_erase(struct blo
 
 		bio = blk_next_bio(bio, bdev, 0, REQ_OP_SECURE_ERASE, gfp);
 		bio->bi_iter.bi_sector = sector;
-		bio->bi_iter.bi_size = len;
+		bio->bi_iter.bi_size = len << SECTOR_SHIFT;
 
-		sector += len << SECTOR_SHIFT;
-		nr_sects -= len << SECTOR_SHIFT;
+		sector += len;
+		nr_sects -= len;
 		if (!nr_sects) {
 			ret = submit_bio_wait(bio);
 			bio_put(bio);

