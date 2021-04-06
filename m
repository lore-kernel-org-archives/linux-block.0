Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C36BC43462
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015A4613B7
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbhDFHHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhDFHHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F53CC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k8so7792400edn.6
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PDpwO5lWof601MDA4aFO5d06aw+1og0zuKo6oNDR1E=;
        b=NR50vUPRhiH7XgucRRHk2mO0U6XDutBNEq5+DZaR8wvGog/+gFdzjlYXN+IqTb5/Qo
         x+uIBA4Yw2h/VIiD9cHXnHByOVG2i2+ogLF+2Tes39Ep6oXMZvcLSexhFfXwmyjml+vM
         r3/HNLcjkCRkpT3RLgDjbEWXPyq57gcGVRMhsdBEUQMC0RjSFdbXmXUece80iV64QRNI
         LT9O9/bzAIYfQ3QtKCrbMR5eaY3E5AzsU91Qz0WO2WtX9+CWQrMWr58E3rWHn10bcHJ4
         X9BylBuu/0gGxaYhKrUTxpA1FXaFbvpHhx/f3cS/ScvPXarKwbt+XRouR783r1nYU2BG
         FU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PDpwO5lWof601MDA4aFO5d06aw+1og0zuKo6oNDR1E=;
        b=FAJTiAMhoaLCw8Uk4kSWxL79PeJfVbjOu/u/G6BMhl3FvCn6i57TsvtHlgdLoPNHlC
         2lG0vlXpS5D3i0e4UMYW3dPAl3XRficR1BeOAtGyxTfubDYYFY/4Yzr6l2wXZ9AuG0l1
         3Ceqpx/UukKAv7sZEQ146U5ocZWiSeHv1ei1a4pgoIUPyH9faMTe8+66nx/r9yVlJG6I
         vOQpXOFYZJFWEoXDQNyo0g6uzG6TGy19Ik8SQ62VfyFeoUfjlPsqQOGxWuNw3EcxIul+
         wWCidoQhhvMNaHSUE8wa3UXdO5PxqoB55PTI5q7nYtFLi7RU5IHKEktMzyqpSZW5AGJc
         yZDQ==
X-Gm-Message-State: AOAM531qSvb0XhKTq6D9YyEP09LE6iHkxRkJKyN6PjUOGT1wNqfqjr4J
        EFtMcyUAz8QJxGxafR3Eb9rLdhbVGw1qgQ==
X-Google-Smtp-Source: ABdhPJzOI0s0h1Q4q0iKx95xmaqbzUzTBltX2svFwSteFbDuv4es82g5Vcra85HemMUoOHMUcRv/yQ==
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr22880910edd.344.1617692842220;
        Tue, 06 Apr 2021 00:07:22 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv3 for-next 03/19] block/rnbd-clt: Remove some arguments from insert_dev_if_not_exists_devpath
Date:   Tue,  6 Apr 2021 09:07:00 +0200
Message-Id: <20210406070716.168541-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@gmx.com>

Remove 'pathname' and 'sess' since we can dereference it from 'dev'.

Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 45a470076652..5a5c8dea38dc 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1471,14 +1471,13 @@ static bool exists_devpath(const char *pathname, const char *sessname)
 	return found;
 }
 
-static bool insert_dev_if_not_exists_devpath(const char *pathname,
-					     struct rnbd_clt_session *sess,
-					     struct rnbd_clt_dev *dev)
+static bool insert_dev_if_not_exists_devpath(struct rnbd_clt_dev *dev)
 {
 	bool found;
+	struct rnbd_clt_session *sess = dev->sess;
 
 	mutex_lock(&sess_lock);
-	found = __exists_dev(pathname, sess->sessname);
+	found = __exists_dev(dev->pathname, sess->sessname);
 	if (!found) {
 		mutex_lock(&sess->lock);
 		list_add_tail(&dev->list, &sess->devs_list);
@@ -1522,7 +1521,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = PTR_ERR(dev);
 		goto put_sess;
 	}
-	if (insert_dev_if_not_exists_devpath(pathname, sess, dev)) {
+	if (insert_dev_if_not_exists_devpath(dev)) {
 		ret = -EEXIST;
 		goto put_dev;
 	}
-- 
2.25.1

