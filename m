Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE395C43217
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJSWXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJSWXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:51 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E588617C547
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:49 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id h13so18549252pfr.7
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA4JvTPoVH6g26z3FX0Uz6+daRehnB5R/bzRqgV/XaI=;
        b=dbAnre1974qrLx7jSRe3ggcTnsm70Cpn83gsGO1r+iv0cwzBAaKQlpi+2sw6VCPXm/
         yuw48DXLcZxF8QSFAzF5bQj66v2wxhq0dgVM7C68cmHoE5jtewkTHqO3WFjUAHMVCTws
         TwVmYImJUGPk+UyXoWpfZZFhOJqHDi4zJsGH/oG/KrYj96+52C/m31ylKp9adsdUY3b0
         1nFsId2xYqk9uuYxeBKc7ZTXb327y7yywh7GAY4ycXYZMVKC+3pXWHncPPsCx0/GLtos
         DTGhqa0oupxfmAbFhSGOSQWIwfnA0oCtYs7diWniFphd6ffwuuJmPgk6xjWG3pTjm28T
         HtWw==
X-Gm-Message-State: ACrzQf3uS0q+bDphnaAFaCCceCifMXvGYf1gC8rX0SkG27VFh40Iw95G
        6hseO7bhmDdEaiVbxfxZf9c=
X-Google-Smtp-Source: AMsMyM5ZFmxRe/+vlRntaQz5s9Y7tkYbM1CQ8HWvpu6xeVp731Q0aLCmoziOBe2uWY1gVPqDxi8rQg==
X-Received: by 2002:a63:881:0:b0:43a:c80a:bea4 with SMTP id 123-20020a630881000000b0043ac80abea4mr9139899pgi.329.1666218229069;
        Wed, 19 Oct 2022 15:23:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 08/10] scsi: core: Set the SUB_PAGE_SEGMENTS request queue flag
Date:   Wed, 19 Oct 2022 15:23:22 -0700
Message-Id: <20221019222324.362705-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch enables support for segments smaller than the page size.
No changes other than setting the SUB_PAGE_SEGMENTS flag are required
since the SCSI code uses blk_rq_map_sg().

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8b89fab7c420..821149a57fbf 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1877,6 +1877,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 {
 	struct device *dev = shost->dma_dev;
 
+	blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, q);
+
 	/*
 	 * this limit is imposed by hardware restrictions
 	 */
