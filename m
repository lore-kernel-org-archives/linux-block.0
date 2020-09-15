Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94325C43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C740206E6
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUPVJVT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgIOSto (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgIORZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 13:25:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45222C06178C
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n133so5022043qkn.11
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqwxkVTd5/jHYQSEXF8VtnLj+gaZ69idekW/tSuak/4=;
        b=PUPVJVT4ak4nDk1bqvG2puF1SWMub6klBCbLVVpdT/rbAQ6XsUxeAhh6AV5x0SJgFo
         TP31TJU5kQ3K2gOTD21dpmVJu0pgFe5iqeH/LmwPk60E76w5wdyK1kPO0KYWlDuamQ0v
         /JYPkgK+CxLFn0XCqAsO2eGnJ37kZ7mVR0qahy9D3BrxQaglggqGPtu5dk1tNUfB7cHE
         r3Ye6P5T7BENd3kZv3y7kgDcaLZcNmo9wdpw3y7dTPTXSM2sR3IqnfIftw4DReSSjanh
         9H97Tk1HJz2Mu/VCqn5NcUrurTYNPW2zjyuZNMJT19KgFtIDOieLv98pDj0s0l8RiBMJ
         Cg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dqwxkVTd5/jHYQSEXF8VtnLj+gaZ69idekW/tSuak/4=;
        b=B7SJi+fCLR/du/rSdBz6HKQtlmQA3J3VDvc9X1rVUy0NH2ECtGxsuBHPoYCxRJByWt
         5hV089cDqjlsAu4/Isjgs8vLmkS4kQTXqbROcxNrEXAeXjYciJVhWMRXbtBwuj/3M8bq
         XjMuFYxvPsbBRAl/QMZlH6rvJ8nA89irjwcwZRAeqEOB9nlXODkcjwwBD+wCyu+0AnYb
         LmUo27TJz44pzYrvVw6kkZDwuAo5pQVcIN30SRVNHjcbCBr9gUUoFixxRbAnYOKdDMe3
         CY6X5r/diRmmuVqE1A+AuHpPRq8pFFcLxSQRM7P3qKGWHit0JZf5x8YgfyIFjzMpqfb6
         pyxg==
X-Gm-Message-State: AOAM532d8NJbnvEYAnwzRqxkJuDfdfOfqnK8GOV+DmUveGtWyYIO3vrp
        v+uKUIoj8jSHGNhRwfiCPgY=
X-Google-Smtp-Source: ABdhPJxiR4Ue6DgxQjUkZ0Cqffe6uNtsKfw0d7romunYOFP/MQ/XemUbad9vhcfTDChNaw/ffFS7Ng==
X-Received: by 2002:a05:620a:34c:: with SMTP id t12mr18171543qkm.431.1600190642969;
        Tue, 15 Sep 2020 10:24:02 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d9sm18088289qtg.51.2020.09.15.10.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:24:02 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 3/4] dm table: stack 'chunk_sectors' limit to account for target-specific splitting
Date:   Tue, 15 Sep 2020 13:23:56 -0400
Message-Id: <20200915172357.83215-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200915172357.83215-1-snitzer@redhat.com>
References: <20200915172357.83215-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
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
index 5edc3079e7c1..248c5a1074a7 100644
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
@@ -1502,6 +1503,10 @@ int dm_calculate_queue_limits(struct dm_table *table,
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

