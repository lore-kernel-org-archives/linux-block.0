Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD25C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B981121928
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mtD/qTCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391683AbeLUTXH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36818 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391681AbeLUTXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:05 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so8041697itj.1
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GSREJtBuAvhbTUjN/u5HzyiIS3quP1BHw3BKuwPJKYo=;
        b=mtD/qTCORbaJYIkv8fNODte+zOgsfMoylz4xbuC7ty4hBKQLHkOAFoXu69NMn0YR/1
         eg8WN4iMOF9c6PKYSRXBQCKeFe8bix7YfniBx3nabhB0VgZg82EUYqmCfzDhWaMQ4sA8
         FJcV8cBFfGQeD4zGIqR+Qo5/R1zJn7FoHl962nPuxZwuq7vKTlDYQSkS3LhDp/Aeabxx
         2iyRtV2XF7QjifMHxWStF1Sqm0K17QN4LvdgSPDBXzRo5+PaDJy6zY5VF77yDt5Z7lmf
         u1solArB3XPkHt15Pn5LGPSomVEE27Iict3NEQiOFGwtvhK2EZcugDIcIZ/MOHyqMW7U
         QrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GSREJtBuAvhbTUjN/u5HzyiIS3quP1BHw3BKuwPJKYo=;
        b=nvD8SssplSX+Oa2ApMtmj7fX0qYopdVKDBIiWyJUbSwiS7C5Gha7Jz/jo56ab3KOiF
         8e5tqfTuTMWAPqU3XpRLQiYcsnRabU+0hTHYWtXzJQGtC/BTekjx7F/54TXu83w7ZwCL
         TlPnwsQarwDshudp1E05hUKXJ/382wu3NoFKajUqGgQn9Kd33Cujq9+JuWpAoXcJ2G4K
         lwsaZYEadZ4vftkYg/wVzirTeDIerRLj+qgTC3ZQ27hnfEkxJDARjyRwNGLcC+QqWnXT
         TGTkInT0aUIdbLuYCwEqA5oUIp6qLBH53EzAnQGQSRSNr1PWTe5ILfEUyQIrRMVkMvko
         PSuA==
X-Gm-Message-State: AJcUukei3iT8HqB2MfkrfCAPV3/y2hlRgwla2/QpFo6raAbMbgZlHztC
        JL5SA8ps+A/w7OsgFIRUfPPYfZ4V8jIzwQ==
X-Google-Smtp-Source: ALg8bN4+icP+kWC2EohTn7mr62b0McPodIWbdv3yGDNNNgdN21zAlZxMdbm66TTEI20aBEy20hdcPg==
X-Received: by 2002:a24:9b89:: with SMTP id o131mr944921itd.41.1545420184311;
        Fri, 21 Dec 2018 11:23:04 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/22] aio: pass in user index to __io_submit_one()
Date:   Fri, 21 Dec 2018 12:22:29 -0700
Message-Id: <20181221192236.12866-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is used for the user iocb pointer right now, but in preparation
for having iocbs not reside in userspace, unionize with a ki_index
and pass that in instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index d33417bee594..9e9b49fe9a8b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -209,7 +209,11 @@ struct aio_kiocb {
 	struct kioctx		*ki_ctx;
 	kiocb_cancel_fn		*ki_cancel;
 
-	struct iocb __user	*ki_user_iocb;	/* user's aiocb */
+	union {
+		struct iocb __user	*ki_user_iocb;	/* user's aiocb */
+		unsigned long		ki_index;
+	};
+
 	__u64			ki_user_data;	/* user's data for completion */
 
 	struct list_head	ki_list;	/* the aio core uses this
@@ -1192,7 +1196,7 @@ static void iocb_put_many(struct kioctx *ctx, void **iocbs, int *nr)
 static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 			   long res, long res2)
 {
-	ev->obj = (u64)(unsigned long)iocb->ki_user_iocb;
+	ev->obj = iocb->ki_index;
 	ev->data = iocb->ki_user_data;
 	ev->res = res;
 	ev->res2 = res2;
@@ -2299,7 +2303,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb,
+			   unsigned long ki_index,
 			   struct aio_submit_state *state, bool compat)
 {
 	struct aio_kiocb *req;
@@ -2346,14 +2350,17 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	}
 
 	if (aio_ctx_supports_cancel(ctx)) {
+		struct iocb __user *user_iocb = (struct iocb __user *) ki_index;
+
 		ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
 		if (unlikely(ret)) {
 			pr_debug("EFAULT: aio_key\n");
 			goto out_put_req;
 		}
-	}
+		req->ki_user_iocb = user_iocb;
+	} else
+		req->ki_index = ki_index;
 
-	req->ki_user_iocb = user_iocb;
 	req->ki_user_data = iocb->aio_data;
 
 	ret = -EINVAL;
@@ -2419,12 +2426,13 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct aio_submit_state *state, bool compat)
 {
+	unsigned long ki_index = (unsigned long) user_iocb;
 	struct iocb iocb;
 
 	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 		return -EFAULT;
 
-	return __io_submit_one(ctx, &iocb, user_iocb, state, compat);
+	return __io_submit_one(ctx, &iocb, ki_index, state, compat);
 }
 
 #ifdef CONFIG_BLOCK
-- 
2.17.1

