Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601CEC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166F723AC4
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgLJKTW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgLJKTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:19:12 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4EEC06179C
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:32 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id r5so4875222eda.12
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1nkDS+t71lcZcyKCx1EdDkNSPvYcn8wLT9ZWpiLudM=;
        b=RPWNMP+eTWP+4JQCgK9cGj2p75kCnnScwZcNskA6nn+FE5Tj+LiOYEzLHlEPnZgk32
         CRhmOvzgn09XqFTBDDRX7Ye1pb/+T0WAJp0g7w/s5Z6z6ZcsfA+MJ3325eouJjrR41vU
         2svmKzmjuxSnkWeUe8GK/txAmmNHPL4g5sNLbMR6sYgfBFQLMIgBx84IA9JlMwtgMXe2
         C5Wg6v2X+7sqnsr5sUFmNhmKLWocWf+GD/x/wJu/qdLpd3n9EzPxc9agLqsxoAqMWIi4
         lJu9wmIg2OPu6jqU28TsE818eAchQCFRSLS5XK4GIHUXnILCjIwqHYsWfKg4P1jbVxVR
         LYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1nkDS+t71lcZcyKCx1EdDkNSPvYcn8wLT9ZWpiLudM=;
        b=YgZjJzf+sN9XvLDKxjIbiiO4bU7Xojhf9qfQbTJr2pK+ljrWwI6CJh8GQfXDoVYHzZ
         CHcX2uwhE8PnldH+TxYRtb6b1mGKO2DbaB7EpVZlVzic4g0b/XzmbZ6Sl06yHuq1ozQs
         Suj5OEgzkzzTa6Frl4sGuMP2ZtLRAlwOGgYX2JcnAdfSOEy2FrxwjBy0elhdEHStbMyF
         5GCruxvSe9nRNdrsy0wuNJyNV64+9DvTA7gKeVS1hWYrJp3vIsZCCCsW721Js6IU6LQ/
         j3aeFQpC9OnpmlJvMGiHSzTGdiEkd8Eq3OFVyyaqM4mADhkN7VSE281VwSY3+i6Gckdn
         RKBQ==
X-Gm-Message-State: AOAM532syfCVXW29MhwWwkZ21INSMhrkHlTXYgiMgtHY9q4M/zjhZEoa
        z/EM7Uad9wU356mv4imfspXlSSJCVKkapQ==
X-Google-Smtp-Source: ABdhPJwnQ1TRux1B6UlziLnXPzzWJZwvKYrSzLotnDqvsHV8veLu14vOvU8L2S9fQQGE2IhQqxmPaw==
X-Received: by 2002:a05:6402:16c8:: with SMTP id r8mr5909508edx.59.1607595510758;
        Thu, 10 Dec 2020 02:18:30 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4938:300:58f0:963a:32b2:ff05])
        by smtp.gmail.com with ESMTPSA id s24sm3955878ejb.20.2020.12.10.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:18:30 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 3/7] block/rnbd-srv: Protect dev session sysfs removal
Date:   Thu, 10 Dec 2020 11:18:22 +0100
Message-Id: <20201210101826.29656-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
References: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

Since the removal of the session sysfs can also be called from the
function destroy_sess, there is a need to protect the call from the
function rnbd_srv_sess_dev_force_close

Fixes: 786998050cbc ("block/rnbd-srv: close a mapped device from server side.")
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index d1ee72ed8384..066411cce5e2 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -338,9 +338,10 @@ static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
 
 void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
 {
+	mutex_lock(&sess_dev->sess->lock);
 	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
+	mutex_unlock(&sess_dev->sess->lock);
 	sess_dev->keep_id = true;
-
 }
 
 static int process_msg_close(struct rtrs_srv *rtrs,
-- 
2.25.1

