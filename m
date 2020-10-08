Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079BBC433E7
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 03:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C762F2168B
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 03:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgJHDwl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 23:52:41 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59380 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgJHDwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 23:52:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UBGOQ8o_1602129157;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBGOQ8o_1602129157)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:52:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Some improvements for blk throttle
Date:   Thu,  8 Oct 2020 11:52:21 +0800
Message-Id: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch set did some improvements for blk throttle, please
help to review. Thanks.

Changes from v1:
 - Add another 4 new patches in this patch set.

Baolin Wang (8):
  blk-throttle: Remove a meaningless parameter for
    throtl_downgrade_state()
  blk-throttle: Avoid getting the current time if tg->last_finish_time
    is 0
  blk-throttle: Avoid tracking latency if low limit is invalid
  blk-throttle: Fix IO hang for a corner case
  blk-throttle: Move the list operation after list validation
  blk-throttle: Move service tree validation out of the
    throtl_rb_first()
  blk-throttle: Open code __throtl_de/enqueue_tg()
  blk-throttle: Re-use the throtl_set_slice_end()

 block/blk-throttle.c | 69 ++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

-- 
1.8.3.1

