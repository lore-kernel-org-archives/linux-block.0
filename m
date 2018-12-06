Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A3C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13078208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VA9RMPgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13078208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLFSSq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:18:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37437 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLFSSf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:18:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so1453191wru.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RfVPSbe8COb3JfBcyAa/yaISs2N1Qoc4T/gKzQMBMBc=;
        b=VA9RMPgOdFcTDws5kwhkDGg5hNmYuVJC8XxTFUhD2NuBAfGrVlVJ9X3hTCG+Smtxlt
         aLrB59gGuyo15j7yMiWi2NGnls05UYpe1yu0NMBaoC+CkmYSexzCFLVb2y/xQgQTAZf2
         Jqb1bhkgP++dxt9tyrlh+X0BufXuK6Lt9L0YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RfVPSbe8COb3JfBcyAa/yaISs2N1Qoc4T/gKzQMBMBc=;
        b=qcegmHyAIvaomLEFgnGvHjDkMmq1K5oLRB7FyxFpk6jqRNJQ/5UrM6UxfMIosbtn35
         UOMlbiV+C2KBKl6ZriBajGAhjWlwqe73m0sLT9a3TJ5nQjqjatnEhG4nj1Cn97xVU8za
         /JoZFvLdFN+Zz39/lzYhvZWdUs2wjwrHB3T0b7pftlNuDCfECFrJgkO12ddu3GynA1S/
         8qF6w8H8oVPo5Mmu8DCoJc8Hnqv4qNl9QkgclZQaktshFcPlVg7dXMWJugIFby8/sWcw
         uWA0OnYwpYLsI97br+N4jprQ+VpQmpEQz7gWrsZ72/VOtO2PDHbxJpdfqPqJxgViz7ol
         cUuQ==
X-Gm-Message-State: AA+aEWZa++pTo4+f8crZPn1tcdTXvO2oEZF0BEHweJLpkpCJLnWJqHy3
        BSiOu0O6DopCGEWw0xdgj+CLOR/GfqY=
X-Google-Smtp-Source: AFSGD/W/+LH5wB3qV1U4XVfNkgBN/afXd5dBI/zUB/aaPqdZsrAOwZ1PxcRfvPHaIbdJsoO5rsKPpA==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr26615236wrv.25.1544120313858;
        Thu, 06 Dec 2018 10:18:33 -0800 (PST)
Received: from localhost.localdomain (146-241-0-214.dyn.eolo.it. [146.241.0.214])
        by smtp.gmail.com with ESMTPSA id w18sm727733wru.54.2018.12.06.10.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:18:33 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 2/2] block, bfq: fix comments on __bfq_deactivate_entity
Date:   Thu,  6 Dec 2018 19:18:19 +0100
Message-Id: <20181206181819.11148-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181206181819.11148-1-paolo.valente@linaro.org>
References: <20181206181819.11148-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Comments on function __bfq_deactivate_entity contains two imprecise or
wrong statements:
1) The function performs the deactivation of the entity.
2) The function must be invoked only if the entity is on a service tree.

This commits replaces both statements with the correct ones:
1) The functions updates sched_data and service trees for the entity,
so as to represent entity as inactive (which is only part of the steps
needed for the deactivation of the entity).
2) The function must be invoked on every entity being deactivated.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-wf2q.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 63e0f12be7c9..72adbbe975d5 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1154,15 +1154,14 @@ static void bfq_activate_requeue_entity(struct bfq_entity *entity,
 }
 
 /**
- * __bfq_deactivate_entity - deactivate an entity from its service tree.
- * @entity: the entity to deactivate.
+ * __bfq_deactivate_entity - update sched_data and service trees for
+ * entity, so as to represent entity as inactive
+ * @entity: the entity being deactivated.
  * @ins_into_idle_tree: if false, the entity will not be put into the
  *			idle tree.
  *
- * Deactivates an entity, independently of its previous state.  Must
- * be invoked only if entity is on a service tree. Extracts the entity
- * from that tree, and if necessary and allowed, puts it into the idle
- * tree.
+ * If necessary and allowed, puts entity into the idle tree. NOTE:
+ * entity may be on no tree if in service.
  */
 bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 {
-- 
2.16.1

