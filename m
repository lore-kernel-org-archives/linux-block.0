Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087ADC43217
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiK1PXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiK1PXa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 10:23:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5DFDF5;
        Mon, 28 Nov 2022 07:23:29 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NLTf60YLQzqSfN;
        Mon, 28 Nov 2022 23:19:26 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 23:23:26 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 23:23:26 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 0/8] iocost bugfix
Date:   Mon, 28 Nov 2022 23:44:26 +0800
Message-ID: <20221128154434.4177442-1-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset fixes problem in iocost. It contains Yu Kuai's patchset he
sent before because of conflicts.

Li Nan (4):
  blk-iocost: fix divide by 0 error in calc_lcoefs()
  blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in
    ioc_refresh_params()
  blk-iocost: fix possible UAF in ioc_pd_free
  block: fix null-pointer dereference in ioc_pd_init

Yu Kuai (4):
  blk-iocost: cleanup ioc_qos_write() and ioc_cost_model_write()
  blk-iocost: improve hanlder of match_u64()
  blk-iocost: don't allow to configure bio based device
  blk-iocost: read params inside lock in sysfs apis

 block/blk-iocost.c | 114 ++++++++++++++++++++++++++++-----------------
 block/genhd.c      |   2 +-
 2 files changed, 73 insertions(+), 43 deletions(-)

-- 
2.31.1

