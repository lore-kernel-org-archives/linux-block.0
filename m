Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E1EC04A6A
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 18:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjHHSKl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjHHSKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 14:10:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA828160AED
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 10:13:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7748ca56133so40213039f.0
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691514794; x=1692119594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLyKq52KYLZ4dQFCp6Er3nWNHdNoVBS8+miSC+qxbZ0=;
        b=lDER6FJ9VC1w+T2eW4e+D4n3STcf0lH5s8joMtaLg66cllF0SY4HAYipTP24Cuirbn
         jsN44yud/n8hTFFaJXVgMVd625cajc6rkPywxSIAhkIfoLaPRgADTC8yEE+3UFROK2ph
         Q9H12Trju1Ff0lDPWtKpilpMYCdFUGxLzvY9n74OpQQv25faBNrDFu7wgnf+EZ+NG2Pm
         HaQYwautW16KO2wCvMJFjADMDfHdLZXvz02XOVeLQkrwosMsTNgdhZbdZw2a7Lz8YgJf
         9Gn683kqCtU8oxZJr+vmvnpZrlN+29kuTiHSZEKynnFhAcYmxZ/G4z03nYne3r2PNKm3
         kEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514794; x=1692119594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLyKq52KYLZ4dQFCp6Er3nWNHdNoVBS8+miSC+qxbZ0=;
        b=FbxGkQFfYiz1Zuxc7Z2QiBpGF+UDaktBuuyWzgpBobXaS5CTil/a3H4JAmDPcOKwu1
         TaiMQhOxGqBeD63Q1LVu4hIQ5oI2kAuzLNkGdSUOVRrfAsn3jInjp7oZzn23K5h3NKic
         UCTzPx/vmFrS6i83PwL/huBaYqhGOK58EU2p3dc3h7xLGlm+8rRcbFSvMRoFNGwMtpRF
         8T0Cu5GB03nLBznwGr4DyqRYyVwSkkEw4LvVtkVNFNe1JHYxhs2s3NzuqfXHmiJzLYR6
         XHnGlySC/fKyXk+kJI7Gl7LH9zkfJWrqP521ShWSAh6KgtyWxDDdqIQHmE5hTKOSVTi4
         qCbQ==
X-Gm-Message-State: AOJu0YxAIdOW7NSG+TqscvHvc/5Hsz1IDP/gYquQ7+mu69QBX2ShFFZb
        x0IgJXDDblbKQaaT09xQMKDPh1KXLu2VfyfhMCs=
X-Google-Smtp-Source: AGHT+IG3b4YO4hE/AP8xqwX9q+eIrNqoGd69voEcN0Eb7r+i4RP2EcDVGtevWwUVCIihQ/DnEr938g==
X-Received: by 2002:a05:6602:3713:b0:791:3651:dfc7 with SMTP id bh19-20020a056602371300b007913651dfc7mr270536iob.1.1691514793922;
        Tue, 08 Aug 2023 10:13:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r25-20020a02c859000000b0042afec5be53sm3222955jao.153.2023.08.08.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 10:13:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: get rid of unused plug->nowait flag
Date:   Tue,  8 Aug 2023 11:13:09 -0600
Message-Id: <20230808171310.112878-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171310.112878-1-axboe@kernel.dk>
References: <20230808171310.112878-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This was introduced to add a plug based way of signaling nowait issues,
but we have since moved on from that. Kill the old dead code, nobody is
setting it anymore.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 6 ------
 include/linux/blkdev.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 90de50082146..9866468c72a2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -722,14 +722,9 @@ void submit_bio_noacct(struct bio *bio)
 	struct block_device *bdev = bio->bi_bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
 	blk_status_t status = BLK_STS_IOERR;
-	struct blk_plug *plug;
 
 	might_sleep();
 
-	plug = blk_mq_plug(bio);
-	if (plug && plug->nowait)
-		bio->bi_opf |= REQ_NOWAIT;
-
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue does not support NOWAIT.
@@ -1059,7 +1054,6 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
 	plug->has_elevator = false;
-	plug->nowait = false;
 	INIT_LIST_HEAD(&plug->cb_list);
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..87d94be7825a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -969,7 +969,6 @@ struct blk_plug {
 
 	bool multiple_queues;
 	bool has_elevator;
-	bool nowait;
 
 	struct list_head cb_list; /* md requires an unplug callback */
 };
-- 
2.40.1

