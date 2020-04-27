Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E2EC7C883
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23EE206B9
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QYbBK9Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgD0OLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgD0OLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:11:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E818FC09B050
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so11124135wmj.3
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=QYbBK9DbOIfDjpvixqC9gH7peta7Q8hgFgX/dWyl5yBC445GyVm08wphqL+dq3i42u
         vFU8y0HTd8j6VzfqJAM/vbgV1j6D+kj9ZTA0c3gB68SUg5iPlZJZopx8KP2+EQF5KOJ7
         AlMasXN4HARmhvgDlur4GG8wssC2FyLav0Y2uW6Kco58L+4beDMREb0bXofQw7ZO+8HQ
         FUUjoIcxT/jyP3NNRo7sXoO2MOqXMLWZ2zV8STWjXtfjOxfBzToTRUNl2RVvgniQRDmW
         ofiy1Wl59IbzFBkpw6OLRsWQI+4hdNdt0cH6KAS/bCpUr+7kbK8gs2vUJW5LfV+aviLz
         k08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pQCniYLvJw1t2gFCRxCBobqn/8Zkqb7cqfvQGuESp0=;
        b=D2VpXOmmvLQ4kjJwUfCMVvummDVFpIdhg/Zic01m09wxHMs9e3nUkbPdPAAG2PWZPy
         6DCQexftlZlW5kVtA3KZexlhuYhmFAfg//+sUQZ1tsn2LFbcI19h35NQ2971uL8UjiAz
         PNx3A9J2DyaRX90QB95U4BmD+5lZAYqgIjVGNZNWl/M8xFDvsOOfhcqXIyuFIfoxbvll
         L+sVGO868DX1yVgJCZI4jN2N1ZorNAkJEipHiGd6jgvLr2eA3bHqQ5CbxzC2QEffsb70
         SvpXQgMUSAqwU1IeRiqcNP3sQDYsTZiknWhu/fXtZXxGLbyKal0Xbs+WKQR2AwPfegAj
         Fe+Q==
X-Gm-Message-State: AGi0Pub5dy9/ji6By+KgyiGdsbqlG6/1+ROYY1E+Dt1qv8AkPbOsypPY
        DxxR+VRk+KJmGtmlpur+dlYq5Pl/sJAF4jA=
X-Google-Smtp-Source: APiQypLDhKoekXoK8t8GosTdbst2JwUpSEc3ZZyd0LtRviotWrk833PTXPg7VH3OdHQYsuKvsbjfLA==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr25871930wmg.36.1587996683512;
        Mon, 27 Apr 2020 07:11:23 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:22 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 11/25] RDMA/rtrs: server: statistics functions
Date:   Mon, 27 Apr 2020 16:10:06 +0200
Message-Id: <20200427141020.655-12-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
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

