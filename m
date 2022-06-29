Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D51CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiF2G4k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiF2G4i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:56:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6582F02D
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:56:37 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LXsdQ6rplz1L8d2;
        Wed, 29 Jun 2022 14:54:18 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 14:56:34 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tj@kernel.org>, <jack@suse.cz>, <hch@lst.de>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
Date:   Wed, 29 Jun 2022 15:09:15 +0800
Message-ID: <20220629070917.3113016-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two duplicated code segment refactors. No functional change.

v2->v3: Fix indentation and add review tags.
v1->v2: Remove inline keyword of blkcg_iostat_update().

Jason Yan (2):
  blk-cgroup: factor out blkcg_iostat_update()
  blk-cgroup: factor out blkcg_free_all_cpd()

 block/blk-cgroup.c | 73 ++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

-- 
2.31.1

