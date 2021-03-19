Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B37C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 01:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB77464E01
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 01:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhCSB0s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 21:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhCSB0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 21:26:42 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5981C06174A;
        Thu, 18 Mar 2021 18:26:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id q9so4251885qvm.6;
        Thu, 18 Mar 2021 18:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3thIuGvX4XVj1AmbqY3O0t5dR3K+7Boprdi3co112Xo=;
        b=HHVcqiE5wJWjoem7DySaldq182RCZdUA3Qy6yGV9HvnOrQhDrH9MnXrKzYJmLOhrqj
         S3VHN7MqyjaK+2c78meKA4G7sNrVqevNdH0w0EF9FRCSHV8Zq4s50+6V7ufi517EF24/
         IAcOMihMcseGMgFESuME6BepuMkBL0wbQ/PU0tr8kdFDYH2AXoLJUQ/Qaqbxm6+HHmqt
         KaDH78zOo6vWdzToPpo+aOiNLsoHKlCTFJwV0Wx+YwD/sFHYvITSTjRlumnxSuCNbJP6
         7Zp0MsUI0KjRbojrJJDWwT48s83Cs+kU/qX5jnpBLzQKe3yMwWcoJZQc0ukcTmpHke9z
         SP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3thIuGvX4XVj1AmbqY3O0t5dR3K+7Boprdi3co112Xo=;
        b=r5QyKGou3V7MNxnqNlDLvTGb3AqPZlNzEstorf493oZtlL5C/9NYzYsZqzXeHz9baM
         0/pMPbzOs3zo1SqsQnV8dG9AtaR5WX5I+1mtv6G4JePyKQly+p1nJnSQv4C4pcdGN8pI
         TkREc07e+9U1O/2YDrn1y0+wDoE2caliCIa6aesEX0CUYS0WSAxBvS71uSvJWFrc0it9
         ax7Frf8vBJQkzlT4ZYVhMErl3mJK3UcVUfGtaDjp/FqXN19o4c38RZfbhHoFpfInQSqn
         EYQQYmyXhERE/YyweDBmPx1M3yeWdOSYlBrUikHWcRF+y5VPM8eeB3gCKlJJB4QYng1t
         CRdA==
X-Gm-Message-State: AOAM533bkTmTPSMUQjbdu5y4TQ16gyu0txSwBY6WyFUPQPl2RyXEBsDo
        ls2fJYWlclpYUDjVr+v1O/8uFnQZbG75WnjS
X-Google-Smtp-Source: ABdhPJy4qYgG0+SJ78eysaifXglW4drVynzVzNqH6d24eP9yfoFq1/Ek+kVSlO3MKzEHb9k2/WVQ0g==
X-Received: by 2002:a0c:bd82:: with SMTP id n2mr7247287qvg.62.1616117201088;
        Thu, 18 Mar 2021 18:26:41 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id k138sm3105181qke.60.2021.03.18.18.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 18:26:40 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] blk-mq: Trivial typo fix
Date:   Fri, 19 Mar 2021 06:54:19 +0530
Message-Id: <20210319012419.16778-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/funtion/function/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 block/blk-mq-tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..ad91e98dbc43 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -374,7 +374,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,

 /**
  * blk_mq_tagset_wait_completed_request - wait until all completed req's
- * complete funtion is run
+ * complete function is run
  * @tagset:	Tag set to drain completed request
  *
  * Note: This function has to be run after all IO queues are shutdown
--
2.26.2

