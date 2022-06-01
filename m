Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C72C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiFAMWF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352193AbiFAMVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 08:21:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1295D648
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 05:21:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v15so1728336pgk.11
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s5ua/r45roXfkQ5hrpMLZbr0p+EmyEspzho/oSN+Lzc=;
        b=7ZLzivQcWHT/fZLvUnhrnUfj964Nf9oki+lLUmPDgm3tT1NkPsx65NAMA/pIfo8fz5
         8XmKwUEWO1aq3Y5S8cwNVZHu83FaoDYbH3OwSCYDmyn9m71XUW7EmqoDVQjVFzFp3Kby
         dHsxWGfqI5ml3ym3Zkfo19ZEWlJhHH2Wh/eW5Hf6eH3W2OD7EfxldSvs4ZUI8Tkj0A6y
         zXBL7hF7Qe3WplF+DLg13shRaSlZUwM//s3p+ev+0vSYfZpymN+gxqhiwBWW39lEf3Zi
         V5ZPW4NvFxxhPoyOk2b/v4WbV/NU0I8UhLixDgBeemnSf2QXLxVYEZmZiz4pJ3+PVfXk
         ulIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5ua/r45roXfkQ5hrpMLZbr0p+EmyEspzho/oSN+Lzc=;
        b=1yrbJzET5+MmNvUB6PIpN3n8Cvp/RmgcZQR4LG/rq5lSMv7e3e40coPN2eY2UBGwsi
         zYmBqT/u5zI52lOL0shMi6r5JnLvWCQvO3AutHjAjZhnfpJu9W4OrLQxOBQ+/OlNcMR7
         CWT5EAoE9Sq9Tz7PWdrlcVUw8ZPX1iDVdJ3lvS51XP2Xx4mAE4BRUmGJNGSBOQbCun4W
         uz3SAoIHJXvu0adBr2YC314h0TidFHQT2YcYXk4PdUx7Onm4EcozTe1NWkqw6ENFctNs
         ZhbJfZ/dJ28FLhsbe8DwEtNKbVpiGy0SmhWauGDYKbOrx6sTjdcTXRdry+Kdp//MeBJ7
         rIxQ==
X-Gm-Message-State: AOAM530iy4RT4gxRO3U2kFFjkWZDI1uZS7imtUoJpKbeDMukKgyn02gS
        UCv+YmWqgFZkftJV6kg312li5L2HEKj4XQ==
X-Google-Smtp-Source: ABdhPJykF5V8wdIz+24+3hXF1BEqN6fMbgYxPfSjrxb6lRi/c7LiocB7K9uaafs9UPDJYbpSxmXKDg==
X-Received: by 2002:a05:6a00:a8f:b0:51b:5ca1:47f1 with SMTP id b15-20020a056a000a8f00b0051b5ca147f1mr12074388pfl.50.1654086081610;
        Wed, 01 Jun 2022 05:21:21 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b0015e8d4eb1f7sm1427535plb.65.2022.06.01.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:21:21 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/2] blk-iocost: only flush wait and indebt stat deltas when needed
Date:   Wed,  1 Jun 2022 20:20:07 +0800
Message-Id: <20220601122007.1057-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220601122007.1057-1-zhouchengming@bytedance.com>
References: <20220601122007.1057-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only need to flush wait and indebt stat deltas when the iocg
is in these status.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b1f2305e8032..502425b44475 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2174,28 +2174,28 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 
 		spin_lock(&iocg->waitq.lock);
 
-		/* flush wait and indebt stat deltas */
-		if (iocg->wait_since) {
-			iocg->stat.wait_us += now->now - iocg->wait_since;
-			iocg->wait_since = now->now;
-		}
-		if (iocg->indebt_since) {
-			iocg->stat.indebt_us +=
-				now->now - iocg->indebt_since;
-			iocg->indebt_since = now->now;
-		}
-		if (iocg->indelay_since) {
-			iocg->stat.indelay_us +=
-				now->now - iocg->indelay_since;
-			iocg->indelay_since = now->now;
-		}
-
 		if (waitqueue_active(&iocg->waitq) || iocg->abs_vdebt ||
 		    iocg->delay) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, true, now);
 			if (iocg->abs_vdebt || iocg->delay)
 				nr_debtors++;
+
+			/* flush wait and indebt stat deltas */
+			if (iocg->wait_since) {
+				iocg->stat.wait_us += now->now - iocg->wait_since;
+				iocg->wait_since = now->now;
+			}
+			if (iocg->indebt_since) {
+				iocg->stat.indebt_us +=
+					now->now - iocg->indebt_since;
+				iocg->indebt_since = now->now;
+			}
+			if (iocg->indelay_since) {
+				iocg->stat.indelay_us +=
+					now->now - iocg->indelay_since;
+				iocg->indelay_since = now->now;
+			}
 		} else if (iocg_is_idle(iocg))
 			iocg_deactivate(iocg, now);
 
-- 
2.36.1

