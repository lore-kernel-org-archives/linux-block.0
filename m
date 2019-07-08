Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DF1C606C2
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D7421537
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ve3zJM8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbfGHPbV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:31:21 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42246 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbfGHPbU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Jul 2019 11:31:20 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1B4CE2E0AFB;
        Mon,  8 Jul 2019 18:31:18 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id IybuJqQbtA-VHUevqMH;
        Mon, 08 Jul 2019 18:31:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1562599878; bh=++lrfvwZjaLsfQzgaVw0H2rIS5jqJhN6AJSriPvsrIY=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=ve3zJM8jhAoeWRKWPa6NVzg904mXBEzV97CoUdwtLmTzRS5A2tkLlckrpJdlV2s0n
         dxc3Y/GFnYWQJu5fLUmYVTk48k5Y+VBREqe4LJbhKKGTtreuRg0m9RIjEacGsSYDlS
         8l97F7f7upQMOSfCX+QaTjM7Z7R5XTarP7xDs5n4=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fce8:911:2fe8:4dfb])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nA5P8SeRQi-VH9CfHCJ;
        Mon, 08 Jul 2019 18:31:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/2] null_blk: fix race and oops at removing device with
 bandwidth limit
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Jul 2019 18:31:17 +0300
Message-ID: <156259987752.2590.11230901750437507796.stgit@buzz>
In-Reply-To: <156259987576.2590.3397115585587914567.stgit@buzz>
References: <156259987576.2590.3397115585587914567.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function null_del_dev should disable throttling before canceling timer,
otherwise timer could be restarted by null_handle_cmd().

Remove bump of cur_bytes - without NULLB_DEV_FL_THROTTLED it has no effect.

Fixes: eff2c4f10873 ("nullb: bandwidth control")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/block/null_blk_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 15925b355965..2d4ba7b05e2f 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1398,8 +1398,8 @@ static void null_del_dev(struct nullb *nullb)
 	del_gendisk(nullb->disk);
 
 	if (test_bit(NULLB_DEV_FL_THROTTLED, &nullb->dev->flags)) {
+		clear_bit(NULLB_DEV_FL_THROTTLED, &nullb->dev->flags);
 		hrtimer_cancel(&nullb->bw_timer);
-		atomic_long_set(&nullb->cur_bytes, LONG_MAX);
 		null_restart_queue_async(nullb);
 	}
 

