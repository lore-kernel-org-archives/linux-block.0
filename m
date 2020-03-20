Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8802C43332
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB2F20776
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="KqCkgDdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgCTMRc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:17:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34837 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCTMRb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 08:17:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so7217047wru.2
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MoQIAhcbi4rdn1RsqOU3+CFdLFSNg7VnGnkI+FVzxSE=;
        b=KqCkgDdWAL8jNlzWZaaGJ8fxgstbnlT34Bnxb2yVpE03jZIhu/ecOqk9bS+1RdXqnk
         CJ7r8LSQa6QAYmOKgadBm1K3/LWxU4SQYzO7KPSX/XO31Zp7EozqvRWQ4oeNM5kN2BLD
         QxbXSKlUVuuSVm6JM6Ej3+j8oih/eYySG9Aa4EltHUpM02XuExyBkQ1vPQ9MHEjNJh4H
         FlXhNjD6WxeDOdTtfgyYDr0q8ds/x70FiXLUHXd7+oA7x3uzdMmTweKW1nApLu+l4W8o
         zUuy8rIZRiV/SENlZr7/1c29Nh21EOqo54AJBl8N4Edng09L3rq5XEmHFDaLWBwHh6XP
         A8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MoQIAhcbi4rdn1RsqOU3+CFdLFSNg7VnGnkI+FVzxSE=;
        b=a36KrTzjQZ8ploKZSUW68cJH8aPIuwSlWvbruT1cqHnrJIyokLeErrlZfVCwJi0VI+
         82FTC2yNk8owjBWfUK/Km9nMfp5af2RpoJYjMnWN0Ck/54lLgkYYVUwZuSyzmlFmdFpW
         VQgMQlcTTNavb8ONoRN0Q907hMPlJ3+s9rdb1f0rB1ph4GOZblEISa0h5nMdSu+8DdqD
         ElxFIVCJzoEunW3jG0lOOLbIJ9u7qu45t0idi3BKKfO6Y71bbxobsPgco4g6SG/zysPj
         huv33JaQ3ygm1jB1++yb866zl4mvT2j++7kItRaoiZB1EwEwmIn+CUd4QMf+Iko/h+JA
         Dakg==
X-Gm-Message-State: ANhLgQ2zaEFYrO/MUNMlnwn3iMEBsbDU7T8+vi5jiyPdOTP7G1P+lZ6q
        FXJ58hA606T/RdZoz7pmt8Bc85wxDAE=
X-Google-Smtp-Source: ADFU+vv+XXqjsgXYYq+tUal/2Pv7x8EezcFQMTxkHi5SkUxjky7j9p1Y1qErUKbOtqXfLnLKcKYc6A==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr10457609wrq.216.1584706647567;
        Fri, 20 Mar 2020 05:17:27 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:27 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 17/26] block/rnbd: client: private header with client structs and functions
Date:   Fri, 20 Mar 2020 13:16:48 +0100
Message-Id: <20200320121657.1165-18-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This header describes main structs and functions used by rnbd-client
module, mainly for managing RNBD sessions and mapped block devices,
creating and destroying sysfs entries.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-clt.h | 148 ++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-clt.h

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
new file mode 100644
index 000000000000..276a3220f78f
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -0,0 +1,148 @@
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
+#include "rtrs.h"
+#include "rnbd-proto.h"
+#include "rnbd-log.h"
+
+#define BMAX_SEGMENTS 29
+#define RECONNECT_DELAY 30
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
+					   size_t path_cnt,
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
2.17.1

