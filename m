Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419D9C4361B
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CED64FEA
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhCLK4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhCLKzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03632C061763
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so14905508wmd.5
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQ2DfDdVbjmrehTjwybpEwMo+GbFYXt1R0CwuBdY3Z0=;
        b=OghrvRpS8GWv/AV2ViOXbgTejwPy/gpOEe32zLkGmtvykZU0mA2lJyRWzqmmb1K1j4
         FesBzDGRHwApz1sUTLSb7KsA0Kq7y3o+Aa8+OLK4bYkbcmGmf5eH2y1s8jQbwcSFZwqX
         Jj1LPCVlsV8XrcQNIsjLT2QiXqB2L+guzQ4YkhZ/ZvNFtQ3juB+J7AKfIS8Hq+g6KXly
         xONNkru+slCIA/hDIB+kLJwxk+wRqinyKG4qqc33vRzGKfmm4CeOkiX/n4xWDkFhCpL9
         1AGgKMsjnXiZKJFNc27dCH3ocNFLOMDsy68oApOjCZchXDOusCet6BaY9iQN6N/KkEkZ
         1ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQ2DfDdVbjmrehTjwybpEwMo+GbFYXt1R0CwuBdY3Z0=;
        b=lqCAEEP8OnoXPW8cDwJfedwlA2tCfe1t/YXpYkd24Y98aFMcQ0N2Z9BaqATOPkunRJ
         jGKu1dJXnM1znaIOdKkgtvONGh3Zqio7SNvS5H+uVQtslN/7jKBm9Gd5/iQAdF6lY5Ac
         /IyS+rg00cWqz4lNYWTzQo/Kz9T9NAznD3kHRcEMIm4COTlsmZwleqOcc4WkSxXFlLGw
         XfRknTlaiArm3sZFHVlaQOjjTBFGJrNtkhz+bDaf+kLl/6NXyY0eTnrOd3GYCaIIZNPr
         5VDWyCCT5ZS+AXJqgTr63FvHQZ4VqnsUhHOvrVjthMqia7bvhyh10+RhFOd1yX78xqgX
         eLwg==
X-Gm-Message-State: AOAM533JyERNbS2f3vmctt4fdnyb2RfS+4VFS2ditVC4XL5SMYx/7nRs
        4WvTiQc9AIMoBb0AYfYnOq1aZQ==
X-Google-Smtp-Source: ABdhPJz0HY2DHTHFDRtkB2revKFFtu6vGCyfJwf+UX60jhtgQzFrnGp54e9OnekD8J52ZO5w2YW1hQ==
X-Received: by 2002:a1c:a306:: with SMTP id m6mr12059136wme.13.1615546544651;
        Fri, 12 Mar 2021 02:55:44 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 09/11] block: drbd: drbd_receiver: Demote less than half complete kernel-doc header
Date:   Fri, 12 Mar 2021 10:55:28 +0000
Message-Id: <20210312105530.2219008-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_receiver.c:1641: warning: Function parameter or member 'op' not described in 'drbd_submit_peer_request'
 drivers/block/drbd/drbd_receiver.c:1641: warning: Function parameter or member 'op_flags' not described in 'drbd_submit_peer_request'
 drivers/block/drbd/drbd_receiver.c:1641: warning: Function parameter or member 'fault_type' not described in 'drbd_submit_peer_request'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 89818a5e0ac67..7a32185347247 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1618,7 +1618,7 @@ static void drbd_issue_peer_wsame(struct drbd_device *device,
 }
 
 
-/**
+/*
  * drbd_submit_peer_request()
  * @device:	DRBD device.
  * @peer_req:	peer request
-- 
2.27.0

