Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EE0C433F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3DE600D4
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 12:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhIDMNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Sep 2021 08:13:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9003 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbhIDMNh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Sep 2021 08:13:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H1tnJ1R4BzWrHT;
        Sat,  4 Sep 2021 20:11:48 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 4 Sep 2021 20:12:34 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 4 Sep 2021
 20:12:34 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <nbd@other.debian.org>, <hch@lst.de>, <houtao1@huawei.com>
Subject: [PATCH v2 0/3] fix races between nbd setup and module removal
Date:   Sat, 4 Sep 2021 20:25:16 +0800
Message-ID: <20210904122519.1963983-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The patch series aims to fix the races between nbd setup and module
removal which may lead to oops. Patch #1 is just replacing
printk(KERN_ERR "nbd: ...") by pr_err("...") which makes it easier
to add error message in patch #3. Patch #2 serializes the concurrently
calling of nbd_genl_connect() and nbd_cleanup(), and patch #3 fixes race
between nbd_alloc_config() and nbd_cleanup().

Any comments are welcome.

Regards,
Tao

ChangeLog:
v2:
  * add a new patch "use pr_err to output error message"
  * add the missing error message in patch 3.

v1: https://www.spinics.net/lists/linux-block/msg72995.html

Hou Tao (3):
  nbd: use pr_err to output error message
  nbd: call genl_unregister_family() first in nbd_cleanup()
  nbd: fix race between nbd_alloc_config() and module removal

 drivers/block/nbd.c | 70 ++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 26 deletions(-)

-- 
2.29.2

