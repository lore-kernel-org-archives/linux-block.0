Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960B5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 08:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiESIoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 04:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiESIod (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 04:44:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF617E1EB;
        Thu, 19 May 2022 01:44:30 -0700 (PDT)
Received: from kwepemi500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3k0m1v6SzhZ0x;
        Thu, 19 May 2022 16:43:52 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500021.china.huawei.com (7.221.188.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:44:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 16:44:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <geert@linux-m68k.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v3 0/2] bugfix for blk-throttle
Date:   Thu, 19 May 2022 16:58:09 +0800
Message-ID: <20220519085811.879097-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes in v3:
 - fix a check in patch 1
 - fix link err in patch 2 on 32-bit platform
 - hanlde overflow in patch 2
Changes in v2:
 - use a new solution suggested by Ming
 - change the title of patch 1
 - add patch 2

Patch 1 fix that blk-throttle can't work if multiple bios are throttle,
Patch 2 fix io hung due to configuration updates.

Previous version:
v1 : https://lore.kernel.org/all/20220517134909.2910251-1-yukuai3@huawei.com/
v2 : https://lore.kernel.org/all/20220518072751.1188163-1-yukuai3@huawei.com/
Yu Kuai (2):
  blk-throttle: fix that io throttle can only work for single bio
  blk-throttle: fix io hung due to configuration updates

 block/blk-throttle.c | 104 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 19 deletions(-)

-- 
2.31.1

