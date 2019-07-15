Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E519FC7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9962171F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="fTbMGjhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfGOULd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:11:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44004 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbfGOULd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 16:11:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so8231908pgv.10
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bppF0imIlhYjcYfkQ8qzigS2WeXZqJaJnuaoOOwuuFA=;
        b=fTbMGjhZ5blJowGwm2MJxtZHweyY/0RlHfhgceJb25UGo+volUkTPCmWjzS03PBjyn
         kHfDbE8J4q9AzwOGORyrxIu4szA6P8Xk1bdbt2DiojhwuvacJ7PmNvTRc0tKv72Hqx2X
         075DecMI7HFpdHAAC+b7lPz52kOaw8zthuPhJ6Rpfts1CvxJCLLhDuFQmzsZAZ4pKjfe
         9MlmC2qa68Z36lwh9nEdU4u9qo1loAa9iFjYRGIU8A5hjDrMEGD6Dvh9Hu88S/nrbTEo
         PjdVQxTGakTQg0vRIz++tjF+muZtEq+IWWOm51EXG52TyeVrTGQUbTJwn8DzQuyBPTgf
         2rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bppF0imIlhYjcYfkQ8qzigS2WeXZqJaJnuaoOOwuuFA=;
        b=nvDud5wN3DB0Saf/t04W4EqdPBqmRJK2I4eHEMWwsuuC3IIKR9jdOTCKU1Z/KQnI/L
         fqsTD9f8q+Mmbv/mxSRvDczPRSC+C2ze4Z14H4b9IYmc54k+rINS4Rx61D0MwxFlCfdH
         GT63XdGMVA2yHkKs3notn/lbWsLseuWlYC2KgB3SGQj1OZXUCmJGVq53CW6wtRaJq9w4
         23+bOUOdjQ6JsSD6gSFlYGBlKALgLpR48uqLd36+UU/uH7QG5Ylq4JNEQo2Ppf2/dCIc
         UuRYIgkrR+bb6KNfJ5gDfqWkHgc1N2ZWhBFFZQqJNhIrDT1ymOGneBvHTEbw6G2ww95H
         w22Q==
X-Gm-Message-State: APjAAAXNGVRVPTe6fQspjgTNICA0GtOm+hFOqi5djj+g8xsoCyBMdtmv
        mig/88EsRtNynTrjVAT0y7Y=
X-Google-Smtp-Source: APXvYqy6gnNuaPgBbBSmZ4RVshldvtkrhOme8CwfUdtrtitIzHVWM7YkYEXuIr0v7qze0Eitc3gpSg==
X-Received: by 2002:a63:a41:: with SMTP id z1mr28773187pgk.290.1563221492268;
        Mon, 15 Jul 2019 13:11:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4caf])
        by smtp.gmail.com with ESMTPSA id h1sm24681888pfo.152.2019.07.15.13.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:11:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 3/4] rq-qos: use READ_ONCE/WRITE_ONCE for got_token
Date:   Mon, 15 Jul 2019 16:11:18 -0400
Message-Id: <20190715201120.72749-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190715201120.72749-1-josef@toxicpanda.com>
References: <20190715201120.72749-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Oleg noticed that our checking of data.got_token is unsafe in the
cleanup case, and should really use a memory barrier.  Use the
READ_ONCE/WRITE_ONCE helpers on got_token so we can be sure we're always
safe.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 67a0a4c07060..f4aa7b818cf5 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -201,7 +201,7 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 	if (!data->cb(data->rqw, data->private_data))
 		return -1;
 
-	data->got_token = true;
+	WRITE_ONCE(data->got_token, true);
 	list_del_init(&curr->entry);
 	wake_up_process(data->task);
 	return 1;
@@ -246,7 +246,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
 	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
 	do {
-		if (data.got_token)
+		if (READ_ONCE(data.got_token))
 			break;
 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
 			finish_wait(&rqw->wait, &data.wq);
@@ -256,7 +256,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			 * which means we now have two. Put our local token
 			 * and wake anyone else potentially waiting for one.
 			 */
-			if (data.got_token)
+			if (READ_ONCE(data.got_token))
 				cleanup_cb(rqw, private_data);
 			break;
 		}
-- 
2.17.1

