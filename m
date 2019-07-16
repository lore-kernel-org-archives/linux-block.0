Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5651C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9617620659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="UgS/qVNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfGPUTm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:19:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46391 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfGPUTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 16:19:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so20935346qtn.13
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=TFVLDA77cnSRzhHRobnrF66rGEp70nX1OfcS3CZKAFI=;
        b=UgS/qVNbKj+IdrlB+0y5xCamIZXfpG2tqApZ4CX0TmdlcmNyz+G39Gz2NYqUdEXEgE
         zzwkP6Sv/Osqt5db1JaP3BGQQaiLxfh/gr7hHzge1hVpltXKlAwK0O+ut2qo/wlZ9K4/
         uv7cerlINyxYQwpi9fGE3h2lKaBXsZA2W1ndKMiTBF+Ry4MUdhpwAVv7Z9PlkiIii3TN
         aStRLPSzGHcPGTCwXw8/PGZFoAz4e0fjmrcNpNtggTmPO+xFCh6+AiSZqp5acgxQnExJ
         8oZd1jN4fKJSXCgeS1/UQ60MH+bW3pDDQQz/lPuCp6XfXjoN/u2yP474bx08QyX2FuPt
         Bi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=TFVLDA77cnSRzhHRobnrF66rGEp70nX1OfcS3CZKAFI=;
        b=HU3q+yfVi58+ezsXmXZmNx7VbbqDg2iaEU7R4A3BWebTsMDR5xG73X3rKmYsktJ4gf
         mdR+k+g577Etuy8D/boXfBW80Yfn3PALTke2yWzy7+Lc/XrM/fVGuCeLtv7qgvGC66P3
         0gb7qBtqTfbwKXC0dFuRryJjhw15Y7qTwUDoBSp9fkhlTSmtZwzyxHqVfcjeZBhORXg3
         jWu0s9OW2n68+917w648uVyjH7V8H5Cxi7oDwXHpBdEBa4Qk4RWj9zNeIBHyuM4ESalS
         90dPmJrU0M70LFiF026vIKtZfTZrSjOr36/SDDOxO733bnuBam6SsaBG2bF3rGy/faIc
         7SBg==
X-Gm-Message-State: APjAAAVm3HCQTZdZf0pD79q5cmjXzJWFXHfI9kzst6Mtm9kGbbtV0Ggr
        EFOFTHyEMUobkB2ER/b7Mw0=
X-Google-Smtp-Source: APXvYqwNmctRE10wLXD43RT8dNa9p6irhDGe14B9B7ZEH12rQoA3ypjBJ2wkinKbJKpvcRav+aDeyA==
X-Received: by 2002:ac8:303c:: with SMTP id f57mr24652233qte.294.1563308381048;
        Tue, 16 Jul 2019 13:19:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d7f3])
        by smtp.gmail.com with ESMTPSA id m44sm12314962qtm.54.2019.07.16.13.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:19:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 4/5] rq-qos: set ourself TASK_UNINTERRUPTIBLE after we schedule
Date:   Tue, 16 Jul 2019 16:19:28 -0400
Message-Id: <20190716201929.79142-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190716201929.79142-1-josef@toxicpanda.com>
References: <20190716201929.79142-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case we get a spurious wakeup we need to make sure to re-set
ourselves to TASK_UNINTERRUPTIBLE so we don't busy wait.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 69a0f0b77795..c450b8952eae 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -262,6 +262,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		}
 		io_schedule();
 		has_sleeper = true;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
 }
-- 
2.17.1

