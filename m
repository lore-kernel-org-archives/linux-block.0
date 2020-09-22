Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B18C4727C
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9802193E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKnm8Z19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgIVCdB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 22:33:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0BC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:33:01 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cr8so8724660qvb.10
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f+wJtsaJ4ki6kX0/25dbRuxCZ8RWAvelZliZZZPY1wA=;
        b=UKnm8Z19ZZN+3X9eVnBVY9zx4xSYf4Wca1Fk5DB5m/l7WOQ0aGNEkhcIVeyCwcyPO3
         Yw+gHvJQ+qXYZ88D6ywbDPNpbhQ7ZD8i8IGkb0SoZA+SIH2yuHYKmb1VHSgi7nWvxxOz
         +HRqgn0zGaWZkPQ5v2kiQ+kYFZ0A2/JUU43e50eHzOvDCOmRLnCyyFK85Z2wxzTF6i/8
         qUWBDTpTKcl/nN2DG/byLbZxXh6yScybrIXvBrRsYZ/JjjAL09ltiTUop5Uq8abe9qs/
         scEQ12RRdS2ytVSPB6LghSTqJXnFgOoj7hNn8/cWNIVk6xOC0A/0Igt1XJtzQA18ZcSd
         x5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=f+wJtsaJ4ki6kX0/25dbRuxCZ8RWAvelZliZZZPY1wA=;
        b=f3N5p+9mHgbd5+3QnZ3ZeNkSRtk+1QzQDWlc3KuKwLsTrbglkvHkGkFqnqStLYujCD
         RB34Ym7AVnjT0tUxT6U3k8hDBvxxEd18s7zTKTFFjtqX+L42FPTbYLJF12fE7cOW08SU
         pl8B8+Z5XZufJ1gqoKbLRzGBvLcBaDxawEJNGrrT7DtJ9x3mIXbG/cS4jPIwgnGghBvK
         n/NGUX7IWqaQkEz0jRO74mavjtmHEG6/K+bOO36/1HbIrUuxPUUXzsrClpAusg9urCGR
         Z8tG0t3HrJPMKOgu16D0hnF8CFlQthVjGUeq8BnF+HorxDFvOz6GJh50NpcmGZenPHkf
         bQ2w==
X-Gm-Message-State: AOAM531pzKcUKLv3D73UVSZO1t9lgmPg6SYVIfyxf+bPw1tPDJ2C4j0y
        ylT8itg+OgKi2CTZdIOcW24=
X-Google-Smtp-Source: ABdhPJybaXDHibBnryCpvlu+eGdLlFYEy/iKvGW8mgApZ21WrhLkuUCAuLFUgOC/psmohYQMDaM4ag==
X-Received: by 2002:ad4:500c:: with SMTP id s12mr3583015qvo.7.1600741980589;
        Mon, 21 Sep 2020 19:33:00 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 16sm10783248qks.102.2020.09.21.19.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:32:59 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 5/6] dm table: stack 'chunk_sectors' limit to account for target-specific splitting
Date:   Mon, 21 Sep 2020 22:32:50 -0400
Message-Id: <20200922023251.47712-6-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200922023251.47712-1-snitzer@redhat.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If target set ti->max_io_len it must be used when stacking
DM device's queue_limits to establish a 'chunk_sectors' that is
compatible with the IO stack.

By using lcm_not_zero() care is taken to avoid blindly overriding the
chunk_sectors limit stacked up by blk_stack_limits().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-table.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 229f461e7def..3f4e7c7912a2 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
+#include <linux/lcm.h>
 #include <linux/blk-mq.h>
 #include <linux/mount.h>
 #include <linux/dax.h>
@@ -1506,6 +1507,10 @@ int dm_calculate_queue_limits(struct dm_table *table,
 			zone_sectors = ti_limits.chunk_sectors;
 		}
 
+		/* Stack chunk_sectors if target-specific splitting is required */
+		if (ti->max_io_len)
+			ti_limits.chunk_sectors = lcm_not_zero(ti->max_io_len,
+							       ti_limits.chunk_sectors);
 		/* Set I/O hints portion of queue limits */
 		if (ti->type->io_hints)
 			ti->type->io_hints(ti, &ti_limits);
-- 
2.15.0

