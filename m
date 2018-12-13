Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6F2C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB8220851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TYCXvBP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB8220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeLMR52 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52728 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeLMR51 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:27 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so4987606itg.2
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RpRLIkS/GSyyVMAQBGyyudrshJ9VbZFY2XJOsbDfsqQ=;
        b=TYCXvBP+eZFima9PaUN7PZd3pWeVlZy0ToMWNVkLOLDxL7iC/5oabcIZqITJXMb6TC
         NsdMv4dXSHed0FHleSe++zr3Ge2MoiRvPfZUJQXHL5GR25/8RMOyzX3Th1fGErwL6i7v
         uHXPfnWUHD18iKYy4HQrKgPvDrDp6kOoB2tlwnaFtA7bGV1ra0vrIOz2LFlLifXk4tp0
         D+n6rzaDO/yJ9+rgkw06ZMGi8TD6exKymAo6M/TdGJjdqtZd2JUzzeF4EyP80On79Lv7
         W72L7GI+SE073cppYTO3bGpe1cdWt0l4YWTCEKu/ziWLsRUn+4yjdwJQJFQXXxz5Gxt3
         YFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RpRLIkS/GSyyVMAQBGyyudrshJ9VbZFY2XJOsbDfsqQ=;
        b=BwUn7raeFkvl6WpHDPH9IUKsSIfQGCfuA+e6nTlPX1oIQptrzii5ft+YQvXAEhX3VX
         x7kV8xhXPyi7toZRhKdBfPlsY0lDpdyOS04WwoIu54jJ+pVH+XOqZBPd8KgcdNEuXsYW
         lkhl1RKHKrujC9pE0bOJXO3Mnnt3xIGouCsYC/TzBhbxfdR88CFvKltm9o4kaC2H+Cyb
         1c4jIF7VYU91pgQ+9RCk8JFb5UYdP3OLR/X/vLFbxBQWosnto1D6TW3COJsJE+P3l9qW
         oCY3eLiqDAeWvNulNpLVoS9WU0N4RRg+QaASlLFMJERIEptnV49zYDdfLPYo/z+M4yhA
         dXxg==
X-Gm-Message-State: AA+aEWaLubOcC2Bb4CQvG55c/7u7Tz9kxSoEUxAQ+uRjTKoqo6i78Uga
        jILs8ZEx9tEeDWRI8CDrtK5rL5Du0E/ABA==
X-Google-Smtp-Source: AFSGD/XRIOXxSJcN5fkxfi85glEqP4PiSgn651rzD9o0zML/OCryolTEH88EIV8qKHlulnanlsj6Hg==
X-Received: by 2002:a24:2208:: with SMTP id o8mr281790ito.23.1544723846571;
        Thu, 13 Dec 2018 09:57:26 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/26] aio: batch aio_kiocb allocation
Date:   Thu, 13 Dec 2018 10:56:38 -0700
Message-Id: <20181213175645.22181-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the aio_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b6dfc4e9af47..7a3986c6cc1b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -233,6 +233,8 @@ struct aio_kiocb {
 	};
 };
 
+#define AIO_IOPOLL_BATCH	8
+
 struct aio_submit_state {
 	struct kioctx *ctx;
 
@@ -247,6 +249,13 @@ struct aio_submit_state {
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
@@ -1111,15 +1120,34 @@ static void aio_iocb_init(struct kioctx *ctx, struct aio_kiocb *req)
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
  */
-static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
+static struct aio_kiocb *aio_get_req(struct kioctx *ctx,
+				     struct aio_submit_state *state)
 {
 	struct aio_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (unlikely(!req))
-		return NULL;
+	if (!state)
+		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	else if (!state->free_iocbs) {
+		size_t size;
+		int ret;
+
+		size = min_t(size_t, state->ios_left, ARRAY_SIZE(state->iocbs));
+		ret = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, size,
+						state->iocbs);
+		if (ret <= 0)
+			return ERR_PTR(-ENOMEM);
+		state->free_iocbs = ret - 1;
+		state->cur_iocb = 1;
+		req = state->iocbs[0];
+	} else {
+		req = state->iocbs[state->cur_iocb];
+		state->free_iocbs--;
+		state->cur_iocb++;
+	}
+
+	if (req)
+		aio_iocb_init(ctx, req);
 
-	aio_iocb_init(ctx, req);
 	return req;
 }
 
@@ -1357,8 +1385,6 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret < 0 || *i >= min_nr;
 }
 
-#define AIO_IOPOLL_BATCH	8
-
 /*
  * Process completed iocb iopoll entries, copying the result to userspace.
  */
@@ -2295,7 +2321,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EAGAIN;
 
 	ret = -EAGAIN;
-	req = aio_get_req(ctx);
+	req = aio_get_req(ctx, state);
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
@@ -2416,6 +2442,9 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
 	aio_file_put(state, NULL);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -2427,6 +2456,7 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

