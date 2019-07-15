Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA972C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815452171F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="XEf2gZju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfGOULg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:11:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbfGOULf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 16:11:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so1931100pgr.2
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=SJf4C6KejtjXuljRmpFGx9hGgMD/PzbLxtQzdurli00=;
        b=XEf2gZjuQsH1ka7bXG6EbQb9vscFZbQwJD1e5tErbkF2mj1opSw/jrqlb7VP9Z6vR/
         V7hfb+upbv2VoCdZc9VVvKpvPhU2/dtbcOthkuFgQ8/gCcSxUII2LzhngNa2WvCg+i8C
         qNxWD+U0UvQu3f1I0JXc0+BX4PcWwwAZ0USR6lsF1ZENnCgAqBte8ggCurdQ2jC5YarE
         XAgafgfG/HQzzFQaM6V9tK3LDKQQ9kTpxNRIG8kg6vdvxcWqCi29LhYcZROsCdhmziut
         7iEM8x3u6EBYxhVTkw7zJNJZRV70K3KXbYH7HYKCEFPQdksnKMk9bcTGuN6ImEFrubTd
         PvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=SJf4C6KejtjXuljRmpFGx9hGgMD/PzbLxtQzdurli00=;
        b=DM+mjjvfTKq4j3pZJR//Wu52BK8fggbeX052nhcfsi3SUopezRENV1AtMQgLIGcAm/
         6qGbKEjzF+0q4BIgeyxgx0E5GiHUWgQVcwgQLpw589wW5l7MWr1UShc9Os0aCYvbQHaJ
         xTfuIT8E7Y5htJlDe713tTpYWV+rwsMJCfPCvxPmVyzHfZuEidG6pIv1B+d13yADQmcj
         5BNWEt4zrXxqUIBwv1qNMGkYt1OZMv47ADhXiqh0Cvbe/YpiD9hT0KiyB43x3gmPeQbu
         A/1bwrNwQZAXZAqP4akrhCGdbVhKsVRHMC4Jhm6xsZQHITxh9rWPCn3+OhxdIjE4zuCR
         hoSQ==
X-Gm-Message-State: APjAAAUDsI0zgfmdKjLcEpUjzCS8FEa/XDhJUMuSRb77SAo67Ep3ZTkF
        8RRZSjHHpYqql8hkoRVfDuY=
X-Google-Smtp-Source: APXvYqw24vVbSWaGT1XYSVoCsx77tNpMoTKR6cg3dqCR+s4/Mxl6zTKM7kFs3jPH73aua2yoVNXa8g==
X-Received: by 2002:a63:f501:: with SMTP id w1mr371963pgh.444.1563221495103;
        Mon, 15 Jul 2019 13:11:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4caf])
        by smtp.gmail.com with ESMTPSA id a3sm20020489pfo.49.2019.07.15.13.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:11:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 4/4] rq-qos: don't reset has_sleepers on spurious wakeups
Date:   Mon, 15 Jul 2019 16:11:19 -0400
Message-Id: <20190715201120.72749-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190715201120.72749-1-josef@toxicpanda.com>
References: <20190715201120.72749-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we had multiple sleepers before we don't need to worry about never
being woken up.  If we're woken up randomly without having gotten our
inflight token then we need to go back to sleep, we won't be properly
woken up without being given our inflight token anyway so this resetting
isn't needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index f4aa7b818cf5..35bc6f54d088 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -261,7 +261,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			break;
 		}
 		io_schedule();
-		has_sleeper = false;
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
 }
-- 
2.17.1

