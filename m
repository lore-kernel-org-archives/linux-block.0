Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD843C43457
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 03:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A47022248
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 03:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgJIDX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 23:23:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729318AbgJIDX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F21E982E6B38E65CB67;
        Fri,  9 Oct 2020 11:23:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:20 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 0/7] some improvements and cleanups for block
Date:   Thu, 8 Oct 2020 23:26:26 -0400
Message-ID: <20201009032633.83645-1-yuyufen@huawei.com>
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

Yufen Yu (7):
  block: invoke blk_mq_exit_sched no matter whether have .exit_sched
  block: remove redundant mq check
  block: use helper function to test queue register
  blk-mq: use helper function to test hw stopped
  block: fix comment and add lockdep assert
  block: get rid of unnecessary local variable
  blk-mq: get rid of the dead flush handle code path

 block/blk-iocost.c   |  2 +-
 block/blk-mq-sched.c |  6 ------
 block/blk-mq.c       |  2 +-
 block/blk-sysfs.c    |  5 +----
 block/elevator.c     | 23 ++++++++---------------
 5 files changed, 11 insertions(+), 27 deletions(-)

-- 
2.25.4

