Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DBCC4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528AF214AF
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfIRCiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:38:03 -0400
Received: from smtpbg702.qq.com ([203.205.195.102]:44039 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbfIRCiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 22:38:03 -0400
X-Greylist: delayed 1638 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 22:38:03 EDT
X-QQ-mid: bizesmtp28t1568774276thdo4m77
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 18 Sep 2019 10:37:55 +0800 (CST)
X-QQ-SSF: 01400000002000R0YS90000A0000000
X-QQ-FEAT: gDbwoeOnDAE5syuAuZ/6ujTciWVNQTqCOssCtM/iCik5QuQjKPtLxpgSTOrYT
        YxYZUHsVeciQm7gONcaRw3qPmlzMZViaMcv4Y10EgrrqSA9Jv919xNJ3AAXEUujfmraoYPc
        OPSoQGOCADs3GftKkR4mk+sBB0YFCKbjDzw5kmMkdgmHm6KjSvnPqTetSYr0b/vKgI+x/Ka
        7fK/CQ5w52jFywI3qZUQBy4l1MB6YPIky1Cd1Fi43sqOl14MRTD+UrOZDSAlizc+6YqVWrm
        6xs+vtAvQsHqm7BVU5azLOgk8jc9MjOE8JsWm0OxcTjCvo0oalaX/qgLGvId0hEJ96bRf+/
        VUgSjZnVFTlcE9nbjo=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH RESEND 2/2] io_uring: fix use-after-free of shadow_req
Date:   Wed, 18 Sep 2019 10:37:53 +0800
Message-Id: <1568774273-19434-2-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568774273-19434-1-git-send-email-liuyun01@kylinos.cn>
References: <1568774273-19434-1-git-send-email-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a potential dangling pointer problem. we never clean
shadow_req, if there are multiple link lists in this series of
sqes, then the shadow_req will not reallocate, and continue to
use the last one. but in the previous, his memory has been
released, thus forming a dangling pointer. let's clean up him
and make sure that every new link list can reapply for a new
shadow_req.

Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 42a684e..1621243 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2357,6 +2357,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			io_queue_link_head(ctx, link, &link->submit, shadow_req,
 						true);
 			link = NULL;
+			shadow_req = NULL;
 		}
 		prev_was_link = (sqes[i].sqe->flags & IOSQE_IO_LINK) != 0;
 
@@ -2543,6 +2544,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 			io_queue_link_head(ctx, link, &link->submit, shadow_req,
 						force_nonblock);
 			link = NULL;
+			shadow_req = NULL;
 		}
 		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
 
-- 
2.7.4



