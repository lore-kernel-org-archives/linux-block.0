Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D3C54FCB
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 16:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994842082E
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 16:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bf9D+rR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgDTQZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728930AbgDTQZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 12:25:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7EC061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 09:25:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id my1so147974pjb.1
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eeish4b0dApiVROXwgSxWPD6R6u9/nVb7Rxz/mEcfI0=;
        b=bf9D+rR4RVTl/d8EDJ4rebre5pMf0BlvggkGCYG0ek5YLxATE4clEcjGna06GBTP4w
         7KzCuHcuZ4k5557dVd5iFpPPe7uodJpjSNuvWbApzF0x+2rntuS/MOdDuyErz1u4A38e
         nV17RYe/ZjPw4XBZPZnhY2nMCMYSjEly/8cGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eeish4b0dApiVROXwgSxWPD6R6u9/nVb7Rxz/mEcfI0=;
        b=StfrKmbIsCcTmtPpwe+FwgWOGMdzAGDlG6w892ZCzbDaZT9ZaVfvvAl0liGFHLjSrd
         +3YwOFo0LT4qX67d1mekXKWDnVvOQWzkRxG2P1ohr1T00NH4iN/H9PyLCIw6dNnfGNDc
         xu8q7zjFmBD+CG72XKggFcTU4oZh2ezzRmVXpeb5V9eBDXKbDnJc/Wacpx+lSBSKHRSl
         N3JIatXLvsG3/gZkhPP3MvdhXrjA0X7yhY+SBKkCAQs3H0f5rgcfBmoVaa+l7n5h+4dY
         zMRRPEJMOPyRIyPyAB6TGeWPQeNRKDusXHd8mibOsHvEjVx2v+/FdVRrwOSQhAW68j8r
         CCvQ==
X-Gm-Message-State: AGi0PubgQG548Medxykoy/QvmllgVBlQvOwMiZb4iE46cHPqDNnqu5Fw
        R2e/Gf4znPTOg3gEX1tR9U+EMA==
X-Google-Smtp-Source: APiQypJ2um6WEi/dNweSMis0tXgK55PhuM1j2i0i3wYSHB8seu03qmbLpIwN83SaTaH9ExAeqMD74Q==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr193496pjh.25.1587399927822;
        Mon, 20 Apr 2020 09:25:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p64sm93150pjp.7.2020.04.20.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:25:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        sqazi@google.com, groeck@chromium.org,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] Revert "scsi: core: run queue if SCSI device queue isn't ready and queue is idle"
Date:   Mon, 20 Apr 2020 09:24:54 -0700
Message-Id: <20200420092357.v5.4.I630e6ca4cdcf9ab13ea899274745f9e3174eb12b@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420162454.48679-1-dianders@chromium.org>
References: <20200420162454.48679-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 7e70aa789d4a0c89dbfbd2c8a974a4df717475ec.

Now that we have the patches ("blk-mq: In blk_mq_dispatch_rq_list()
"no budget" is a reason to kick") and ("blk-mq: Rerun dispatching in
the case of budget contention") we should no longer need the fix in
the SCSI code.  Revert it, resolving conflicts with other patches that
have touched this code.

With this revert (and the two new patches) I can run the script that
was in commit 7e70aa789d4a ("scsi: core: run queue if SCSI device
queue isn't ready and queue is idle") in a loop with no failure.  If I
do this revert without the two new patches I can easily get a failure.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- ("Revert "scsi: core: run queue...") new for v3.

Changes in v2: None

 drivers/scsi/scsi_lib.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 47835c4b4ee0..ea18f618dc66 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1610,12 +1610,7 @@ static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct scsi_device *sdev = q->queuedata;
 
-	if (scsi_dev_queue_ready(q, sdev))
-		return true;
-
-	if (atomic_read(&sdev->device_busy) == 0 && !scsi_device_blocked(sdev))
-		blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
-	return false;
+	return scsi_dev_queue_ready(q, sdev);
 }
 
 static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.26.1.301.g55bc3eb7cb9-goog

