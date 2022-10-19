Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2140EC433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJSWXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiJSWXx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:53 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD38183DB6
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:51 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id p14so18571022pfq.5
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/yIaxhI1yPf5aaPRmle6MnBQgL/MMUFgF9F1LCmVvM=;
        b=ag2sc3PHTxdRdZjI2ELd9eCiXp3iJXGuMYcrD/CsY5P2PCZAw1tbKIQoDaL5P48Bfx
         BO9EyMAaQ4B28rw7Z+5BuTA5BS0h7sm+1VAuAhEF0/4fZH/pnuM3tEAOo5UO6ZsDxdiH
         8fOs6j6oxJN/bjdGiWhBifoLGigYQsHQKLtiA/EDr//sq808d9MQzy+ktFmK+4pEoVqU
         EoYVRkAtn38ocfJ4jpWD8aC7IZNglHlJVIHJ+3+FSTO9M+k118WMa5a7BmWEFMuw05bk
         cf7Ks0piZwAAiMpYVNYOWT/xOUoZVwy3vJURfcrdVPe0fo9oVP5VZLnezxzn/hcSXurO
         ph6w==
X-Gm-Message-State: ACrzQf0xGBMPiH1eK+NChv7ZV23857DnQshg3pdNA/weCUXVVzu1mF2f
        ujbVt3O3VORQYa2yMaj4ZsmBQV7Bv9Q=
X-Google-Smtp-Source: AMsMyM6MxrMkFWj9HWc97rWCVjPv/poNlDKV+YEFS8clU5An8V2hU3o94TnAtaWHind2ZjJpwTRWjw==
X-Received: by 2002:a65:4084:0:b0:463:aa4:49cf with SMTP id t4-20020a654084000000b004630aa449cfmr8947705pgp.164.1666218230772;
        Wed, 19 Oct 2022 15:23:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 09/10] scsi_debug: Support configuring the maximum segment size
Date:   Wed, 19 Oct 2022 15:23:23 -0700
Message-Id: <20221019222324.362705-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a kernel module parameter for configuring the maximum segment size.
This patch enables testing SCSI support for segments smaller than the
page size.

Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 697fc57bc711..1c7575440519 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -770,6 +770,7 @@ static int sdebug_sector_size = DEF_SECTOR_SIZE;
 static int sdeb_tur_ms_to_ready = DEF_TUR_MS_TO_READY;
 static int sdebug_virtual_gb = DEF_VIRTUAL_GB;
 static int sdebug_vpd_use_hostno = DEF_VPD_USE_HOSTNO;
+static unsigned int sdebug_max_segment_size = -1U;
 static unsigned int sdebug_lbpu = DEF_LBPU;
 static unsigned int sdebug_lbpws = DEF_LBPWS;
 static unsigned int sdebug_lbpws10 = DEF_LBPWS10;
@@ -5844,6 +5845,7 @@ module_param_named(ndelay, sdebug_ndelay, int, S_IRUGO | S_IWUSR);
 module_param_named(no_lun_0, sdebug_no_lun_0, int, S_IRUGO | S_IWUSR);
 module_param_named(no_rwlock, sdebug_no_rwlock, bool, S_IRUGO | S_IWUSR);
 module_param_named(no_uld, sdebug_no_uld, int, S_IRUGO);
+module_param_named(max_segment_size, sdebug_max_segment_size, uint, S_IRUGO);
 module_param_named(num_parts, sdebug_num_parts, int, S_IRUGO);
 module_param_named(num_tgts, sdebug_num_tgts, int, S_IRUGO | S_IWUSR);
 module_param_named(opt_blks, sdebug_opt_blks, int, S_IRUGO);
@@ -7804,6 +7806,7 @@ static int sdebug_driver_probe(struct device *dev)
 
 	sdebug_driver_template.can_queue = sdebug_max_queue;
 	sdebug_driver_template.cmd_per_lun = sdebug_max_queue;
+	sdebug_driver_template.max_segment_size = sdebug_max_segment_size;
 	if (!sdebug_clustering)
 		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
 
