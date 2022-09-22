Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D25C6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 11:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiIVLZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiIVLZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 07:25:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E3ABF20;
        Thu, 22 Sep 2022 04:25:13 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYCWJ5mXhzMpSn;
        Thu, 22 Sep 2022 19:20:28 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:25:11 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:25:10 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 0/5] blk-wbt: simple improvment to enable wbt correctly
Date:   Thu, 22 Sep 2022 19:35:53 +0800
Message-ID: <20220922113558.1085314-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

changes in v3:
 - instead of check elevator name, add a flag in elevator_queue, as
 suggested by Christoph.
 - add patch 3 and patch 5 to this patchset.

changes in v2:
 - define new api if wbt config is not enabled in patch 1.

Yu Kuai (5):
  wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
  elevator: add new field flags in struct elevator_queue
  block, bfq: don't disable wbt if CONFIG_BFQ_GROUP_IOSCHED is disabled
  blk-wbt: don't enable throttling if default elevator is bfq
  elevator: remove redundant code in elv_unregister_queue()

 block/bfq-iosched.c |  6 +++++-
 block/blk-sysfs.c   |  9 ++++++++-
 block/blk-wbt.c     | 15 ++++++++++++++-
 block/blk-wbt.h     |  5 +++++
 block/elevator.c    |  8 ++------
 block/elevator.h    |  5 ++++-
 6 files changed, 38 insertions(+), 10 deletions(-)

-- 
2.31.1

