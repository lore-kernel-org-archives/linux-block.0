Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7EBC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 02:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D497F6056C
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 02:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbhICCgU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:36:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9397 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhICCgT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Sep 2021 22:36:19 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H11xf2ZDvz8xJZ;
        Fri,  3 Sep 2021 10:31:02 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 10:35:18 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 3 Sep 2021
 10:35:18 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>, <houtao1@huawei.com>
Subject: [PATCH 0/2] fix races between nbd setup and module removal
Date:   Fri, 3 Sep 2021 10:48:01 +0800
Message-ID: <20210903024803.1056229-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The patch series aims to fix the races between nbd setup and module
removal which will lead to oops. Patch #1 serializes the concurrently
calling of nbd_genl_connect() and nbd_cleanup(), and patch #2 fixes
race between nbd_alloc_config() and nbd_cleanup().

Any comments are welcome.

Regards,
Tao

Hou Tao (2):
  nbd: call genl_unregister_family() first in nbd_cleanup()
  nbd: fix race between nbd_alloc_config() and module removal

 drivers/block/nbd.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
2.29.2

