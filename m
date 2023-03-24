Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB9C76195
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 18:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCXSAF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjCXR7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:59:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5C2311D
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:14 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cu4so2177339qvb.3
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GATmDpp2LqxaO3YBsTr83VB1ZcPRtnkKD4xtYp0nm8=;
        b=fmIwU49eY7Ejn+bWSYdBz3oGlZoPnxPs37J8yYlYyE8AkcGHnvNZIXNS6n8aa7cW07
         pybKsQuMQVU0QQlH+2yXYGGhK54noWC1qEYTTv5es5VokZ5rFPay+tz/0mD1PXY5MjdE
         1wJ/bB7SgGDT1noKeUyq+TUFTiOYJoMMa3548wYQwDBV89lMGUQbJFRFHsrIu17iosvK
         i/REL0bzQcyTf3ztiN293MBNgnqswNtGnAl90XzRhGZqaNIaWjbIJgYNM0/b2PPgW28a
         STB1IOE6xE8k9wKvZExhgCEkB9cU/2uFTp2r0T9yiCl7gJMD90bnLmAn3pldUIsoEAcR
         z7Qw==
X-Gm-Message-State: AAQBX9eV7nPAkH8f0b1x98RSVyhRNMlkv73Oe38sfu3nWSPs0WN1nq6k
        oaf5wL3XzO7zzzjhpsLkiR9yUe0Z2PUw7In8DvvJ
X-Google-Smtp-Source: AKy350ZtoK3QhI7V4jQoKyRj8RRPy+HsVSg5fhN94i68TW8ZYwcPzF6HgFN8Nykpq82YzgyFXcllwg==
X-Received: by 2002:a05:6214:2303:b0:5c6:cd00:aaa1 with SMTP id gc3-20020a056214230300b005c6cd00aaa1mr6249028qvb.39.1679680630706;
        Fri, 24 Mar 2023 10:57:10 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 6-20020a05620a040600b006f9f3c0c63csm3541115qkp.32.2023.03.24.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:10 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 7/9] dm thin: speed up cell_defer_no_holder()
Date:   Fri, 24 Mar 2023 13:56:54 -0400
Message-Id: <20230324175656.85082-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
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

