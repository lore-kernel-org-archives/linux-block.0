Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723AC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjC0UOW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjC0UOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:21 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857213583
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:34 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id cr18so5982226qtb.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0nH8y5nrVQVdjQ+7MWEvssVfY/cEbcGbEWp6ylrqyQ=;
        b=ScdDx1DqN86Dz3YI124dbxilOBRwykvRhF62zEdEnm92B2AHG4TIeAV5UXI8ggN8jQ
         Y7+XDVq3idZljunFoh7WLJks+8dx6jy1QvNs+Evu06aik05yGPHc2ixN/5A9Mf1Jqdpp
         HBYYpswubxNAcCTFckCokxa+n2YvxdH1gmiV5ruP8/8blMEzJrQ70pJpZ6/QSDU8fFng
         qli1+oOOGrPTfB0BZsmrJXZWy0+REFvk3trDAmXmZr7sHbFi2/Ij80+ZoXIBJIGTXcc+
         aoxHdyYtxo9sI3lN26R0n+1cGiByd4GN8kc36U6g2JcXUsOhfwkrEzlrnDjvmlEVfNOy
         8Z5w==
X-Gm-Message-State: AAQBX9eypFW929qszY+uxo/7XIj/tkYv43w/a/dxjRxTzdHOhVTzXG6l
        BHNbjjObJyg6VJhiF7wMTljp
X-Google-Smtp-Source: AKy350Y96gqJ8gm1eUDkWBdhHVPSIF25C9Z/7pTPicBHvic+yBssV8gx7JTYQ5NQ4P/SYw+5vk3tRA==
X-Received: by 2002:ac8:5c46:0:b0:3e4:e8a8:f235 with SMTP id j6-20020ac85c46000000b003e4e8a8f235mr8388241qtj.36.1679948013682;
        Mon, 27 Mar 2023 13:13:33 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003e3897d8505sm6400099qtt.54.2023.03.27.13.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:33 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 16/20] dm: add dm_num_sharded_locks()
Date:   Mon, 27 Mar 2023 16:11:39 -0400
Message-Id: <20230327201143.51026-17-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simple helper to use when DM core code needs to appropriately size,
based on num_online_cpus(), its data structures that split locks.

dm_num_sharded_locks() rounds up num_online_cpus() to next power of 2
but caps return at DM_MAX_SHARDED_LOCKS (64).

This heuristic may evolve as warranted, but as-is it will serve as a
more informed basis for sizing the sharded lock structs in dm-bufio's
dm_buffer_cache (buffer_trees) and dm-bio-prison-v1's dm_bio_prison
(prison_regions).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 22eaed188907..18450282d0d9 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/refcount.h>
+#include <linux/log2.h>
 
 #include "dm-stats.h"
 
@@ -228,4 +229,13 @@ void dm_free_md_mempools(struct dm_md_mempools *pools);
  */
 unsigned int dm_get_reserved_bio_based_ios(void);
 
+#define DM_MAX_SHARDED_LOCKS 64
+
+static inline unsigned int dm_num_sharded_locks(void)
+{
+	unsigned int num_locks = roundup_pow_of_two(num_online_cpus());
+
+	return min_t(unsigned int, num_locks, DM_MAX_SHARDED_LOCKS);
+}
+
 #endif
-- 
2.40.0

