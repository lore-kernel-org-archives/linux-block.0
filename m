Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EE2C070DF
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2983D61285
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhDARqG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhDARkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 13:40:25 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 021B1C0613AE;
        Thu,  1 Apr 2021 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=CWklXCL+YD
        Y2PYR5Ag06YNYFH//f8R5Tm4EPbzqTnEU=; b=o3ghQiqfYhiAzCfXAPKmxKmsRx
        vIRaQkLAMkZkkiqMZBnyQrBPS69dtKc0FLZ4pSyXdlZKqExNxjFS3Cv3U0s62CC8
        IBXXW5CXEtzHVRatWC34w+FAY0jlrprnxs/1ileqLUJLtHMdhPb4E4EVauIPWQcE
        VgC/V0ExDRBnCy5fs=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHjaVFtWVgWIeBAA--.1831S4;
        Thu, 01 Apr 2021 19:57:57 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] drbd: Fix a use after free in get_initial_state
Date:   Thu,  1 Apr 2021 04:57:53 -0700
Message-Id: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCHjaVFtWVgWIeBAA--.1831S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDJrWDJFW8KFWkGF43Awb_yoW8Xr4fpa
        yUW3sIkFs8Ka18uFy3Kw18ZF909a1kGr9xGrWjq343AFnxtrn3Za40yFWYyFWFkr9xGF4r
        t3W2vw1DGayDK3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUDb1bUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In get_initial_state, it calls notify_initial_state_done(skb,..) if
cb->args[5]==1. I see that if genlmsg_put() failed in
notify_initial_state_done(), the skb will be freed by nlmsg_free(skb).
Then get_initial_state will goto out and the freed skb will be used by
return value skb->len.

My patch lets skb_len = skb->len and return the skb_len to avoid the uaf.

Fixes: a29728463b254 ("drbd: Backport the "events2" command")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/block/drbd/drbd_nl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bf7de4c7b96c..474f84675d0a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4905,6 +4905,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
 	unsigned int seq = cb->args[2];
 	unsigned int n;
+	unsigned int skb_len = skb->len;
 	enum drbd_notification_type flags = 0;
 
 	/* There is no need for taking notification_mutex here: it doesn't
@@ -4915,7 +4916,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	cb->args[5]--;
 	if (cb->args[5] == 1) {
 		notify_initial_state_done(skb, seq);
-		goto out;
+		return skb_len;
 	}
 	n = cb->args[4]++;
 	if (cb->args[4] < cb->args[3])
-- 
2.25.1


