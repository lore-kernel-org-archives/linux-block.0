Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BDC433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Mar 2022 21:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiCDV1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiCDV1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 16:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC21F5F27C
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646429188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=u3JizttDnirlW0fMUt56CDfPU64YbUD435+Bb5JoywE=;
        b=aYX2DRP9fUTvbb9jRaFduUxwbpPhhfNrTUkgqdxhHoY4AtfKTm0WHEB9pM/NtE4rm0Rdee
        fQWbHFo2OzKM4wnXbIuRsO7TQxlEYDkc1Iur5sfZ04r38su6CQxAKkWqs0aCXfFgaovhyI
        FU0Yf+mX2IbOwfbAq3IvRxBF6yZyoVg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-KuHcVKB2MSm1n3CsCyXe4g-1; Fri, 04 Mar 2022 16:26:27 -0500
X-MC-Unique: KuHcVKB2MSm1n3CsCyXe4g-1
Received: by mail-qk1-f199.google.com with SMTP id t10-20020a37aa0a000000b00605b9764f71so6538138qke.22
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 13:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u3JizttDnirlW0fMUt56CDfPU64YbUD435+Bb5JoywE=;
        b=yEWhJwXSvK0jr+K4g7dtKfJ/lArczG6RduEXcgi9ET5h63+NlDch7BNvpzgxSrBVfl
         L8AuzuXD3HgDFRrkjJ2nLmreimprFq8KLqkIVTsvFYOvHKqR2srLDMkAUqZAN2CNeaVC
         GvVPa5KmW/XToQyV1T8PuX+2Oh1tcIl5blD1THFN7d0kkSr1s5QoJgC5UvrKJ7PMqoOd
         FhSsXn03OXr1PxSD2X/Sjncbj79thzBJOligbRFaxWqUnw3jLEHhfMeewceckq3fB8/f
         sZkAyQXz/c78ECWCoW9FnE1OzZ7DW+8xGFfuuKA900CgL6ur+qUyxfrDYH4CRp7DlxUK
         RXIw==
X-Gm-Message-State: AOAM530msl4srYqp2LkB93VwQdQudQ5sOtp6mOuashWlTcuTNvzVvJXF
        SYfT6kl2WNmif4T+EB/aFJ5mBgJnF61gFed5tDTl9HXODBJWGSWS2k5Is/wNRKdtTuaQ5NNE2gq
        gnQV24xdJ7bx8K+kcTYN38w==
X-Received: by 2002:a05:622a:48f:b0:2dd:b41a:e206 with SMTP id p15-20020a05622a048f00b002ddb41ae206mr666416qtx.274.1646429186684;
        Fri, 04 Mar 2022 13:26:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqW5GCMKvuqgxUxRYl6ae7o3MM/vyX88ha2no7fzevAHX+A2WiT26fh9A3P4zHYp3OiTR69A==
X-Received: by 2002:a05:622a:48f:b0:2dd:b41a:e206 with SMTP id p15-20020a05622a048f00b002ddb41ae206mr666398qtx.274.1646429186469;
        Fri, 04 Mar 2022 13:26:26 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s19-20020ac85cd3000000b002de4e165ae0sm3977166qta.75.2022.03.04.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:26:25 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v4 1/2] block: add ->poll_bio to block_device_operations
Date:   Fri,  4 Mar 2022 16:26:22 -0500
Message-Id: <20220304212623.34016-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220304212623.34016-1-snitzer@redhat.com>
References: <20220304212623.34016-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Prepare for supporting IO polling for bio based driver.

Add ->poll_bio callback so that bio driver can provide their own logic
for polling bio.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-core.c       | 12 +++++++++---
 block/genhd.c          |  2 ++
 include/linux/blkdev.h |  2 ++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 94bf37f8e61d..e739c6264331 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -985,10 +985,16 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 
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
+		else
+			ret = !WARN_ON_ONCE(1);
+	}
 	blk_queue_exit(q);
 	return ret;
 }
diff --git a/block/genhd.c b/block/genhd.c
index e351fac41bf2..eb43fa63ba47 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -410,6 +410,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	struct device *ddev = disk_to_dev(disk);
 	int ret;
 
+	WARN_ON_ONCE(queue_is_mq(disk->queue) && disk->fops->poll_bio);
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

