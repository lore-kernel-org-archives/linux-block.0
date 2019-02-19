Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0919FC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 05:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D644A2173C
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 05:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfBSFWc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:22:32 -0500
Received: from mx56.baidu.com ([61.135.168.56]:43911 "EHLO
        tc-sys-mailedm04.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbfBSFWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 00:22:32 -0500
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2019 00:22:31 EST
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm04.tc.baidu.com (Postfix) with ESMTP id E5679236C005;
        Tue, 19 Feb 2019 13:14:07 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-block@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH] nbd: propagate genlmsg_reply return code
Date:   Tue, 19 Feb 2019 13:14:07 +0800
Message-Id: <1550553247-28077-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

genlmsg_reply can fail, so propagate its return code

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/block/nbd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7c9a949e876b..accb627fc158 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2118,8 +2118,7 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 	nla_nest_end(reply, dev_list);
 	genlmsg_end(reply, reply_head);
-	genlmsg_reply(reply, info);
-	ret = 0;
+	ret = genlmsg_reply(reply, info);
 out:
 	mutex_unlock(&nbd_index_mutex);
 	return ret;
-- 
2.16.2

