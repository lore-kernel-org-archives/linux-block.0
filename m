Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC2BC43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B7120859
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hxarlySS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfEDSkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:40:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45261 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfEDSij (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id w12so7811883ljh.12
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4sMfKD6BWHHY2w0leCFH8ILHNGcbbmFVkVvKPdVieNc=;
        b=hxarlySSKrvW9s7uG9u1fIU9cGNTvxWsqqv5ikXOvS3MO579hnmYEU/umNLoGeFlyl
         3b1iwcDzIFAP3Jl/owreGfLhII+TA99CUWyvLxIy+qEtnklNfvtxIF9D7Njdv+Zzcbjo
         l/3RVycxqsyLrrWfwwccNMkhZJ27/SNVUwFmdPdZ8E5ixWDdu/aXjl4UYR1ywEGw7bAP
         0pNrQ9dWpNvVt+2WjOsORXL1uuYrbpMZ49Q/lnz+ObKGW2cYV/4d7OrN3Vrw/1ogTmFr
         Nl+daEBaPqcL3gaWtAPqYqdgS6eGSQR/ORnzr8zbPNe2zZOCWgc9q1s2yZ3mI+T26CVI
         oNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4sMfKD6BWHHY2w0leCFH8ILHNGcbbmFVkVvKPdVieNc=;
        b=R88B8VsSF2M2uQOUSL8nTUCyOUWkuIQ8qFmryQu1g6yUvlYc1pT4CN+SnVrZ6dgtkv
         yk0FbPtzI63ktTtwbfc1aRNX1gEu77bywHFauIinHZZFve2GK4veINKUCgXkEJ2NA/J0
         PTXeTk8dqWkoHmF/riHiNGgE9hg+DFaUJ30LGNDUC3oPKcmGRhbWk1PTXgY0+gxYlMOJ
         RAXvz/P0JBe7F+Jz+cVlTY4tbGH8Qa+yCvlgEzSk+KmcuJAyfpmqHs2f0RBY7DA4SUSK
         6/vavf0LVlDv9mRePSmNMGO0NHyOq05BVLdQHF3NM6uR1DTSdZN7AHAA6vzm/VXB7Tua
         rOCw==
X-Gm-Message-State: APjAAAXXR4rMl4JCMNoLjHi64mK3OK/QwrFCrLEPnUNMb90CMymh1blY
        oXneuk/zURzkh+YVBeti56iA8g==
X-Google-Smtp-Source: APXvYqwg9+2iF7iezU58WykeOaS9dYyJU+rYamqU1PfMDzCQIa5wT2f6a1cyss8VQSuveC8kunoMjw==
X-Received: by 2002:a2e:7611:: with SMTP id r17mr2332585ljc.95.1556995117501;
        Sat, 04 May 2019 11:38:37 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:36 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 12/26] lightnvm: pblk: set propper line as data_line after gc
Date:   Sat,  4 May 2019 20:37:57 +0200
Message-Id: <20190504183811.18725-13-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>

In current implementation of l2p recovery, when we are after gc and we
have open line, we are not setting current data line properly (we set
last line from the device instead of last line ordered by seq_nr) and
in consequence, kernel panic and data corruption.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 83b467b5edc7..017874e03253 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -844,6 +844,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		spin_unlock(&l_mg->free_lock);
 	} else {
 		spin_lock(&l_mg->free_lock);
+		l_mg->data_line = data_line;
 		/* Allocate next line for preparation */
 		l_mg->data_next = pblk_line_get(pblk);
 		if (l_mg->data_next) {
-- 
2.19.1

