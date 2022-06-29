Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F413C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 01:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiF2Bhw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 21:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiF2Bhw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 21:37:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5297225C7C
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 18:37:51 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXkYd2g1GzhYcs;
        Wed, 29 Jun 2022 09:35:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 09:37:49 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tj@kernel.org>, <jack@suse.cz>, <hch@lst.de>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 0/2] blk-cgroup: duplicated code refactor
Date:   Wed, 29 Jun 2022 09:50:20 +0800
Message-ID: <20220629015022.2667445-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two duplicated code segment refactors. No functional change.

v1->v2: Remove inline keyword of blkcg_iostat_update().

Jason Yan (2):
  blk-cgroup: factor out blkcg_iostat_update()
  blk-cgroup: factor out blkcg_free_all_cpd()

 block/blk-cgroup.c | 73 ++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

-- 
2.31.1

