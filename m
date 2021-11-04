Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A6C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8238A611EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhKDSYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhKDSYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:24:47 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E3FC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:22:08 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bg25so9952542oib.1
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUVdiKdE3UtLDrSJ4ppTvX/REgJOcEw5TGAopy8ZtZU=;
        b=b1BJAdCEj6dG21jDoA7a0zw9fEykYkNP82YHbmI/x9hd1uvkJPdEnBv+2VAlFSdQLR
         Qd7kBU6A2pLDo2GfSY7WGuW8fG4AtzpU39TZC/RmdQNM5g+BdfTFcA44yVWh3XPgvyJp
         vYL6mOP1TGMrYFL8cE3wXIumZQ2+966hu6km0neDAmIwck89qlgqKkaPHSXDp7G3sEGb
         mudl0UkHVbk2euTLXbGSr5z5GzsIUwk6xjVpw8eK6bH1eO28txAjwGXvZPQRKofV4t9L
         e84XLn/+wo4gA/IizecZzfuPoQ6Tr428pQMMIuV52G1VgtrfLC8gpU0aWHJx7fX+T21V
         OcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUVdiKdE3UtLDrSJ4ppTvX/REgJOcEw5TGAopy8ZtZU=;
        b=IyDCFEbAdq+2j6ByKbJ1QDHl8UeNyfV0EbWKeqNRs+HC2idxlFUohAp6h592zZ00rY
         VXUnPDhGqbgAG47L6Y5Rywip5z1OKj8unZLeewSIWhzEr1jkquANtGwlGad4nOlUI72F
         FgtX8HG8/Y+8KELZ68mMSYkZqxBJK4rtCCbT+P2J/GGC/FZ+JngYx0UXpH5gMJBwPOgC
         SSDIFQ0oyPCj215OAydN+alBCVLAju0k6eqa2P4vkD24pFdptKB+g9jN+HA3NYPA1urA
         sC+o03P2348uWl5DEJq0OVNePOvm/2KXNl0hP9Vur8acxv17AZsITZ8TyUU1CEplvKd7
         HV7g==
X-Gm-Message-State: AOAM532UutJf1l3TU3OOUOqQ5l0UMst7LCzNNluxiDjV6tLNKcxxWnWk
        SWf3MgNxvUWWxFdslhBShIP4Rc+uO0utkQ==
X-Google-Smtp-Source: ABdhPJzAz6cdk0dnoos9/zg76frPvqbQhFvU+umzOy70maDAWS7YvbyKUFF3NdelHGbxfQU6XXIcmw==
X-Received: by 2002:a05:6808:1686:: with SMTP id bb6mr17856955oib.40.1636050127892;
        Thu, 04 Nov 2021 11:22:07 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s206sm1595445oia.33.2021.11.04.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:22:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: have plug stored requests hold references to the queue
Date:   Thu,  4 Nov 2021 12:21:57 -0600
Message-Id: <20211104182201.83906-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104182201.83906-1-axboe@kernel.dk>
References: <20211104182201.83906-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requests that were stored in the cache deliberately didn't hold an enter
reference to the queue, instead we grabbed one every time we pulled a
request out of there. That made for awkward logic on freeing the remainder
of the cached list, if needed, where we had to artificially raise the
queue usage count before each free.

Grab references up front for cached plug requests. That's safer, and also
more efficient.

Fixes: 47c122e35d7e ("block: pre-allocate requests if plug is started and is a batch")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fd389a16013c..c2d267b6f910 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1643,7 +1643,7 @@ void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 		flush_plug_callbacks(plug, from_schedule);
 	if (!rq_list_empty(plug->mq_list))
 		blk_mq_flush_plug_list(plug, from_schedule);
-	if (unlikely(!from_schedule && plug->cached_rq))
+	if (unlikely(!rq_list_empty(plug->cached_rq)))
 		blk_mq_free_plug_rqs(plug);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c68aa0a332e1..5498454c2164 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -410,7 +410,10 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		tag_mask &= ~(1UL << i);
 		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
 		rq_list_add(data->cached_rq, rq);
+		nr++;
 	}
+	/* caller already holds a reference, add for remainder */
+	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -= nr;
 
 	return rq_list_pop(data->cached_rq);
@@ -630,10 +633,8 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 {
 	struct request *rq;
 
-	while ((rq = rq_list_pop(&plug->cached_rq)) != NULL) {
-		percpu_ref_get(&rq->q->q_usage_counter);
+	while ((rq = rq_list_pop(&plug->cached_rq)) != NULL)
 		blk_mq_free_request(rq);
-	}
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.33.1

