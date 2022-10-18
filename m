Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FB4C433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 12:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJRMww (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJRMwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 08:52:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B6C4C32;
        Tue, 18 Oct 2022 05:52:49 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MsDKh5h6nzHv1m;
        Tue, 18 Oct 2022 20:52:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 20:52:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:52:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@lst.de>, <axboe@kernel.dk>, <gregkh@linuxfoundation.org>,
        <willy@infradead.org>, <martin.petersen@oracle.com>,
        <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 0/2] block: fix uaf in bd_link_disk_holder()
Date:   Tue, 18 Oct 2022 21:14:30 +0800
Message-ID: <20221018131432.434167-1-yukuai3@huawei.com>
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

Yu Kuai (2):
  kobject: add return value for kobject_put()
  block: protect slave_dir/bd_holder_dir by open_mutex

 block/genhd.c           |  8 ++++++--
 block/holder.c          | 13 ++++++++++++-
 block/partitions/core.c |  5 ++++-
 include/linux/kobject.h |  2 +-
 lib/kobject.c           |  7 +++++--
 5 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.31.1

