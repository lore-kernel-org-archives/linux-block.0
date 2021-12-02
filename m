Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A80C433FE
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 19:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbhLBTvJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbhLBTvH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 14:51:07 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5751BC06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 11:47:45 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z8so507052ilu.7
        for <linux-block@vger.kernel.org>; Thu, 02 Dec 2021 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGZ/ToMx6lxHV/ekPWJEttmnALPy8nZgQuvoKyBwdeU=;
        b=kH0EkMCWG0/ZUYTHzqYPAdSdiD8d5LOis1CzHiOjFC0rte2qwhL8MRwxB6dmVwPRAv
         Bd0My+0wtnKP9AJVxmxvJqKS1ZETxQRe1ipGA1yHznCPnZCfTqsLeDfaZJ0YnQWhj9Ta
         bTrwMcPgMrdbISHmPt//jNI1FeGnwea5lun31czEDaNWdYI3+jMhHRXAj6L1vxpiPFjx
         ohd6jxU1Rf757u9zB62LCWOzqBo3ZpSjuu8J+fiakr5RvDCPpi1ZSNsHbaiD4ScQBk8G
         5A7jiP4DwgXQsFqK9aXepmPPvFDFkLlosqz3dY0/C301exPffcE9x8BBwu1tv3aiIOBn
         CGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGZ/ToMx6lxHV/ekPWJEttmnALPy8nZgQuvoKyBwdeU=;
        b=faGc4voa1iwb4w9n36DxLX5Pu7rTHslA9wWoNdcL/lwBpA6BSBaKoN6JfzrZMU11PD
         wR9mgdn2yGTdK4uQhHn9qeX+nm2QIGLlcOIl4OyifWyALXY2+ra5pVgkptvXksaeonWr
         107+8hjVN21qtwerJoyczM0pqkvJEC6wenBmynnyTDWquLhmSyi0kWzNHjZ98E/NeH+A
         4+IpzLkQI+pBLjeunSM7yu2BmhsALb/avC0qnzt6lsqB31Cjq8eyzm7+NVpR9dvMSkx2
         IjTHIpoBAVRi1xOITHWGZSYW1PYC5hk+4gKySktpXq58p0pkSQJ1QWIRfDVAysBh9Eub
         RIPA==
X-Gm-Message-State: AOAM5336FZbWbUw8WzJUmCwVAF4dCmJqP4vDfTRDD/0SSYzhQo4+x3sS
        Aqc05ZZLRjv1gDyNWtfeveC9bc/B3RSyU6zR
X-Google-Smtp-Source: ABdhPJy3zVvuiDGjWlqu8uX4X6SuLzF4W7mgCXGDD6GgUhHTSjhNiHrmRcwFY7jQ+gquGtR6s139sA==
X-Received: by 2002:a05:6e02:1b84:: with SMTP id h4mr16571792ili.62.1638474464466;
        Thu, 02 Dec 2021 11:47:44 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 18sm359477iln.83.2021.12.02.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:47:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: get rid of useless goto and label in blk_mq_get_new_requests()
Date:   Thu,  2 Dec 2021 12:47:40 -0700
Message-Id: <20211202194741.810957-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202194741.810957-1-axboe@kernel.dk>
References: <20211202194741.810957-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Expected case is returning a request, just check for success and return
the request rather than having an error label.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ecfc47fad236..ca33cb755c5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2720,11 +2720,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	}
 
 	rq = __blk_mq_alloc_requests(&data);
-	if (!rq)
-		goto fail;
-	return rq;
-
-fail:
+	if (rq)
+		return rq;
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-- 
2.34.1

