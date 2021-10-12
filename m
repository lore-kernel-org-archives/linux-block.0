Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2340C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 03:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7509560F21
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 03:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhJLDwM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Oct 2021 23:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhJLDwL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 23:52:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A5C061570;
        Mon, 11 Oct 2021 20:50:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om14so2825233pjb.5;
        Mon, 11 Oct 2021 20:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6oao9/RKZ/3MAcA9E8XyptRvVdxPDYeqXrlRMKIUSM=;
        b=cUpHCxzGTUjLul7YCGMklVvXS6FBN0B6bMVLWhXilg3Suluw0NRsJ/nFeYp2oXFdG+
         cX8/g6rkWxQGbouAfXFcy7kyAJJ+EVuyaf6huFhDWA6X/brvG7YTBpZwJ4D0jNwTxltR
         OLmpGIPPpoQ4G1YPlFSzCW5aWaieAggNJe/J3fXjaNomgxw7bRpSzxC60TT/vn2qnUx7
         3rCpmyW5myYWrHeybxJt76pGHILxgejVCEfpayITxiKTLwo5Ir7ozqtgXMDQyD7GWaVJ
         Fnrx6L7+/V9blF0XcYm5IQp3Fzdk46rRxzZIFnXM2foN67ATYEfbkkCK7qwVV+CpW1KM
         ONIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6oao9/RKZ/3MAcA9E8XyptRvVdxPDYeqXrlRMKIUSM=;
        b=NWvYSugQfu55PMpbB4hUWJcuFrG3rKGTGFPk0VS6845oDN4R5VJoBr3jO9WTtLHJIb
         PQ4esKPpK8vMi+OeQnle8SYYYdSRoDv782/nVfV+mHUiDNHw4xXZUgbDKwFbmqme+YVk
         GV9PXeTqsK7anPCc4/L2HXFDjhyXX58wceb0r4Arfk1gmFKd5NA/eWf0EUa2isro82YZ
         fOtntBAexD9l2zG3dAU7nOqkIwzhqiJ1+J80JjC+falTvrLnTBGbce2ERwzaj3ejgUAW
         fx3SeA/oVHTCoOtME57Wufl7IfNx7JGfsljyc1umtM6K4HeVhNLLu3EhE0jq6estwlGE
         SWBA==
X-Gm-Message-State: AOAM532IgejUjPC8kV7kfNu6oiXLCr6Mkln5VWRg9cSFIqrfoMu3NALU
        J91kqcj1Y0CWPTILMOPXkTs=
X-Google-Smtp-Source: ABdhPJwgVzEtgPXXX/SbNkEJL1zIlagHUulOVWGKQBAjKSR3237zvpRgUQXyKjxgTYXJ21tzXOa/VA==
X-Received: by 2002:a17:90b:314d:: with SMTP id ip13mr3343841pjb.13.1634010610202;
        Mon, 11 Oct 2021 20:50:10 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.104])
        by smtp.gmail.com with ESMTPSA id h6sm887443pji.6.2021.10.11.20.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:50:09 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver: floppy: fix warning in __alloc_pages
Date:   Tue, 12 Oct 2021 11:49:54 +0800
Message-Id: <20211012034955.2802626-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the user-provided length (ptr->length) is longer than one threshold,
it will trigger a warning in __alloc_pages.

Fix this by checking get_order(ptr->length) >= MAX_ORDER.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/block/floppy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index fef79ea52e3e..8b88960e2784 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3109,6 +3109,8 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
 		if (ptr->length <= 0)
 			return -EINVAL;
+		if (get_order(ptr->length) >= MAX_ORDER)
+			return -EINVAL;
 		ptr->kernel_data = (char *)fd_dma_mem_alloc(ptr->length);
 		fallback_on_nodma_alloc(&ptr->kernel_data, ptr->length);
 		if (!ptr->kernel_data)
-- 
2.25.1

