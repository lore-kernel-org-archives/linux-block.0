Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE830C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8078206C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfCROCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:02:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbfCROCu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:02:50 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4878100AE043F53EB96;
        Mon, 18 Mar 2019 22:02:47 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 22:02:45 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <tj@kernel.org>, <hch@lst.de>
Subject: [PATCH 0/2] fix use-after-free of gendisk
Date:   Mon, 18 Mar 2019 22:07:01 +0800
Message-ID: <20190318140703.28963-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 1: fix use after free in get_gendisk, when open device partition.
Patch 2: remove unneccessary if statement

Yufen Yu (2):
  block: remove devt from ext_devt_idr when delete partition
  block: remove unnecessary statement in blk_free_devt

 block/genhd.c             | 3 ---
 block/partition-generic.c | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.16.2.dirty

