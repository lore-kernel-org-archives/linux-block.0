Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F0EC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 19:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA682076E
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 19:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbhAVSjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbhAVSWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 13:22:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489C1C061793
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b21so7631233edy.6
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMJc3fvNQabQh6z6D9WSCx7y8czmLn+2gUl4fumpUHU=;
        b=kw1KtJhYSMS/im4yQwTlK4t79fvvhEJuZFHLnIGO0wREQkpMpOgURKsVOpsQq/Lcz9
         mg7Nvhpuo9oVcxocZ4HEWwRnBfb2uegHEkC9+IVCqR1la13k1SBDnAQkkjCVrVrtovGK
         sDdEfaj7yCxI2PVSc0Tf7R52dDyzqTzd0+LZeym733t+eJR3hN14m9zkzhdefNNcfl0b
         HVgGuyoWyy7I5Q+ytwcRulLsPS8JST5oAQQjDV+gC8B6EgGxRpyw5ohb7uoXMAIaz/oy
         VWGdIiMq7YEF5vaTVZOWJUUy4bqVrJsG4ZT6LjT7C0Euxa/nDKCaBodTKzUIfEd9oKZF
         n0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMJc3fvNQabQh6z6D9WSCx7y8czmLn+2gUl4fumpUHU=;
        b=lVZpyCOWtT4lPZ7gITIA1M8d6Y2AeLOMzop+TqyjtzMTMoY6B4IpIzNPSiTQ4nAWRn
         /2DeDWkykcJHv38wFFoVTkfg5u0TNd5J85MLSLz+B0ES46JdbbST3pMpZ3bg8gBBduvA
         rMyELqM3ctLiVK2z8R21+egLfMWqyEc1990wzjMDT8tdjYLSr6z3sGTMroKn35Pvkcik
         MYwIwrDNS67kvCKkz50vZR7cfFDZn0rqWT1RL5cKDkw2fuITv1xBbtzIpoNg6WhBMtyQ
         ZTaf46i2KCu0NpqRHl5dktogzk9pimZDoxUMAscvJzct2stXd9+gYqZNBmxjrW54WCYX
         28Kw==
X-Gm-Message-State: AOAM531xgD+qWQq6nuJuA8ZMvlW1mx5Uo+8FcwAhy/Y/wjidF81QRAZ9
        cU+jQq33h1KCJ+0jiqM6OroiIA==
X-Google-Smtp-Source: ABdhPJwlXNf6RARff5m4Jn8d628AS4mJE8EEUc8+yo0v0fFp5vNff9tinxvvKqC3Hiv9bhepgO2usg==
X-Received: by 2002:a50:c34b:: with SMTP id q11mr4248536edb.173.1611339634946;
        Fri, 22 Jan 2021 10:20:34 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:34 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 1/6] block, bfq: use half slice_idle as a threshold to check short ttime
Date:   Fri, 22 Jan 2021 19:19:43 +0100
Message-Id: <20210122181948.35660-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The value of the I/O plugging (idling) timeout is used also as the
think-time threshold to decide whether a process has a short think
time.  In this respect, a good value of this timeout for rotational
drives is un the order of several ms. Yet, this is often too long a
time interval to be effective as a think-time threshold. This commit
mitigates this problem (by a lot, according to tests), by halving the
threshold.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e4eb0fc1c16..eb2ca32d5b63 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5238,12 +5238,13 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 		return;
 
 	/* Think time is infinite if no process is linked to
-	 * bfqq. Otherwise check average think time to
-	 * decide whether to mark as has_short_ttime
+	 * bfqq. Otherwise check average think time to decide whether
+	 * to mark as has_short_ttime. To this goal, compare average
+	 * think time with half the I/O-plugging timeout.
 	 */
 	if (atomic_read(&bic->icq.ioc->active_ref) == 0 ||
 	    (bfq_sample_valid(bfqq->ttime.ttime_samples) &&
-	     bfqq->ttime.ttime_mean > bfqd->bfq_slice_idle))
+	     bfqq->ttime.ttime_mean > bfqd->bfq_slice_idle>>1))
 		has_short_ttime = false;
 
 	state_changed = has_short_ttime != bfq_bfqq_has_short_ttime(bfqq);
-- 
2.20.1

