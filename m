Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5061C77B6C
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjC0UOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjC0UOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:15 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A926F1FCF
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:27 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id t13so7704629qvn.2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GATmDpp2LqxaO3YBsTr83VB1ZcPRtnkKD4xtYp0nm8=;
        b=PJ5YUgxpkooPAStG43yFlylYAELAzvmxYMxeHotDyrq6ubmyuIHXTsbE97Tbp0Hh1b
         mkZeEV08/40qdLpKRAxgSmp10/+tkwen98gm787U3qF5OQVHlMMVS423/t2YQBhLo45r
         x7TqYe09xtjc3P4+xM2gP9W6okGgwwWePqVwegKjzIgvrPcF0SOlATexLcvu8q9ssqx9
         OFt9s6kK2TP7oErTfkOE1zSOsjtkMYK8YBh42+02oJSzy0pM+9W0qgbeuToMNFdsE20w
         0yMJL8SJmhI0PMNMWpLRq5DCbVHGPO/SfXg6KmNRyO85RoAm299nWMlA7ji04U/H3RJx
         i0Tg==
X-Gm-Message-State: AAQBX9dtTKLgLefd3SluPNUaqXpaNgG1q4G+0w3fbCSu9UOVGixDRXic
        gDA4RmoW2pxf3B6AaVDRZV4M
X-Google-Smtp-Source: AKy350ZI9rUbEEtVYKNa1rqSBi0yYegoZt54hv+kbNekJScyZbdA+0A6vj49+yGatxgvJEDQcYubbw==
X-Received: by 2002:ad4:5bc7:0:b0:5b8:d0b5:9a46 with SMTP id t7-20020ad45bc7000000b005b8d0b59a46mr20840019qvt.37.1679948006778;
        Mon, 27 Mar 2023 13:13:26 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id jy3-20020a0562142b4300b005dd8b934595sm3228566qvb.45.2023.03.27.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:26 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 12/20] dm thin: speed up cell_defer_no_holder()
Date:   Mon, 27 Mar 2023 16:11:35 -0400
Message-Id: <20230327201143.51026-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

Reduce the time that a spinlock is held in cell_defer_no_holder().

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-thin.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 13d4677baafd..00323428919e 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -883,15 +883,17 @@ static void cell_defer_no_holder(struct thin_c *tc, struct dm_bio_prison_cell *c
 {
 	struct pool *pool = tc->pool;
 	unsigned long flags;
-	int has_work;
+	struct bio_list bios;
 
-	spin_lock_irqsave(&tc->lock, flags);
-	cell_release_no_holder(pool, cell, &tc->deferred_bio_list);
-	has_work = !bio_list_empty(&tc->deferred_bio_list);
-	spin_unlock_irqrestore(&tc->lock, flags);
+	bio_list_init(&bios);
+	cell_release_no_holder(pool, cell, &bios);
 
-	if (has_work)
+	if (!bio_list_empty(&bios)) {
+		spin_lock_irqsave(&tc->lock, flags);
+		bio_list_merge(&tc->deferred_bio_list, &bios);
+		spin_unlock_irqrestore(&tc->lock, flags);
 		wake_worker(pool);
+	}
 }
 
 static void thin_defer_bio(struct thin_c *tc, struct bio *bio);
-- 
2.40.0

