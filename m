Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A7C43142
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAC823B00
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 19:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbhAVSjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbhAVSXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 13:23:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC0C0617AA
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r12so8960062ejb.9
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9J+BrlLYgTspJD9ye4jQWIk1CnW/3Fa8FFYzOeIfBjg=;
        b=pNsesT89U7y5KJ1pEZlTSDCIUB5uvizLU78Mu0wTiEKOO6D/10eVKYuCXomHEVIoF1
         uUJBOkyDvdVYAkJxpIDPAbraxpqDhBjCb3We1hpwVHhnm9pxK7YLrAnL2iJrRhrDdgnc
         s/uSwg4i//AxxRlFCtZ8B1u1eZC6WxDLPAvQOrJErEpEwdS561izyrWaMWQsqPaNZDPy
         y6LiZyvwSyCL58UYszo6WQrXpvjyyEkV6G4/YcX049kuaJ78b4FotKTG33jnjbXjrs52
         1rEF6piabrfbjVRBjQ/mkxavp7GALCttEbLKv/dB3uan96JCtAEZutKrMpbfLDeQeBJe
         gPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9J+BrlLYgTspJD9ye4jQWIk1CnW/3Fa8FFYzOeIfBjg=;
        b=eePoq3nhlzHyrcwk0uDPmvAyRM6bmLym0sFZwRvAGznmsPMMAn2xODQPypq31AUzJ8
         sA4gi2vfauOFnuMqB02oIClZwNZG6zvop5C3C2WWROrHV+qiEepWdBq6V60E+PTfdWBE
         nllxcc83Po5qgFgq4IekrcwVumWyGbjgOkZaeJpB3dm7uoXNe6cm6ILagGP2BiOYDXtN
         8Nbt4+NtcSsDVPxckOWeMIiNQf/dypRZVQgQMHVfrEpfADboxyiJAiqJIvkWbB/w6nRV
         H9jnsAyR1NttZgEAAeZXAXcVpiqNNg2JVQXn5q3WfaI/YJut2zE2ebao8MzkCc3XNcja
         6ydQ==
X-Gm-Message-State: AOAM5322Cxu3zh3Znfak7FwPR2yYGoOpycv8iQMIHeW0J2RFEWp0DoWP
        u+gqePoq3HTxzvEqPniBYPflRw==
X-Google-Smtp-Source: ABdhPJyqm3+gKiCprsqFB+RUq/U8eR1CKgZSuBsW/tlTEJqKlqoa9pAtScGwg5GqO/PqylyRRvoGiQ==
X-Received: by 2002:a17:906:1958:: with SMTP id b24mr3742722eje.263.1611339638190;
        Fri, 22 Jan 2021 10:20:38 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:37 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 3/6] block, bfq: increase time window for waker detection
Date:   Fri, 22 Jan 2021 19:19:45 +0100
Message-Id: <20210122181948.35660-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tests on slower machines showed current window to be way too
small. This commit increases it.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fdc5e163b2fe..43e2c39cf7b5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1931,7 +1931,7 @@ static void bfq_add_request(struct request *rq)
 		if (bfqd->last_completed_rq_bfqq &&
 		    !bfq_bfqq_has_short_ttime(bfqq) &&
 		    ktime_get_ns() - bfqd->last_completion <
-		    200 * NSEC_PER_USEC) {
+		    4 * NSEC_PER_MSEC) {
 			if (bfqd->last_completed_rq_bfqq != bfqq &&
 			    bfqd->last_completed_rq_bfqq !=
 			    bfqq->waker_bfqq) {
-- 
2.20.1

