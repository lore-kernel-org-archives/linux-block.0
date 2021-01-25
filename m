Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD610C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FDA2220B
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbhAZFdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbhAYTFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 14:05:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57816C061788
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 190so379219wmz.0
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBkn8blA/6+QqkMVIGbS0xGWL5eTh//t50DpyLtTo/8=;
        b=vqsaLV7pZBnPICnzIgmqorwk2fyo45c5UKZBvj6tVNO/j3qga7xpo2Ha8grkSszN3A
         mZnbVNrlC62jx5xVWKCIKvxE1MyVwNu0h1gUVW17Pyzi3OK+uM3x4+iOKYYu7vtS+PQD
         +cRVLfrDNzVVtZ2Jz7EhZHV6ZUXp3KsVeVYbmz4HubIkDNrwgRWcPPMalW2cM1gCrd9Q
         iBevB2gs3Q4wo3DmleUZTog8Kx/uhjAesYQrrzCDs6XYqmRcOBKAXc97pRy4HQJN/tqo
         XSwGu72eqRjpk3R+dw96+AA4bt3dL0egLqL4WpqT1cWD7bPimewOBIRMd101afM7/XkM
         xUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBkn8blA/6+QqkMVIGbS0xGWL5eTh//t50DpyLtTo/8=;
        b=ufYeC07BR9x+mJOrB6of6Bo3iGA/9PS8h+jduF0DKgHSv2o56VAoazcJZ4kzH0/GSi
         RZugWW8srCspDjfxAb2I2uFzjwGJHs9ad35DnGS2I0cNHNwjejMeNRaLRlsL0WmUWglM
         SGdbw/dQ2UdZRU59sb4UvU7+XX0pIZ4CGJO16USK9dZ+V+B4px0KwyuBr2nzWy5zlc5m
         vyC4hagzz268Q301nUn7CQHU2BRjp/1aSLkuhlXnq0Fpm5POhC1bFclgOMyI8pyambJR
         j0l1o8LNMJTOuLVEfNQ4vChLuzPwLJUmlso08+zYpiYBUXncUnsGZUsJVq8cUSYwAfaW
         Oazg==
X-Gm-Message-State: AOAM532LGfUSD5BI5XeS0BLi+oAtoErnyJtKPFQzWVDSb0wflohBrzTZ
        CBW7ozYXGD9blfShI4QCXu+ZDA==
X-Google-Smtp-Source: ABdhPJzGmeJTvaTg1ITDmlviE9TGzuSOK9EMZHfgNtiPJsBjq/PBozhjmh5XEBzl7dO7ymaRlYvfGg==
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr1413130wmo.161.1611601398093;
        Mon, 25 Jan 2021 11:03:18 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:17 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 3/6] block, bfq: fix switch back from soft-rt weitgh-raising
Date:   Mon, 25 Jan 2021 20:02:45 +0100
Message-Id: <20210125190248.49338-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
References: <20210125190248.49338-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A bfq_queue may happen to be deemed as soft real-time while it is
still enjoying interactive weight-raising. If this happens because of
a false positive, then the bfq_queue is likely to loose its soft
real-time status soon. Upon losing such a status, the bfq_queue must
get back its interactive weight-raising, if its interactive period is
not over yet. But this case is not handled. This commit corrects this
error.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6a02a12ff553..9e5242b2788a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5293,8 +5293,26 @@ bfq_update_io_seektime(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (bfqq->wr_coeff > 1 &&
 	    bfqq->wr_cur_max_time == bfqd->bfq_wr_rt_max_time &&
-	    BFQQ_TOTALLY_SEEKY(bfqq))
-		bfq_bfqq_end_wr(bfqq);
+	    BFQQ_TOTALLY_SEEKY(bfqq)) {
+		if (time_is_before_jiffies(bfqq->wr_start_at_switch_to_srt +
+					   bfq_wr_duration(bfqd))) {
+			/*
+			 * In soft_rt weight raising with the
+			 * interactive-weight-raising period
+			 * elapsed (so no switch back to
+			 * interactive weight raising).
+			 */
+			bfq_bfqq_end_wr(bfqq);
+		} else { /*
+			  * stopping soft_rt weight raising
+			  * while still in interactive period,
+			  * switch back to interactive weight
+			  * raising
+			  */
+			switch_back_to_interactive_wr(bfqq, bfqd);
+			bfqq->entity.prio_changed = 1;
+		}
+	}
 }
 
 static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
-- 
2.20.1

