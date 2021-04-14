Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07767C43603
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E069761242
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhDNMYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhDNMYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C2C061756
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 18so23472287edx.3
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zL6gQYZ5yMQsIXTOxSRsFVO1XenlLGr+TV3FCZ4q0tY=;
        b=T4KgICg89ttuyNjL3+l+0cmKUGqep51gecgxOTRFvoQxTxJs1GsDxbM0v4l6kYw0uJ
         o1+6Uudb7DC/YDqivHdd27NfJ/xCYqhEmIJvweYKExxbr1cUk9eVy+OG7lat1Q/AwAKN
         yDJGFH6NLqbI4+EPpCBMocuKVn17KIGmdWQV9fxUtw1ka6+RQL+XocZ0D9d4UDdXTHBC
         2tScGuP0q2ILxNKels9NLxH0Y1B3Yg8bZ25cac1AfZeXsw8gJSEoZZITwvBfKjbWGq6Z
         EMKEeW1FaFYfgzudf8MTbpa8ST5fkxvTZ5kYh9giplhAAOGZlTZ2Gm5tbJkxfGgzCey/
         bE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zL6gQYZ5yMQsIXTOxSRsFVO1XenlLGr+TV3FCZ4q0tY=;
        b=a4ydR5L0HufaAB7Pn/jyribQdKk707B94n5HLkDW1sK5yyiuz/qQi/RJJFd4ap0Xsh
         IIeYUnOKBZCqu5rm72iV2pusOUVe0cAZp+myjkPNSmKx/8Ap13Vyd5yjhtyqHWvWvK/q
         X1MGSMMWz0118h1inronDaqAYnDcX8YSACNzGC1Ag20uJUAJmDsp4sC+/cA+NNmULWX1
         c31Mc/zUqLEA6m58Cnt/Gh+uSqjwJJ+HRl2uyqcYO89R9/HIsVvFCJfxXKLYO1edmDHy
         llA6V9iZHONIsH5JX0/WhTDWqJUD/fk0Cn+q5TOuzT1Lz75M560ZZfcmERw7iV5M7k46
         WiBA==
X-Gm-Message-State: AOAM531A2BFYjnLCcy8znyRuyw15GC9UB40Q3Tit/NRGHPL6w9QQekMn
        T2VPetLcmYwSCKHCd0g8e6L8+vohYuiQkQMv
X-Google-Smtp-Source: ABdhPJzbHSzGoTgQ9JphXLMQiMrw3lU8La8qjav7BykfgOjUdAsNyIIAORfTvNlvE5KUbCXmZiTO+w==
X-Received: by 2002:aa7:c64b:: with SMTP id z11mr41621829edr.8.1618403054206;
        Wed, 14 Apr 2021 05:24:14 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:13 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv4 for-next 06/19] block/rnbd: Kill rnbd_clt_destroy_default_group
Date:   Wed, 14 Apr 2021 14:23:49 +0200
Message-Id: <20210414122402.203388-7-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need to have it since we can call sysfs_remove_group in the
rnbd_clt_destroy_sysfs_files.

Then rnbd_clt_destroy_sysfs_files is paired with it's counterpart
rnbd_clt_create_sysfs_files.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 drivers/block/rnbd/rnbd-clt.c       | 1 -
 drivers/block/rnbd/rnbd-clt.h       | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index d4aa6bfc9555..58c2cc0725b6 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -639,13 +639,9 @@ int rnbd_clt_create_sysfs_files(void)
 	return err;
 }
 
-void rnbd_clt_destroy_default_group(void)
-{
-	sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
-}
-
 void rnbd_clt_destroy_sysfs_files(void)
 {
+	sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
 	kobject_del(rnbd_devs_kobj);
 	kobject_put(rnbd_devs_kobj);
 	device_destroy(rnbd_dev_class, MKDEV(0, 0));
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index f864f06a49b3..4e687ec88721 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1675,7 +1675,6 @@ static void rnbd_destroy_sessions(void)
 	struct rnbd_clt_dev *dev, *tn;
 
 	/* Firstly forbid access through sysfs interface */
-	rnbd_clt_destroy_default_group();
 	rnbd_clt_destroy_sysfs_files();
 
 	/*
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 537d499dad3b..714d426b449b 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -159,7 +159,6 @@ int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize);
 int rnbd_clt_create_sysfs_files(void);
 
 void rnbd_clt_destroy_sysfs_files(void);
-void rnbd_clt_destroy_default_group(void);
 
 void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev);
 
-- 
2.25.1

