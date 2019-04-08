Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E72C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D3620879
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EFrkl671"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDHOsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:48:31 -0400
Received: from m15-113.126.com ([220.181.15.113]:56616 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDHOsa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 10:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=85PjgBN0MDpvlDO4QI
        FYZgfZpywAJvb9WkD9ICJ41go=; b=EFrkl67145WxSQxTIHuMbtcw/u/5NRWogQ
        uZ3G2oyPzBozlQBtcr3scLUhyfYbfgUFu9F1mm8fTy7oH6quCV4Q+U8YbRf92XSb
        FTtqk22ytWGKtuatAJLjoH5AogJlXGBKJ3PVVRLYgYzpfgiOMJl5JghWHB/Wrtko
        Cddjx+tOo=
Received: from localhost.localdomain.localdomain (unknown [58.100.210.24])
        by smtp3 (Coremail) with SMTP id DcmowAB3zAk1X6tc1r+TDw--.36969S3;
        Mon, 08 Apr 2019 22:48:23 +0800 (CST)
From:   Tian Xianting <xianting_tian@126.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     stable@vger.kernel.org, xianting_tian@126.com
Subject: [PATCH] block: convert kmalloc_node to kzalloc_node
Date:   Mon,  8 Apr 2019 10:48:22 -0400
Message-Id: <1554734902-8295-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcmowAB3zAk1X6tc1r+TDw--.36969S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW7Cw13trWrKryfJw43Wrg_yoW3Xwb_Z3
        48GFy0vr4kJr4rWFs8tFWUJwnIkw4fWF15KFnxCwsruF15J3WSyry7uFnxCrWDWFW7CFWS
        kw1q9F47Kr1xGjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeAgA5UUUUU==
X-Originating-IP: [58.100.210.24]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi9BeQpFpD64U1JwAAsy
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use kzalloc_node to zero allocated buffer, as deadline and cfq I/O
scheduler initialization function (deadline_init_queue, cfq_init_queue)
did.

Signed-off-by: Tian Xianting <xianting_tian@126.com>
---
 block/noop-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/noop-iosched.c b/block/noop-iosched.c
index 2d1b15d..739e8cd 100644
--- a/block/noop-iosched.c
+++ b/block/noop-iosched.c
@@ -68,7 +68,7 @@ static int noop_init_queue(struct request_queue *q, struct elevator_type *e)
 	if (!eq)
 		return -ENOMEM;
 
-	nd = kmalloc_node(sizeof(*nd), GFP_KERNEL, q->node);
+	nd = kzalloc_node(sizeof(*nd), GFP_KERNEL, q->node);
 	if (!nd) {
 		kobject_put(&eq->kobj);
 		return -ENOMEM;
-- 
1.8.3.1

