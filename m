Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C1C282C5
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DA1218D2
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfAYANJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:13:09 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34583 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbfAYANI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 19:13:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TIwm2.D_1548375186;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TIwm2.D_1548375186)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Jan 2019 08:13:07 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 0/3] iolatency bug fix
Date:   Fri, 25 Jan 2019 08:12:46 +0800
Message-Id: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This set is to fix a hang case if blk-iolatency is in use.

The 1st patch explains the hang problem with more details and provides
a fix.
The 2nd patch adds a warning for unexpected inflight counter.
The 3rd patch is a cleanup of blk_mq_freeze_queue.

v2: reorder the actual fix to the first patch.

Liu Bo (3):
  blk-iolatency: fix IO hang due to negative inflight counter
  Blk-iolatency: warn on negative inflight IO counter
  blk-mq: remove duplicated definition of blk_mq_freeze_queue

 block/blk-iolatency.c | 56 ++++++++++++++++++++++++++++++++++++-------
 block/blk-mq.h        |  1 -
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.20.1.2.gb21ebb6

