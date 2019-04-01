Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BFC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 08:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDA920857
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 08:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Xoq5hUeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfDAIa2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:30:28 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:43223 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726206AbfDAIa2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 04:30:28 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 92C3920F1F;
        Mon,  1 Apr 2019 11:30:24 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2FHU7Vb8GG-UOLuEYR3;
        Mon, 01 Apr 2019 11:30:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1554107424; bh=Jf0jVNGeLRlmm74eSStV0tqfbbEcCYjzm+rMl+ttSlA=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=Xoq5hUeQep1OW7DOzQTHZ/7Ch14s57J9Y2Sy6hMGNQvZn0EPV5bcjc1ylIh6Rb4EW
         KmPle+Q7PymVPMSvi9a/bLXXIxIUfbGGQnkoLZzL+97/ybYhpBkU7XJqFajz+7nJJ4
         XJb8EDp/9D6UQ2ZGRDal7KJ+DP55yPlIIDEgDx04=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d4bb:795:9728:5f59])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id AXLWN893C9-UNsmffam;
        Mon, 01 Apr 2019 11:30:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] null_blk: fix race and oops at removing device with
 bandwidth limit
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Shaohua Li <shli@fb.com>
Date:   Mon, 01 Apr 2019 11:30:23 +0300
Message-ID: <155410742366.3063.14505657567265604512.stgit@buzz>
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
index 417a9f15c116..757b58e0fec7 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1383,8 +1383,8 @@ static void null_del_dev(struct nullb *nullb)
 	del_gendisk(nullb->disk);
 
 	if (test_bit(NULLB_DEV_FL_THROTTLED, &nullb->dev->flags)) {
+		clear_bit(NULLB_DEV_FL_THROTTLED, &nullb->dev->flags);
 		hrtimer_cancel(&nullb->bw_timer);
-		atomic_long_set(&nullb->cur_bytes, LONG_MAX);
 		null_restart_queue_async(nullb);
 	}
 

