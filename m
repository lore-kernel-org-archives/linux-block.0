Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB949C54E91
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F7020801
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Zltqf7Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgEKNxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730251AbgEKNxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 09:53:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552EC05BD09
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 06:53:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so11073101wre.13
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=Zltqf7LfmNXAxRzZhaM3M7n2rU8SOtPCfo5Uyj0zMrqiRqarF7rMHPmSQF3+ZuD+/j
         UzmC2p9twEekhAqcehsKQp4PF7kCfptluzVwBd1s69wYHrFYh7KFzPObkC55K7nRUKX/
         w0O4FJUbl8gZzvQvC57yzmSHDoQ9yJzbGNSrJZbxb8oei5lp6OX7gEzZXrfCPVOZI4nc
         7gjrhDHv0mpvg/FXdfJKpFR3inFE08jEpIsrIReCQG5kEPqnNfjQPVb0KJQcsEuv//YC
         tH5Kgns+3RIF64d2/cvEmMZVHnD9nrODoM+GaZGdcVGhET9QmeLdPlkdNg41bqZKDE64
         6pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=Za4XGj2ChLVwy510lopXSh9CDmpiRpOSYiTgweIhWCR1dpBveJf56wRTmivoJsf3PH
         dg9gETBEGFGv5P5BNTL9Go28uI9ViOOibrNJw5XHsteg0AFHZRyLdMQFF4byqyHjqvdi
         yT06gQ4RDHTfgYUvfJX0qW4ppjQmzpo5PbZOQvBrgsHpgZYtzlYCJgy90VPbo2YebndN
         qy4h4FmrxGwKw/9yT7iY2zvomzDhi0uazc0XCDnporQzSGBfhrJdHDbQsv7aGIxHk5ne
         BwCGE9BFfo6jdGhU2QQF1MKA7S9bxs5fzRPN2vkE6HUpsGt5vG7wqNU1uM7K7g2L/mty
         tlEA==
X-Gm-Message-State: AGi0PuZ9cefP/WGihj6Zor9luRLRLHAulO4fWoKedvspVdL88o056Wmg
        WggABf8icKZt1NELY6mwHpsLyzGmVc7J6xs=
X-Google-Smtp-Source: APiQypKMs44zNDR0K+WzVMpey2m3M2wG3mE8SPhXWRcPQjAuPZYEtvMW4jGuDbNu4h0LUnnbD6adiw==
X-Received: by 2002:a05:6000:1045:: with SMTP id c5mr4881306wrx.31.1589205200139;
        Mon, 11 May 2020 06:53:20 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:19 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v15 11/25] RDMA/rtrs: server: statistics functions
Date:   Mon, 11 May 2020 15:51:17 +0200
Message-Id: <20200511135131.27580-12-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This introduces set of functions used on server side to account
statistics of RDMA data sent/received.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
new file mode 100644
index 000000000000..e102b1368d0c
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rtrs-srv.h"
+
+int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+
+		memset(r, 0, sizeof(*r));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
+				    char *page, size_t len)
+{
+	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+	struct rtrs_srv_sess *sess = stats->sess;
+
+	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
+			 (s64)atomic64_read(&r->dir[READ].cnt),
+			 (s64)atomic64_read(&r->dir[READ].size_total),
+			 (s64)atomic64_read(&r->dir[WRITE].cnt),
+			 (s64)atomic64_read(&r->dir[WRITE].size_total),
+			 atomic_read(&sess->ids_inflight));
+}
-- 
2.20.1

