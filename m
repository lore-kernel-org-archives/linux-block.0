Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D38C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 03:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB32E61481
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 03:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhCQD10 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 23:27:26 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:36465 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCQD0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 23:26:55 -0400
Received: by mail-pf1-f170.google.com with SMTP id g15so154104pfq.3
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 20:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgvQj4I2ZqmD6PqnigM/1Yoy1+coAeUUNiECDcvQruw=;
        b=TsKgEQXib+CTtfUZIFmMkWpQoY08fw0o8VTKAjM2Bbsp8jyBJ89OExe2ka9vdsBYve
         cKxcDqLaXgGZ3VP9Lb6q3gP417LxhH9vTOXnb7SdQE+1N9eVAaCNsAjZ6LVxbFTKfUPL
         QHPENs0YVp+ZQw/q8qFYQ+FlZu9oejGw43lVwFrS7Z/2FntApQ2TgFj5SZ5B2zbEI2Rb
         HJlFxNou+1N+ToaEQBcSFqae+2wUV2ntr/7gpTP2bLgppGo6xGOAr6V0W9tsYvvrbUVT
         Tf7vipPdMUwBn22TuWt9cg1YZGDPHYCgm8n+yDSCEDhmTOX87Va9novZN6XzR42Fa54W
         RudQ==
X-Gm-Message-State: AOAM532ltcgk8g34bLBe1bw36fljKFt86JbzzQYU0xph6XKWrVmts52v
        sbLwmKPo10PxHGM32yihnp8=
X-Google-Smtp-Source: ABdhPJyJenNJcfrY/yjk+70JT5VmLWr48otVNS/+u5zJYgX9QJ9sRn7rqq/LdeU9G+UKsySnfc6bOg==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr810695pgb.271.1615951615361;
        Tue, 16 Mar 2021 20:26:55 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:1af6:7b8b:eb3:97d0])
        by smtp.gmail.com with ESMTPSA id a20sm18943192pfl.97.2021.03.16.20.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:26:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2] sbitmap: Silence a debug kernel warning triggered by sbitmap_put()
Date:   Tue, 16 Mar 2021 20:26:48 -0700
Message-Id: <20210317032648.9080-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All sbitmap code uses implied preemption protection to update
sb->alloc_hint except sbitmap_put(). Using implied preemption protection
is safe since the value of sb->alloc_hint only affects performance of
sbitmap allocations but not their correctness. Change this_cpu_ptr() in
sbitmap_put() into raw_cpu_ptr() to suppress the following kernel warning
that appears with preemption debugging enabled (CONFIG_DEBUG_PREEMPT):

BUG: using smp_processor_id() in preemptible [00000000] code: scsi_eh_0/152
caller is debug_smp_processor_id+0x17/0x20
CPU: 1 PID: 152 Comm: scsi_eh_0 Tainted: G        W         5.12.0-rc1-dbg+ #6
Call Trace:
 show_stack+0x52/0x58
 dump_stack+0xaf/0xf3
 check_preemption_disabled+0xce/0xd0
 debug_smp_processor_id+0x17/0x20
 scsi_device_unbusy+0x13a/0x1c0 [scsi_mod]
 scsi_finish_command+0x4d/0x290 [scsi_mod]
 scsi_eh_flush_done_q+0x1e7/0x280 [scsi_mod]
 ata_scsi_port_error_handler+0x592/0x750 [libata]
 ata_scsi_error+0x1a0/0x1f0 [libata]
 scsi_error_handler+0x19e/0x330 [scsi_mod]
 kthread+0x222/0x250
 ret_from_fork+0x1f/0x30

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Omar Sandoval <osandov@fb.com>
Fixes: c548e62bcf6a ("scsi: sbitmap: Move allocation hint into sbitmap")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: changed patch subject and elaborated patch
description.

 include/linux/sbitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 3087e1f15fdd..2713e689ad66 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -324,7 +324,7 @@ static inline void sbitmap_put(struct sbitmap *sb, unsigned int bitnr)
 	sbitmap_deferred_clear_bit(sb, bitnr);
 
 	if (likely(sb->alloc_hint && !sb->round_robin && bitnr < sb->depth))
-		*this_cpu_ptr(sb->alloc_hint) = bitnr;
+		*raw_cpu_ptr(sb->alloc_hint) = bitnr;
 }
 
 static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
