Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C73C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 04:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKHEwm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiKHEwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 23:52:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A929318382;
        Mon,  7 Nov 2022 20:52:30 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5wgh2Ms5zmVhC;
        Tue,  8 Nov 2022 12:52:16 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:27 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 00/10] A few bugfix and cleancode patch for bfq
Date:   Tue, 8 Nov 2022 12:52:14 +0800
Message-ID: <20221108045224.19092-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, this is another series contain some bugfix and cleancode patches to
fix temporarily inject limit raise in bfq_choose_bfqq_for_injection,
correctly initialize decrease_time_jif to trigger inject limit update
in time and some random cleancode.
Thanks!

Kemeng Shi (10):
  block, bfq: correctly raise inject limit in
    bfq_choose_bfqq_for_injection
  block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
  block, bfq: initialize bfqq->decrease_time_jif correctly
  block, bfq: use helper macro RQ_BFQQ to get bfqq of request
  block, bfq: remove unnecessary pointer reference to get async_bfqq
  block, bfq: remove redundant bfqd->rq_in_driver > 0 check in
    bfq_add_request
  block, bfq: remove redundant check in bfq_put_cooperator
  block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
  block, bfq: remove unused bfq_wr_max_time in struct bfq_data
  block, bfq: remove check of bfq_wr_max_softrt_rate which is always
    greater than 0

 block/bfq-iosched.c | 49 +++++++++++++++++----------------------------
 block/bfq-iosched.h |  2 --
 2 files changed, 18 insertions(+), 33 deletions(-)

-- 
2.30.0

