Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1F8C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AABA61181
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbhJOOqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbhJOOqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 10:46:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB54C061570
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 07:44:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g10so39234047edj.1
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0AcRHxbsJqcdNBbA8ZycbNmfq6eGlGuizQ1L+4ECzU=;
        b=W+FWn4Mv/TO5KXHCMg0d0W+CHYKlkF/r179+o7IpLBUW+yvh+E4VDjXbrGum++Dwrr
         ZQnNzBqAEuA9LLXRqri1BiWxli+T3VZLszl85tGCbEWRihjJiAnlK1B8UXxDqmCAufsU
         P8VRPOjQwdKGO2y751hTEtPNOXIqPVhx2tabcBjJFXG4nvDaLyZSwnH1OVjFCcBPPTDf
         h3/SsqeVgD9hob784JuklDmox/3bRQwFNGsN/+O4Xls5bhJufOkrOeB6Mii9lzPCSnOQ
         6vAN6bvY0dH83IS2va0csRDBYQ7mKL/WYDrLWyFq70KW1nyt3uYMtTklBzkIU/YV1p3B
         zw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0AcRHxbsJqcdNBbA8ZycbNmfq6eGlGuizQ1L+4ECzU=;
        b=dVUycFyEHhodslbJOhu1L8BCwx6sPOZ3VR95K5/ljiQAeNsO0LCpfrYT6r3P1+35XC
         HeKV5X5Q6HkRJ3KoLWUnxKtjMBSzQYcOgL7t8o24c057POK9xRIXq8YDTBhuw8+l4zoQ
         Ia2hF4geppgz4JIkPrYJBj7QKPDWDexPTP2xrnNG46Vp2ILLmMqHjunvKC7D8opHQQoJ
         MBkWLnqWmzDPqH/ar/iamvjWRvnfwhnTy/V+CzPeJzLabFhhItzCnUz8lgTtrXv9jdOw
         iv+AQwMRZsCJIUZHBM0j00pIEH+84/olsdAl5lvMy3dw8EZqmcWaIHkiEKPdoGBEq7YF
         Dtcw==
X-Gm-Message-State: AOAM530CNSL1vTQpMFU/+8IW8GEAdEckK1sMihKgsmXqDvgXlM82syYQ
        yC47vs3bsmrfe94fFlKYpo8ybw==
X-Google-Smtp-Source: ABdhPJxMzu0t5qDegUTfDOxUEMUyRNB4PVT0CnESzMIapKxxoTzk89iMSV5b32F6EzqnDZ4XfQgClQ==
X-Received: by 2002:a17:907:3353:: with SMTP id yr19mr7070455ejb.508.1634309032135;
        Fri, 15 Oct 2021 07:43:52 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id v28sm4605365edx.21.2021.10.15.07.43.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 07:43:51 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Grzegorz Kowal <custos.mentis@gmail.com>
Subject: [PATCH BUGFIX 1/1] block, bfq: reset last_bfqq_created on group change
Date:   Fri, 15 Oct 2021 16:43:36 +0200
Message-Id: <20211015144336.45894-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015144336.45894-1-paolo.valente@linaro.org>
References: <20211015144336.45894-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 430a67f9d616 ("block, bfq: merge bursts of newly-created
queues"), BFQ maintains a per-group pointer to the last bfq_queue
created. If such a queue, say bfqq, happens to move to a different
group, then bfqq is no more a valid last bfq_queue created for its
previous group. That pointer must then be cleared. Not resetting such
a pointer may also cause UAF, if bfqq happens to also be freed after
being moved to a different group. This commit performs this missing
reset. As such it fixes commit 430a67f9d616 ("block, bfq: merge bursts
of newly-created queues").

Such a missing reset is most likely the cause of the crash reported in [1].
With some analysis, we found that this crash was due to the
above UAF. And such UAF did go away with this commit applied [1].

Anyway, before this commit, that crash happened to be triggered in
conjunction with commit 2d52c58b9c9b ("block, bfq: honor already-setup
queue merges"). The latter was then reverted by commit ebc69e897e17
("Revert "block, bfq: honor already-setup queue merges""). Yet commit
2d52c58b9c9b ("block, bfq: honor already-setup queue merges") contains
no error related with the above UAF, and can then be restored.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=214503

Fixes: 430a67f9d616 ("block, bfq: merge bursts of newly-created queues")
Tested-by: Grzegorz Kowal <custos.mentis@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e2f14508f2d6..85b8e1c3a762 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -666,6 +666,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
 	bfqg_and_blkg_put(bfqq_group(bfqq));
 
+	if (entity->parent &&
+	    entity->parent->last_bfqq_created == bfqq)
+		entity->parent->last_bfqq_created = NULL;
+	else if (bfqd->last_bfqq_created == bfqq)
+		bfqd->last_bfqq_created = NULL;
+
 	entity->parent = bfqg->my_entity;
 	entity->sched_data = &bfqg->sched_data;
 	/* pin down bfqg and its associated blkg  */
-- 
2.20.1

