Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70630C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C640206A2
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 07:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfG3HyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:54:11 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:56494 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfG3HyL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 03:54:11 -0400
X-QQ-mid: bizesmtp12t1564472823tfr2n64f
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 30 Jul 2019 15:47:02 +0800 (CST)
X-QQ-SSF: 01400000002000Q0WQ80000A0000000
X-QQ-FEAT: NMeSvuvY+wuq0CXopHzPm6BLTqEQPYPX/EwVrBa50mSzrHdyIKbd1rzLAo0PQ
        3dhl09+GbwehHvS5rhL/C6kc2BA0TzXJJ1E4Bf0tPQGdz/UL0DNEjpUfwESup+zUVdStr0Z
        YbRZv/Yfv7gvXU7VdjETvlvmM0w36qXXoeiiZmdN9JL+1PpUsg5yZkmBYYTRQKO5eXQFYF5
        UTpoxNPtFBackFZpDfjJRVk22OWVothl/sS1sTOCj3OI5lf8Al/etOhISTfv2ie6Y+WNVSN
        fSHAYJWypFErT+hPbcw0INT3UXll/PZShyZFHFMXhzuteutIWC1IkcLzsLo9Y7/c1p9QjwA
        vP6MJOy5PkRo9g9htoRHIGqIEqrVQ==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] io_uring: remove the variable tmin that is not useful
Date:   Tue, 30 Jul 2019 15:46:46 +0800
Message-Id: <1564472806-413-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

*nr_events is always equal to 0, tmin has no meaning.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 012bc0e..4204a53 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -808,12 +808,7 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 	int ret = 0;
 
 	do {
-		int tmin = 0;
-
-		if (*nr_events < min)
-			tmin = min - *nr_events;
-
-		ret = io_iopoll_getevents(ctx, nr_events, tmin);
+		ret = io_iopoll_getevents(ctx, nr_events, min);
 		if (ret <= 0)
 			break;
 		ret = 0;
-- 
2.7.4



