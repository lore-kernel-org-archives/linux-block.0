Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F6C43464
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 08:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFBE2100A
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 08:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIRIDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Sep 2020 04:03:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgIRIDG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 04:03:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AD0B8F32FBC6BE6E31D3;
        Fri, 18 Sep 2020 16:03:04 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 16:02:56 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <andy.lavr@gmail.com>, <yuyufen@huawei.com>
Subject: [PATCH v2 0/4] some improvements and clean-up for block
Date:   Fri, 18 Sep 2020 04:03:04 -0400
Message-ID: <20200918080308.2787773-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

  This series contains improvement for elevator exit, removing
  wrong comments and clean-up code.

v1->v2:
  fix a error in patch 2.

Yufen Yu (4):
  block: invoke blk_mq_exit_sched no matter whether have .exit_sched
  block: use common interface blk_queue_registered()
  block: fix comment and add lockdep assert
  block: get rid of unnecessary local variable

 block/blk-iocost.c |  2 +-
 block/blk-sysfs.c  |  5 +----
 block/elevator.c   | 19 ++++++-------------
 3 files changed, 8 insertions(+), 18 deletions(-)

-- 
2.25.4

