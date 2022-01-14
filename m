Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25838C433F5
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 15:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243053AbiANP7B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiANP7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 10:59:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E6C061574
        for <linux-block@vger.kernel.org>; Fri, 14 Jan 2022 07:58:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so6631367wmf.3
        for <linux-block@vger.kernel.org>; Fri, 14 Jan 2022 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvrEaZ+TQ6VKM77v4JB2rHZqwIdOcC3CwhFosRkDsHs=;
        b=O2FuFBto4FpgfdFenQNa7caaW9AUCJ+dOWfMoMSyY89NPKMdcmMVOx74gyDAUxStfv
         x034Qy0OIEEm4qFUsbPSLJW+ftQi/j7bOOxLnPn3MGNB/4H5bSPPz3seDhGvEVYwqSQZ
         eQ0x8r+CKwQZ9mVnjc3znO+DJeL24+WItPK+SCLoRKK5SLw5/gthnNaLqrbxc2yqxpD1
         lbdG+gqdwp0mTPYTSiX/LAJ/Rn9dY92t8r0VGYuq5m6uemZ2gj0R3NEmdRtOOKvcgtPf
         MtNuPfxURpE5l62FvwvWi4QfuIxNiTwGjh1Z1aRsThmqFZXyV7mnOfw9dbu/B3zFvkXG
         mtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvrEaZ+TQ6VKM77v4JB2rHZqwIdOcC3CwhFosRkDsHs=;
        b=njn3gqngg1uwTjAjDRn/87nQUIjllvnxqsK/RmOLYISZSaFp1s/zMdiGC4izu9anwz
         LlOqxzLDgvt59wdqN2fnBDOpXcSLh8v0Rd7ySkzxVlv2tYdDFGr1ud9WOd8G/9cxrOQB
         yUO/46oB6LXsJ9Qa8BB0kXj/z4lJqNQyoE+dlmm7O1ahrY1xJIDXlWVir3W/iiXIjwJf
         KvID1epQQVwxFz3tmkar8lwW9iu41y1859LWLXYG0rthTu6Zzo8w01hvQ3HHwp1C/P3b
         a8mU5qxgws18FNhNdP691ug1IKxCz7JdbQF4yVw2FTYkLk7BFyOEOxz/yZKkz17CmizP
         uxPg==
X-Gm-Message-State: AOAM5307Bjau/rG1xdULFw5AXL2SFPJCwx2h9EtKOLS9e/o3xtU5nc3J
        Gu28W6rsF1CuekZJeymrHM6ziWXGOPdZgQ==
X-Google-Smtp-Source: ABdhPJwlm1btaCCrqcgf6ZUBkh6nv0o5ZMAwWLzya77rokUM+YobG/SdkLUXueDKgWc5Cg7cGosHeg==
X-Received: by 2002:a17:906:c0d6:: with SMTP id bn22mr4668307ejb.740.1642175938048;
        Fri, 14 Jan 2022 07:58:58 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j5sm1930246ejo.171.2022.01.14.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:58:57 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 1/2] block/rnbd-clt: fix CHECK:BRACES warning
Date:   Fri, 14 Jan 2022 16:58:54 +0100
Message-Id: <20220114155855.984144-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114155855.984144-1-haris.iqbal@ionos.com>
References: <20220114155855.984144-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

This patch fix the "CHECK:BRACES: braces {} should be used on all
arms of this statement" warning from checkpatch

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 67a8edbaa1fd..8c24d3dfe35f 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1262,9 +1262,9 @@ find_and_get_or_create_sess(const char *sessname,
 	struct rtrs_clt_ops rtrs_ops;
 
 	sess = find_or_create_sess(sessname, &first);
-	if (sess == ERR_PTR(-ENOMEM))
+	if (sess == ERR_PTR(-ENOMEM)) {
 		return ERR_PTR(-ENOMEM);
-	else if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess->nr_poll_queues)) {
+	} else if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess->nr_poll_queues)) {
 		/*
 		 * A device MUST have its own session to use the polling-mode.
 		 * It must fail to map new device with the same session.
-- 
2.25.1

