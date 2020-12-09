Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3073C4167B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD1023BAF
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgLIIVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLIIVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:21:36 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E0EC061793
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:20:56 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id x16so831537ejj.7
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwUB98OMU5vN+dBpGv0EWnnHA2hhEx1MlU32S5W8EnI=;
        b=Y7iAr8W9bTfDF+GBMnJgiqr+SqswugJViBgz+7cr1bw2XVu4V16CQAENB3Q7wBbAz7
         NFYLuzpQmGxVgVPTpLW7sCypvlj+y1ybi1YYOkcbdsGzI0dCurYUI9QBhAaiInm+B1WZ
         jPS9SKy+lxtp8nICT8rWvP7LgaONnrpP1SZvApUFW/Fv7n6YN0vRTw4IYuKZJDxoBe1J
         l268QuEXKUzw6PgBfhoHkzyiPLN4mT8zQ/3HBGmyJ9NW9iUXO9v2Cfmc19PC0S+SpHyw
         ZO/DOak7P3gR9PKJhF1dvoisLRhasPltTfgFUL2uXh5l5w0/tgFNq9r/oJ3f4twwF3tZ
         VuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwUB98OMU5vN+dBpGv0EWnnHA2hhEx1MlU32S5W8EnI=;
        b=FAOEOBdADRVwvFObgnum+eyaOjiQu7FTQ5T327SfJgtMuGmUUF9E5zRQ8RZQKEcsjQ
         FYaVMiBDMgUxfBvp3L9r3Ui5QVI97lhyuQm7IYF/PYxhZ4ppFurCKAfEvYPnxTrl7Iwt
         55ZWOcuOj1LUeROcLCGmygSDLMTm4ni2taWmzY2UZcXGRkVS0SLsDi6j+q6JC9vCQa4Y
         mOAXdjAPm6eleEbImv91Wqh778jfgXMQYBKNACJbTnkIdlD+lK9aEoU2wMQKoQemgmVZ
         JQkUdMZHqMKvU5d4XfGZWKXhRevrp7VqacCkeKxE8TmoRQR/SbGmesJ7/1a/H0jVtts+
         RNmQ==
X-Gm-Message-State: AOAM531fKxN3QP3wwe/TrAeoMEbfdgpghnyy/wHVi8Iqb05IDd30zB5J
        QNZN+GPFENXei17MYz3z8up0Q9Za7qOqaA==
X-Google-Smtp-Source: ABdhPJxmMFgDEnqtKjdXG4Wk75pBmlC+sPXVEOEbJkKy4oxIAiMat73fsjasSujS/E764NNjdbXOYQ==
X-Received: by 2002:a17:906:60c8:: with SMTP id f8mr1085979ejk.14.1607502055098;
        Wed, 09 Dec 2020 00:20:55 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:54 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 2/7] block/rnbd-clt: Fix possible memleak
Date:   Wed,  9 Dec 2020 09:20:46 +0100
Message-Id: <20201209082051.12306-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In error case, we do not free the memory for blk_symlink_name.

Do it by free the memory in error case, and set to NULL
afterwards.

Also fix the condition in rnbd_clt_remove_dev_symlink.

Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index a7caeedeb198..d4aa6bfc9555 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -432,7 +432,7 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 	 * i.e. rnbd_clt_unmap_dev_store() leading to a sysfs warning because
 	 * of sysfs link already was removed already.
 	 */
-	if (strlen(dev->blk_symlink_name) && try_module_get(THIS_MODULE)) {
+	if (dev->blk_symlink_name && try_module_get(THIS_MODULE)) {
 		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
 		kfree(dev->blk_symlink_name);
 		module_put(THIS_MODULE);
@@ -521,7 +521,8 @@ static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
 	return 0;
 
 out_err:
-	dev->blk_symlink_name[0] = '\0';
+	kfree(dev->blk_symlink_name);
+	dev->blk_symlink_name = NULL ;
 	return ret;
 }
 
-- 
2.25.1

