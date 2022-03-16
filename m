Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9310C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 12:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiCPMyt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354040AbiCPMys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 08:54:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8BAE57;
        Wed, 16 Mar 2022 05:53:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7Mec2u_1647435209;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7Mec2u_1647435209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 20:53:30 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     paolo.valente@linaro.org
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] block: Add parameter description in kernel-doc comment
Date:   Wed, 16 Mar 2022 20:53:27 +0800
Message-Id: <20220316125327.126996-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the description of @ioprio_class in bfq_reparent_leaf_entity()
and bfq_reparent_active_queues() kernel-doc comment to remove
warning found by running scripts/kernel-doc, which is caused by
using 'make W=1'.

block/bfq-cgroup.c:848: warning: Function parameter or member
'ioprio_class' not described in 'bfq_reparent_leaf_entity'
block/bfq-cgroup.c:878: warning: Function parameter or member
'ioprio_class' not described in 'bfq_reparent_active_queues'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 block/bfq-cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 420eda2589c0..af92c2e5fd98 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -841,6 +841,7 @@ static void bfq_flush_idle_tree(struct bfq_service_tree *st)
  * @bfqd: the device data structure with the root group.
  * @entity: the entity to move, if entity is a leaf; or the parent entity
  *	    of an active leaf entity to move, if entity is not a leaf.
+ * @ioprio_class: the offset used to manipulate the service_tree
  */
 static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
 				     struct bfq_entity *entity,
@@ -870,6 +871,7 @@ static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
  * @bfqd: the device data structure with the root group.
  * @bfqg: the group to move from.
  * @st: the service tree to start the search from.
+ * @ioprio_class: the offset used to manipulate the service_tree
  */
 static void bfq_reparent_active_queues(struct bfq_data *bfqd,
 				       struct bfq_group *bfqg,
-- 
2.20.1.7.g153144c

