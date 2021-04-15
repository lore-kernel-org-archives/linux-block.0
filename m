Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5931CC433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34529610FC
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhDOXP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhDOXP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:15:59 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACAC061756
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so27135567qkb.0
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0e+GUnuCpe8QCvStaw0mUR7nWzw75w2F948YZAEt28Q=;
        b=gpzaqMNTFlFilz2e3S5iD/m2OFN8Lm8z7jY1WAdGZPLXGTkFBuxo9V0fj8MwWesr7h
         3ZPtRchAXubkQeYXwGu90Ic8J6XaMy/00CP3Q7vnlOfP0yCEGguCX2hvktmCO1jl031p
         6lEHBiKMIqWojpylJ/7+1Ct8NM0am+lnWE7p0XD84VHrxT3Z7ql5GETkkCVYNWxIU6H/
         VoCOnVTv4fcuxnboKsXk0sUm1mW8j0JWHRDVKg981Q/bDwK7aoaBg4JOhnTuaYMJgS/J
         6a9HUewDk7G1lqS2bjy83ZBkBNPBZFZKVv7VDSZj61bjKABqRfsY8AIbLFYxrqnng86B
         0l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0e+GUnuCpe8QCvStaw0mUR7nWzw75w2F948YZAEt28Q=;
        b=XCGXZTFbkTtwPPnSWfGVf43Gkj6cMAQlURKy3tqjGp6BWpWKxqHzfkeVRdpFxcZoox
         7MCHbXxbNLJFBQzfARJqTugcF9eoVrn6c/QQaO5VvjWSjPN90K1JMcuOTMrIYuJBJVkL
         Wtu+6YID3n80Nim4eJ3pB3PjPxR64eOqSQZDMrGEtBljgYMbYN0GUYHZh/wZTLpEdFCV
         sVVeHmhZ7QZJ3f9oQTfDx3i4IYjYw3TAV+5sXqCi45Ja/ELPpL7HqbWpb8krnZ7FA9g+
         9nbbXVVb3JJlp5IjjCYjJls49SxoOOtXoyRN+5t9kbbPKFWtuHWg7pKsLn4Dl45RY6q+
         hGwg==
X-Gm-Message-State: AOAM533RE9GmhNswLVltPB3caa3mH7WZusbzzUZx08ZvOtIBsULqm5sr
        h3ocTlTHwetfpRZc98khxfw=
X-Google-Smtp-Source: ABdhPJyItbrqK2zs8RtBIkzXLNW5V+kFE3mMQiJR8+zeLyi/3FrV8WPxvWweLdOctd9XT9tRHGx3wA==
X-Received: by 2002:a37:a104:: with SMTP id k4mr3716326qke.149.1618528533257;
        Thu, 15 Apr 2021 16:15:33 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d62sm3100679qkg.55.2021.04.15.16.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:15:32 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
Date:   Thu, 15 Apr 2021 19:15:27 -0400
Message-Id: <20210415231530.95464-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210415231530.95464-1-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
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

