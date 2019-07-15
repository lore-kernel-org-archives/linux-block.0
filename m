Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3983AC7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FC32171F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="sEHOuZwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfGOUL1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:11:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36719 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfGOUL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 16:11:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so8865066plt.3
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ZWvLpiy8LsbkNpgxUihtSHfUQdquxnVHPH9fwkxLy2U=;
        b=sEHOuZwJ+BIE4P1ZiXDV0TH7shHP117fYRKQpA5BigDI/0l8pSGUvBLBHvSg3SnJrH
         E8vygy29R4ETfHRbefwSVptD/vymZ1I6RiNrywBCkMlycvvDn8IcJga5V+jn0GSrMTFk
         QRotMxIwlVamTSmE1HbjMxBZ45Ye2nh6qZsSIANnTSOrwttE90DdRnaluUfZ6NHV8qrz
         6McH7qRWuUsUpcWB1kwD8EC/dJhtygH6AWR74MzdZywIRhvHzNj6uPuwif3OIPXPSf5g
         KnmA6LzPBsiikOl44CqcOO2qeNbC0CW3fqZS2EbVntOUnrtB7iKGFhkthHEsFcT5vm3m
         HxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ZWvLpiy8LsbkNpgxUihtSHfUQdquxnVHPH9fwkxLy2U=;
        b=j73cmgk/+6XdR1gV5n6mEdyoKHduWwTYO+CCqKRnsiv2ctkaiRmcnlX3ynZHlGfmK9
         f5QGNh62NpTaenaIvL76bbRCe8eqUwBInOlwqnvYeXEM6cmZJ2DqSBlqPwspozHwia+Q
         DTQRSLhuGDQe3g7H8g1KL0WEWHXxk1sZyHhlKI96/9ERUZUrxYafWZuu2pvNhiN5h4E/
         FX5PxomhYNiNlFIDJGkmJhC+P5TwSld/epMo1HnEm0TYao18m0r2NeJhRpKQs41hPDaa
         0tyyV8UBMS/eu0KczB6z43gSlTK4/6RLSwmDjtFDQYYNlyU6849g370/aMcmJUkDMUp1
         EuiQ==
X-Gm-Message-State: APjAAAVTKre2co7ZeoLUH6NhgW4q+0E0c24GnbuOjmMdJaNupHoHZhWC
        BOijiIKNzmaXfZ4ThXUEN2U=
X-Google-Smtp-Source: APXvYqwsAL3ErP2ILEO0DCMd1V6VC7J0kOlBY+GrN2v5wIUoSqYN9htNnvIaemXXeHDzUOPRxHUNcw==
X-Received: by 2002:a17:902:44e:: with SMTP id 72mr30311235ple.326.1563221486694;
        Mon, 15 Jul 2019 13:11:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4caf])
        by smtp.gmail.com with ESMTPSA id j13sm17302484pfh.13.2019.07.15.13.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:11:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 1/4] wait: add wq_has_single_sleeper helper
Date:   Mon, 15 Jul 2019 16:11:16 -0400
Message-Id: <20190715201120.72749-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190715201120.72749-1-josef@toxicpanda.com>
References: <20190715201120.72749-1-josef@toxicpanda.com>
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

