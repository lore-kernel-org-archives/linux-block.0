Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D4C74A36
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 19:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB28120645
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 19:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="mbcEIb07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfGJTwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:52:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42839 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJTwb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 15:52:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so2894727qkm.9
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=7LrlK+yNNAjChYy/KKDWPKU1AjfJ6+kVoZtH7HVXgDk=;
        b=mbcEIb07lqT+Z3l0i7Q6mn7bsmxOkVz5EIr4O7is29m/Z9VmB8Lwt2qzOiG59dHNx5
         CAqIC/UQjbm1xjptJif+P4Gul1WL9gab/L+V9jpBrOvNY8Gct3CEhCS6kSYMvq2oYWp+
         yjwL1jRAlMvuUOnD1Z2jMpWoobCQwipkoDBrFptMDxdj27XFsG9UBPv4sOGwhryGArV+
         /10YrTZqTni+LzVKfKw9cgWK96dUpRQYlWDAs1+pJgvYghcY8ed060idj1Nfuz5KNPox
         ZVcoPTpEYlvrK0bqJHjp6qVW+2YGQrvJwV7BQdg8nhPJxwL8LXwGWOIWZqdGc0MeccJ5
         NETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=7LrlK+yNNAjChYy/KKDWPKU1AjfJ6+kVoZtH7HVXgDk=;
        b=Gx4G/1OENlSjBF7AFLuuIoWGZVfgQA1sfRG+ute3XnBDETHK4qa2n6xktSJ44kK6/B
         fBHyZfCr+oBLpMl9v5jXDuKKjOGkwiO59FVSn4gdERkhI6wdTWthE4mOBtMAdPJc8JOQ
         VsO9C3OSUsj3hB4yO2mxTsiOQH3oJaazrL8RxTGosKeOl6EGMrqu/MJtN1QU45A5dFMI
         wSED3yM2a7OsAeJtQWsmA7OXyVoBSVn551SQEGrcc54jkNKp9G7FcqY+SvTAqnSJAZ95
         +2NOtqeGtGOAQp1IGAD1XqWZyhTTf5w2ZRdyRCj+GAmddNjbvEKozjzpjekWnU2EKG8E
         iN9g==
X-Gm-Message-State: APjAAAU+8wTeUmIp0nbyBzv+Jlx59BgZ867phmsNT+5XSYqk1DccsD+X
        Q+MJvjaI+W4b6uwthYncgWaDEhR0s7DIJg==
X-Google-Smtp-Source: APXvYqzrX5Mu1F+rJEn/mze6e18ppOiP76Z8WHG3lMMHqzs63hTFSa9n5x3JOorwaVTHB5e/gE1Qww==
X-Received: by 2002:a37:9d13:: with SMTP id g19mr19799619qke.124.1562788349890;
        Wed, 10 Jul 2019 12:52:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5ce])
        by smtp.gmail.com with ESMTPSA id f133sm1554254qke.62.2019.07.10.12.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:52:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Date:   Wed, 10 Jul 2019 15:52:26 -0400
Message-Id: <20190710195227.92322-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rq-qos sits in the io path so we want to take locks as sparingly as
possible.  To accomplish this we try not to take the waitqueue head lock
unless we are sure we need to go to sleep, and we have an optimization
to make sure that we don't starve out existing waiters.  Since we check
if there are existing waiters locklessly we need to be able to update
our view of the waitqueue list after we've added ourselves to the
waitqueue.  Accomplish this by adding this helper to see if there are
more than two waiters on the waitqueue.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/wait.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index b6f77cf60dd7..89c41a7b3046 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -126,6 +126,27 @@ static inline int waitqueue_active(struct wait_queue_head *wq_head)
 	return !list_empty(&wq_head->head);
 }
 
+/**
+ * wq_has_multiple_sleepers - check if there are multiple waiting prcesses
+ * @wq_head: wait queue head
+ *
+ * Returns true of wq_head has multiple waiting processes.
+ *
+ * Please refer to the comment for waitqueue_active.
+ */
+static inline bool wq_has_multiple_sleepers(struct wait_queue_head *wq_head)
+{
+	/*
+	 * We need to be sure we are in sync with the
+	 * add_wait_queue modifications to the wait queue.
+	 *
+	 * This memory barrier should be paired with one on the
+	 * waiting side.
+	 */
+	smp_mb();
+	return !list_is_singular(&wq_head->head);
+}
+
 /**
  * wq_has_sleeper - check if there are any waiting processes
  * @wq_head: wait queue head
-- 
2.17.1

