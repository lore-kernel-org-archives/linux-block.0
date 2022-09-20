Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E18C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 01:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiITBwW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiITBwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 21:52:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3291558F9
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 18:52:19 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWkvw1NsYz14QfW;
        Tue, 20 Sep 2022 09:48:12 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:52:16 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>,
        <cuigaosheng1@huawei.com>
CC:     <drbd-dev@lists.linbit.com>, <linux-block@vger.kernel.org>
Subject: [PATCH 0/2] Remove orphan declarations for drbd
Date:   Tue, 20 Sep 2022 09:52:14 +0800
Message-ID: <20220920015216.782190-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series contains a few cleanup patches, to remove a orphan
declaration which has been removed and some useless comments. Thanks!

Gaosheng Cui (2):
  drbd: remove orphan _req_may_be_done() declaration
  block/drbd: remove useless comments in receive_DataReply()

 drivers/block/drbd/drbd_receiver.c | 3 ---
 drivers/block/drbd/drbd_req.h      | 2 --
 2 files changed, 5 deletions(-)

-- 
2.25.1

