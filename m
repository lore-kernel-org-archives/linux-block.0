Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B14C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC74965039
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCPDyj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 23:54:39 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:37495 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhCPDy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 23:54:27 -0400
Received: by mail-pj1-f52.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so663350pjc.2
        for <linux-block@vger.kernel.org>; Mon, 15 Mar 2021 20:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0ebrkSrvSWtPmPU55fHgzA/0QP9P0JLQivozPizXCU=;
        b=oy8Z363eTISOTKpZKTMa1Jve2kJOiFMURDcX3tPmcahzTOWJA4duQIE8GkA8OT2arj
         mtpHml3VHcLv6GpQARgYmrOp/lyvKDPtj/jpkz+IJRp8WoS0755HK/eAJJz3PecfIHoS
         LLtsDnJIHL5qnhFrFaSWUgDnUxydOsWKGD9CuScJ4LGPivZxNvKCNBVND3GlKfBK/Bqp
         I1QXmC8IMuhQbq1/UhOsruH6ZR/3aRqKJuYpWIvl8+TXyJJOPquWLUqrtonNCnDdRA6+
         WN9kTjgR7/HjpXOKWHu5fhkFGLA3fJ5j0oM+WbiyTijtQ+yl4ed6MrykwzOPT9i6Jy7E
         /b4Q==
X-Gm-Message-State: AOAM5312bT8D7QI7+tWUmrnYRT8sl/OyjcFN50msP5eDj7ab7PE6DyLG
        WOobp026SGAfBRCMq0dOELo=
X-Google-Smtp-Source: ABdhPJzQYwHSBsLgc5kFGlwXKK66lnEWFcPwWB660UeJ9v7vG4rhTCKCOyY6dObjeIyLHneQz25j8Q==
X-Received: by 2002:a17:90a:8913:: with SMTP id u19mr2625224pjn.59.1615866867151;
        Mon, 15 Mar 2021 20:54:27 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:8641:766a:ce30:8278])
        by smtp.gmail.com with ESMTPSA id p5sm14665858pfq.56.2021.03.15.20.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 20:54:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH] sbitmap: Fix sbitmap_put()
Date:   Mon, 15 Mar 2021 20:54:20 -0700
Message-Id: <20210316035420.2584-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes the following kernel warning:

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

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Omar Sandoval <osandov@fb.com>
Fixes: c548e62bcf6a ("scsi: sbitmap: Move allocation hint into sbitmap")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
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
