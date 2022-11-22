Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949DBC43217
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 03:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiKVDGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKVDGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 22:06:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C357F12A8F
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 19:06:14 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGTf75DTdzHwMP;
        Tue, 22 Nov 2022 11:05:35 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:06:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 11:06:08 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <liwei391@huawei.com>, <linux-block@vger.kernel.org>,
        <drbd-dev@lists.linbit.com>, <axboe@kernel.dk>,
        <lars.ellenberg@linbit.com>, <christoph.boehmwalder@linbit.com>,
        <bobo.shaobowang@huawei.com>
Subject: [PATCH v2 0/2] drbd bugfix and cleanup
Date:   Tue, 22 Nov 2022 11:04:25 +0800
Message-ID: <20221122030427.731308-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

drbd bugfix and cleanup.

v2:
  - add new patch for removing useless memset().

Wang ShaoBo (2):
  drbd: remove call to memset before free device/resource/connection
  drbd: destroy workqueue when drbd device was freed

 drivers/block/drbd/drbd_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

