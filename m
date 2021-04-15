Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027DC43460
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37F9610FC
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhDOXQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhDOXQA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:16:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFAAC06175F
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 30so12578768qva.9
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
        b=PVZxMAKpqiXZzHl9BvxQp24AQZguptUtV/s7pogFbPpcCHpzTMwNsz4MVcnFxXLRHE
         im2pdKP2a/tlVrydPANj0R7tLy6LWbzS1ixH6wR/+ZBe8EjQ00zD5SQ/Ixwo9k387AG1
         JciNZ5cfTRC/6gcwjJj7adY8VWCWQGXB6dambvdN84bwaBWg4UGP3FflRBxbfIg7IgGl
         LcAyJKk+7P/PawzP2Dk52Y407mQ0hD/hqF0hMIk5PHulscOdODexLXmKovlD1he7tN5p
         XW8a3FTwIJCh5EHvqSqzsadfXhbJNXMe5rAV7D5XNnsR5xJjC6tR++10MpvILvA0tLXx
         Z6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
        b=WSvTtrLpBSaloWvgamuQ+TcJSRIcxXlZbcFbJwclmchvRnEo+KVhium8wYBfSUjkSZ
         FFEs/lRBeeBA1JZNnMR8Egr+FDP32hFC65trMLHIGLWX6RugF/kEK6DuhsXcXqEmqx42
         tocBtK3JbL25/7yakB0KFBHjGRdAu7aKt1+7+MHBwn1kH2IoU1+v2PAwG7ciRKLqhURm
         YMbinqkfNkXx2A1VfJxv7DCRqCMkuR1v5G6jjBe+Mhz+JCFwlMHAESpxv4yRjmSGuo3S
         AZdcHMOyJTVB6sTl8uGYTG+Mt6oobH/2clCVXesQ7hq0KQIgmqaTmCk1LJKvRZIms+/Q
         EM1Q==
X-Gm-Message-State: AOAM530YDPFbDpA6VJoDVgkqUVvgEbyHhNayCHca7y/I399IYppQTqfG
        ZbOIVeXN4iP1QaF9I8eFGWg=
X-Google-Smtp-Source: ABdhPJypcPvBNABtyi60w7ZSs8nt8uydx8Z2UbVEMidzcXwJJfkUfTv11ayzAABKZ6UGP/UZ2UlWeA==
X-Received: by 2002:ad4:5630:: with SMTP id cb16mr5609781qvb.40.1618528534657;
        Thu, 15 Apr 2021 16:15:34 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h7sm1656528qka.39.2021.04.15.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:15:34 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Subject: [PATCH v2 2/4] nvme: allow local retry for requests with REQ_FAILFAST_TRANSPORT set
Date:   Thu, 15 Apr 2021 19:15:28 -0400
Message-Id: <20210415231530.95464-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210415231530.95464-1-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chao Leng <lengchao@huawei.com>

REQ_FAILFAST_TRANSPORT was designed for SCSI, because the SCSI protocol
does not define the local retry mechanism. SCSI implements a fuzzy
local retry mechanism, so REQ_FAILFAST_TRANSPORT is needed to allow
higher-level multipathing software to perform failover/retry.

NVMe is different with SCSI about this. It defines a local retry
mechanism and path error codes, so NVMe should retry local for non
path error. If path related error, whether to retry and how to retry
is still determined by higher-level multipathing's failover.

Unlike SCSI, NVMe shouldn't prevent retry if REQ_FAILFAST_TRANSPORT
because NVMe's local retry is needed -- as is NVMe specific logic to
categorize whether an error is path related.

In this way, the mechanism of NVMe multipath or other multipath are
now equivalent. The mechanism is: non path related error will be
retried locally, path related error is handled by multipath.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[snitzer: edited header for grammar and clarity, also added code comment]
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 540d6fd8ffef..4134cf3c7e48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -306,7 +306,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
+	/*
+	 * REQ_FAILFAST_TRANSPORT is set by upper layer software that
+	 * handles multipathing. Unlike SCSI, NVMe's error handling was
+	 * specifically designed to handle local retry for non-path errors.
+	 * As such, allow NVMe's local retry mechanism to be used for
+	 * requests marked with REQ_FAILFAST_TRANSPORT.
+	 */
+	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
-- 
2.15.0

