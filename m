Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EEC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 12:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiDMMPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiDMMPj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 08:15:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B05D644
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 05:13:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v15so2077154edb.12
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=euyt40KhhUsQOe6kvPhCTuxL2KFbhG8Znq1qtDTg1Fk=;
        b=YsvDdLFJypbjPO2wtWoUQIyX9PXTrLQN1l2SBkG0res/Ogqs8H6Z0JcVcuxzQDhHvV
         /QwVQJ8mV/BJ5O+NdACNBLnvJyHDYZMDqs2cZHM6mA1/GVgUxRcFhY+lmf9BprCBIDwL
         S3EybliV26Cr88p/7w31zLFs1f4OOiD3C378QjkxEZlmluNjVODxaOgsTXbr+vOARp5A
         XPFZEsM07dh7fnxINlT+i9b7IgKnMeJbHK2or3Ddh976922ymdWTwHA2hSpgs6hFr4TS
         yRNm5w3hCKkgt4BCCegwyupaxI2YFO369FQ3TN1sEdTxgNWyJ9ECEUduC2UnxTN3+w36
         UeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=euyt40KhhUsQOe6kvPhCTuxL2KFbhG8Znq1qtDTg1Fk=;
        b=CRMW7TSYoEhmwYYrabnC9SKnZMwQjE3rD64HMXxxByr2neC48xW6AUzcEVDeqeZvG1
         bJITcJJRgnp0LrWdzrgxvFf1Bm/EZJOaV2me3ncwXWLPUjVYYlK4y4nDReLeO4yXWraN
         D/M5/uQ1f7t9di/8Dh42vIi43pI1bkd5ThMsZwD0cjFxfT7GdiRlZUK8tJd9JWXf7rC+
         b42n7NnxjGRfLloYkDdgAhuhcX+nSmnOdZB2mXTMecs/QVB5Fbqrt+xg0KWgjbJWt+h3
         n0/7OoZwms7K/npbxH5DDjyXdJ/AdNISzTDDfbitxtMI2qPCLmS2pQW1m6v7E8bJzkqr
         Y30w==
X-Gm-Message-State: AOAM530y0MaoFW0jtswDhHufVjh/QODBF1TKY34NfPlV1Ko+KE+H0C58
        wHXJFBVj9rH2EErAwmasm7H9FZ11u24D8A==
X-Google-Smtp-Source: ABdhPJxMlXvv7HIpl8e2f0+OeHmYJ70cNzI5OOQmC2BfYsk66Gj46a5rJD4BEUsYuplv9j/KCF5M6g==
X-Received: by 2002:aa7:c40b:0:b0:41d:9886:90a0 with SMTP id j11-20020aa7c40b000000b0041d988690a0mr5828427edq.275.1649851996727;
        Wed, 13 Apr 2022 05:13:16 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net (200116b8451b58006033032d82fea3ec.dip.versatel-1u1.de. [2001:16b8:451b:5800:6033:32d:82fe:a3ec])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906310a00b006e834953b55sm7167358ejx.27.2022.04.13.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 05:13:16 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Subject: [PATCH] block/rnbd-clt: Avoid flush_workqueue(system_long_wq) usage
Date:   Wed, 13 Apr 2022 14:13:15 +0200
Message-Id: <20220413121315.63684-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flushing system-wide workqueues is dangerous and will be forbidden.

Replace system_long_wq with local rnbd_clt_wq.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b66e8840b94b..1cb34649a875 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -25,6 +25,7 @@ static int rnbd_client_major;
 static DEFINE_IDA(index_ida);
 static DEFINE_MUTEX(sess_lock);
 static LIST_HEAD(sess_list);
+static struct workqueue_struct *rnbd_clt_wq;
 
 /*
  * Maximum number of partitions an instance can have.
@@ -1761,12 +1762,12 @@ static void rnbd_destroy_sessions(void)
 			 * procedure takes minutes.
 			 */
 			INIT_WORK(&dev->unmap_on_rmmod_work, unmap_device_work);
-			queue_work(system_long_wq, &dev->unmap_on_rmmod_work);
+			queue_work(rnbd_clt_wq, &dev->unmap_on_rmmod_work);
 		}
 		rnbd_clt_put_sess(sess);
 	}
 	/* Wait for all scheduled unmap works */
-	flush_workqueue(system_long_wq);
+	flush_workqueue(rnbd_clt_wq);
 	WARN_ON(!list_empty(&sess_list));
 }
 
@@ -1792,6 +1793,13 @@ static int __init rnbd_client_init(void)
 		       err);
 		unregister_blkdev(rnbd_client_major, "rnbd");
 	}
+	rnbd_clt_wq = alloc_workqueue("rnbd_clt_wq", 0, 0);
+	if (!rnbd_clt_wq) {
+		pr_err("Failed to load module, alloc_workqueue failed.\n");
+		rnbd_clt_destroy_sysfs_files();
+		unregister_blkdev(rnbd_client_major, "rnbd");
+		err = -ENOMEM;
+	}
 
 	return err;
 }
@@ -1801,6 +1809,7 @@ static void __exit rnbd_client_exit(void)
 	rnbd_destroy_sessions();
 	unregister_blkdev(rnbd_client_major, "rnbd");
 	ida_destroy(&index_ida);
+	destroy_workqueue(rnbd_clt_wq);
 }
 
 module_init(rnbd_client_init);
-- 
2.25.1

