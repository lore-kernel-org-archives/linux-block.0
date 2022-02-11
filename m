Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68636C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 09:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiBKJBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:01:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiBKJBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 04:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B59C101F
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 01:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644570103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MUJ3kp9XV1crkiRU1Q1VRzma3f38pwQD2oCOh9SbY8o=;
        b=Z/0Lc0VTas0KJCgpLazGew6CpEqe8UYcEbxAzCnAH+t5QEKi6IJ/pcsaD8IFomMsDBLrvE
        wcMRN35N7xlgEhTSSDNhGm+yDbIfcIY03d0P6iuU3UBA+RY0Y872jFYD05yOttv5tKEF1e
        RJXeZzifd9UrGF24hSn/JkCH3a0iMfs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-gBqfDK0PN1i8l3gINBHyMg-1; Fri, 11 Feb 2022 04:01:42 -0500
X-MC-Unique: gBqfDK0PN1i8l3gINBHyMg-1
Received: by mail-qv1-f70.google.com with SMTP id t5-20020a056214118500b0042c272ede45so5832275qvv.13
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 01:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUJ3kp9XV1crkiRU1Q1VRzma3f38pwQD2oCOh9SbY8o=;
        b=CyrHl3ve062ysiBg397pu4Uib41M12SZvzJkpztKm864gPyzf2AtheNdjfRz8qTmwg
         ZE/8NuBWdA1Z+I6t98NbfC04wt1XV6ZtdqajJ/oUaNT57Kf+mzGisBzfJXaupuQ8SuG6
         bYJ+RdZKwRUrJOyztqXxPhFwVoGbjPMe65H/qghEZH7vkXy1BnOStRWN5Oi21u2YgTLa
         dxm5Vudg9DXMD0i2+eijwGhAT8vG0yvwGcwMMd19KV92B/9rBt7qNvJlr5WD6G0Jv31l
         ZRgjhpdFdhWj1Y9X0f0iryV6G7EQc4ks01d+7EX/m2tgncqKR88qBOYPovkWKyNvr6va
         2ofQ==
X-Gm-Message-State: AOAM533OMNSS/QMRzxZIg4HLD3ke4IYSuTB/6soicA/7XCVg78sjKT8s
        8hTQ2QQswha6G+Gkpx0yjiXkDPZ9Lf9yjFpGgmfZ1pVzVb4sCAYqpkHs+CVXAEDpHOsoIJ1U1i8
        WF+31SXcvjb4uklSxMKKyLcU=
X-Received: by 2002:a05:620a:40cd:: with SMTP id g13mr235556qko.57.1644570101704;
        Fri, 11 Feb 2022 01:01:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyNuZXoU1YXd7dflX1tLfs7w8jGDkinb/+LSW7pW/yCk8l/jvZYRrAUOMjJt184Nuyt+EK0A==
X-Received: by 2002:a05:620a:40cd:: with SMTP id g13mr235544qko.57.1644570101489;
        Fri, 11 Feb 2022 01:01:41 -0800 (PST)
Received: from step1g3.redhat.com (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id p70sm10931673qka.62.2022.02.11.01.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:01:40 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: clear iocb->private in blkdev_bio_end_io_async()
Date:   Fri, 11 Feb 2022 10:01:36 +0100
Message-Id: <20220211090136.44471-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

iocb_bio_iopoll() expects iocb->private to be cleared before
releasing the bio.

We already do this in blkdev_bio_end_io(), but we forgot in the
recently added blkdev_bio_end_io_async().

Fixes: 54a88eb838d3 ("block: add single bio async direct IO helper")
Cc: asml.silence@gmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
I haven't seen a failure, I was just reading the code to understand iopoll,
so IIUC we should clean iocb->private in blkdev_bio_end_io_async().

Thanks,
Stefano
---
 block/fops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 4f59e0f5bf30..a18e7fbd97b8 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -289,6 +289,8 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 	struct kiocb *iocb = dio->iocb;
 	ssize_t ret;
 
+	WRITE_ONCE(iocb->private, NULL);
+
 	if (likely(!bio->bi_status)) {
 		ret = dio->size;
 		iocb->ki_pos += ret;
-- 
2.34.1

