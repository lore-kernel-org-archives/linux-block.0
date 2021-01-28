Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A0C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244EF60235
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhA1HWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 02:22:31 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35145 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231754AbhA1HTo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 02:19:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UN7J966_1611818338;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UN7J966_1611818338)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Jan 2021 15:18:58 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-cgroup: Remove obsolete macro
Date:   Thu, 28 Jan 2021 15:18:50 +0800
Message-Id: <2d053708b596fe148c1d9e63a97117c150a0004a.1611818240.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the obsolete 'MAX_KEY_LEN' macro.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4b4fcb5..a317c03 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -32,8 +32,6 @@
 #include <linux/psi.h>
 #include "blk.h"
 
-#define MAX_KEY_LEN 100
-
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
  * blkcg_pol_register_mutex nests outside of it and synchronizes entire
-- 
1.8.3.1

