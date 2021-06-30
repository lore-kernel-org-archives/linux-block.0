Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4CC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0956610E6
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhF3UkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhF3UkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 16:40:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3DC061756;
        Wed, 30 Jun 2021 13:37:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so5333345wme.3;
        Wed, 30 Jun 2021 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpmwZY/0RfS3+/odCugsQIGN0paNDtRCrK+WQbciJeM=;
        b=RANL818+eUhgzkhv0e5jhz9tP6ti9DakKQBmOvcW4v/bIzWO6XngrBhAX2CQp2RzRj
         XdpMF/jhEYORkzjZ04Gum32FBKzU08ko3JPGG8JCIvr7vfbaoEnqZGC0JGRgH9gC9jKd
         +BYFTQysF1R3uNTGUAzvVSCyCWTdZ+NV0Ef9DzxNk/LAIKhQVfW2Q7b0Gd/t7kfwo5oe
         nzdjKDoZJ2KaLAZdMUF4bM/wqdi8YB+/mmkruHqM+cjuZLvyot2cAyWu8KPS0r5EghUe
         PQHq/qa9EnC43o8uJdfaasgSfIZGFGvje2zuHmpvvkxzZt3NOpsFKrM3TGDnLsSx6oF4
         7a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpmwZY/0RfS3+/odCugsQIGN0paNDtRCrK+WQbciJeM=;
        b=qAupOIVbiYidd2amF5XpWumjxQP6xrBZ71XpWfSFdAUNm1+aOknd1/Gs8vYD8+Tyqn
         oY7d3zWCXPd/iYudI0GmWge4l+TZAyKNQc6LWQ6NUZQdCGyHGNoIPhZY69JkJIGFTsvn
         0dwK5TlyZIeEBlhKsNyo8GNXy98dZG2XDQGuRcvcDqr1ABP4nIEukCJ6QBeqQoOv3nee
         b4LXsVDsX1F6qy81vgu9p5wjeSg/GRBLACANCfkvNMhWYzL1X2qIqFfnTNPJ5vw9Y7kC
         r6MH9Ggl7TlLHiEM4yUUgrMxDMjzm8KcuuN9eXUBntpWyyVeJ/t8SNMkr73qa1W/Moe6
         gKMQ==
X-Gm-Message-State: AOAM5330aIafB1Ex1NII0RTtIPemC3XdrrNwMBnx/S7mFa689QH/bRgh
        pekD4hOqjtzq4bTIEiXkZj8=
X-Google-Smtp-Source: ABdhPJyIjOfiCi5Keiz7W8iN/kgBRVtdclmWtAqd4n1pJ+I+5zy4wXIYW8YRM15FnudVY3OC2Vu17A==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr6561857wmc.15.1625085467858;
        Wed, 30 Jun 2021 13:37:47 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id p9sm6182958wmm.17.2021.06.30.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 13:37:47 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] block: Declearing print_disk_stats static to remove [-Wmissing-prototypes]
Date:   Wed, 30 Jun 2021 22:37:20 +0200
Message-Id: <20210630203720.208003-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the first patch I have not defined the print_disk_stats function
static so it triggered an [-Wmissing-prototypes] warning, fixing it
by defineing the function static.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5d393b2bc62c..803c3448f09a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1107,8 +1107,8 @@ const struct device_type disk_type = {
 
 #ifdef CONFIG_PROC_FS
 
-void print_disk_stats(struct seq_file *seqf,
-		      unsigned int inflight, struct disk_stats *stat)
+static void print_disk_stats(struct seq_file *seqf,
+			     unsigned int inflight, struct disk_stats *stat)
 {
 	seq_printf(seqf, "%lu %lu %lu %u "
 		   "%lu %lu %lu %u "
-- 
2.29.0.rc1.dirty

