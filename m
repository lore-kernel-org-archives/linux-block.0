Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2048C28E86
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828596500E
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhCLK4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhCLKzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF797C061761
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso15505736wmi.3
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xA52xjDJnHJLgzflByk0CYC2xv7fgNWSlI8xs2AjI2I=;
        b=yBhGkoCBvWZlTxApi3aQJCnXm6iZzfXW4lQ1f6lbu63T/UR1hwscaZQgi6mFsVg64a
         oiA/rWoXUQKQGJ5nth3GW+1+N6Q9vQ+LsOSskFQvM5+FfVpyUsxa1oVrzuO7bgSsVet+
         1LCEz6xdgaUNJ0NNVGWeHhf6ln0L/JSLz2qMsYBqA3fk6Yl2JEUPxgAQyQB+GlNOero6
         ZpeDtbIKY2N+DkzL73rgHW+TRdFtjfwk7QEw69eurO+gkMsQEIQpbkTgDWbcfs1q/+t5
         Bx5XTPDeM450Q5ULCtVDlRXPeZuf8JJp9FGJSRNnul8wY2tmaHUSIYbYczvw3aGjkxBJ
         9yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xA52xjDJnHJLgzflByk0CYC2xv7fgNWSlI8xs2AjI2I=;
        b=b49Ys+FZHGlxbGQWn4exSpn4ZDZU6a28B4ndct021jUMKsiWfelWx9/LIdCJzfRUvK
         Uf1OAgauloWc5MhsbGZpRAmN99EDCzXJ9s3/da0O9V48fF3YU6S/E3lqX9iGrv89k+IO
         gAYjA6d3oInfvKxs0Vyp3Uuy/Vv/Ww+rav3gSbWczW9cN+nUcpjncC9x/+1I0btNdZkc
         Lfuh/W/AWvifzW6NLXj75FQK7tpcEMOBdTzt7O7eg5dijeTwe/UGvaMVivpx1CxYBo1q
         cUF+oNtV691A2jVe+/O8bFINaV5v2WhZfGIz6j9uADmhjDfHX0tOMefmec/bjVb8/O84
         DSDQ==
X-Gm-Message-State: AOAM530a2CxXlHqtMgS8u+uCJQPzW1eO9DTeU66nfRSmQgjOqiohRzaS
        BonwL2tTf68Ixk/9r16Oww+xPw==
X-Google-Smtp-Source: ABdhPJyuSwTDyvh7rCaXNW786qrIPBHDymlJenX8Hl8exjSrhayuRqjYskb8CzXmWzlIWfVNFKDDdw==
X-Received: by 2002:a1c:9a0e:: with SMTP id c14mr12656107wme.34.1615546545649;
        Fri, 12 Mar 2021 02:55:45 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Subject: [PATCH 10/11] block: xen-blkfront: Demote kernel-doc abuses
Date:   Fri, 12 Mar 2021 10:55:29 +0000
Message-Id: <20210312105530.2219008-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/xen-blkfront.c:1960: warning: Function parameter or member 'dev' not described in 'blkfront_probe'
 drivers/block/xen-blkfront.c:1960: warning: Function parameter or member 'id' not described in 'blkfront_probe'
 drivers/block/xen-blkfront.c:1960: warning: expecting prototype for Allocate the basic(). Prototype was for blkfront_probe() instead
 drivers/block/xen-blkfront.c:2085: warning: Function parameter or member 'dev' not described in 'blkfront_resume'
 drivers/block/xen-blkfront.c:2085: warning: expecting prototype for or a backend(). Prototype was for blkfront_resume() instead
 drivers/block/xen-blkfront.c:2444: warning: wrong kernel-doc identifier on line:

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: xen-devel@lists.xenproject.org
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/xen-blkfront.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index e1c6798889f48..e57e3cd354fb8 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1949,7 +1949,7 @@ module_param(feature_persistent, bool, 0644);
 MODULE_PARM_DESC(feature_persistent,
 		"Enables the persistent grants feature");
 
-/**
+/*
  * Entry point to this code when a new device is created.  Allocate the basic
  * structures and the ring buffer for communication with the backend, and
  * inform the backend of the appropriate details for those.  Switch to
@@ -2075,7 +2075,7 @@ static int blkif_recover(struct blkfront_info *info)
 	return 0;
 }
 
-/**
+/*
  * We are reconnecting to the backend, due to a suspend/resume, or a backend
  * driver restart.  We tear down our blkif structure and recreate it, but
  * leave the device-layer structures intact so that this is transparent to the
@@ -2440,7 +2440,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	return;
 }
 
-/**
+/*
  * Callback received when the backend's state changes.
  */
 static void blkback_changed(struct xenbus_device *dev,
-- 
2.27.0

