Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87009C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 08:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6F46109E
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 08:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhHMILQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbhHMILQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 04:11:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB91C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 01:10:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a20so10942751plm.0
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqAwpQO8X7n0Y17FIjHDN+UGwZ5lc+0aIYD45P4Rl4g=;
        b=l8/qcIze3UJ/k/jiJb2vHoa8CtAObJsq3orL2ts+8ZZH11WygZ3VKtV4S3zXMVAQtg
         EUNX5F6AtaSlV0F2zXUnl64GzbdG+LG+MBHD6Ly7OkTO61r6ArgZZkZIpreVscpSFbRZ
         ZYYGDxJFTS7yyb3dCBmJJR3z/Z3uBSwA7NsFwiyLM9SdPsK2BZhDJ9a6Mj99acrsZmdj
         gbO6GxF/mixJbOzwMs6j6Utf+CsoHCnaWqEAXzzbPAHptvDqYTU+v4SFX7hwQx3dAxDo
         48fH23LDthKUFdoDgc3dIlvggqFkMTf6rKFZ1Lbbu5wI85XZY9TnWVbhPMEg/+JwQW6d
         L1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqAwpQO8X7n0Y17FIjHDN+UGwZ5lc+0aIYD45P4Rl4g=;
        b=BMVCo/ZktSIfn5mmrR0DWNLtIMdQ0CQV+/YBVSn7z22SHzNQS2JS1k0pYpYQxXTR6w
         yP5hGv8fCNhO+LQtu1mdR84OhULV7+YYfhb8CqBw1stFHf4v6pnIv4ZmsV4LKscR2IGn
         cn5udrB/ILprmF6YS/oV8tOjG/a6iYAF/fLHAmXwJ2afRbjo521imdnpYpuvFjfUNAwg
         fHvdv2zC9OaSWaGGRBLZlPXT3hzg8lCHDspXiID9JdV4/VjJpd1zNfafF8CFSTaMKiJv
         m1g8Ak1jxR7/ObJPRP20h6cKiwhzHu6+NnRFeF4kRT9Wx55v36zBRRlWo65SJM56s3k/
         e8Lw==
X-Gm-Message-State: AOAM532UTJzKi0Lr8nD/0H1YdDTV4P0oeasD2AN/J1whR+NmNr75JaPn
        gMuq054OAmXp7/lpdTCsnMoF
X-Google-Smtp-Source: ABdhPJwI8wUVL//spsdg0J/QOM84H++McIr0oJRvfmnTg8JmS3gHPpnvCN+5uY3Ok8roqBq0Y7JaFA==
X-Received: by 2002:a17:90a:f696:: with SMTP id cl22mr1501205pjb.124.1628842249694;
        Fri, 13 Aug 2021 01:10:49 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id x13sm1127205pjh.30.2021.08.13.01.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:10:49 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     jiangyadong@bytedance.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH] nbd: Aovid double completion of a request
Date:   Fri, 13 Aug 2021 16:10:33 +0800
Message-Id: <20210813081033.142-1-xieyongji@bytedance.com>
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

