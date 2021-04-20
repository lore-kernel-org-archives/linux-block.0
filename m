Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F942C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BA613B2
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhDTLVK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhDTLVJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384AC06138A;
        Tue, 20 Apr 2021 04:20:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu16so17659565pjb.4;
        Tue, 20 Apr 2021 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tfZJcsESVJJ7LF8DyaFqXDwDLdv4yW2KMDeBAC866jo=;
        b=HHlhkFuIT3/E5oLlfNfJToXUKA4q4QJqlBFVsRIiZB+9wu5yf2mtd+cQ/IPhUC22ON
         odRSdjzuYwQjrh6m9ZSyUKdRr6Eg31izfhHUVkrwbvtr/r43FPoTmJB0oiCInUDskMaP
         WOLKw2nfh71WRLarYH4+M5u+mzOgD3wU32KSsmo2ftT6AQVuDK6UcYptgWeyAswgxwGz
         bAvGB0raoTbqwAyj21X87L0gpAzG5U5KM5eFU4OYho8Z2qsiFTdtaOEvJWTTa9mJnLCN
         JFlqgsZbfSDdhITrYTNrHTZHvZ7WRRr43z/l3E8yvuuxhL/tKNstgnNBVYR0vxlokEp2
         duYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tfZJcsESVJJ7LF8DyaFqXDwDLdv4yW2KMDeBAC866jo=;
        b=CT8WBZxind3Dor6hjjoDBcQWcw7cSyaFGizLENyOOeCur3OFFyvImkCNes3H9NwSCj
         VN8SKIw1jDCwDR6Pc04ieBnfeO5RR98Aow86/d5c8wliPvGA6ctyre/t95cQrnwVPJJn
         XCc4mEgPjabHYFSJnW5PHvMf9J3JxRCrq8OmAdgvX23YKJLNez14Mm2jDauBOMV4FtfY
         XjtTSYY5Cm/NDYjkHW9QdeCHeHDJ3BhajWnxJk5zMMSPl/TX9IAhrRIPQg3umZrCYqE/
         y8uK3PNgaplxdlVpD6bpYlPG55C86KZaU+62gbrat8tlGR81o3oMDrsN1zC4myvOY+E/
         RUxw==
X-Gm-Message-State: AOAM533SfrfZGsv0oQES3R/OkVl9i7b5bc/5TEaSgXsEv+On+NGmQ9rd
        GRxHvbuXgUktF561CLErIOc=
X-Google-Smtp-Source: ABdhPJwhtKio1/NXn2mOTJSCoi6eeI7xCDByM6/15sltzKq6VIfjBHwyKeRKrz4+6GR7/Y6wV5XxwA==
X-Received: by 2002:a17:90a:6f45:: with SMTP id d63mr4459617pjk.39.1618917638072;
        Tue, 20 Apr 2021 04:20:38 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:37 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] bfq: reset entity->prio_changed in bfq_init_entity()
Date:   Tue, 20 Apr 2021 19:20:24 +0800
Message-Id: <34c02f3525ed632ea1878591b41174aee50e953d.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since weight, ioprio, ioprio_class will be updated in bfq_init_entity(),
st->wsum will be updated in __bfq_activate_entity(), so when it is first
active, it seems that __bfq_entity_update_weight_prio() has nothing to
do. By resetting entity->prio_change in bfq_init_entity(), we can avoid
unnecessary logic calls.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c8c68dc..79a5aaa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -426,6 +426,7 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
 
 	entity->weight = entity->new_weight;
 	entity->orig_weight = entity->new_weight;
+	entity->prio_changed = 0;
 	if (bfqq) {
 		bfqq->ioprio = bfqq->new_ioprio;
 		bfqq->ioprio_class = bfqq->new_ioprio_class;
-- 
1.8.3.1

