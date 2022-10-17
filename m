Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B004C43217
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 02:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJQCAT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJQCAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CABDE2;
        Sun, 16 Oct 2022 19:00:16 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrKp45gw1zVjDh;
        Mon, 17 Oct 2022 09:55:40 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:13 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 0/8] A few cleanup and bugfix patches for blk-iocost
Date:   Mon, 17 Oct 2022 10:00:03 +0800
Message-ID: <20221017020011.25016-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series contain a few patch to correct comment, correct trace of
vtime_rate and so on. More detail can be found in the respective
changelogs.
Thanks!

Kemeng Shi (8):
  blk-iocost: Fix typo in comment
  blk-iocost: Reset vtime_base_rate in ioc_refresh_params
  blk-iocost: Trace vtime_base_rate instead of vtime_rate
  blk-iocost: Remove vrate member in struct ioc_now
  blk-iocost: Correct comment in blk_iocost_init
  blk-iocost: Avoid to call current_hweight_max if iocg->inuse ==
    iocg->active
  blk-iocost: Remove redundant initialization of struct ioc_gq
  blk-iocost: Get ioc_now inside weight_updated

 block/blk-iocost.c            | 45 +++++++++++++++++------------------
 include/trace/events/iocost.h |  4 ++--
 2 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.30.0

