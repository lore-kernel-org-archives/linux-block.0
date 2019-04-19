Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27573C282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 20:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E339F20869
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 20:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIp8wlHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfDSUf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:35:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41225 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDSUf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 16:35:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so3092062pgs.8
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2019 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+YgfeLbCyP7h2J6H6EvbHAS9wXC4NfpGet1Up2O/eA=;
        b=YIp8wlHpv3NKirjUTNRYPsE1SgJ7dzD5ZU3fBCpmzksw9C5ua1m3F9OvBYeGLcGeSR
         uiex/MgPC4jcSsIYTd7OOANpA1AQg4PBdSky70g5X3y7mtdAB3Wk+KSnAClN5wDmZAmY
         zx/aDR2/FZq8Q9AzJMVr3Lpl4n16PD8Hw0UgPOUDZlid0mQkLI5+N5oYcgPNj9KsWZiP
         ujampXAg15UJXGrgCb3GvfgEJMfZi6YnWVUu5wnk+/tQI0hrui2GPvZl1qnlLV0FTsnE
         +tgdhSz1lkBCdKViQjZMlJRzPCVp2fOHN+A852Sbu2SawV3eCx/ZizY3nIWZ1sYkNxkn
         qiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+YgfeLbCyP7h2J6H6EvbHAS9wXC4NfpGet1Up2O/eA=;
        b=lbU0PBXt4tCir7N6IDeCdYnTuirHtkkzlG45Kq3ADZ8hrYLDxnvh+jrq46UwroF3/p
         dtMHMgbYu+kuN4DKSsRXo6RAlynR1BcA5IGGPg/Cys3OKZXa9L8Q1PmRm1ItSWzL7WF3
         Yt+YQPTW3D4wTObvof1qC6fIYHJITxW8EqVPxM0y0LG7sk39W/iY4CrGMhowdVYwm5C9
         0LSHuNrt+AvX0uAg7JEcIc7IU1VPB/Vhi3q6g4CIBZJ16HqAzUVqLACow5aiWPuRKqZ/
         oBG3VwlaLFqo/2KB1yhNR7F6jogCV0/u2A7z0T+Eb7863Ik2J+RpFdYZlDDQWnmgshbf
         RVbw==
X-Gm-Message-State: APjAAAVNsCyoxU1o7mSO2eH7CCkY5dV5U3X2zBjM0j4RImPwxU89GHnx
        r26nXrQ9AL/Zbh8BF6fwU+BCmFNG3SDDSw==
X-Google-Smtp-Source: APXvYqykKLFRSsaS8HmvcP3p4wNN0G94oGAu1Fi1xOhe0YKIYv7efa3aAkuT5EDYY21jF7UZAQzioQ==
X-Received: by 2002:a63:fc43:: with SMTP id r3mr5738070pgk.44.1555706156191;
        Fri, 19 Apr 2019 13:35:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5cfc])
        by smtp.gmail.com with ESMTPSA id 17sm9583359pfw.65.2019.04.19.13.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 13:35:55 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 1/1] blk-mq: Fix memory leak in error handling
Date:   Fri, 19 Apr 2019 16:35:44 -0400
Message-Id: <20190419203544.11725-2-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419203544.11725-1-Jes.Sorensen@gmail.com>
References: <20190419203544.11725-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

If blk_mq_init_allocated_queue() fails, make sure to free the poll
stat callback struct allocated.

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9516304a38ee..7aa90c0b056b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2838,7 +2838,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		goto err_exit;
 
 	if (blk_mq_alloc_ctxs(q))
-		goto err_exit;
+		goto err_poll;
 
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
@@ -2899,6 +2899,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	kfree(q->queue_hw_ctx);
 err_sys_init:
 	blk_mq_sysfs_deinit(q);
+err_poll:
+	blk_stat_free_callback(q->poll_cb);
+	q->poll_cb = NULL;
 err_exit:
 	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
-- 
2.17.1

