Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7DCC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356269AbiDLNtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354684AbiDLNtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 09:49:13 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629A54BDE
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 06:46:56 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23CDkmc8037512;
        Tue, 12 Apr 2022 22:46:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Tue, 12 Apr 2022 22:46:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23CDkmRf037508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Apr 2022 22:46:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <becb2389-e249-0aa2-7701-2c02155aedf2@I-love.SAKURA.ne.jp>
Date:   Tue, 12 Apr 2022 22:46:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] block/rnbd: client: avoid flush_workqueue(system_long_wq)
 usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flushing system-wide workqueues is dangerous and will be forbidden.

Since system_long_wq is used only inside rnbd_destroy_sessions(),
let's use list_head than creating a local workqueue for tracking
work_struct to flush.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Notice: This patch is only compile tested. Please test before applying.

 drivers/block/rnbd/rnbd-clt.c | 5 ++++-
 drivers/block/rnbd/rnbd-clt.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b66e8840b94b..b14e7c15133e 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1730,6 +1730,7 @@ static void rnbd_destroy_sessions(void)
 {
 	struct rnbd_clt_session *sess, *sn;
 	struct rnbd_clt_dev *dev, *tn;
+	LIST_HEAD(list);
 
 	/* Firstly forbid access through sysfs interface */
 	rnbd_clt_destroy_sysfs_files();
@@ -1762,11 +1763,13 @@ static void rnbd_destroy_sessions(void)
 			 */
 			INIT_WORK(&dev->unmap_on_rmmod_work, unmap_device_work);
 			queue_work(system_long_wq, &dev->unmap_on_rmmod_work);
+			list_add_tail(&dev->unmap_on_rmmod_list, &list);
 		}
 		rnbd_clt_put_sess(sess);
 	}
 	/* Wait for all scheduled unmap works */
-	flush_workqueue(system_long_wq);
+	list_for_each_entry(dev, &list, unmap_on_rmmod_list)
+		flush_work(&dev->unmap_on_rmmod_work);
 	WARN_ON(!list_empty(&sess_list));
 }
 
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 2e2e8c4a85c1..a6d704abda61 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -136,6 +136,7 @@ struct rnbd_clt_dev {
 	char			*blk_symlink_name;
 	refcount_t		refcount;
 	struct work_struct	unmap_on_rmmod_work;
+	struct list_head	unmap_on_rmmod_list;
 };
 
 /* rnbd-clt.c */
-- 
2.32.0
