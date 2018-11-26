Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3ECC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A2120855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T8xXpaYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A2120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeK0Dan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:43 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34219 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Dam (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:42 -0500
Received: by mail-io1-f68.google.com with SMTP id f6so14453176iob.1
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XXvNiHPYXxX5XgSQnfFMNCnnoUcJikRAPxMVajab6f8=;
        b=T8xXpaYGpsx+hN5FjhoUjPJR5bpLgtCjq5JfGSWiWbEvxlvfUx3jCeCTqPSyxdmpmE
         L8ciU7325zjScr2g12Ek5ckh18vqnIFM/on6GtbmzScvMU4rUqHpg1CnioxJyPvancwT
         tz+MkqSUPo97xk7hDMyaiUYRnokXug2xgzyVabcatwplYWW1B4/vs9rukAs9c+RxEjlO
         cfRU7lPOdHc6KIw73WLEov4MOA5XfvUYkXY+rMw9tQdRXGy5i7u+HBMSPH6FFoMF+nEp
         DCPfio62/kpjHDX2d4bzWZyz7MbxBAgOeAmevytHd0yUxXrY3fDjyykZqMai7CKa+m4x
         m7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XXvNiHPYXxX5XgSQnfFMNCnnoUcJikRAPxMVajab6f8=;
        b=bSo77lx7ZVa7F2blwaC1dkz/GEnlZzlk2RmG9tf7Zi+VbBk0Md3f40LmEBmVr4yQgB
         mDK7AUCNhDu69n2oWcApxRC65wja0JoU3y8JDNk/0qwYbcSkjw8VlwleK8y62x8VtbII
         jfyItpXLKAzYLZzCgElHva16Pz5SRc6WwiFOTPsGPqJbm9G6IO9x1wWE0iQ/QERZWBkj
         L/fATj33yRT8fA1n1+CKtkxLFd0CJkm5sfUpkjh0mgcI8NXu5/IreQtKEkM48Sbw7sny
         rYoo7HP2UAgga1HUitTkJb0kDN4xoxSY+UW9kpYgZWMXjE+0Dn5+UayQxuxot7N33j4W
         CiPQ==
X-Gm-Message-State: AA+aEWY+FfmrYe0aTeMFs3RDYe7a6ob7IPyDTLpvdy3IbC1SMfDxWCfv
        A30sTg6xYutbq/qIgMGB6XUTlCaMw9s=
X-Google-Smtp-Source: AFSGD/XbUkapnAgNL5HAZiSvhTJ8m/NT2GBdkNlSJvNQhKjHIQSrp9lgXIlVY62Esopjm5fvPe+idA==
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr20651748ioh.294.1543250164682;
        Mon, 26 Nov 2018 08:36:04 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] block: improve logic around when to sort a plug list
Date:   Mon, 26 Nov 2018 09:35:50 -0700
Message-Id: <20181126163556.5181-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
case if we have requests for multiple devices in the plug.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 1 +
 block/blk-mq.c         | 7 +++++--
 include/linux/blkdev.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index be9233400314..c9758d185357 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
 	INIT_LIST_HEAD(&plug->mq_list);
 	INIT_LIST_HEAD(&plug->cb_list);
 	plug->rq_count = 0;
+	plug->do_sort = false;
 
 	/*
 	 * Store ordering should not be needed here, since a potential
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 99c66823d52f..6a249bf6ed00 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	list_splice_init(&plug->mq_list, &list);
 	plug->rq_count = 0;
 
-	list_sort(NULL, &list, plug_rq_cmp);
+	if (plug->do_sort)
+		list_sort(NULL, &list, plug_rq_cmp);
 
 	this_q = NULL;
 	this_hctx = NULL;
@@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 		plug->rq_count++;
+		plug->do_sort = true;
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
@@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			data.hctx = same_queue_rq->mq_hctx;
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
-		}
+		} else if (plug->rq_count > 1)
+			plug->do_sort = true;
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02732cae6080..b6d0b33feee7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1131,6 +1131,7 @@ struct blk_plug {
 	struct list_head mq_list; /* blk-mq requests */
 	struct list_head cb_list; /* md requires an unplug callback */
 	unsigned short rq_count;
+	bool do_sort;
 };
 #define BLK_MAX_REQUEST_COUNT 16
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
-- 
2.17.1

