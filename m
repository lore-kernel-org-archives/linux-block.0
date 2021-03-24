Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB466C433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9D2619F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 07:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhCXHQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:16:25 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:42004 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhCXHQI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 03:16:08 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 03:16:08 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 74C14980276;
        Wed, 24 Mar 2021 15:09:46 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: lightnvm: Remove duplicate include
Date:   Wed, 24 Mar 2021 15:09:21 +0800
Message-Id: <20210324070921.736874-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk9OTk0eQ04YGRhOVkpNSk1OTUJMQ01NTkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Qhw*CD8IODgSTyEyPj0Z
        PxJPCSxVSlVKTUpNTk1CTENMTkpDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0pONwY+
X-HM-Tid: 0a78631160d0d992kuws74c14980276
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ifdef CONFIG_NVM, linux/blkdev.h and uapi/linux/lightnvm.h
would be included twice. So remove them.
By the way, I find that struct nvm_rq is declared twice. 
If removing the duplicated declaration really makes sense, it would 
be much clean up work to do in inlude/linux.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/lightnvm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 1db223710b28..1ddb41ee71eb 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -112,10 +112,8 @@ struct nvm_dev_ops {
 
 #ifdef CONFIG_NVM
 
-#include <linux/blkdev.h>
 #include <linux/file.h>
 #include <linux/dmapool.h>
-#include <uapi/linux/lightnvm.h>
 
 enum {
 	/* HW Responsibilities */
@@ -276,7 +274,6 @@ struct nvm_target {
 
 #define NVM_MAX_VLBA (64) /* max logical blocks in a vector command */
 
-struct nvm_rq;
 typedef void (nvm_end_io_fn)(struct nvm_rq *);
 
 struct nvm_rq {
-- 
2.25.1

