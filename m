Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0682C4725B
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6F620705
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="K0mVqTsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgEDOCh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgEDOCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:02:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D657AC061A0F
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 07:02:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so10769262wrt.9
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ApNUZv+jn8U1ruuCY92J66SowBgO5SapbNz4atRxmk=;
        b=K0mVqTsnfsRrtdArV9CvAlAgc3YHzd8JaoW+bMBesDEtqgDCdd9N4sWm5sqlWMA/W8
         9/+nPI/NcFhZHEmTFUr23bSQwT4Sl98Qyx5AAgg9uCnj/WaAaUmW5wTRDTJ+VkGjjJex
         Ij56OBN44gT8OPXt0qJqLjPBrSo1AcsyNAvRUSd8QGrqEnw23swF9vH5CWRWGkABP0fk
         AaVVGEioXGbdHaR8tWIcGuN4nE+G3sDEo8iC3jyD6ACNcpqNmQ6o2tI9Xde772yDxRbE
         Pe74TYaPh02Cnkrnk/fJChXqFqvmh0dpzeYDj5eNdHzNYx4rXxH+ZoJCmm2hdURqgRwU
         ulSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ApNUZv+jn8U1ruuCY92J66SowBgO5SapbNz4atRxmk=;
        b=N+6NuGHJHFGWXkOb/Jp3ii8xIU1JccXWSrjFAO8fBLM+xL9pLEl6ws0NU3KL+S1g0W
         nu8I1pmIhPA6WVODn/KjbNFJFgRYND/NoyPMekxLPuWlhqfYOPHJ4Ro49HGdoAfJTtSO
         TGem7xUlZiO3WMWKNUJCmhiwYqu4G8P6hvnS1FmaNnNqXZOa3TUbRo3yYuErlOxeyqJR
         5SgWydcP3C0nkoOCUEWcBvfB2p/ZmX+BGpV3fFw8CMbS0zVQbn+Qb8wJ6bxZ8idqcxsp
         a3dQLjNyFVZFa1dXcBGzQ7Z1C9C/2sdEK+X69u0bcduvPNftlqb7ZR1AlMMx6K2yzvDH
         6Y/w==
X-Gm-Message-State: AGi0PuZVYfkxkHM9457mYqB4wQkqB0kLfZpiUlry3N+RqNKGbdQi8f9I
        GKT/GXRFrkkmGV2yngKBnZ/ZiPoJ07x1YYM=
X-Google-Smtp-Source: APiQypLbWwdRFw/ZsvX89TKyjUuU7c6a5iHJrv8u74bKDzU3a7duvt0z67BP3TnDtrPOS/7LReYEVQ==
X-Received: by 2002:adf:f648:: with SMTP id x8mr19035544wrp.257.1588600955250;
        Mon, 04 May 2020 07:02:35 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:34 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 16/25] block/rnbd: client: private header with client structs and functions
Date:   Mon,  4 May 2020 16:01:06 +0200
Message-Id: <20200504140115.15533-17-danil.kipnis@cloud.ionos.com>
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

