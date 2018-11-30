Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6268C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1792146F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CybVR32+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1792146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeLAEHV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34234 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeLAEHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:21 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so2413199itd.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=78SuIHvJEGe4HNzKE6mphC3LsuN6oQSJbZlJ28AUFt4=;
        b=CybVR32+jarjJ76TPU/bO9CZh6/NEIOw504HgVXYL9vCvsOON6+ZEirHjPBmf6QLpA
         LlDMypoqqsx7t66NpCwcNR6Gs++5nv/R9tITUIT6sY9vEqUi66ulxuMNlbrc0nLDeN06
         0islDq9NWRGbIbyKGRKzqOrkZFGWmjkOhA8kUnMjmXT91tts0+2Rss1WuCJ5pa3WmdwT
         afoqaAFQpyfksFrkEx7ebXP/UctwGkl4hrNoGadaRNjcHJuqNryzUv53jfB9P+e7zhK+
         1l7Itv23/zbquTD9ukbpxF+Vbx9akkAN02BfFJFncgzo4iETOuTxWjHit/xSgiCp5duU
         f0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=78SuIHvJEGe4HNzKE6mphC3LsuN6oQSJbZlJ28AUFt4=;
        b=HDmWUX58Jjyhd9HLNqMKXB/gEusLqZuA0Kq6Mnp2VIGsyq0GN33wPCPavUdtzdHWs2
         O/ce/IDME1BTmpsZkS1Vvv0XaaBHiVSLOH1Cg365xI8TRGBKreJm+Wfgjk5Pg2d+pKnG
         4fVthcNlpBSPdepfp6oPDYfrm3YW9EVC+8DsJJwu+yZ0jlEu7DA1dYZ3gaqRWkpXT3OL
         eaclPgJzl7BHJkiGCG0otPE2gBHz7/wFDVEezdWr6g0YdoAEMvFYIlyx4yUBBAQTnhKz
         c4XUe6ftnj81OuxJJCKSKaOJlm5Am2nQZRI/CpiHtEuA+y6mcb1uAYU9eqCfsX/qXaG8
         e+1w==
X-Gm-Message-State: AA+aEWYOa5v05/OK2gu0N8z1WOSdxqETtNCa86pF+fd+N9S4MpGEhQLP
        4OqPCC14u0I/AX4g2M8QEmQOToR8J10=
X-Google-Smtp-Source: AFSGD/V5dWKOWJxvrGG9zXnr/xPm16NRoYiBRF3PbvhJS+lzC5P5Gb9ZAYpneogFNlSRcOEMATZzRQ==
X-Received: by 2002:a24:570a:: with SMTP id u10mr6010544ita.11.1543597044784;
        Fri, 30 Nov 2018 08:57:24 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/27] aio: batch aio_kiocb allocation
Date:   Fri, 30 Nov 2018 09:56:41 -0700
Message-Id: <20181130165646.27341-23-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the aio_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 341eb1b19319..426939f1dae9 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -230,6 +230,8 @@ struct aio_kiocb {
 	};
 };
 
+#define AIO_IOPOLL_BATCH	8
+
 struct aio_submit_state {
 	struct kioctx *ctx;
 
@@ -244,6 +246,13 @@ struct aio_submit_state {
 	struct list_head req_list;
 	unsigned int req_count;
 
+	/*
+	 * aio_kiocb alloc cache
+	 */
+	void *iocbs[AIO_IOPOLL_BATCH];
+	unsigned int free_iocbs;
+	unsigned int cur_iocb;
+
 	/*
 	 * File reference cache
 	 */
@@ -1102,11 +1111,32 @@ static void aio_iocb_init(struct kioctx *ctx, struct aio_kiocb *req)
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
  */
-static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
+static struct aio_kiocb *aio_get_req(struct kioctx *ctx,
+				     struct aio_submit_state *state)
 {
 	struct aio_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	if (!state)
+		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	else if (!state->free_iocbs) {
+		size_t size;
+
+		size = min_t(size_t, state->ios_left, ARRAY_SIZE(state->iocbs));
+		size = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, size,
+						state->iocbs);
+		if (size < 0)
+			return ERR_PTR(size);
+		else if (!size)
+			return ERR_PTR(-ENOMEM);
+		state->free_iocbs = size - 1;
+		state->cur_iocb = 1;
+		req = state->iocbs[0];
+	} else {
+		req = state->iocbs[state->cur_iocb];
+		state->free_iocbs--;
+		state->cur_iocb++;
+	}
+
 	if (req)
 		aio_iocb_init(ctx, req);
 
@@ -1347,8 +1377,6 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret < 0 || *i >= min_nr;
 }
 
-#define AIO_IOPOLL_BATCH	8
-
 /*
  * Process completed iocb iopoll entries, copying the result to userspace.
  */
@@ -2320,7 +2348,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EAGAIN;
 
 	ret = -EAGAIN;
-	req = aio_get_req(ctx);
+	req = aio_get_req(ctx, state);
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
@@ -2452,6 +2480,9 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
 	aio_file_put(state);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -2463,6 +2494,7 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

