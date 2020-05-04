Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C8AC3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BB620705
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="jaeElwsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEDOCY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbgEDOCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:02:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20867C061A41
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 07:02:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so15962071wra.7
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbEb4GO4bkclUwQzLx6sFQQlfkXtWxWn8YWxJIwHuCk=;
        b=jaeElwsBidRjDM1Gu9h5Rb7tmtJ70ahI1TVuDkuV1aqjpf9xKqoIuZ0CegqjqkS3I0
         6GyW8+kFIMbP6zQrwuTlP579ThDbVW/qzFyduIz4eDoYxaSqt3n1AgJIYk+r1FMc9Iz8
         rm4m8qDXKznWuxD5D7cgIAXBjq+Z64T17pLZ4eVi0jZw/seP+/LXpB3AhNejJBQWYGIv
         7guyO9kV4OUqE27BLUArdVZTkC/DhyclFZt500TZgdNKVBDNAPVArZ4gw0RKIUxcvyCP
         kDgF20dXd7RIbBHbcV3/iMsoUw7Pth/iqJb54JKqj5A/BH+XqdF/pA/fsZds9EwT0/8r
         g5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbEb4GO4bkclUwQzLx6sFQQlfkXtWxWn8YWxJIwHuCk=;
        b=GA9ovDeQH0eorH1KuTwaf8B4BQC/ZrDpUk7eec4EfC4ENNVp2IyhNdmzw+vo7lZQrg
         zkT1leIr9QdaZm1gY8eu6ENJkUtnCl+bJ5/ULjrNvcNLyHmwZLGEw9K6+pfIwo/opKoZ
         H/AhU26mqlL8EXQypz4MMpECJ4bUtG0OORXJBk37H55zFK2tZMmLzWoqAf8t0aq1uFQ/
         R/t/b8yTDz7CSdGgLXQLIt7waTZCy+h3x5rsdbNgmlmLIskS9ccPOMStcUD50p/x9Jtj
         pQA9oU8HvS6E5GOLCYX+bTb5W4+CxVPqVKUGIP9gJQ88x3FMedrCxiZO7X5Y2ZCsP5tR
         h+oA==
X-Gm-Message-State: AGi0PubycVoe8AR/Ho/VUJuLtsPKEe/K72cpmsTnwPm7J++QFCTcukQh
        lXW9AiWpHKvLYLT56oiYrCu+qUm9r4JTf4Q=
X-Google-Smtp-Source: APiQypLnlcZ5/JmbcIrO8+07pKsGIL7i9jzlgPXeFYqSyP05/H6y1L532z28VDb24pcA3SsIMRvKYw==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr6947250wrj.237.1588600941529;
        Mon, 04 May 2020 07:02:21 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:20 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 09/25] RDMA/rtrs: server: private header with server structs and functions
