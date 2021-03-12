Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF43C4360C
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A926500D
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhCLKz7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhCLKzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A90DC061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j2so4535781wrx.9
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHYhJM9nMyAbr9kC0PuVmzVL2n+2I82Ba3dsjUeY+AI=;
        b=d9pSu1o7M26wU29kEvwgXHR/9OVEDjrsKEs7qA14xPmWODrzW4tRDS+O/ts0F6JnJj
         x8LEZn2Mxngo9It+fCDXY5fgfGOD4zgSTA6ebhbt4XLG9X5WFjcMG1GW/qH9Dc54vTTQ
         qtO6jZ6Q12Be2RxnqCH6coaZLJ1/7iKCa4GUEm3PK9l9ecouej6FvqT4qQtwC9EEBjfC
         6UCJZ01F8JIqq0ga1L79yVOaCcrGTLakUKnzqxO4hIjCiE5+wJ02o3TyIz3uifCAb/s+
         xnthZx1vQSV8G+vAhq1he8Qp91qlJKzBGpZKDLAaMHHOE+iWfyWF65ScVDsCEdij7GLM
         mAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHYhJM9nMyAbr9kC0PuVmzVL2n+2I82Ba3dsjUeY+AI=;
        b=UsBCyeHsDsoBsoDmGD/GMXM3b4lD4IJaRIPax/ydSG50+XLreyUdoFjtNwhsYfsQL3
         TFXNp17MtO+wV5N3sMUYwOGpKMbGi8uat/tO8VmjBHvB8j3GdAhwrtbE3GBdhGvEIR9l
         3y0mQuVwRXbUQNm4UMpub5j/2/z8q9OQCPUGVv9/k86hBxjt8AP/oVKR+u41h8ZcEqMM
         SKgyyjGrP/EQusjmOOKsM5LM1Ckv3PoeeI9Hei1cXvEQd0ZxQz9fddDbimdTF6N6kQIE
         dz1whYxYPv/WurODOJIoZn8n4R5zyIlW1aQccX6v1A1UMUBuSYPEqL7GaH8dxcj7Ceb3
         5SZA==
X-Gm-Message-State: AOAM5320ESGiYVqixFfu89jykmDNf+5IKRa5Y3aMYVhbmoGGCQqnTQmr
        ErDoX34sX9lMHlnpTTM56Y+eWA==
X-Google-Smtp-Source: ABdhPJwn83lXba8ON91dxvqRmuL6Fo3sSgrermJApEsbmfY2Mjz9q/po8sAA6SAMQtVCUVHM4Ak+VQ==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr13658139wrr.30.1615546541806;
        Fri, 12 Mar 2021 02:55:41 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 06/11] block: drbd: drbd_main: Remove duplicate field initialisation
Date:   Fri, 12 Mar 2021 10:55:25 +0000
Message-Id: <20210312105530.2219008-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[P_RETRY_WRITE] is initialised more than once.

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_main.c: In function ‘cmdname’:
 drivers/block/drbd/drbd_main.c:3660:22: warning: initialized field overwritten [-Woverride-init]
 drivers/block/drbd/drbd_main.c:3660:22: note: (near initialization for ‘cmdnames[44]’)

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 25cd8a2f729db..69c9640d407df 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3657,7 +3657,6 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_RS_CANCEL]		= "RSCancel",
 		[P_CONN_ST_CHG_REQ]	= "conn_st_chg_req",
 		[P_CONN_ST_CHG_REPLY]	= "conn_st_chg_reply",
-		[P_RETRY_WRITE]		= "retry_write",
 		[P_PROTOCOL_UPDATE]	= "protocol_update",
 		[P_RS_THIN_REQ]         = "rs_thin_req",
 		[P_RS_DEALLOCATED]      = "rs_deallocated",
-- 
2.27.0

