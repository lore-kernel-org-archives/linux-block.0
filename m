Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9851C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13D060F57
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbhHMPVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbhHMPUo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 11:20:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78711C034006
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:13:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c17so7060336plz.2
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqAwpQO8X7n0Y17FIjHDN+UGwZ5lc+0aIYD45P4Rl4g=;
        b=RW/1s1tEObM+aMj+uE+Htb/efFrSyNxAfeOBq1Vz2YvsOEIuCSgCTIeHifrQ0TFo7I
         jp8U/OyohQYoOF0HPKXQFLCk8DmhQEW5zPjSUTgXU9Wxqrx6p/Sv0nXj2hO0AqTt+bG4
         v3ubYArUpAXueL1tFkjJ/gSKDXlbyROw7FyoGSdYr0skyehKyV5XfFoc1No91evpRKVa
         RzlJsNAlqyzrmH8sLBlMQluE5MpFZeg+Z3PFcANII9aXia4za05B+G2fxWXF/xB2r8J+
         TT1RVgGLyly6PlM+e2EqRMgICIdE342LsMa3GZz1I6YRMn8mJvgqN8T0Mw2bUWZb9fTy
         hQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqAwpQO8X7n0Y17FIjHDN+UGwZ5lc+0aIYD45P4Rl4g=;
        b=Z2lJuoDTFlxEiHZdLfGK1ZbyoxSzy0hbv7qD6VgZhGoIltJIKCz4wU+10w8mlpNdM1
         d+r0RXj/Bn9XjDjjV4NvGUmaTbEaLCRTG0kfPsnsVaqPN6GNojZblueNj5YBM1M99pGp
         7OCxcoJd1pzUpLdrcQMjZd3xu4BDAgHlip8TG3vxhgIH6FcDmY/agPCuJkp3nuM5H1cL
         FmjROn2WpVWa0FfJ1uDgqEyaMTSBJrkw5OIUqytJx4jaX+QzcxQaj11JdHzQZbnmaP0I
         ilDbIQNAZyP5VUxopMi6emvCIoftgHog6Gtg9CpbgVOzgcFb/MGX0nL2yi71wdnSfZ7a
         Pn5g==
X-Gm-Message-State: AOAM5337N1s0enNFLDyh9Zj5wSfAtCdH+msHD/YeXJyxDRPr1yjUfCKt
        XAXaj5cvqsdTpebYNY/FKa3a
X-Google-Smtp-Source: ABdhPJwGooV4r6z+dWtH6qviTbcKfA1byzCmqr/9V/NKLRQP0hZs1bL1Nd0Cd71kAtKUqRsPBAFa2Q==
X-Received: by 2002:a05:6a00:1481:b029:3e0:4537:a1d9 with SMTP id v1-20020a056a001481b02903e04537a1d9mr2870848pfu.36.1628867621984;
        Fri, 13 Aug 2021 08:13:41 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id y23sm2892615pfb.130.2021.08.13.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 08:13:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     jiangyadong@bytedance.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH RESEND] nbd: Aovid double completion of a request
Date:   Fri, 13 Aug 2021 23:13:30 +0800
Message-Id: <20210813151330.96-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a race between iterating over requests in
nbd_clear_que() and completing requests in recv_work(),
which can lead to double completion of a request.

To fix it, flush the recv worker before iterating over
the requests and don't abort the completed request
while iterating.

Fixes: 96d97e17828f ("nbd: clear_sock on netlink disconnect")
Reported-by: Jiang Yadong <jiangyadong@bytedance.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/nbd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74..19f5d5a8b16a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -818,6 +818,10 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 
+	/* don't abort one completed request */
+	if (blk_mq_request_completed(req))
+		return true;
+
 	mutex_lock(&cmd->lock);
 	cmd->status = BLK_STS_IOERR;
 	mutex_unlock(&cmd->lock);
@@ -2004,15 +2008,19 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 {
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
-	nbd_clear_sock(nbd);
-	mutex_unlock(&nbd->config_lock);
+	sock_shutdown(nbd);
 	/*
 	 * Make sure recv thread has finished, so it does not drop the last
 	 * config ref and try to destroy the workqueue from inside the work
-	 * queue.
+	 * queue. And this also ensure that we can safely call nbd_clear_que()
+	 * to cancel the inflight I/Os.
 	 */
 	if (nbd->recv_workq)
 		flush_workqueue(nbd->recv_workq);
+	nbd_clear_que(nbd);
+	nbd->task_setup = NULL;
+	mutex_unlock(&nbd->config_lock);
+
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
-- 
2.11.0

