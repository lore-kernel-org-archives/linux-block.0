Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783CBC3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3002469C
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI2MdFg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1QTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:19:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41394 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1QTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 11:19:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id b5so3450710qkh.8;
        Fri, 28 Feb 2020 08:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rcHTuvAOaz4tYd8jn3eVp37XThhB3BUEsbS4Oq9/Ti0=;
        b=QI2MdFg70JdoM+0mtQmYlNhBY/R8I9De/XO55Qw2Aao6kcTVTMq66d9TtSgvYAY4XB
         BaHg+Ai8Xprd5PReqzMNqv8qJ0TxbdScIwdt/+I8pg0Li+9l+3XxcJzQ0DPS5DE3Kyyv
         3NkiviaIPMf8s5ck94+/g2GdvDwk6ZhhldsS81Op1D/3iDZTfiYk6wZUr/e6Qk6V771j
         kBTr+gJQF1SZ66Q1Z1V/mrSWNwXYRSa6wCbKlc9ljGGAOFF6O38H/sVNa0aWsRc+Gk8w
         2PV2u5+0uDmXyxZSxHd1trnKBXMRt8rWJ8j2WHIIr8wXshZtDrG51SU50ckNeoxddIo0
         d7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rcHTuvAOaz4tYd8jn3eVp37XThhB3BUEsbS4Oq9/Ti0=;
        b=BSrCZ77dCwqi+SfY2fv/DauiRnx/J3pv8ggN33J1E1KMS8LlU54+sN3mQP9lla+NXz
         PIyMDFtK8dlsJhnMzxdQOyzBl33ro5l32FRiY951U6MSjQcPX4gUVSG7kiDc6r/T4mTw
         SUN/uHJnxqVANJvnjErTW7pvwIW3TbulEEK7rpwmSjh6ICEusLenM541X9hAc12ur3Kk
         Ey6D5IJGQ+lBfRSgvubh0WdCPgPCngw38X6tonGGlmZl634FPH34My3LTmA0GFbAS8Of
         IIcXKgIfgszV/4YJTX6h7yAmYba+wXBQ30srY1qYs9orB3vNIAZ7Ps4iN3uUgmTv2xFZ
         s10A==
X-Gm-Message-State: APjAAAWD6kD+A4ho1o70bWGXOgF+gn1jGLTl03vTiAt59gq8VBpuBFY4
        q2TKj2o3iVuKwM2VqccaFf4=
X-Google-Smtp-Source: APXvYqx9HquH0V8YJNmUsDuBlRTdbBRa4Lu0KOkH0veOcWdu40Metz2v89QhDe8kIJa7O4HO1oxbUA==
X-Received: by 2002:a37:61c3:: with SMTP id v186mr5114393qkb.96.1582906750449;
        Fri, 28 Feb 2020 08:19:10 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:500::3:7b95])
        by smtp.gmail.com with ESMTPSA id 133sm5368724qkh.109.2020.02.28.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:19:09 -0800 (PST)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Qian Cai <cai@lca.pw>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG)), linux-kernel@vger.kernel.org (open list),
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH] loop: Fix irq lock ordering bug
Date:   Fri, 28 Feb 2020 11:18:47 -0500
Message-Id: <20200228161847.28107-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"loop: Use worker per cgroup instead of kworker" in patch series
"Charge loop device i/o to issuing cgroup", v3.  introduced a lock
ordering bug. The previously existing lo->lo_lock was always acquired
as spin_lock_irq but never actually used in irq context. The above
patch started to use this lock in irq context which triggered a
lockdep warning on sysfs reading.

Fix this by executing file_path outside of the lock.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 drivers/block/loop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index eb766db48685..366658e60064 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -768,12 +768,18 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 {
 	ssize_t ret;
 	char *p = NULL;
+	struct file *filp = NULL;
 
 	spin_lock_irq(&lo->lo_lock);
 	if (lo->lo_backing_file)
-		p = file_path(lo->lo_backing_file, buf, PAGE_SIZE - 1);
+		filp = get_file(lo->lo_backing_file);
 	spin_unlock_irq(&lo->lo_lock);
 
+	if (filp) {
+		p = file_path(filp, buf, PAGE_SIZE - 1);
+		fput(filp);
+	}
+
 	if (IS_ERR_OR_NULL(p))
 		ret = PTR_ERR(p);
 	else {
-- 
2.17.1

