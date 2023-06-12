Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52EFC7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 20:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjFLUdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjFLUd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:29 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84BE10FC
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:28 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b3a6fc8067so15779605ad.3
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602008; x=1689194008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+3rH1/I9JYUC9AV7hb8Nbme0XVHrq65BO+O7WSem7o=;
        b=DIX81hQI59dj3BtOdYT/ldIw7UFTVpMbSdZtek4VIiLeTZpw4bjW/XdtNfeTzNPq3F
         05lfxhSIEPSRlz/8UkNUnp8sXRL5Kp8eUsuFgacjFuN3d07Vtgg5KSKaexB7/uIWPnb/
         kykW/ga3x4rspZ4RDSKz+fMuGUDEwCa8BTmvhAU8zzN9lFXIjf2j4DCiSuDk8xza+91Q
         ZGCrXxwoEjWvJEb6FN0BFCtEboc0sinLw10BWdvKEtMgoGCGe96zScM6vYM8fLK/C09M
         1cj25Pmu22jkQodbhJaayUpgy++Pmb3TwoY28J2H889hRVTNbjZO2nDFyykAYNpVK5Kk
         R1sw==
X-Gm-Message-State: AC+VfDySJNtMUx16ackx8ciwstVux7QlyyGTFq6ai61TIlw3VffJ7R//
        m44ItfxpAi5ym38yuc8j/Mo=
X-Google-Smtp-Source: ACHHUZ58dz+iv/BsbrZlS7DI2Y3W8VhQ8/RxK2kfezpujyVSFBZCL6KBaRh+Bm9oLMANo1mIE7LX3g==
X-Received: by 2002:a17:903:248:b0:1b2:4e00:a3a9 with SMTP id j8-20020a170903024800b001b24e00a3a9mr7158565plh.41.1686602007995;
        Mon, 12 Jun 2023 13:33:27 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v6 7/8] scsi_debug: Support configuring the maximum segment size
Date:   Mon, 12 Jun 2023 13:33:13 -0700
Message-Id: <20230612203314.17820-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
References: <20230612203314.17820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a kernel module parameter for configuring the maximum segment size.
This patch enables testing SCSI support for segments smaller than the
page size.

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 8c58128ad32a..e951c622bf64 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -752,6 +752,7 @@ static int sdebug_host_max_queue;	/* per host */
 static int sdebug_lowest_aligned = DEF_LOWEST_ALIGNED;
 static int sdebug_max_luns = DEF_MAX_LUNS;
 static int sdebug_max_queue = SDEBUG_CANQUEUE;	/* per submit queue */
+static unsigned int sdebug_max_segment_size = BLK_MAX_SEGMENT_SIZE;
 static unsigned int sdebug_medium_error_start = OPT_MEDIUM_ERR_ADDR;
 static int sdebug_medium_error_count = OPT_MEDIUM_ERR_NUM;
 static int sdebug_ndelay = DEF_NDELAY;	/* if > 0 then unit is nanoseconds */
@@ -5735,6 +5736,7 @@ module_param_named(lowest_aligned, sdebug_lowest_aligned, int, S_IRUGO);
 module_param_named(lun_format, sdebug_lun_am_i, int, S_IRUGO | S_IWUSR);
 module_param_named(max_luns, sdebug_max_luns, int, S_IRUGO | S_IWUSR);
 module_param_named(max_queue, sdebug_max_queue, int, S_IRUGO | S_IWUSR);
+module_param_named(max_segment_size, sdebug_max_segment_size, uint, S_IRUGO);
 module_param_named(medium_error_count, sdebug_medium_error_count, int,
 		   S_IRUGO | S_IWUSR);
 module_param_named(medium_error_start, sdebug_medium_error_start, int,
@@ -5811,6 +5813,7 @@ MODULE_PARM_DESC(lowest_aligned, "lowest aligned lba (def=0)");
 MODULE_PARM_DESC(lun_format, "LUN format: 0->peripheral (def); 1 --> flat address method");
 MODULE_PARM_DESC(max_luns, "number of LUNs per target to simulate(def=1)");
 MODULE_PARM_DESC(max_queue, "max number of queued commands (1 to max(def))");
+MODULE_PARM_DESC(max_segment_size, "max bytes in a single segment");
 MODULE_PARM_DESC(medium_error_count, "count of sectors to return follow on MEDIUM error");
 MODULE_PARM_DESC(medium_error_start, "starting sector number to return MEDIUM error");
 MODULE_PARM_DESC(ndelay, "response delay in nanoseconds (def=0 -> ignore)");
@@ -7723,6 +7726,7 @@ static int sdebug_driver_probe(struct device *dev)
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
 	sdebug_driver_template.cmd_per_lun = sdebug_max_queue;
+	sdebug_driver_template.max_segment_size = sdebug_max_segment_size;
 	if (!sdebug_clustering)
 		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
 
