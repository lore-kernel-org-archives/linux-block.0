Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C8C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFFC61107
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhDPWHI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbhDPWHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 18:07:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD52C061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c123so25612300qke.1
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
        b=LgIcZlSDZxZaNxg+glWRfcMpcC9dR6quQulhPwYdpCRhwy+iqE6s3gcU3jlWt7L12D
         1kiwiB3lXhdhOdnWcADpTiOKxv7IiiVuIZyeyE6YvWgNlq/JEVIo1HRefy1w8zWA5ceB
         1mb/pNNjloYkz2+1x6BtCxttrywhEZqAOdcbl7BlZ95td7M+BtvNNysjGrgqymGFiaDB
         HUTtTF2bH+D/azHxQmu6aZvhzBR/5AK2Xno7qgC/0siHsVU1gDLhkeLD91LTWf9lyGOX
         reEfb+qSTwZnOIM0+XYF2A1AnNvbtmNaOn8m9oZ5dh2PhEZriCaBe7dFKzC9bhZt/nLh
         rjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
        b=spaLo8VAB4QQlyIGh/yxeGbqLIcmebCb6oF8YUXZcy0ugCNuf6Cw7IO+uWI8L7cXrE
         XzxFy1eDrmkKtxhwTwbhr/s9WTa4EqAH6SzWsz8s5vQkPLtTE+VS8xNJijEoBA7JDNR5
         7yU3Y4zao+JlJwmFFqiFcyeWQ34ltPlXQ3kgP09fVUGSYcGsS2+4qggEfbHxXA/XsbqR
         V9k2W7SHyp9GIDNKWRI3v8WJZcRh8p8StTMa7LYTqgZOwUlfjZBr3LNKEX3MB3WUcO1s
         l72AnTQersa9fLvAiiH4hARzHQT2N7yyb/6iO4dxqFsfn+trs+ZDBi9anIzDWC2p5Ath
         sBXQ==
X-Gm-Message-State: AOAM531UvwvrlwCndKANf3qeGhhUoEbR6OjpLTq/LeyEAiFWsNfjacvp
        h/6qsISnHWNdRsLWGS1FDcuscLTckDZfXw==
X-Google-Smtp-Source: ABdhPJw7ppGOCSahVk+duKk+ADJkHO9EgUt1Epe+BpmeIZB5SJVOeurj1Lrnnmi1p9nftS5OkFYZjg==
X-Received: by 2002:a05:620a:1112:: with SMTP id o18mr1476969qkk.52.1618610800275;
        Fri, 16 Apr 2021 15:06:40 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x4sm4972979qkp.78.2021.04.16.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:06:39 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
Date:   Fri, 16 Apr 2021 18:06:34 -0400
Message-Id: <20210416220637.41111-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the DNR bit is set we should not retry the command.

We care about the retryable vs not retryable distinction at the block
layer so propagate the equivalent of the DNR bit by introducing
BLK_STS_DO_NOT_RETRY. Update blk_path_error() to _not_ retry if it
is set.

This change runs with the suggestion made here:
https://lore.kernel.org/linux-nvme/20190813170144.GA10269@lst.de/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c  | 3 +++
 include/linux/blk_types.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642be..540d6fd8ffef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
 static blk_status_t nvme_error_status(u16 status)
 {
+	if (unlikely(status & NVME_SC_DNR))
+		return BLK_STS_DO_NOT_RETRY;
+
 	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..1ca724948c56 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -142,6 +142,13 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
 
+/*
+ * BLK_STS_DO_NOT_RETRY is returned from the driver in the completion path
+ * if the device returns a status indicating that if the same command is
+ * re-submitted it is expected to fail.
+ */
+#define BLK_STS_DO_NOT_RETRY	((__force blk_status_t)17)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
@@ -157,6 +164,7 @@ typedef u8 __bitwise blk_status_t;
 static inline bool blk_path_error(blk_status_t error)
 {
 	switch (error) {
+	case BLK_STS_DO_NOT_RETRY:
 	case BLK_STS_NOTSUPP:
 	case BLK_STS_NOSPC:
 	case BLK_STS_TARGET:
-- 
2.15.0

