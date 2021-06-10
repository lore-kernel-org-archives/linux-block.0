Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB017C48BDF
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316F613BD
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFJHZy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:25:54 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:34549 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhFJHZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:25:49 -0400
Received: by mail-pj1-f54.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso4992179pjx.1;
        Thu, 10 Jun 2021 00:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wHtH4uowNcGLatA4FtFRbjnON3Vo2NBBY5rs+rY1XYM=;
        b=ijDqdMdybR12VbiH1FvS4GERu5HwmJIsIhCDL9KKb4kcRxeCxHQvhwolB/WMDWie5j
         S+YgENzMj2U8wQe1ZVZHOFpDgvGR8cOijTk/nhC98miY86HvlmlnWrxv1EyLay3untW1
         qN8XC9vt1OFUbO4URqzs2ROjf90ubtadopfqmnZ26e0GVpnx4GgERnkPSA5yTwwFTkrI
         vx5M9P+bE7pjcLS9sXDkgoU4L+/EM0KSDN2OYBkoCMKTnOE89qbrNDpPG2rIdxibrkkd
         wmJKeJiA858MdhNcSVfPTVF44ry7HW5VJuesTowmOGy2QHmN9OAR7o2NEN463MMjEjma
         UojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wHtH4uowNcGLatA4FtFRbjnON3Vo2NBBY5rs+rY1XYM=;
        b=rgkBovCbd9fwoNMw5Z6/avO//rGNM1f8uM7ILwG8+A23oXov+RRasvklntlWV8RJOO
         EK59Q95t39OEIK4XhVI293ZrGdqfsud3iieL6nYiTUpps02Pp2i5YT17jEHleGn1JjDN
         wB6xK19S6xXONM4eoriYZPqN/nX5To/61h48uzoz9xaFlVNiE/AmqZGFcCWR66BZDRSH
         YSq8g7L9Kv6vq55c4RlTG87gJMU1l3zjwwXl73cOG6n9pkmtbG7crP2fpyjl8BxUsBlQ
         TOXbwQ3dKq9aVceaFMw25tzkI/AReQDK2s/CR2TCnUqi4kchZUdeS3UFmIQGRsOgVOlk
         EajQ==
X-Gm-Message-State: AOAM530gXYtUP1K2AnO9gGGqAezv2wWZNrRT+M60amqu3IqLHevO6FCk
        jhOyAPITTFz/XIuYSxdisn4=
X-Google-Smtp-Source: ABdhPJyLN0lTFVvklgpmZ30pvlCxugWOf9z9tIo7tvO8Mb/6UQRc6bzpJfdAw8tqwM2NpP8EgiFEVw==
X-Received: by 2002:a17:90a:4b0d:: with SMTP id g13mr1897325pjh.77.1623309766287;
        Thu, 10 Jun 2021 00:22:46 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:45 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 5/8] bfq: remove unnecessary initialization logic
Date:   Thu, 10 Jun 2021 15:22:34 +0800
Message-ID: <686dd8506bb511ae181a99c9b45f287233aa2ecf.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
References: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072234.BoYduqQt9o3ZiExo63RK3u2a8h126URC6ZoybZKAi68@z>

From: Chunguang Xu <brookxu@tencent.com>

Since we will initialize sched_data.service_tree[] in
bfq_init_root_group(), bfq_create_group_hierarchy() can
ignore this part of the initialization, which can avoid
repeated initialization.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 50d06c7..c8c68dc 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1429,15 +1429,11 @@ void bfqg_and_blkg_put(struct bfq_group *bfqg) {}
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 {
 	struct bfq_group *bfqg;
-	int i;
 
 	bfqg = kmalloc_node(sizeof(*bfqg), GFP_KERNEL | __GFP_ZERO, node);
 	if (!bfqg)
 		return NULL;
 
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
-		bfqg->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
-
 	return bfqg;
 }
 #endif	/* CONFIG_BFQ_GROUP_IOSCHED */
-- 
1.8.3.1

