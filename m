Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D644C10F14
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73B82075B
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPJZP9Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfDQCK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:10:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42924 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQCKw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 22:10:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so13457253qkg.9;
        Tue, 16 Apr 2019 19:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GikxrOMvkBouqwGAydsHalkqVsemnnDXG0/IMRMQiDw=;
        b=sPJZP9UkGu2hFwim30z89DRkk7WSG4/2eCLIL4JQXKNhn//ObzCRL8Z6/f99vrRE7B
         nsoX3pS0vC8F2WVQ/zhXLWJkz118SgMQvexHUX1QpH+bftjyfcy0MnHQUrbUcrSLQO2c
         aArKUcZf3r7DYPdAqU7zn5sQnnCsyxSQ6ZQctjg8QHPpu9cTHQc/K+ZlbmdphPttvxVa
         7SMsOnRRtzuNfj83/Hq1OSMazmNbd6qmu5nXMHi3VQO6kb+n7EaX2E5aPi2UQokBolTH
         UJbFnUYdY25v/jcr9xU7YLTRhrtE/hQxgDNEiROADU52dbam7mfMCb57pYDj3vG/CJDo
         ijxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GikxrOMvkBouqwGAydsHalkqVsemnnDXG0/IMRMQiDw=;
        b=suRkVSNBM+6/DFS0zpQc4IiWmEL1o5PYGw3BrnGkWfuM7/swDt29ob2r+8X+ABztxp
         uDKXW38Ke36yK/dC81TGjSWa/uOs7Z5y7WoNIRpPbFy6QalZ5EUOHJNhD+JdT6YNuqXJ
         0iCoRf4nMTsnpxEaAlkUyKo3kcLdCUuI8fIdrQSbGjUF6yTwVxl0sx/3ETVF7aKsQRiV
         273PiwfilHfu8A2UPlPgq7vUd4MJS35IqQpQ9SQ3LfXcRX7w5AhNosHLH+SaYxR630Jh
         kuyFi0xYf8qE9aas1SM/ZU8Hszx0EqXLoVW4hafiStQ8sjVyxXoN676wbt7is5siIOwj
         DYkQ==
X-Gm-Message-State: APjAAAWUyDJHL3NxThDOOIt6FfN/4xm+8GKZOcn0DYtB9yDGV4EbD05W
        sFeIOiUTFIA/prb0UrdaXNkuNXcdmM4=
X-Google-Smtp-Source: APXvYqzDG9vs7IlvoxexD+iIQN9LLCEwJDcfOcGtV1l9+bskUrP2ulOIrMHM3DOEvv99GZbP1ivd0Q==
X-Received: by 2002:a37:9b87:: with SMTP id d129mr22177809qke.263.1555467051364;
        Tue, 16 Apr 2019 19:10:51 -0700 (PDT)
Received: from localhost.localdomain (179.187.200.226.dynamic.adsl.gvt.net.br. [179.187.200.226])
        by smtp.gmail.com with ESMTPSA id s55sm1497228qte.17.2019.04.16.19.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 19:10:50 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, marcos.souza.org@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com
Subject: [PATCH v3 3/3] Documentation: kernel-api.rst: Add block/blk-mq.c
Date:   Tue, 16 Apr 2019 23:10:30 -0300
Message-Id: <20190417021030.82998-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417021030.82998-1-marcos.souza.org@gmail.com>
References: <20190417021030.82998-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now documented functions of blk-mq.c will appear in the official kernel
documentation.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Documentation/core-api/kernel-api.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 71f5d2fe39b7..cc323480ce0e 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -276,6 +276,12 @@ Block Devices
 .. kernel-doc:: block/blk-map.c
    :export:
 
+.. kernel-doc:: block/blk-mq.c
+   :export:
+
+.. kernel-doc:: block/blk-mq.c
+   :internal:
+
 .. kernel-doc:: block/blk-sysfs.c
    :internal:
 
-- 
2.16.4

