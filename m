Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A411C43463
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 08:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2194F2176B
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 08:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRIDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Sep 2020 04:03:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgIRIDG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 04:03:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B11D3BFE0D4F9F7BAD63;
        Fri, 18 Sep 2020 16:03:04 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:02:59 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <andy.lavr@gmail.com>, <yuyufen@huawei.com>
Subject: [PATCH v2 3/4] block: fix comment and add lockdep assert
Date:   Fri, 18 Sep 2020 04:03:07 -0400
Message-ID: <20200918080308.2787773-4-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918080308.2787773-1-yuyufen@huawei.com>
References: <20200918080308.2787773-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After commit b89f625e28d4 ("block: don't release queue's sysfs
lock during switching elevator"), whole elevator register and
unregister function are covered by sysfs_lock. So, remove wrong
comment and add lockdep assert.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/elevator.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 431a2a1c896e..293c5c81397a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -479,16 +479,13 @@ static struct kobj_type elv_ktype = {
 	.release	= elevator_release,
 };
 
-/*
- * elv_register_queue is called from either blk_register_queue or
- * elevator_switch, elevator switch is prevented from being happen
- * in the two paths, so it is safe to not hold q->sysfs_lock.
- */
 int elv_register_queue(struct request_queue *q, bool uevent)
 {
 	struct elevator_queue *e = q->elevator;
 	int error;
 
+	lockdep_assert_held(&q->sysfs_lock);
+
 	error = kobject_add(&e->kobj, &q->kobj, "%s", "iosched");
 	if (!error) {
 		struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -507,13 +504,10 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 	return error;
 }
 
-/*
- * elv_unregister_queue is called from either blk_unregister_queue or
- * elevator_switch, elevator switch is prevented from being happen
- * in the two paths, so it is safe to not hold q->sysfs_lock.
- */
 void elv_unregister_queue(struct request_queue *q)
 {
+	lockdep_assert_held(&q->sysfs_lock);
+
 	if (q) {
 		struct elevator_queue *e = q->elevator;
 
-- 
2.25.4

