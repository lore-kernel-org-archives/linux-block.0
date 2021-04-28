Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B23DC433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BD461418
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhD1GO6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhD1GO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 02:14:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4ACC061763
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gx5so752773ejb.11
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HN76YNCopOUfvfBy/lksY+1E2cxekdLf/6fjdkK043U=;
        b=hERUOW+J5ug2xAvXyJrhYW+M2xFohVRto1G9pYwpoDIG5cZ0nhZv7r3wglOrWZWk+D
         nYZkHYckQxDLMXFZfeYVZtsSSJF4gd+TxPA1pEnwH8BaE/kFTTjoHP9JNTn1Sbi4KZsI
         nip+2zf6YYJRqhAYnmy9VKrnNkF7DZ59Kuy1BsfAwWcwHVLBVUC62cnIoUwKmoh2H2Jq
         lkD/EuPpEcGpATbF9qzAr/ubqhrfqRwqzJEOzPewprY6hZLSLh1F/O6zkkm/JeTX6SdQ
         BG35K4moBmwTwnLKIHoRscDs0uG0RNgx1gFDaGpE1YAxDokk69IjzAW2ZZ6qb4hZzXiH
         PfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HN76YNCopOUfvfBy/lksY+1E2cxekdLf/6fjdkK043U=;
        b=Vh+QQN1Bm5kUItHTiZxbCQCnTIltSiCgN2k2/UIoVXAk4xw3BNEXAWfha2D996s2Ew
         BrONm7vdZcSJKai5+XFcY7Hn3OmBkBktGuKziq9yPDWEPdxUG3rMGEYDYbhZrhcpbEV6
         MoBierIGcny9q7FcbKoYxYLTnVIunT3gaJMMHGptFvhfJROeeRi94D7AdLNY5JB7loCy
         khRfXQbf5NJQ65Fop3LnJ4KM4Xzn2o2oqZ7kd2xpRh1R3gHkj8RJrikMLyOgNMsfpv+C
         SRc+7kwMKRgoxISZ2tJXY7aJRsb6Iu05+J0yewA5WvBkRVlH/A9AIjMaEN6XqqBjfCfR
         aKbA==
X-Gm-Message-State: AOAM530btInzvtfOnZbeeD4jwtfxcUdlIiWNPIBYl5MX+Hfe6M3oCW0B
        Xj6o6WeVH15ymfjLswfaWacWmskZMf0VDg==
X-Google-Smtp-Source: ABdhPJw280wLG65bMjbT4bjeZulTXoATrvsKQqD+rUXLUaMcnBuNcoNX36QkShYeMPpbwfDY7gofKQ==
X-Received: by 2002:a17:906:4486:: with SMTP id y6mr10435953ejo.466.1619590452644;
        Tue, 27 Apr 2021 23:14:12 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5ae8b9.dynamic.kabel-deutschland.de. [95.90.232.185])
        by smtp.googlemail.com with ESMTPSA id t4sm3970322edd.6.2021.04.27.23.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:14:12 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 3/4] block/rnbd-clt: Check the return value of the function rtrs_clt_query
Date:   Wed, 28 Apr 2021 08:13:58 +0200
Message-Id: <20210428061359.206794-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428061359.206794-1-gi-oh.kim@ionos.com>
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

In case none of the paths are in connected state, the function
rtrs_clt_query returns an error. In such a case, error out since the
values in the rtrs_attrs structure would be garbage.

Fixes: f7a7a5c228d45 ("block/rnbd: client: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 15f831159c31..f855bf1fa8d5 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -691,7 +691,11 @@ static void remap_devs(struct rnbd_clt_session *sess)
 		return;
 	}
 
-	rtrs_clt_query(sess->rtrs, &attrs);
+	err = rtrs_clt_query(sess->rtrs, &attrs);
+	if (err) {
+		pr_err("rtrs_clt_query(\"%s\"): %d\n", sess->sessname, err);
+		return;
+	}
 	mutex_lock(&sess->lock);
 	sess->max_io_size = attrs.max_io_size;
 
@@ -1294,7 +1298,11 @@ find_and_get_or_create_sess(const char *sessname,
 		err = PTR_ERR(sess->rtrs);
 		goto wake_up_and_put;
 	}
-	rtrs_clt_query(sess->rtrs, &attrs);
+
+	err = rtrs_clt_query(sess->rtrs, &attrs);
+	if (err)
+		goto close_rtrs;
+
 	sess->max_io_size = attrs.max_io_size;
 	sess->queue_depth = attrs.queue_depth;
 	sess->nr_poll_queues = nr_poll_queues;
-- 
2.25.1

