Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB3C76192
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4920659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="rQjEeIi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfGPUTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:19:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39038 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPUTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 16:19:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so20978412qtu.6
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ZWvLpiy8LsbkNpgxUihtSHfUQdquxnVHPH9fwkxLy2U=;
        b=rQjEeIi3+bfHage+YBJh/Hl4NhqEclZqjhzRRdUWBzduXxbVOamfeXMfZ4+HpzkE5g
         vLBAQMwsghkmFvCvyWdcuRjRqEekqrh6bwXBRwtJO5cz5itSGTifrQK7aViKRavn85RZ
         62/nqxG+tgMsm18Y7Ialoupxwb+xXVZK32EX/eZL09yFCOHYDvwJA66DbQM7OfLxY6Bu
         +WsmXW06O7wgsuOfFbrXD44ILmxH1+wvqVcBryd8CyyJtCX2XgV6XB6VDmFjRIpeoXd3
         3Oaws/VeTyCLco1Sd3LFOabGp5l9or6xNT2K0yreMyS6QH7RH5Lmij+A4hKAtooGP2Nz
         X0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ZWvLpiy8LsbkNpgxUihtSHfUQdquxnVHPH9fwkxLy2U=;
        b=e1jnt9Pt/56h0jdi5Kz5bXrnWMEuclqwCBuElPQD5YhNwNg+I2EDfyAjnuaUkTpGmH
         IuKd2q1iA5Vkw8XojgjjNctlFTj/14K6SiBjUtCjs+QMeAz9ThVvrOiwY9aus2ELBgjc
         tiW3a++T8Mx/xEa/6dGVQW5V8y90iYZIL/0/iLn9dORn3cbc4OKisGNJiXDdexSRpDxa
         4GV3BATWvG2uid/eSnIpxnhsSjuQflQdpQB9V5uI1OaXd23vj8+TScgOIBCzpvmwVoxj
         psTGUj66oWVaifUAhrcJrVOa+v7J8FYjM0PSTMh68ul2h1SzAQbLQCUUPGepu2Ywx/eK
         QuOg==
X-Gm-Message-State: APjAAAU1Xz0suP7zqFJmfriaMR9qw+76vGJWnM/JwmLQeEYkotTDWSvQ
        athayBx2n3joKx5J/eyk0Jg=
X-Google-Smtp-Source: APXvYqwTXHy1G9KQCSKkWAoL3wLWOeIyHfWtkmdoI1getlh48C3Ypjb1f2yZmQXw54xF482q/rQDeg==
X-Received: by 2002:a0c:e001:: with SMTP id j1mr25989191qvk.110.1563308375432;
        Tue, 16 Jul 2019 13:19:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d7f3])
        by smtp.gmail.com with ESMTPSA id l19sm13326988qtb.6.2019.07.16.13.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:19:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 1/5] wait: add wq_has_single_sleeper helper
Date:   Tue, 16 Jul 2019 16:19:25 -0400
Message-Id: <20190716201929.79142-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190716201929.79142-1-josef@toxicpanda.com>
References: <20190716201929.79142-1-josef@toxicpanda.com>
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
waitqueue.  Accomplish this by adding this helper to see if there is
more than just ourselves on the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/wait.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index b6f77cf60dd7..30c515520fb2 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -126,6 +126,19 @@ static inline int waitqueue_active(struct wait_queue_head *wq_head)
 	return !list_empty(&wq_head->head);
 }
 
+/**
+ * wq_has_single_sleeper - check if there is only one sleeper
+ * @wq_head: wait queue head
+ *
+ * Returns true of wq_head has only one sleeper on the list.
+ *
+ * Please refer to the comment for waitqueue_active.
+ */
+static inline bool wq_has_single_sleeper(struct wait_queue_head *wq_head)
+{
+	return list_is_singular(&wq_head->head);
+}
+
 /**
  * wq_has_sleeper - check if there are any waiting processes
  * @wq_head: wait queue head
-- 
2.17.1

