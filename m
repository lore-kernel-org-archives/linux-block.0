Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4660BC433EF
	for <linux-block@archiver.kernel.org>; Sat,  5 Mar 2022 02:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiCECI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 21:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCECI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 21:08:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AA553B2A6
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 18:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646446089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kVWmWgbDLTD3/ZaHC1HftVSSj9oMx7XhGSZ/C09Jmt4=;
        b=ReidpdW6S29R+uyv4h1526HR2piJk+UwQ/q8pi/JVnTQg632KiCKNsPnWHH3B2ea0KXgO/
        KRtect9W3f7I+gAdeQt6gayNM3binWfsB7aPuvzMOAX+mLkA4Dx+KhDUHHtMfeQ3eqZha+
        Ab9rSI022jWg4z6LERZ82gB1s+PwWKU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-4WW1F922NDenqu6rQSYGuA-1; Fri, 04 Mar 2022 21:08:08 -0500
X-MC-Unique: 4WW1F922NDenqu6rQSYGuA-1
Received: by mail-qt1-f200.google.com with SMTP id 12-20020ac8590c000000b002e05c408284so142719qty.22
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 18:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVWmWgbDLTD3/ZaHC1HftVSSj9oMx7XhGSZ/C09Jmt4=;
        b=6Ct/rNH7PYFxbEzFEWccl0wj3pi1GU/s88PtR/8zjH1BJhbAo4xvAmcQ2FXpShCfPw
         v9icHeu9iH0Xd8fhyG+LR00IyxupgkbpdcmUWArC22a0RcInVZ+FKVNJZxUSeSvkbrCr
         lqhwjzBGOrfPRdP0VUmYt+9P6eGo/shhp9IQMqguqIRwHbbn3qZ82QFxLiGIX9POUdfi
         YAyC32R8frpikQjUvdOavnFZPoSQxsQb1LGnEp/nR0/xLXdEjA3sa/CQlBn9d8bAmlsJ
         rahjA9emchhy0Wmc9LwkOI+LPrUz1May+bLbY+EzuINBlXiYB6BHL5acmISYBcU5WgDF
         p+/w==
X-Gm-Message-State: AOAM530zX2UcAMxv9cEwWeEuNYo58kNOWN2uZpbuHLaYl7eS75O08CRe
        8VbEtkXk9PBkvqhWOcLOpvtviER3EEOD2HDRSofp0ZeyHahBKXNMig9zQQrpKqOoC+SkZdsdtWM
        qzSPpR355hEqssig0uh73rw==
X-Received: by 2002:a05:622a:246:b0:2de:8d73:dd0f with SMTP id c6-20020a05622a024600b002de8d73dd0fmr1391667qtx.650.1646446088002;
        Fri, 04 Mar 2022 18:08:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyr2VaGp9pPfltICqCfX6F+ZJRP2Non3wbaYp1PLuwyJwHknB3GBJo2GW5pQUlbApKqmIl1qw==
X-Received: by 2002:a05:622a:246:b0:2de:8d73:dd0f with SMTP id c6-20020a05622a024600b002de8d73dd0fmr1391652qtx.650.1646446087760;
        Fri, 04 Mar 2022 18:08:07 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8068e000000b002dd1bc00eadsm4006757qth.93.2022.03.04.18.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:08:07 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v5 1/2] block: add ->poll_bio to block_device_operations
Date:   Fri,  4 Mar 2022 21:08:03 -0500
Message-Id: <20220305020804.54010-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220305020804.54010-1-snitzer@redhat.com>
References: <20220305020804.54010-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Prepare for supporting IO polling for bio-based driver.

Add ->poll_bio callback so that bio-based driver can provide their own
logic for polling bio.

Also fix ->submit_bio_bio typo in comment block above
__submit_bio_noacct.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-core.c       | 14 +++++++++-----
 block/genhd.c          |  4 ++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 94bf37f8e61d..ce08f0aa9dfc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -708,7 +708,7 @@ static void __submit_bio(struct bio *bio)
  *
  * bio_list_on_stack[0] contains bios submitted by the current ->submit_bio.
  * bio_list_on_stack[1] contains bios that were submitted before the current
- *	->submit_bio_bio, but that haven't been processed yet.
+ *	->submit_bio, but that haven't been processed yet.
  */
 static void __submit_bio_noacct(struct bio *bio)
 {
@@ -975,7 +975,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
-	int ret;
+	int ret = 0;
 
 	if (cookie == BLK_QC_T_NONE ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
@@ -985,10 +985,14 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 
 	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
 		return 0;
-	if (WARN_ON_ONCE(!queue_is_mq(q)))
-		ret = 0;	/* not yet implemented, should not happen */
-	else
+	if (queue_is_mq(q)) {
 		ret = blk_mq_poll(q, cookie, iob, flags);
+	} else {
+		struct gendisk *disk = q->disk;
+
+		if (disk && disk->fops->poll_bio)
+			ret = disk->fops->poll_bio(bio, iob, flags);
+	}
 	blk_queue_exit(q);
 	return ret;
 }
diff --git a/block/genhd.c b/block/genhd.c
index e351fac41bf2..1ed46a6f94f5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -410,6 +410,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	struct device *ddev = disk_to_dev(disk);
 	int ret;
 
+	/* Only makes sense for bio-based to set ->poll_bio */
+	if (queue_is_mq(disk->queue) && disk->fops->poll_bio)
+		return -EINVAL;
+
 	/*
 	 * The disk queue should now be all set with enough information about
 	 * the device for the elevator code to pick an adequate default
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f757f9c2871f..51f1b1ddbed2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1455,6 +1455,8 @@ enum blk_unique_id {
 
 struct block_device_operations {
 	void (*submit_bio)(struct bio *bio);
+	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
+			unsigned int flags);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
-- 
2.15.0

