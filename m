Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD590C433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A015E6147E
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 09:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhENJRc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 05:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhENJRc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 05:17:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5841BC061574
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 02:16:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so1364935pjb.2
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8seeBM5LE0O8pctDLlP1jLCUk2HggkCK3lvKT09jHQA=;
        b=KcyA9pZxxhdnXsKIZmCaSzi3NTQ08eksn/mDJc+QB1+k0OOifyFFWattzyEb5MnfXH
         dVD++zeNFUSo1a0XdrzVNTT+1d6qG3TX9/e+He+6njisqcP2JYtIX+Yt0usE6Z1z7dZ6
         v6ORKyiAjn5WqdhrKTnMfesgHbRnHuMsn32ApW3GxqGi32dnz9OZ7T7sTIYQTj2If6oV
         DQg+jv2kDywd4A1n2LQqEsLy/L6eB1Dcty3NrVGvA1Dqbk67FToVrtKyna+MajhkmNdq
         i6NsMo9ZyQKJ/qYzVJtc5Jt2iv5fhw4ISJg89ux0xneJMHUa7JyKn7XCS9CBu+/M3046
         ocbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8seeBM5LE0O8pctDLlP1jLCUk2HggkCK3lvKT09jHQA=;
        b=W1e/mlZE614aLsRsL1yYpMQKomGXtP1aVbPd8boPYVz3aDfX8EWJQHkk/SJgM5/zd0
         hVyxFvY3iEm37TyTyxBnkU28KOmq/6kmgRVtXSZ6JxTUY13IicKJwMwzq/5/uj22H9ZT
         dMatRsEX7FyWkHhl7b5R5k9JktJvDsbg3zi6q7VmvEzuBwhPS5M7N5S+x0A2fGBrbjHz
         y00Xzmh0w6Fhj9Y9iiBb8/XZZ1y93Ml4QpQdwCCpIZ/CU5JJob4jLVYIwOOH0uClr9NK
         E13BSewYY4faZnCuU6xQPIy+0y5M0FnegOUuvsSPxyoVUe4WII1ah8uHoZ57eRjqyeCd
         SwYQ==
X-Gm-Message-State: AOAM531P2p7xy8UgKj9Ciq2bop9KzxJi05t34/mqdxhpp8Uhy2FDFTvv
        Pq0sjQGkkggBxqtuvXrDwiA=
X-Google-Smtp-Source: ABdhPJzJIu8h9R6RVI9GNNMRPKv1sHzx0acgizMaM6MvxB0pNMluIBJkOXg8XuMv0rg9yyLhFtEufg==
X-Received: by 2002:a17:90b:1b48:: with SMTP id nv8mr10338489pjb.39.1620983779790;
        Fri, 14 May 2021 02:16:19 -0700 (PDT)
Received: from yguoaz-VirtualBox.hz.ali.com ([106.11.30.42])
        by smtp.googlemail.com with ESMTPSA id q18sm3828292pfj.131.2021.05.14.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 02:16:19 -0700 (PDT)
From:   Yiyuan GUO <yguoaz@gmail.com>
X-Google-Original-From: Yiyuan GUO <yguoaz@cse.ust.hk>
To:     hare@suse.de
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, yguoaz@gmail.com,
        Yiyuan GUO <yguoaz@cse.ust.hk>
Subject: [PATCH] block: add protection for divide by zero in blk_mq_map_queues
Date:   Fri, 14 May 2021 17:16:09 +0800
Message-Id: <20210514091609.66252-1-yguoaz@cse.ust.hk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <21cb65d1-b91a-2627-3824-292de3a7553a@suse.de>
References: <21cb65d1-b91a-2627-3824-292de3a7553a@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function blk_mq_map_queues, qmap->nr_queues may equal zero
and thus it needs to be checked before we pass it to function
queue_index.

Signed-off-by: Yiyuan GUO <yguoaz@cse.ust.hk>
---
 block/blk-mq-cpumap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 3db84d319..dc440870e 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -65,7 +65,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 		} else {
 			first_sibling = get_first_sibling(cpu);
 			if (first_sibling == cpu)
-				map[cpu] = queue_index(qmap, nr_queues, q++);
+				if (nr_queues)
+					map[cpu] = queue_index(qmap, nr_queues, q++);
 			else
 				map[cpu] = map[first_sibling];
 		}
-- 
2.25.1

