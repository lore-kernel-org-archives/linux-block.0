Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F32C001E0
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 22:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGaWPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGaWP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:29 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D01724
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:27 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bb893e6365so31671595ad.2
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841727; x=1691446527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKserUc7+qK0U76dK5VQGcFoPHl5fU7xJij7hQDUDFE=;
        b=d0BXnw9rRF5DrZeENVGCsq/SjoGckxND3kQevTw8C2xSdPCUpVGrPpbpY3Ziiinqm+
         Fv1BnJMNTmQAcCGg0ipSNTFRq6gkUvD3gd0e90ERLInJMCghF+BAA+NSTQEOtT+5FIvb
         Ep3uRUd8aJjNFmEFJiCEIwArF7JiE+wjVvr7UMiY0yx2TAZdzmWbsBWBt9XXEmNOUzaU
         16lt8cBcskr8kLNgVyPV5CMeEEYXCfoD8udhWQDnfzyCnYec6Z+liuXVl+S0SV7Pvdwe
         AxosNsKq2mvFTsytmcZuqPN/n+vex3QX9M/bDj9XPGaOnW+Daj/5gkMvHMIxXvqCwZ9g
         324Q==
X-Gm-Message-State: ABy/qLZRHYemCY9e7UyhoEG8zYGyo/QYAnUwOPxlfO0saAxE89y5qf8H
        iT/ZBOSegs1aXF6iCh5uDCQ=
X-Google-Smtp-Source: APBJJlFYo6Yv4sGqTfEtAHxyPuUIhMy/TRgtk7hqlmrhaNqPvxMCt8gfS+S4sKo7YMdWSisAUqYKLQ==
X-Received: by 2002:a17:903:11d0:b0:1b6:bced:1dd6 with SMTP id q16-20020a17090311d000b001b6bced1dd6mr11851749plh.35.1690841726941;
        Mon, 31 Jul 2023 15:15:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 4/7] scsi: scsi_debug: Support disabling zone write locking
Date:   Mon, 31 Jul 2023 15:14:40 -0700
Message-ID: <20230731221458.437440-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230731221458.437440-1-bvanassche@acm.org>
References: <20230731221458.437440-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make it easier to test handling of QUEUE_FLAG_NO_ZONE_WRITE_LOCK by
adding support for setting this flag for scsi_debug request queues.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 9c0af50501f9..57c6242bfb26 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -832,6 +832,7 @@ static int dix_reads;
 static int dif_errors;
 
 /* ZBC global data */
+static bool sdeb_no_zwrl;
 static bool sdeb_zbc_in_use;	/* true for host-aware and host-managed disks */
 static int sdeb_zbc_zone_cap_mb;
 static int sdeb_zbc_zone_size_mb;
@@ -5138,9 +5139,13 @@ static struct sdebug_dev_info *find_build_dev_info(struct scsi_device *sdev)
 
 static int scsi_debug_slave_alloc(struct scsi_device *sdp)
 {
+	struct request_queue *q = sdp->request_queue;
+
 	if (sdebug_verbose)
 		pr_info("slave_alloc <%u %u %u %llu>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
+	if (sdeb_no_zwrl)
+		blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
 	return 0;
 }
 
@@ -5738,6 +5743,7 @@ module_param_named(ndelay, sdebug_ndelay, int, S_IRUGO | S_IWUSR);
 module_param_named(no_lun_0, sdebug_no_lun_0, int, S_IRUGO | S_IWUSR);
 module_param_named(no_rwlock, sdebug_no_rwlock, bool, S_IRUGO | S_IWUSR);
 module_param_named(no_uld, sdebug_no_uld, int, S_IRUGO);
+module_param_named(no_zone_write_lock, sdeb_no_zwrl, bool, S_IRUGO);
 module_param_named(num_parts, sdebug_num_parts, int, S_IRUGO);
 module_param_named(num_tgts, sdebug_num_tgts, int, S_IRUGO | S_IWUSR);
 module_param_named(opt_blks, sdebug_opt_blks, int, S_IRUGO);
@@ -5812,6 +5818,8 @@ MODULE_PARM_DESC(ndelay, "response delay in nanoseconds (def=0 -> ignore)");
 MODULE_PARM_DESC(no_lun_0, "no LU number 0 (def=0 -> have lun 0)");
 MODULE_PARM_DESC(no_rwlock, "don't protect user data reads+writes (def=0)");
 MODULE_PARM_DESC(no_uld, "stop ULD (e.g. sd driver) attaching (def=0))");
+MODULE_PARM_DESC(no_zone_write_lock,
+		 "Disable serialization of zoned writes (def=0)");
 MODULE_PARM_DESC(num_parts, "number of partitions(def=0)");
 MODULE_PARM_DESC(num_tgts, "number of targets per host to simulate(def=1)");
 MODULE_PARM_DESC(opt_blks, "optimal transfer length in blocks (def=1024)");
