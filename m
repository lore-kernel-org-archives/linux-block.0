Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B18C433E2
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2252721481
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 08:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIGIKm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:10:42 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41292 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727931AbgIGIKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Sep 2020 04:10:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U89GXW8_1599466228;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U89GXW8_1599466228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Sep 2020 16:10:29 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Some improvements for blk-throttle
Date:   Mon,  7 Sep 2020 16:10:12 +0800
Message-Id: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi All,

This patch set did some clean-ups, as well as removing some unnecessary
bps/iops limitation calculation when checking if can dispatch a bio or
not for a tg. Please help to review. Thanks.

Baolin Wang (5):
  blk-throttle: Fix some comments' typos
  blk-throttle: Use readable READ/WRITE macros
  blk-throttle: Define readable macros instead of static variables
  blk-throttle: Avoid calculating bps/iops limitation repeatedly
  blk-throttle: Avoid checking bps/iops limitation if bps or iops is    
    unlimited

 block/blk-throttle.c | 59 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 23 deletions(-)

-- 
1.8.3.1

