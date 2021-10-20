Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F9DC433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A2C61372
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhJTUFn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJTUFm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 16:05:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA14C06161C;
        Wed, 20 Oct 2021 13:03:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m22so658339wrb.0;
        Wed, 20 Oct 2021 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1EZc8F3LGa37Y9tu7Tob6o+fpihU/+4iG2rIzfXu/A=;
        b=WbgNFPzpqQwP0xWC2uli9FeYZOhufR5CXwXu9ncgcBUanmWs0Ez75Z5+fFvqOG5bt/
         eJpYOZzGZ9tAkQgonvDFNrrYSFzu5esd6IyZyysSWI/h4WpmX6UDDLnVD27MjESegLuu
         3NmuuSKZhY4d0/i2CFq9mvSrdzwWkLm5oC1Z4KiE+qQJQqTx15w3dHHYmkE36FUHQzk1
         xvtbkRz63rAMB3yVc3yAWs5Exet7k2+Jg3/Yq1KtDHEytbGiJ9I/YC38HULEosaZ7ulB
         gxycBcHHjBN0VfIQQAIK58bdOyYVPQ/qXWa94VOYsXQyA7GqpxKeyeJJBA2Wvadnt4EG
         wXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1EZc8F3LGa37Y9tu7Tob6o+fpihU/+4iG2rIzfXu/A=;
        b=e0qyHPjpwerLclgaB5H0r/GDFU5w/lZstwKV45+9Sc97Tdl8Qbzhwh5ybNJxNKwZsH
         RfUOMSWOPjcjB+u5uzBLojL7Rd8gVcC+BcNKBz3DU3hpYvsc7bgXp7Le9eTGjd67EKIc
         TgCaYIIXqni780XKaPYF8Ysuh0RnznChVQbICjWXbi/+jjKE/dhBR/rbOxC3hvbmyeAS
         GhIl/6LW+kZ8QATiZeA3ymo1mQpA8R/Oiut2iz4SkgiYwue6GcAv+rHADidMc4Ge4Ils
         mnktY000np27A0KgNFW15ZmBQ51e08o/FO5mAgcGpxdOESpiSxdWR5q0UbzC79kcroUg
         sn4A==
X-Gm-Message-State: AOAM533BWpJjVHPw5DfWCnG9OuvCK/CA8km2c/akaI79NJGy+pG/+xIb
        1Nrp0GkXhwm5zoVbkRD+cw2RtXncPuLEfA==
X-Google-Smtp-Source: ABdhPJyHaPBBNKhdLB85ZPk4rJy40dUZ0AZiN0c283LaQx4WPK7+fyH8BjtbhoxBpccA3tSED0163A==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr1557870wrq.415.1634760205953;
        Wed, 20 Oct 2021 13:03:25 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id m14sm3600119wms.25.2021.10.20.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:03:25 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/2] block: kill extra rcu lock/unlock in queue enter
Date:   Wed, 20 Oct 2021 21:03:19 +0100
Message-Id: <159884e23f494a4b658c9cb66e36900c3c5800f5.1634759754.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634759754.git.asml.silence@gmail.com>
References: <cover.1634759754.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_try_enter_queue() already takes rcu_read_lock/unlock, so we can
avoid the second pair in percpu_ref_tryget_live(), use a newly added
percpu_ref_tryget_live_rcu().

As rcu_read_lock/unlock imply barrier()s, it's pretty noticeable,
especially for for !CONFIG_PREEMPT_RCU (default for some distributions),
where __rcu_read_lock/unlock() are not inlined.

3.20%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
3.05%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock

2.52%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
2.28%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 88752e51d2b6..20e76aeb50f5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -389,7 +389,7 @@ EXPORT_SYMBOL(blk_cleanup_queue);
 static bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
 	rcu_read_lock();
-	if (!percpu_ref_tryget_live(&q->q_usage_counter))
+	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
 		goto fail;
 
 	/*
-- 
2.33.1

