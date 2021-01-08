Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A752C4332D
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8B23884
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbhAHOh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbhAHOh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 09:37:57 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692CEC0612FF
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 06:36:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u19so11451711edx.2
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ScMrBuTqjTl8319DDqHcMUIBD1FsCL0Z6pG3bPYJIM4=;
        b=H7A4uGKBnPTa7bvvSnMq0Jt7V5kVZC/xTLbWWQzKDgMLJSXQqVKt7sXR1j973lyYkV
         OtQj49+RUzyS4i7VBPhEpgV5AMy6HT+7lkTadhZ1r+706jrfSR0kdTvncTDteo50trpZ
         5PAnYsYm9O7MannRIMDUW9+z34ZwXQGKsMmzjDFHLOsgHDV5Pm2/DN2gnZKokVaANUT9
         WJKiZwvlsCmuz8EYg2yXncGnVG/EsFyz3EV9VAbYYsxZMzZXF6bL0n35AaXqnBkjcPGW
         mom0VEaQj1Aqzi0B/ZFvZLghVREBwOSsgWlZQtB6i4B94hIhRwhj10KD5X8Prd8Lin83
         EyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ScMrBuTqjTl8319DDqHcMUIBD1FsCL0Z6pG3bPYJIM4=;
        b=VxF0uBLPxK92MeBqDg/6lN49H9bnjzD6Zr5xq+BBlEgcRDQKrHqIG6XXrvM2RNjNCS
         TV0uQ+pzWbk/Ldd/gRDCDIdBLuZDqupl/lcyNMPGrq60CKj2KiDD9F2Rto4tpuGkK9CI
         p5wvTdYBXkhOGpPSZKJaEHiYEjXv8b7oxQ33do/jhZmrc6KB1QyPXOl0iChSUFgzWLsL
         DSWTaeJMm6cqRu24vOOJEv1VNYiUMACFEU6SDxVSi17xMFyWA44NgBb394/DuRXrJK2X
         faxwiKM7m1s5k0kFBy1zhvxCwQSDlMPE7mbFx8V3F0Lc1XEljk23pYP1dWPysqxBg1bQ
         VAIg==
X-Gm-Message-State: AOAM532qOxnieuVey1B7tvy9RDRR1aBwmDXV5hs52w2WlXkqhra3iW4K
        3RbVyfkqksGCaPOHjIWLg8T7YfgPiki/1A==
X-Google-Smtp-Source: ABdhPJz+Vb7nmsHRmskf7mb3upTeTt8wbLoY7+LjVjje+rEqNONSgjuvL2ZTD5AbrJkjoFBCHrn8Ow==
X-Received: by 2002:aa7:c58a:: with SMTP id g10mr5409627edq.315.1610116600052;
        Fri, 08 Jan 2021 06:36:40 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4906:c200:31ac:50df:cd1f:f7fc])
        by smtp.gmail.com with ESMTPSA id e25sm3858698edq.24.2021.01.08.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:39 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-rc 5/5] block/rnbd-clt: avoid module unload race with close confirmation
Date:   Fri,  8 Jan 2021 15:36:34 +0100
Message-Id: <20210108143634.175394-6-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
References: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We had kernel panic, it is caused by unload module and last
close confirmation.

call trace:
[1196029.743127]  free_sess+0x15/0x50 [rtrs_client]
[1196029.743128]  rtrs_clt_close+0x4c/0x70 [rtrs_client]
[1196029.743129]  ? rnbd_clt_unmap_device+0x1b0/0x1b0 [rnbd_client]
[1196029.743130]  close_rtrs+0x25/0x50 [rnbd_client]
[1196029.743131]  rnbd_client_exit+0x93/0xb99 [rnbd_client]
[1196029.743132]  __x64_sys_delete_module+0x190/0x260

And in the crashdump confirmation kworker is also running.
PID: 6943   TASK: ffff9e2ac8098000  CPU: 4   COMMAND: "kworker/4:2"
 #0 [ffffb206cf337c30] __schedule at ffffffff9f93f891
 #1 [ffffb206cf337cc8] schedule at ffffffff9f93fe98
 #2 [ffffb206cf337cd0] schedule_timeout at ffffffff9f943938
 #3 [ffffb206cf337d50] wait_for_completion at ffffffff9f9410a7
 #4 [ffffb206cf337da0] __flush_work at ffffffff9f08ce0e
 #5 [ffffb206cf337e20] rtrs_clt_close_conns at ffffffffc0d5f668 [rtrs_client]
 #6 [ffffb206cf337e48] rtrs_clt_close at ffffffffc0d5f801 [rtrs_client]
 #7 [ffffb206cf337e68] close_rtrs at ffffffffc0d26255 [rnbd_client]
 #8 [ffffb206cf337e78] free_sess at ffffffffc0d262ad [rnbd_client]
 #9 [ffffb206cf337e88] rnbd_clt_put_dev at ffffffffc0d266a7 [rnbd_client]

The problem is both code path try to close same session, which lead to
panic.

To fix it, just skip the sess if the refcount already drop to 0.

Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c696c3a937d7..7bdd26229c70 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1697,7 +1697,8 @@ static void rnbd_destroy_sessions(void)
 	 */
 
 	list_for_each_entry_safe(sess, sn, &sess_list, list) {
-		WARN_ON(!rnbd_clt_get_sess(sess));
+		if (!rnbd_clt_get_sess(sess))
+			continue;
 		close_rtrs(sess);
 		list_for_each_entry_safe(dev, tn, &sess->devs_list, list) {
 			/*
-- 
2.25.1

