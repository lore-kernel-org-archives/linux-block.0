Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1475EC43334
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 07:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiFSHuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 03:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiFSHuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 03:50:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448BE01F;
        Sun, 19 Jun 2022 00:50:14 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LQlK94TpzzkWbN;
        Sun, 19 Jun 2022 15:49:01 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 19 Jun 2022 15:50:10 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 19 Jun
 2022 15:50:09 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <osandov@fb.com>, <asml.silence@gmail.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RFC v2 0/2] bugfix for sbitmap
Date:   Sun, 19 Jun 2022 16:03:07 +0800
Message-ID: <20220619080309.1630027-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes in v2:
 - split to spearate patches for different problem.
 - add fix tag

Yu Kuai (2):
  sbitmap: fix that same waitqueue can be woken up continuously
  sbitmap: fix possible io hung due to lost wakeups

 lib/sbitmap.c | 60 +++++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

-- 
2.31.1

