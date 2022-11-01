Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16015FA373D
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 09:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiKAJeX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiKAJeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 05:34:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44A18B13;
        Tue,  1 Nov 2022 02:34:22 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lGK4fknzmVYL;
        Tue,  1 Nov 2022 17:34:17 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:19 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 00/20] A few bugfix and cleanup patches for bfq-iosched
Date:   Tue, 1 Nov 2022 17:33:57 +0800
Message-ID: <20221101093417.10540-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series contain a few patches to fix typo in comment, protect
max_budget from concurrent access and so on. More detail can be
found in the respective changelogs.

Kemeng Shi (20):
  block, bfq: fix typo in comment
  block, bfq: Update bfqd->max_budget with bfqd->lock held
  block, bfq: correct bfq_max_budget and bfq_min_budget
  block, bfq: simpfy computation of bfqd->budgets_assigned
  block, bfq: recover the "service hole" if enough budget is left
  block, bfq: correct interactive weight-raise check in
    bfq_set_budget_timeout
  block, bfq: simpfy check for interactive bfqq in bfq_update_wr_data
  block, bfq: do srt filtering for interactive queues in
    bfq_completed_request
  block, bfq: remove redundant check if (bfqq->dispatched > 0)
  block, bfq: define and use soft_rt, in_burst and wr_or_deserves_wr
    only low_latency is enable
  block, bfq: remove unnecessary "wr" part of wr_or_deserves_wr
  block, bfq: start/restart service_from_wr accumulating correctly
  block,bfq: remove redundant nonrot_with_queueing check in
    bfq_setup_cooperator
  block, bfq: remove redundant oom_bfqq check for bfqq from
    bfq_find_close_cooperator
  block, bfq: some cleanups for function bfq_pos_tree_add_move
  block, bfq: remove unnecessary goto tag in __bfq_weights_tree_remove
  block, bfq: remove unnecessary traverse in bfq_add_to_burst
  block, bfq: remove unnecessary bfqq->next_rq = NULL in
    bfq_remove_request
  block, bfq: remove unnecessary local variable __bfqq in
    bfq_setup_merge
  block, bfq: remove unncessary process_ref check for merged queue in
    bfq_setup_merge

 block/bfq-iosched.c | 280 +++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 147 deletions(-)

-- 
2.30.0