This header describes main structs and functions used by rnbd-client
module, mainly for managing RNBD sessions and mapped block devices,
creating and destroying sysfs entries.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-clt.h | 156 ++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-clt.h

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
new file mode 100644
index 000000000000..ed33654aa486
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RNBD_CLT_H
+#define RNBD_CLT_H
+
+#include <linux/wait.h>
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/blk-mq.h>
+#include <linux/refcount.h>
+
+#include <rtrs.h>
+#include "rnbd-proto.h"
+#include "rnbd-log.h"
+
+/* Max. number of segments per IO request, Mellanox Connect X ~ Connect X5,
+ * choose minimial 30 for all, minus 1 for internal protocol, so 29.
+ */
+#define BMAX_SEGMENTS 29
+/*  time in seconds between reconnect tries, default to 30 s */
+#define RECONNECT_DELAY 30
+/*
+ * Number of times to reconnect on error before giving up, 0 for * disabled,
+ * -1 for forever
+ */
+#define MAX_RECONNECTS -1
+
+enum rnbd_clt_dev_state {
+	DEV_STATE_INIT,
+	DEV_STATE_MAPPED,
+	DEV_STATE_MAPPED_DISCONNECTED,
+	DEV_STATE_UNMAPPED,
+};
+
+struct rnbd_iu_comp {
+	wait_queue_head_t wait;
+	int errno;
+};
+
+struct rnbd_iu {
+	union {
+		struct request *rq; /* for block io */
+		void *buf; /* for user messages */
+	};
+	struct rtrs_permit	*permit;
+	union {
+		/* use to send msg associated with a dev */
+		struct rnbd_clt_dev *dev;
+		/* use to send msg associated with a sess */
+		struct rnbd_clt_session *sess;
+	};
+	struct scatterlist	sglist[BMAX_SEGMENTS];
+	struct work_struct	work;
+	int			errno;
+	struct rnbd_iu_comp	comp;
+	atomic_t		refcount;
+};
+
+struct rnbd_cpu_qlist {
+	struct list_head	requeue_list;
+	spinlock_t		requeue_lock;
+	unsigned int		cpu;
+};
+
+struct rnbd_clt_session {
+	struct list_head        list;
+	struct rtrs_clt        *rtrs;
+	wait_queue_head_t       rtrs_waitq;
+	bool                    rtrs_ready;
+	struct rnbd_cpu_qlist	__percpu
+				*cpu_queues;
+	DECLARE_BITMAP(cpu_queues_bm, NR_CPUS);
+	int	__percpu	*cpu_rr; /* per-cpu var for CPU round-robin */
+	atomic_t		busy;
+	int			queue_depth;
+	u32			max_io_size;
+	struct blk_mq_tag_set	tag_set;
+	struct mutex		lock; /* protects state and devs_list */
+	struct list_head        devs_list; /* list of struct rnbd_clt_dev */
+	refcount_t		refcount;
+	char			sessname[NAME_MAX];
+	u8			ver; /* protocol version */
+};
+
+/**
+ * Submission queues.
+ */
+struct rnbd_queue {
+	struct list_head	requeue_list;
+	unsigned long		in_list;
+	struct rnbd_clt_dev	*dev;
+	struct blk_mq_hw_ctx	*hctx;
+};
+
+struct rnbd_clt_dev {
+	struct rnbd_clt_session	*sess;
+	struct request_queue	*queue;
+	struct rnbd_queue	*hw_queues;
+	u32			device_id;
+	/* local Idr index - used to track minor number allocations. */
+	u32			clt_device_id;
+	struct mutex		lock;
+	enum rnbd_clt_dev_state	dev_state;
+	char			pathname[NAME_MAX];
+	enum rnbd_access_mode	access_mode;
+	bool			read_only;
+	bool			rotational;
+	u32			max_hw_sectors;
+	u32			max_write_same_sectors;
+	u32			max_discard_sectors;
+	u32			discard_granularity;
+	u32			discard_alignment;
+	u16			secure_discard;
+	u16			physical_block_size;
+	u16			logical_block_size;
+	u16			max_segments;
+	size_t			nsectors;
+	u64			size;		/* device size in bytes */
+	struct list_head        list;
+	struct gendisk		*gd;
+	struct kobject		kobj;
+	char			blk_symlink_name[NAME_MAX];
+	refcount_t		refcount;
+	struct work_struct	unmap_on_rmmod_work;
+};
+
+/* rnbd-clt.c */
+
+struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
+					   struct rtrs_addr *paths,
+					   size_t path_cnt, u16 port_nr,
+					   const char *pathname,
+					   enum rnbd_access_mode access_mode);
+int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
+			   const struct attribute *sysfs_self);
+
+int rnbd_clt_remap_device(struct rnbd_clt_dev *dev);
+int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize);
+
+/* rnbd-clt-sysfs.c */
+
+int rnbd_clt_create_sysfs_files(void);
+
+void rnbd_clt_destroy_sysfs_files(void);
+void rnbd_clt_destroy_default_group(void);
+
+void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev);
+
+#endif /* RNBD_CLT_H */
-- 
2.20.1

