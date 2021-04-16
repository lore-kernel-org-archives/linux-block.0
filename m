Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB7C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441A0611C2
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhDPXyA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPXx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 19:53:59 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA6C061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id h15so4492490qvu.4
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
        b=ha/P7mAF80uD2DCWBuD7cEf0koTIbyLMQrHYlG+ZU/QEW4lsNqilMzcDUqE0lS19Vg
         zxbnXv/bKTtHtl5lR31XDYKi+AFVsKgP7z7Z8zAiKlRCsx9qfOv7IaI48Oj9OPXAE2Qd
         ZYR3wqRxDXNi6H9DIfnQwsYzSSW7Spg5gJeSg3jYJJIIMwZLEoohww7jq4Inve6K9JMp
         X9cwoqysjNxzBva5jaH+RKu7XgLa/pmkH4iL8Evwvc9mAsomBSqD28JL5Q+ljnAcrYpd
         a3G5nNNSGci4QPRiPPYZ0F5yGlSQHJH9X8ux9IHZLUqCOCqAOr2Ay+MP182+vsgWGkOf
         F+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
        b=oEJ7xYR2TIIrP9NQvKjUe4/qBM4y09BtPd4U6yKbq/I5A8PgFkZmERB4hKb6EFyIXe
         ibncdosyJ4k+CBED8nbo88OArAXqvy+QXJdyMEXnSlB/7AGpZeeCUDfRMBkGY9YXmkTU
         EcxY7ubBya9hm+ep0c9V2s6rgTNrMTtkHnNop8uqQfghtToqxURE3MdsiH7fedHYvs8w
         v70xxjRFN7GNK9SAhPUgIoZy+eQbauOhvaKTOLS+y+zz+gE88Ca6CokXUIlUXPz5LdD+
         c437xneuDfWd/528WabTbK6etPBYwrKl5jyu/Cjn/yEYTfutszFuCyLmaxgtlRTeGUB+
         RVZQ==
X-Gm-Message-State: AOAM533bVVr6zMFGe9SrZi1ZC1G3VOfQ0EnJ2zwZhFfUkJ0cpb4lmijn
        YACAa5JbTXVs2t0VxVSrZSc=
X-Google-Smtp-Source: ABdhPJwbSaN8dqhGfKHuFj1wuJyFMhfU+pYxWICW3qhsOj3SwzeXkdQVt1y3wjQ6z92Mt6gOTZGp7w==
X-Received: by 2002:a05:6214:1470:: with SMTP id c16mr11115642qvy.60.1618617212158;
        Fri, 16 Apr 2021 16:53:32 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o23sm5037866qtp.55.2021.04.16.16.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:53:31 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v4 1/3] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
Date:   Fri, 16 Apr 2021 19:53:27 -0400
Message-Id: <20210416235329.49234-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
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

