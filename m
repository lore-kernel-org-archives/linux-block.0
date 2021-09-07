Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DEFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 12:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B698B610FF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 12:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbhIGMP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhIGMP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 08:15:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236A6C061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 05:14:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q22so3224498pfu.0
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OZzx+1z6a5c3h3/Sw4pkfFh4EnMP/repP35Q9oKekA=;
        b=OqS7cUnQkPbNnMkKpcwQYzBj23Jep1CoAOlKrTlX406HtEfhAYiOnXCHxlPNYzrJhY
         1IoNmsm2U3KM+oc6wg4G5PyviENAQQtxiqZBFJ1nZp6i4JQgAm+6VT/LmXYaAn44GPXu
         izedj31QPvs2sNUHgFFIO70Ehu8raKq+YjCx/iNvwnh15s9vVUO0WU+bAL9NV/zYxnLF
         s6TYn5hpGWgK6FF6ydWUKa3e5E7YOjXHrlSTDU0TN+8uhdT4rCBas4zYYl8PmvcNXN3I
         ZXBbL8FA6O/r8xFsuc2vrO66DNjqG8L7BCY2M7zTX07+mpef7CXBvmRF4Kgaxc1lGwyp
         8Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OZzx+1z6a5c3h3/Sw4pkfFh4EnMP/repP35Q9oKekA=;
        b=aFfiS+nOF2GoXV8Os3NUsnkAnokkB87A2gE8GmItQ8a4CzCYLA88677VpEcS1umvGT
         pmA/iuAgiafL/rqqpi3/nuS9UkeFMAjmtIkRIUpBV4d4Ek1RdNGyICCgGO5PrTMQNRvs
         PUErvpvvdmIJOQEtYAWzEnmqHIuq62FnrIWvsTQHI5UXqsO1qYYungyUea3gMr0uPd2S
         shDy9qarrkwsCd2CvPkWMz6kC9N3O6Q2wxR1ZxPsZ1szarNxugI0e0pppn5ho/xcrxvW
         4AdPNAwtkbYLOCnpOVQ6zX/+ooLJYMXOo/L194RzFpzwN7xzfTxgt2y4XtLKFvwIch9A
         WBfg==
X-Gm-Message-State: AOAM530QyHZ3a4c3ROPsQU/sVOTBucsMq2WKbbMLKVEz+h7PI1L8LE28
        3h+rLkwE2Yx3PqzaK+ImZLtZvFigjVxBmaU=
X-Google-Smtp-Source: ABdhPJzXdhI0AW8X6rWI5d155rZEK25relN1WCn71YhruAKV3G7gKgsoU7Od0IZyq9OnUYm1/cXQSg==
X-Received: by 2002:a63:4614:: with SMTP id t20mr16678272pga.372.1631016891594;
        Tue, 07 Sep 2021 05:14:51 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id y6sm2476684pjr.48.2021.09.07.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:14:50 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH] nbd: clear wb_err in bd_inode on disconnect
Date:   Tue,  7 Sep 2021 20:14:25 +0800
Message-Id: <20210907121425.91-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a nbd device encounters a writeback error, that error will
get propagated to the bd_inode's wb_err field. Then if this nbd
device's backend is disconnected and another is attached, we will
get back the previous writeback error on fsync, which is unexpected.
To fix it, let's clear out the wb_err on disconnect.

Reported-by: Yi Xingchen <yixingchen@bytedance.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5170a630778d..e6aa804db541 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1233,6 +1233,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 		struct nbd_config *config = nbd->config;
 		nbd_dev_dbg_close(nbd);
 		nbd_size_clear(nbd);
+		nbd->disk->part0->bd_inode->i_mapping->wb_err = 0;
 		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
 				       &config->runtime_flags))
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
-- 
2.11.0