Date:   Mon,  4 May 2020 16:00:59 +0200
Message-Id: <20200504140115.15533-10-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This header describes main structs and functions used by rtrs-server
module, mainly for accepting rtrs sessions, creating/destroying
sysfs entries, accounting statistics on server side.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 148 +++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
new file mode 100644
index 000000000000..dc95b0932f0d
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RTRS_SRV_H
+#define RTRS_SRV_H
+
+#include <linux/device.h>
+#include <linux/refcount.h>
+#include "rtrs-pri.h"
+
+/*
+ * enum rtrs_srv_state - Server states.
+ */
+enum rtrs_srv_state {
+	RTRS_SRV_CONNECTING,
+	RTRS_SRV_CONNECTED,
+	RTRS_SRV_CLOSING,
+	RTRS_SRV_CLOSED,
+};
+
+/* stats for Read and write operation.
+ * see Documentation/ABI/testing/sysfs-class-rtrs-server for details
+ */
+struct rtrs_srv_stats_rdma_stats {
+	struct {
+		atomic64_t	cnt;
+		atomic64_t	size_total;
+	} dir[2];
+};
+
+struct rtrs_srv_stats {
+	struct kobject				kobj_stats;
+	struct rtrs_srv_stats_rdma_stats	rdma_stats;
+	struct rtrs_srv_sess			*sess;
+};
+
+struct rtrs_srv_con {
+	struct rtrs_con		c;
+	atomic_t		wr_cnt;
+	atomic_t		sq_wr_avail;
+	struct list_head	rsp_wr_wait_list;
+	spinlock_t		rsp_wr_wait_lock;
+};
+
+/* IO context in rtrs_srv, each io has one */
+struct rtrs_srv_op {
+	struct rtrs_srv_con		*con;
+	u32				msg_id;
+	u8				dir;
+	struct rtrs_msg_rdma_read	*rd_msg;
+	struct ib_rdma_wr		tx_wr;
+	struct ib_sge			tx_sg;
+	struct list_head		wait_list;
+	int				status;
+};
+
+/*
+ * server side memory region context, when always_invalidate=Y, we need
+ * queue_depth of memory regrion to invalidate each memory region.
+ */
+struct rtrs_srv_mr {
+	struct ib_mr	*mr;
+	struct sg_table	sgt;
+	struct ib_cqe	inv_cqe;	/* only for always_invalidate=true */
+	u32		msg_id;		/* only for always_invalidate=true */
+	u32		msg_off;	/* only for always_invalidate=true */
+	struct rtrs_iu	*iu;		/* send buffer for new rkey msg */
+};
+
+struct rtrs_srv_sess {
+	struct rtrs_sess	s;
+	struct rtrs_srv	*srv;
+	struct work_struct	close_work;
+	enum rtrs_srv_state	state;
+	spinlock_t		state_lock;
+	int			cur_cq_vector;
+	struct rtrs_srv_op	**ops_ids;
+	atomic_t		ids_inflight;
+	wait_queue_head_t	ids_waitq;
+	struct rtrs_srv_mr	*mrs;
+	unsigned int		mrs_num;
+	dma_addr_t		*dma_addr;
+	bool			established;
+	unsigned int		mem_bits;
+	struct kobject		kobj;
+	struct rtrs_srv_stats	*stats;
+};
+
+struct rtrs_srv {
+	struct list_head	paths_list;
+	int			paths_up;
+	struct mutex		paths_ev_mutex;
+	size_t			paths_num;
+	struct mutex		paths_mutex;
+	uuid_t			paths_uuid;
+	refcount_t		refcount;
+	struct rtrs_srv_ctx	*ctx;
+	struct list_head	ctx_list;
+	void			*priv;
+	size_t			queue_depth;
+	struct page		**chunks;
+	struct device		dev;
+	unsigned int		dev_ref;
+	struct kobject		*kobj_paths;
+};
+
+struct rtrs_srv_ctx {
+	struct rtrs_srv_ops ops;
+	struct rdma_cm_id *cm_id_ip;
+	struct rdma_cm_id *cm_id_ib;
+	struct mutex srv_mutex;
+	struct list_head srv_list;
+};
+
+extern struct class *rtrs_dev_class;
+
+void close_sess(struct rtrs_srv_sess *sess);
+
+static inline void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
+					      size_t size, int d)
+{
+	atomic64_inc(&s->rdma_stats.dir[d].cnt);
+	atomic64_add(size, &s->rdma_stats.dir[d].size_total);
+}
+
+/* functions which are implemented in rtrs-srv-stats.c */
+int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable);
+ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
+				    char *page, size_t len);
+int rtrs_srv_reset_wc_completion_stats(struct rtrs_srv_stats *stats,
+					bool enable);
+int rtrs_srv_stats_wc_completion_to_str(struct rtrs_srv_stats *stats, char *buf,
+					 size_t len);
+int rtrs_srv_reset_all_stats(struct rtrs_srv_stats *stats, bool enable);
+ssize_t rtrs_srv_reset_all_help(struct rtrs_srv_stats *stats,
+				 char *page, size_t len);
+
+/* functions which are implemented in rtrs-srv-sysfs.c */
+int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess);
+void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess);
+
+#endif /* RTRS_SRV_H */
-- 
2.20.1

