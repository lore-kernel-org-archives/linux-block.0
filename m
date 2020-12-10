Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A45C4167B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B22723BE5
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgLJKTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLJKTa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:19:30 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DBC0617A6
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:33 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id h16so4882327edt.7
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1awzXDTD2OO7hinTkZTbXg+d34hetKU44PxypjgAm/U=;
        b=PW8i6GNTDEts8xVCi5xucWAFxFPuh2dmJbYEcpich1+UKKLdiqDckiBNu2BrG7rznM
         OzCpZOn03eU5AZBM3tlqmidbAAiAAuFTFsH3r/e6ofUJfZlfyMV+turURnHvhdz8iklE
         ZECt+NZzkjU5hhgF9CDHKOIypRrx0RlcNaDAHMRPYQGLQyh/G2kMFgnaVnphiboL+EAh
         ZoqVsVIKgtJ179vwwZmmySyEYU3hqttzBkzVk3lBa269DUvnPDHz0w1M8AkpL7z4jLk6
         PW+FBoxe8OdPr6G19L7TWAEPJF3EwVCIL3zuA3tX1d2AvFzK3GDBSfDh0I6svngqHILJ
         HfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1awzXDTD2OO7hinTkZTbXg+d34hetKU44PxypjgAm/U=;
        b=OPysBquLKmqWrfuEim1LBiYzN6PNAjgyiQzmWQ1pLR89qhCzg5BSI2ubVCO5Vudovk
         4N3DAUxvibm3WD4Oa16cnh5ujvSNThCPodGCATtzAo9IndznJ3i1g6l7fIxDJYFXJkgr
         H986lPTC7LCRUE/WiqrfixQcZ5C/xYQbxe0C0CtAdkwkvw/jvVpgCQAyP5Xpo4a7NSiY
         zEfFcJ24Jj7sfMSNYdEOO5X45evxb4XENilVCzYidrdEXqM1jq/zHURTRaX6OpWAabMX
         9TrpwbiW0i/T1E9+m/Qv5ayefXVhxzQ49Kuvcq2bm+H1rfUNKe7UTnQ+BMKALyZJu4Xl
         yyAA==
X-Gm-Message-State: AOAM53355q+Hb6v/WOWvogDbvaKrpzKbqZHS1i4ucut5hIhDQznPR3IH
        jbAfuAcBqdtxRAjbr+g7rSRu62XNnMGS7Q==
X-Google-Smtp-Source: ABdhPJxpJYcVSQ3/3P6wNfPRPm4yPXtyWTGh7XJkUqTl/kifz6l0UCesCSHohXtnZPimNCGimZpsLA==
X-Received: by 2002:a50:fb85:: with SMTP id e5mr5899374edq.153.1607595511745;
        Thu, 10 Dec 2020 02:18:31 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4938:300:58f0:963a:32b2:ff05])
        by smtp.gmail.com with ESMTPSA id s24sm3955878ejb.20.2020.12.10.02.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:18:31 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com
Subject: [PATCHv2 for-next 4/7] block/rnbd: Fix typos
Date:   Thu, 10 Dec 2020 11:18:23 +0100
Message-Id: <20201210101826.29656-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
References: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index d63f0974bd04..3a2e6e8ed6b1 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -359,7 +359,7 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 	 * 2nd reference is dropped after confirmation with the response is
 	 * returned.
 	 * 1st and 2nd can happen in any order, so the rnbd_iu should be
-	 * released (rtrs_permit returned to ibbtrs) only leased after both
+	 * released (rtrs_permit returned to rtrs) only after both
 	 * are finished.
 	 */
 	atomic_set(&iu->refcount, 2);
@@ -803,7 +803,7 @@ static struct rnbd_clt_session *alloc_sess(const char *sessname)
 	rnbd_init_cpu_qlists(sess->cpu_queues);
 
 	/*
-	 * That is simple percpu variable which stores cpu indeces, which are
+	 * That is simple percpu variable which stores cpu indices, which are
 	 * incremented on each access.  We need that for the sake of fairness
 	 * to wake up queues in a round-robin manner.
 	 */
@@ -1666,7 +1666,7 @@ static void rnbd_destroy_sessions(void)
 	/*
 	 * Here at this point there is no any concurrent access to sessions
 	 * list and devices list:
-	 *   1. New session or device can'be be created - session sysfs files
+	 *   1. New session or device can't be created - session sysfs files
 	 *      are removed.
 	 *   2. Device or session can't be removed - module reference is taken
 	 *      into account in unmap device sysfs callback.
-- 
2.25.1

