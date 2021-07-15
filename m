Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D2C636CA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E9613ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhGOU0q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:26:46 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:44811 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhGOU0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:45 -0400
Received: by mail-pj1-f49.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so5314916pjo.3;
        Thu, 15 Jul 2021 13:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBxOin91NVVTQ2vJKAAhZ3OQqFRpCk1uS0YMynnvLP8=;
        b=cOrpL4vhrD+7D87hf2+Ba7FLkjvr6ZtMUyDswf6Ov+SaQYdOgx/nSLUgvYgXV3Z2jF
         x6HJmR2f+D0PNmp0S6TgjxONSGH8tPnCPRv1vGUrn4HijQYugfDKNutR23S5XAjvPWKF
         5Eh+ZId/4T/Lmi+8CgvwdP0hc9gk4WjPWmqpY98vlYlDmaNTW1IsR9Acyyt0wkYxtX8g
         lI2gQt2W1T+6KpQfw1R9PQHaF02pYijJtm/9IEcU0EP6HvZ70/Q/TzLoPMnRoBi/1ujC
         NaZsGQkB/L+ub4qxv2nsCek+0UYyM1j0/ubXD5dM/sJDRJvzf1b2Czes6IQ60VZhuqEk
         Iseg==
X-Gm-Message-State: AOAM533slp7GoDDJ6HLxDewPV0a8M2mwFTYk4k5bvFw+fC/APf5r2l3y
        WRI7uW4UphiLbkNd0PYK4xY=
X-Google-Smtp-Source: ABdhPJzk5UBDu29ZBOrd2t/EM+bl7teotg0YavxgMg7zLy85iEyBvcVrJyNJnN4VWM3l2IOIDKhijA==
X-Received: by 2002:a17:90a:8c9:: with SMTP id 9mr11402675pjn.58.1626380631875;
        Thu, 15 Jul 2021 13:23:51 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id q24sm8432159pgk.32.2021.07.15.13.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:23:51 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 3/6] md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on is_mddev_broken()
Date:   Thu, 15 Jul 2021 13:23:38 -0700
Message-Id: <20210715202341.2016612-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715202341.2016612-1-mcgrof@kernel.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The GENHD_FL_DISK_ADDED flag is what we really want, as the
flag GENHD_FL_UP could be set on a semi-initialized device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/md.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 832547cf038f..80561bca1f51 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -766,7 +766,7 @@ static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
 {
 	int flags = rdev->bdev->bd_disk->flags;
 
-	if (!(flags & GENHD_FL_UP)) {
+	if (!(flags & GENHD_FL_DISK_ADDED)) {
 		if (!test_and_set_bit(MD_BROKEN, &rdev->mddev->flags))
 			pr_warn("md: %s: %s array has a missing/failed member\n",
 				mdname(rdev->mddev), md_type);
-- 
2.27.0

