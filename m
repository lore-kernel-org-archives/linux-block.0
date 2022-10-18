Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3DDC43219
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJRMTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJRMTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 08:19:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367962E6;
        Tue, 18 Oct 2022 05:19:36 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsCWj2dWHzpVhF;
        Tue, 18 Oct 2022 20:16:17 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:19:34 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
Date:   Tue, 18 Oct 2022 20:19:27 +0800
Message-ID: <20221018121932.10792-1-shikemeng@huawei.com>
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

This series contain a few patch to correct comment, correct trace of
vtime_rate and so on. More detail can be found in the respective
changelogs.

---
v2:
 Thanks Tejun for review and comment!
 Add Acked-by tag from Tejun.
 Correct description in patch 3/5 and 4/5.
 Drop "blk-iocost: Avoid to call current_hweight_max if iocg->inuse
== iocg->active"
 Drop "blk-iocost: Remove redundant initialization of struct ioc_gq"
 Drop "blk-iocost: Get ioc_now inside weight_updated"
---

Kemeng Shi (5):
  blk-iocost: Fix typo in comment
  blk-iocost: Reset vtime_base_rate in ioc_refresh_params
  blk-iocost: Trace vtime_base_rate instead of vtime_rate
  blk-iocost: Remove vrate member in struct ioc_now
  blk-iocost: Correct comment in blk_iocost_init

 block/blk-iocost.c            | 16 +++++++++-------
 include/trace/events/iocost.h |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.30.0

