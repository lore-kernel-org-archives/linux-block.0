Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB6CA0FE6
	for <linux-block@archiver.kernel.org>; Fri,  1 Sep 2023 07:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjIAHUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Sep 2023 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjIAHUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2023 03:20:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE46E7F;
        Fri,  1 Sep 2023 00:19:57 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcTpn0bKPzNmvF;
        Fri,  1 Sep 2023 15:16:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 15:19:54 +0800
From:   Ze Zuo <zuoze1@huawei.com>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>
CC:     <akpm@linux-foundation.org>, <ying.huang@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 0/2] zram: support for specific numa node for zram
Date:   Fri, 1 Sep 2023 15:19:40 +0800
Message-ID: <20230901071942.207010-1-zuoze1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series adds a parameter "numa_id" to zram to support the use
of memory in a specific node, and attempts to obtain the benefits of using
kvzalloc_node to obtain huge page table mappings.

Ze Zuo (2):
  zram: add a parameter "node_id" for zram
  zram: take the benefit of kvzalloc_node

 drivers/block/zram/zram_drv.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

-- 
2.25.1

