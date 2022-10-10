Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C1EC4332F
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 02:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJJCjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Oct 2022 22:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiJJCjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Oct 2022 22:39:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B34A82E;
        Sun,  9 Oct 2022 19:39:05 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mm30729D2zmV93;
        Mon, 10 Oct 2022 10:34:31 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 10:39:02 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 2/4] blk-cgroup: correct comment for blk_alloc_queue and blk_exit_queue
Date:   Mon, 10 Oct 2022 10:38:57 +0800
Message-ID: <20221010023859.11896-3-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221010023859.11896-1-shikemeng@huawei.com>
References: <20221010023859.11896-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 1059699f87eb("block: move blkcg initialization/destroy into
disk allocation/release handler"), blk_alloc_queue and blk_exit_queue is
called directly from gendisk. Update the corresponding comment.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bc4dec705572..463c568d3e86 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1259,7 +1259,7 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
  * blkcg_init_queue - initialize blkcg part of request queue
  * @q: request_queue to initialize
  *
- * Called from blk_alloc_queue(). Responsible for initializing blkcg
+ * Called from gendisk. Responsible for initializing blkcg
  * part of new request_queue @q.
  *
  * RETURNS:
@@ -1321,7 +1321,7 @@ int blkcg_init_queue(struct request_queue *q)
  * blkcg_exit_queue - exit and release blkcg part of request_queue
  * @q: request_queue being released
  *
- * Called from blk_exit_queue().  Responsible for exiting blkcg part.
+ * Called from gendisk.  Responsible for exiting blkcg part.
  */
 void blkcg_exit_queue(struct request_queue *q)
 {
-- 
2.30.0

