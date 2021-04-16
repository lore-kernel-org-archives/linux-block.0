Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7837C43460
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD3661184
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbhDPIgE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:36:04 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41828 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbhDPIgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 04:36:04 -0400
Received: by mail-qk1-f180.google.com with SMTP id f19so10362059qka.8;
        Fri, 16 Apr 2021 01:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaWCqAz1Lh0K+YMS2Sm/+2KskMbWPrmtR34tefX2FCk=;
        b=iyVx6eVu2hf25UrvagyrvhCGGIwedPrpvdGcALNQumi2a5lYx18aAvRxraDTIz5SyC
         RE4AXtr1Lomo8kfpiVCwGlHn7/ujJeRypo8i7II0AjkW/+c7+Kw+8XaM29EFKK5L15ti
         ZTlURXeJiaIpF4r6IOhFiOElQrFCEsLJZNACJn6rfCgH9Aq5DgFAMCPnWDFt20wGovgI
         XY3CLXoSJEsrcDkCEKawvIjsknFYueZ8w2+Wjt6pslChbvEBG1ppKHVWrIZB1538Ta2Q
         XaiN0BywTNY2OYgaBQJEdAXaYcAyjRlf1eNLzGkWMHVTw0S8lqgo1WexmV/mthhFGSh+
         UZJQ==
X-Gm-Message-State: AOAM533DfO5VCg6w4FD4mFIz5TJR1mNdWlcKhcRjZmRYy7Ibh1JVCCRf
        cxD7dYuWOnve+TJFMO32EJA5hWPs6wFGQg==
X-Google-Smtp-Source: ABdhPJwUeNyXNj6qXFhTLMemljhm2jc4jmR8wxvXhsR6AeYO1w7BNv9NKzzyqEJRet2A85qmSizz6A==
X-Received: by 2002:a37:695:: with SMTP id 143mr8039369qkg.217.1618562138773;
        Fri, 16 Apr 2021 01:35:38 -0700 (PDT)
Received: from black.ru.oracle.com (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id k17sm3363778qtp.26.2021.04.16.01.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:35:38 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] floppy: cleanups: use memset() to zero reply_buffer
Date:   Fri, 16 Apr 2021 11:34:47 +0300
Message-Id: <20210416083449.72700-4-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416083449.72700-1-efremov@linux.com>
References: <20210416083449.72700-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use memset() to zero reply buffer in raw_cmd_copyin() instead
of a for loop.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index df5c32900539..c58b0b079afc 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3090,7 +3090,6 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 {
 	struct floppy_raw_cmd *ptr;
 	int ret;
-	int i;
 
 	*rcmd = NULL;
 
@@ -3109,8 +3108,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	if (ptr->cmd_count > FD_RAW_CMD_FULLSIZE)
 		return -EINVAL;
 
-	for (i = 0; i < FD_RAW_REPLY_SIZE; i++)
-		ptr->reply[i] = 0;
+	memset(ptr->reply, 0, FD_RAW_REPLY_SIZE);
 	ptr->resultcode = 0;
 
 	if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
-- 
2.30.2

