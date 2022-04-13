Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013C1C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 12:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiDMMgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiDMMgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 08:36:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB931401C
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 05:34:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so3653523ejb.4
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm998/ZmJzCU5MOYAEY+vIvQZrAEliqhrH+oV2wW8mc=;
        b=B4e6nxbi0mym/HAPykyJVQVTmIZCt8wKVC2cW27YA7BD5YsRwm2+roX/EkyfXp4nTm
         ua6ICoDrkPtHBJ0GuwRXF0GhZdBCnb4yLzQJIkal9mx2Xptu6r/dNUB9Yef6P0NSOAT7
         tFbGcv6pN8d+d8ld0+wmJy5Q40LpQ7BAtfxvE9Okpg4FtkM26ylkcCnMSkg9zaMup2u7
         gfXBroabBkB5hRamMHopYIq1nZj2hNAvrISTAidwHSkEYXPBeMwuHt65kZY+pKwtTOW5
         Qu0KpzP+jqvjeXhkbRz3iEiCAvquGAzrb9Xgl9e67yTO34FOgzTVIhlRh2t0EzyOJlh7
         QBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm998/ZmJzCU5MOYAEY+vIvQZrAEliqhrH+oV2wW8mc=;
        b=zbTlN4e0uxKJIjd5nfDwaH86Xn7yB8Z8UfBT4FdXpfY3Vyla80rgP6N6jX+6ZZBLHy
         QLD9g1poD1XJvWtlggk4JQQxbO/0E3C/Qz9yqizwMTOtedO0mE1DWFW6uabdY85y/P5R
         8NaVITJMWeqfOVqRHvRBZN8FQ+nLQY/yA2/WjhVV7MV5XNWbyudds1q8ciGcPxls9MJP
         rV51Ljm1B2rGkm5DUv5Z0+aAOjqq+JtusFqDtMuchd8woxJhf6AsOlfN6OkeALrY4P0V
         lRreVMP2A939QZ1jwlzSUEGrAV9HCIP5aQBfIzj2g0IahvpFQPvZEW3ZfHc8rvF2zj+0
         NTzg==
X-Gm-Message-State: AOAM530QMu7oh+ZGXBnGzTWN3f207vilGCAB2Zzl1DcQ+oDm5eRgIeIC
        QsEJlc66iFLwRzlWW46z9wnoGdjWN8cXwA==
X-Google-Smtp-Source: ABdhPJxGFS9jcdPSKJzYeg9NR6S3dwCmb2VDm4P9/fv45LYqFnD4vo8DuGImRm3V2oVks2YKOj2LGw==
X-Received: by 2002:a17:906:3708:b0:6e8:9459:88f3 with SMTP id d8-20020a170906370800b006e8945988f3mr12328308ejc.629.1649853261098;
        Wed, 13 Apr 2022 05:34:21 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net (200116b8451b58006033032d82fea3ec.dip.versatel-1u1.de. [2001:16b8:451b:5800:6033:32d:82fe:a3ec])
        by smtp.gmail.com with ESMTPSA id y13-20020a50eb8d000000b0041f112a63c4sm938778edr.52.2022.04.13.05.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 05:34:20 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Subject: [PATCH] block/rnbd-clt: Avoid flush_workqueue(system_long_wq) usage
Date:   Wed, 13 Apr 2022 14:34:20 +0200
Message-Id: <20220413123420.66470-1-jinpu.wang@ionos.com>
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
v2: return error as suggested by Tetsuo.

 drivers/block/rnbd/rnbd-clt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b66e8840b94b..e21a35c0c62b 100644
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
 
@@ -1791,6 +1792,14 @@ static int __init rnbd_client_init(void)
 		pr_err("Failed to load module, creating sysfs device files failed, err: %d\n",
 		       err);
 		unregister_blkdev(rnbd_client_major, "rnbd");
+		return err;
+	}
+	rnbd_clt_wq = alloc_workqueue("rnbd_clt_wq", 0, 0);
+	if (!rnbd_clt_wq) {
+		pr_err("Failed to load module, alloc_workqueue failed.\n");
+		rnbd_clt_destroy_sysfs_files();
+		unregister_blkdev(rnbd_client_major, "rnbd");
+		err = -ENOMEM;
 	}
 
 	return err;
@@ -1801,6 +1810,7 @@ static void __exit rnbd_client_exit(void)
 	rnbd_destroy_sessions();
 	unregister_blkdev(rnbd_client_major, "rnbd");
 	ida_destroy(&index_ida);
+	destroy_workqueue(rnbd_clt_wq);
 }
 
 module_init(rnbd_client_init);
-- 
2.25.1

