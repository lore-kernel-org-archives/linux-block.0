Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B412C64E7D
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F2A20872
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgKXDeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:34:04 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:24189 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727550AbgKXDeA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:34:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGN9oOX_1606188828;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGN9oOX_1606188828)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 11:33:48 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Some cleanups and improvements for blk-iocost
Date:   Tue, 24 Nov 2020 11:33:29 +0800
Message-Id: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch set did some cleanups and improvements for blk-iocost, and
no big functional changes. Please help to review. Thanks.

Baolin Wang (7):
  blk-iocost: Fix some typos in comments
  blk-iocost: Remove unnecessary advance declaration
  blk-iocost: Just open code the q_name()
  blk-iocost: Add a flag to indicate if need update hwi
  blk-iocost: Move the usage ratio calculation to the correct place
  blk-iocost: Factor out the active iocgs' state check into a separate  
      function
  blk-iocost: Factor out the base vrate change into a separate function

 block/blk-iocost.c | 238 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 126 insertions(+), 112 deletions(-)

-- 
1.8.3.1

