Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5568C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJTM6w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJTM6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 08:58:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA1318A00B;
        Thu, 20 Oct 2022 05:58:51 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtSGM3QBlzmV9g;
        Thu, 20 Oct 2022 20:54:03 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 20:58:48 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 20:58:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <hch@lst.de>, <willy@infradead.org>,
        <kch@nvidia.com>, <martin.petersen@oracle.com>,
        <johannes.thumshirn@wdc.com>, <yukuai3@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>
Subject: [PATCH -nect RFC v2 0/2] block: fix uaf in bd_link_disk_holder()
Date:   Thu, 20 Oct 2022 21:20:47 +0800
Message-ID: <20221020132049.3947415-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes in v2:
 - in order to know when bd_holder_dir will be freed, instead of changing
kobject_put(), add a new field in block_device.

Yu Kuai (2):
  block: add helpers for bd_holder_dir refcount management
  block: fix uaf for bd_holder_dir

 block/blk.h               |  3 +++
 block/genhd.c             | 33 ++++++++++++++++++++++++++++++++-
 block/holder.c            | 19 +++++++++++++------
 block/partitions/core.c   |  5 ++++-
 include/linux/blk_types.h |  1 +
 5 files changed, 53 insertions(+), 8 deletions(-)

-- 
2.31.1

