Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF0C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667B96120E
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbhDMDmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 23:42:07 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:40645 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhDMDmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 23:42:07 -0400
Received: by mail-pj1-f46.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so9974922pji.5
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 20:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6CXt/la1NlQsaTXqZRkax5G/mjA/dfTQWCNKI/36vs=;
        b=a0zNXdFyohw6QuN/TcjrdU2vXWOeoU0dyhUXbMMliUV9HIBoNf1LqGsgnF6hXsQW03
         SFBZeaiRUREBgR3sS2NYiEffjmbXBdFnNJLmIOilO/6zYFYJwZG/A4Ua71sUgt5HyAXx
         cRW3JsM/CNJ1+t8GFZRxXd7YqGrS+zG9FxNxXG/MqJM0IAj8rYgHW0Q/nAiiNsg1Wagn
         2jVlMbT5LG351ZqdhVUQ0XujNzuoIPXsp7awg29EPlzKzLOttvaqIzFOrlcbgF/eUiF4
         lj7bQ6y7GaP3UgNSt1NgRGa1n/KREJimsGSI1GAjCwn69fX7kvAqh+Kw1+tOCRR7yj6C
         gIRg==
X-Gm-Message-State: AOAM532ITIOGdp7T/+hRTwNA1mO8S714vrf4puzH533vLbA95sonhd8B
        aQ1wBOtARGticR7i8VAYTxbk1kLIGgQ=
X-Google-Smtp-Source: ABdhPJw/qXrWBrlVrnw4UPKoul/utDAo4c4Cfrtr+GecbqRK4cFOuDodt8ptjQ1Bc9Nnaurq67UCSQ==
X-Received: by 2002:a17:902:b68c:b029:e6:bb9f:7577 with SMTP id c12-20020a170902b68cb02900e6bb9f7577mr29490442pls.0.1618285307829;
        Mon, 12 Apr 2021 20:41:47 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:b042:d9b4:a765:6810])
        by smtp.gmail.com with ESMTPSA id p22sm709238pjg.39.2021.04.12.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:41:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] block: Remove an obsolete comment from sg_io()
Date:   Mon, 12 Apr 2021 20:41:42 -0700
Message-Id: <20210413034142.23460-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit b7819b925918 ("block: remove the blk_execute_rq return value")
changed the return type of blk_execute_rq() from int into void. That
change made a comment in sg_io() obsolete. Hence remove that comment.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/scsi_ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 1048b0925567..1b3fe99b83a6 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -353,10 +353,6 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 
 	start_time = jiffies;
 
-	/* ignore return value. All information is passed back to caller
-	 * (if he doesn't check that is his problem).
-	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
-	 */
 	blk_execute_rq(bd_disk, rq, at_head);
 
 	hdr->duration = jiffies_to_msecs(jiffies - start_time);
