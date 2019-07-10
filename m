Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58625C74A3C
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 19:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2573F2087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="T1AbzOdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfGJTFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:05:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35147 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfGJTFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 15:05:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so2807905qke.2
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=M3ayD2hVBHLZkT6zKh8ThN0a45uWqaYleKmqMJEURb0=;
        b=T1AbzOdWPx36MIw2csPs4FNvQrxOcVVVd791SXEgS+dEvWWJ70Xb7G8jcMgtc0rjMh
         p8qtitbBOy+I0TpnXjLbtB13guUa/2tFZjwOIPQEl6yYNI6E2GdogGsd9434pLJvP2S7
         gjfc6/t7EyMZuHaNAE3yI6SC439Zw6SFM5M7Nj+BYJfpZobzD4VbnN3KhwOwHkEnjK+C
         mElWCE2uTQBxv/t19fxE8+wtlEAt+e66Y73dWXOV+mXwotyXfT8fnmkB2cDLvslImgGH
         QfKEHvvHBVuBZdCUAgrlaQ2x7N9WzcwQUCmaOd7qfdjrZ5eiFlBr0NMjXhV5XaWeW31G
         G2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=M3ayD2hVBHLZkT6zKh8ThN0a45uWqaYleKmqMJEURb0=;
        b=ujD9vtNM8QNk5yQK5ii1FVZfkgsZO4KAAnKDnbFhSvrIKAe8j+dfOlt5Ta6bh4BCc4
         o7B9RYs9BkJhH43mX8srhSn0UbxZaTLU+6VUyz8C8Lodxj0x2TQsW4xiL8kkb9FRKuWM
         Sa3kqQhtlQ2XLSqOB6nng68otqAFdeN9uGWSfjWIPRDzssFcoElVDUg6S4tYwcekYTZc
         coT0oH2zZI+RTj6asdjBM1B1esGwrlJpvSzgPV4brgDno9RKYmgKc8lT9j4fsYkrwC2T
         QV0hp0Q22RkwqPq6zaOUk6jwC7n6QTdrRX78uxD4l/M67neO1SPOKjpYbsix/LczNbFq
         HrEw==
X-Gm-Message-State: APjAAAWDHESo6Oi16oLFISfiD/m+SLZjfUvx2WfPFKD895J82yfo24am
        +jfrhqOEl43PShurY3zpSOtfOA==
X-Google-Smtp-Source: APXvYqwP0wWEgakSqeygObThhBiApbOJVknyqiheUu+ptpVSNiagEf9/8Ss0m6kFSC6WLF77+VCmOg==
X-Received: by 2002:a05:620a:685:: with SMTP id f5mr20063045qkh.238.1562785516064;
        Wed, 10 Jul 2019 12:05:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5ce])
        by smtp.gmail.com with ESMTPSA id z18sm1409751qki.110.2019.07.10.12.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:05:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] rq-qos: fix missed wake-ups in rq_qos_throttle
Date:   Wed, 10 Jul 2019 15:05:14 -0400
Message-Id: <20190710190514.86911-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We saw a hang in production with WBT where there was only one waiter in
the throttle path and no outstanding IO.  This is because of the
has_sleepers optimization that is used to make sure we don't steal an
inflight counter for new submitters when there are people already on the
list.

We can race with our check to see if the waitqueue has any waiters (this
is done locklessly) and the time we actually add ourselves to the
waitqueue.  If this happens we'll go to sleep and never be woken up
because nobody is doing IO to wake us up.

Fix this by open coding prepare_to_wait_exclusive (yes, yes, I know) in
order to get a real value for has_sleepers.  This way we keep our
optimization in place and avoid hanging forever if there are no longer
any waiters on the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 659ccb8b693f..04590666f7c4 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -237,13 +237,18 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		.cb = acquire_inflight_cb,
 		.private_data = private_data,
 	};
+	unsigned long flags;
 	bool has_sleeper;
 
 	has_sleeper = wq_has_sleeper(&rqw->wait);
 	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
 		return;
 
-	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
+	spin_lock_irqsave(&rqw->wait.lock, flags);
+	has_sleeper = !list_empty(&rqw->wait.head);
+	__add_wait_queue_entry_tail_exclusive(&rqw->wait, &data.wq);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	spin_unlock_irqrestore(&rqw->wait.lock, flags);
 	do {
 		if (data.got_token)
 			break;
-- 
2.17.1

