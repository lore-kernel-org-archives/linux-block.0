Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77563C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 18:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbiCGS6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiCGS6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 13:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EAD192D2F
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646679427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2B5SMd3ysspU+OxmnlZrCO2H0toLWPZVLN6f+cgeOE8=;
        b=f87se5nZLhnpCkhDuCxQjZ9D182nJVTnQ/fQz/Vq/Es6zO1FIMsQmGF80Ds8YrqZFDQ/Zm
        X8XqHJH62QOkVH92CV2dkx2wM8DHu9fLSMxHJc9WId7+dhPG6tV+hJeYyWoC1Ez1RC3VHO
        0jNFArIn6jEzmzmqwMQ+xWeGpJVslm0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-nzw3BEeaNJyllGdIjm9wTQ-1; Mon, 07 Mar 2022 13:53:06 -0500
X-MC-Unique: nzw3BEeaNJyllGdIjm9wTQ-1
Received: by mail-qv1-f71.google.com with SMTP id a9-20020ad45c49000000b004352ae97476so12640316qva.13
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 10:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2B5SMd3ysspU+OxmnlZrCO2H0toLWPZVLN6f+cgeOE8=;
        b=hFKwQE6b3A/6QK6SqfKVEhSdN/sX9W7rneOjdobDMS4ia0nHs2iiQqujp60R/YBFH4
         jnUes/1NGHNa36AxPMiy2T/nTDcj0qySFhTh/WvOMdoNDNpPq3Ab/9gHX/2SGmQJmcMU
         qPif1MyOeCrICUzll+DT2ECIJemAesFY/CM87nSPdS1fmXtn7C2jrkPn0yy1xjAB0Bcl
         qAN/TIlFgxgr7pURThtteJLus8qY5OzU3EDI8u5AXLhrSVy6frgK34k4atfdyLMmrXL4
         gmP0aWIMn+a7uf1j+zcga/3mAlOdK6rCNHG8VjHN/neDELAXs5o1c47Yfw95Kap42s6N
         kOAg==
X-Gm-Message-State: AOAM530h5stopQFWreKrl7uTm4AhXhPDueOC3cW3zahI3r/RsAtX6ndH
        3wB9dac3yuhfRYF4gvdZkIOron+H8j/ynFdHsOeIUBmtN4trmm8qzwfDyLRR86PG/CW2hMi1IKm
        gMqaV9VCFNUarnmuI/hGUZg==
X-Received: by 2002:a05:620a:430b:b0:67b:13fa:c50e with SMTP id u11-20020a05620a430b00b0067b13fac50emr4945515qko.18.1646679186083;
        Mon, 07 Mar 2022 10:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkcWlcshZ/U52q1Ww7b4h8TdCYhTr+j3ZU6fcVu10IBVPZ+Eh+d9No/laKNH5+9bDdV6MNBA==
X-Received: by 2002:a05:620a:430b:b0:67b:13fa:c50e with SMTP id u11-20020a05620a430b00b0067b13fac50emr4945498qko.18.1646679185528;
        Mon, 07 Mar 2022 10:53:05 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002de4d014733sm9217609qtf.13.2022.03.07.10.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:53:05 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v6 1/2] block: add ->poll_bio to block_device_operations
Date:   Mon,  7 Mar 2022 13:53:02 -0500
Message-Id: <20220307185303.71201-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220307185303.71201-1-snitzer@redhat.com>
References: <20220307185303.71201-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Prepare for supporting IO polling for bio-based driver.

Add ->poll_bio callback so that bio-based driver can provide their own
logic for polling bio.

Also fix ->submit_bio_bio typo in comment block above
__submit_bio_noacct.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

