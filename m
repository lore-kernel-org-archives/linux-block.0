Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD6BC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1362085B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvbYcrkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfA2LHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36330 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfA2LHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so21555245wrp.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gAUJ5pwSD9lzILEQVJ0hCKATJxbw5gWvL06xocd7ofI=;
        b=QvbYcrkZ78lOm1jmQmedgdRvvGotGVNAELS2tmY8vO3gAAYJdENhs+i6K5OIIS+aBo
         xUCOofevIfoCvVZg2QYNSy+FXYOWoznVsUprE60jpyQfKtFMCKboVcVrfLJ5xT07Nnt9
         1ToHzHBJJd9kTtBhEl43pS4OGRudDsvoqg7rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gAUJ5pwSD9lzILEQVJ0hCKATJxbw5gWvL06xocd7ofI=;
        b=Vt1lgfiyaBAJTdCxcc376QOaCNmfES6o8Q7bzfkzujnLrm1nqnnRaHJD9Dh4C0p7Br
         z8SHnDtA8/v+/d+kM35USP5/vcMvfJJx28VvuQ7oG1kyEK1WI7fxke8W782cXjUXT6Di
         7Octx6KRgVVq/ZoINbEbTMk8/8ORS1BtsAT7UilH/1yNlE7xqO31OXZdAvJBpP8yyywo
         67HzAQXHoXtWHe3wvIGfeglu0qff9iXXwO8Lim2pM6Al032ovpnfRcL4Q0MpOhDsoAHF
         17K3+wMD2SDPkeW14HCp/I7DVvyYY64HqVNzOllkKWYhHG99Gtq5wHJ/JqzhWtL/oLJL
         GGQA==
X-Gm-Message-State: AHQUAuaNjNiCRYaDPDuOkGqi1/UzqQkPdA0BP1ZCEZmB50C0NinI4Wh+
        cLieKOcfT5x+0bNonH/e9LHikw==
X-Google-Smtp-Source: AHgI3IYc2i9UPPHabAM2+VOeqDKlwg1KhTzJ03eClBSuqGfiMhraGk5QDm1qWeOcqeQ7vS96EOIOIw==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr4707214wrp.92.1548760019712;
        Tue, 29 Jan 2019 03:06:59 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:06:59 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 02/14] block, bfq: avoid selecting a queue w/o budget
Date:   Tue, 29 Jan 2019 12:06:26 +0100
Message-Id: <20190129110638.12652-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To boost throughput on devices with internal queueing and in scenarios
where device idling is not strictly needed, bfq immediately starts
serving a new bfq_queue if the in-service bfq_queue remains without
pending I/O, even if new I/O may arrive soon for the latter
queue. Then, if such I/O actually arrives soon, bfq preempts the new
in-service bfq_queue so as to give the previous queue a chance to go
on being served (in case the previous queue should actually be the one
to be served, according to its timestamps).

However, the in-service bfq_queue, say Q, may also be without further
budget when it remains also pending I/O. Since bfq changes budgets
dynamically to fit the needs of bfq_queues, this happens more often
than one may expect. If this happens, then there is no point in trying
to go on serving Q when new I/O arrives for it soon: Q would be
expired immediately after being selected for service. This would only
cause useless overhead. This commit avoids such a useless selection.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c7a4a15c7c19..9ea2c4f42501 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1380,7 +1380,15 @@ static bool bfq_bfqq_update_budg_for_activation(struct bfq_data *bfqd,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
-	if (bfq_bfqq_non_blocking_wait_rq(bfqq) && arrived_in_time) {
+	/*
+	 * In the next compound condition, we check also whether there
+	 * is some budget left, because otherwise there is no point in
+	 * trying to go on serving bfqq with this same budget: bfqq
+	 * would be expired immediately after being selected for
+	 * service. This would only cause useless overhead.
+	 */
+	if (bfq_bfqq_non_blocking_wait_rq(bfqq) && arrived_in_time &&
+	    bfq_bfqq_budget_left(bfqq) > 0) {
 		/*
 		 * We do not clear the flag non_blocking_wait_rq here, as
 		 * the latter is used in bfq_activate_bfqq to signal
-- 
2.20.1

