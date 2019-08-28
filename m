Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05DAC3A5A6
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8945217F5
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F4caB0aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfH1DzE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:55:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44983 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfH1DzD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 23:55:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so544537plr.11
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2019 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxNtarX9nX57XJxkArjO2AM3QUOz0wzt/JnfD0VPOK0=;
        b=F4caB0aZl1+ljrrlr2ZXzSJ64Udep2IJeA7lQGcAGXBMsyDN9JCNHMO6FT0Ar5vP0v
         UnJCBrHKqZHlbtTQE09XNLLGK9s6lXCj0RfiEUYHCKkZZT3DyfafbE7GpO6RUlwg+E8T
         EDITDAEd81fTvZLyUoEhaX1ib77eZxhg/UoEi81UsG9KE3s0ZgZqgkTAa8cMari6sOBz
         BiasbpjnO/EnhLafHhn/4W5YObrmcFzXPTkbANjmau0q6sNwnLh/HDhWRGDe0dfDU182
         lkes5Qnwe7Mcqt21kTvs3UN/UlyCzS3m/4xDlaMvoRd5eiDJFX2ROW2Xo/vuHPiT5E/i
         l6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxNtarX9nX57XJxkArjO2AM3QUOz0wzt/JnfD0VPOK0=;
        b=lNHkpfE4Z5wno3eO+ogvtzQVvetkrtKAB2NaLWDOJLy+yv7F3i9mKolwLs25jQJUq8
         Ug/lJQR8tVGD+ve618xTjWGHou0U8LECRO8OusVzQIKdBZbezXBLDpgMlYAFLMAYUchj
         a+yXE6n1iI2vMEikm8Zt5mZIUyFAlAB3RB3zessytOlfyRt0n9PzZNiM6JSHt3feLOZW
         oVWeWjrye5JMQH134IuC2Cg8YVTuxLQitN7qsRdbUc8FQgHhUb+1iCIrD+l3wqE5muxg
         EwaH46NRkp3nAoKbsmHeHaAXVR6Tc8t7Kb74I8byVFIk+IAGMkgICisv07Oq2ZZOBm6M
         EeWQ==
X-Gm-Message-State: APjAAAW4avZQGjfHqFBHXw7o65NI9fzu2ychJiPDKa8RRyaDvKgTWHpM
        9WSkDDWrCN0PXOR0R9tmNU9t9g==
X-Google-Smtp-Source: APXvYqx3e2ELfBN+TGYLKM3FzD+6OoDzIwJzZbWpZcxu0XdIQBMS++7j1DfCl/f6RY1tc9dYTvz3FQ==
X-Received: by 2002:a17:902:aa43:: with SMTP id c3mr2177445plr.11.1566964502988;
        Tue, 27 Aug 2019 20:55:02 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id i124sm902847pfe.61.2019.08.27.20.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 20:55:02 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 1/3] bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
Date:   Wed, 28 Aug 2019 11:54:51 +0800
Message-Id: <20190828035453.18129-2-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The comment of bfq_group_set_weight says the reading of prio_changed
should happen before the reading of weight, but a memory barrier is
missing here. Add it now, to match the smp_wmb() there.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-wf2q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index c9ba225081ce..05f0bf4a1144 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -744,6 +744,8 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		}
 #endif
 
+		/* Matches the smp_wmb() in bfq_group_set_weight. */
+		smp_rmb();
 		old_st->wsum -= entity->weight;
 
 		if (entity->new_weight != entity->orig_weight) {
-- 
2.22.1

