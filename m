Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D10C6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 11:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiIVLZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 07:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiIVLZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 07:25:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6587AE9FB;
        Thu, 22 Sep 2022 04:25:14 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCYV6czGzpStk;
        Thu, 22 Sep 2022 19:22:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:25:12 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:25:11 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 2/5] elevator: add new field flags in struct elevator_queue
Date:   Thu, 22 Sep 2022 19:35:55 +0800
Message-ID: <20220922113558.1085314-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922113558.1085314-1-yukuai3@huawei.com>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are only one flag to indicate that elevator is registered currently,
prepare to add a flag to disable wbt if default elevator is bfq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/elevator.c | 6 ++----
 block/elevator.h | 4 +++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index c319765892bb..7cb61820cfa0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -512,7 +512,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 		if (uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
-		e->registered = 1;
+		set_bit(ELEVATOR_FLAG_REGISTERED, &e->flags);
 	}
 	return error;
 }
@@ -523,13 +523,11 @@ void elv_unregister_queue(struct request_queue *q)
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	if (e && e->registered) {
+	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		struct elevator_queue *e = q->elevator;
 
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
-
-		e->registered = 0;
 	}
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index 3f0593b3bf9d..ed574bf3e629 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -100,10 +100,12 @@ struct elevator_queue
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
-	unsigned int registered:1;
+	unsigned long flags;
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
 
+#define ELEVATOR_FLAG_REGISTERED 0
+
 /*
  * block elevator interface
  */
-- 
2.31.1

