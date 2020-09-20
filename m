Return-Path: <SRS0=iZfY=C5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FE0C43465
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AAF20EDD
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 09:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgITJKd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Sep 2020 05:10:33 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55548 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgITJKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 05:10:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U9TXAYI_1600593030;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U9TXAYI_1600593030)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 17:10:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Some improvements for blk throttle
Date:   Sun, 20 Sep 2020 17:10:17 +0800
Message-Id: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch set did some improvements for blk throttle, please
help to review. Thanks.

Baolin Wang (4):
  blk-throttle: Remove a meaningless parameter for
    throtl_downgrade_state()
  blk-throttle: Avoid getting the current time if tg->last_finish_time
    is 0
  blk-throttle: Avoid tracking latency if low limit is invalid
  blk-throttle: Fix IO hang for a corner case

 block/blk-throttle.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
1.8.3.1

