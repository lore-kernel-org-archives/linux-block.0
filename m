Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F238BC43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbiFNRuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345050AbiFNRt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:49:58 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D0340D9
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:57 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id r5so2450112pgr.3
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTVjccNo4CKMeHqr/hq108UQCpYUKQZeJ66SJ8AYLlM=;
        b=rz6zbM0L4wNHsdWejssNq/21P9aIvX9TLW9/qdJtGQqdJV/kO8vEvCKGLGBpJt5vkL
         l49jtVApOJRB8QDoedmFva1GyFtOkWD3s2KBGgDjIwLL4rQ1pQogtCmLZz8Bw4SEDsTC
         RS8jsOc+rmE6TNWCmAVdCaEZvEuJLLdO5fB4LTTnoWDTYVda8qRzGQfOfyRwDZPMzeiV
         eRmQvZfkQLdkYx0DDxcFSrOWJQ1gFi3CzFhr13V/W8ondJnUFb178pPXdN8TE5INboK9
         xdsD+YPJj1mgq7rz4Fp0sk8QWgsNILJ+6LVysGc1+oJ+FrBFx/+kUE/iDohkPWkhb03k
         pCLg==
X-Gm-Message-State: AOAM533gxi5zVKHjXi4/EBHUAB36O9RN/vgWt8Vee0MomRktCdO+2HTa
        oTg7sTcetB4jqOJ3tbqMkjI=
X-Google-Smtp-Source: ABdhPJy+N/f3uyJN3v70yuXSYKi8SvupozwP/NUZXeZ4qgUNwLjKTVxqbsU1V8iXj4kQj+7LOUgKeQ==
X-Received: by 2002:a63:d418:0:b0:3fe:4478:5aa5 with SMTP id a24-20020a63d418000000b003fe44785aa5mr5524712pgh.212.1655228996611;
        Tue, 14 Jun 2022 10:49:56 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id gd3-20020a17090b0fc300b001e2da6766ecsm9866922pjb.31.2022.06.14.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:49:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/5] nvme: Make the number of retries request specific
Date:   Tue, 14 Jun 2022 10:49:41 -0700
Message-Id: <20220614174943.611369-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614174943.611369-1-bvanassche@acm.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for specifying the number of retries per NVMe request.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..fe0d09fc70ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -339,7 +339,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 
 	if (blk_noretry_request(req) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
-	    nvme_req(req)->retries >= nvme_max_retries)
+	    nvme_req(req)->retries >= nvme_req(req)->max_retries)
 		return COMPLETE;
 
 	if (req->cmd_flags & REQ_NVME_MPATH) {
@@ -632,6 +632,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 {
 	nvme_req(req)->status = 0;
 	nvme_req(req)->retries = 0;
+	nvme_req(req)->max_retries = nvme_max_retries;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6ecf33c..15bb36923d09 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -160,6 +160,7 @@ struct nvme_request {
 	union nvme_result	result;
 	u8			genctr;
 	u8			retries;
+	u8			max_retries;
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
