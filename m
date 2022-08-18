Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB41C28B2B
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 10:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiHRKz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbiHRKz5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 06:55:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0D8C477
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 03:55:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bs25so1304078wrb.2
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yi5PQ0UEXVhgxVqBhTl6VQgmHTHOZ66KFQjm/616yjY=;
        b=JI2D7lxTR+WuitPX/9rvhb9qE/c8T8h6uGV3KEY46ONKl0/uSkL3EP/9YijAE1a1DF
         jpJL5/iG87IY8C+ouhFmffBVPYFCVwj+a78qHy1e5TGFxLyUmKiau4wlirrspt7H5mfj
         4WZmLvyQyN3cI5kqz2hvr9DxnRvR0bhKzdKSz52qzo9gljaakeU3o5aA1VoeVQeRplKX
         OcCbQP4S9s9xvSdZv2qxHGzWVed0yfEKs94dxkj3MINy6FkgJBwqfu3/+HQ5/wUOmGXy
         8fJmxjEhtThEGvUK+oaAWqnJWLn0CZ4jMLh4tkHPwZ8aS04uP76S22gIaMF3E0S50J2Z
         jLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yi5PQ0UEXVhgxVqBhTl6VQgmHTHOZ66KFQjm/616yjY=;
        b=H2g25Cuw6nG2T0/s0yC/ktkcWq0L9SdNJ7MWr9h9zYe7iA+etXNh/odLgrriYjG5K7
         RhYkfKGMTq61L9omAy31GcdmzThH08r0svLjhBbW86Hxo3YVSqR9+tXBs772uzt8R0uX
         Mb12vRGvrxvQhNyfGtoEOQ0e7bt/6mQVVJjJxkawd+yTbEmjmntzg4CLodH6bhYSJyQt
         FbVi/xyIfj6bXUjk9vR202GINn8aoQrnY4VkSUXmoBPo4PrIK0v/+QM26uZzZBz8UglV
         fXuO69fgxHn7ZEqYFBklJSXTt2/r9a6+1ewzpcYnIePSQlKu3HIhloPRcxwUj34bl8yd
         YXqQ==
X-Gm-Message-State: ACgBeo3iyJyE7WdlZfl2m54UjLChlpS1KEHIleyy5XmkdMQa7n6XB73s
        LCdaHltMyzWr3UMvr5iKM/FdNIyOr5PYhw==
X-Google-Smtp-Source: AA6agR5/faydHcoRQWkHVASkSbOHalOxqyhlz6+fbVnPOI+R1KgslBgYTvIscIkd8IatLWbbhHFR8A==
X-Received: by 2002:a05:6000:78d:b0:220:6259:2874 with SMTP id bu13-20020a056000078d00b0022062592874mr1333120wrb.678.1660820154243;
        Thu, 18 Aug 2022 03:55:54 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003a5ce167a68sm5114085wms.7.2022.08.18.03.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:55:53 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Santosh Pradhan <santosh.pradhan@ionos.com>
Subject: [PATCH for-next 1/1] block/rnbd-srv: Add event tracing support
Date:   Thu, 18 Aug 2022 12:55:51 +0200
Message-Id: <20220818105551.110490-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818105551.110490-1-haris.iqbal@ionos.com>
References: <20220818105551.110490-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Santosh Pradhan <santosh.pradhan@ionos.com>

Add event tracing mechanism for following routines:
 - create_sess()
 - destroy_sess()
 - process_rdma()
 - process_msg_sess_info()
 - process_msg_open()
 - process_msg_close()

How to use:
1. Load the rnbd_server module
2. cd /sys/kernel/debug/tracing
3. If all the events need to be enabled:
        echo 1 > events/rnbd_srv/enable
4. OR only speific routine/event needs to be enabled e.g.
        echo 1 > events/rnbd_srv/create_sess/enable
5. cat trace
5. Run some workload which can trigger create_sess() routine/event

Signed-off-by: Santosh Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/Makefile         |   5 +-
 drivers/block/rnbd/rnbd-srv-trace.c |  17 +++
 drivers/block/rnbd/rnbd-srv-trace.h | 207 ++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-srv.c       |  19 ++-
 4 files changed, 241 insertions(+), 7 deletions(-)
 create mode 100644 drivers/block/rnbd/rnbd-srv-trace.c
 create mode 100644 drivers/block/rnbd/rnbd-srv-trace.h

diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
index 5bb1a7ad1ada..5fc05e667950 100644
--- a/drivers/block/rnbd/Makefile
+++ b/drivers/block/rnbd/Makefile
@@ -6,10 +6,13 @@ rnbd-client-y := rnbd-clt.o \
 		  rnbd-clt-sysfs.o \
 		  rnbd-common.o
 
+CFLAGS_rnbd-srv-trace.o = -I$(src)
+
 rnbd-server-y := rnbd-common.o \
 		  rnbd-srv.o \
 		  rnbd-srv-dev.o \
-		  rnbd-srv-sysfs.o
+		  rnbd-srv-sysfs.o \
+		  rnbd-srv-trace.o
 
 obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
 obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
diff --git a/drivers/block/rnbd/rnbd-srv-trace.c b/drivers/block/rnbd/rnbd-srv-trace.c
new file mode 100644
index 000000000000..30f0895c18f5
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-trace.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2022 1&1 IONOS SE. All rights reserved.
+ */
+#include "rtrs.h"
+#include "rtrs-srv.h"
+#include "rnbd-srv.h"
+#include "rnbd-proto.h"
+
+/*
+ * We include this last to have the helpers above available for the trace
+ * event implementations.
+ */
+#define CREATE_TRACE_POINTS
+#include "rnbd-srv-trace.h"
diff --git a/drivers/block/rnbd/rnbd-srv-trace.h b/drivers/block/rnbd/rnbd-srv-trace.h
new file mode 100644
index 000000000000..8dedf73bdd28
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-trace.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2022 1&1 IONOS SE. All rights reserved.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rnbd_srv
+
+#if !defined(_TRACE_RNBD_SRV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RNBD_SRV_H
+
+#include <linux/tracepoint.h>
+
+struct rnbd_srv_session;
+struct rtrs_srv_op;
+
+DECLARE_EVENT_CLASS(rnbd_srv_link_class,
+	TP_PROTO(struct rnbd_srv_session *srv),
+
+	TP_ARGS(srv),
+
+	TP_STRUCT__entry(
+		__field(int, qdepth)
+		__string(sessname, srv->sessname)
+	),
+
+	TP_fast_assign(
+		__entry->qdepth = srv->queue_depth;
+		__assign_str(sessname, srv->sessname);
+	),
+
+	TP_printk("sessname: %s qdepth: %d",
+		   __get_str(sessname),
+		   __entry->qdepth
+	)
+);
+
+#define DEFINE_LINK_EVENT(name) \
+DEFINE_EVENT(rnbd_srv_link_class, name, \
+	TP_PROTO(struct rnbd_srv_session *srv), \
+	TP_ARGS(srv))
+
+DEFINE_LINK_EVENT(create_sess);
+DEFINE_LINK_EVENT(destroy_sess);
+
+TRACE_DEFINE_ENUM(RNBD_OP_READ);
+TRACE_DEFINE_ENUM(RNBD_OP_WRITE);
+TRACE_DEFINE_ENUM(RNBD_OP_FLUSH);
+TRACE_DEFINE_ENUM(RNBD_OP_DISCARD);
+TRACE_DEFINE_ENUM(RNBD_OP_SECURE_ERASE);
+TRACE_DEFINE_ENUM(RNBD_F_SYNC);
+TRACE_DEFINE_ENUM(RNBD_F_FUA);
+
+#define show_rnbd_rw_flags(x) \
+	__print_flags(x, "|", \
+		{ RNBD_OP_READ,		"READ" }, \
+		{ RNBD_OP_WRITE,	"WRITE" }, \
+		{ RNBD_OP_FLUSH,	"FLUSH" }, \
+		{ RNBD_OP_DISCARD,	"DISCARD" }, \
+		{ RNBD_OP_SECURE_ERASE,	"SECURE_ERASE" }, \
+		{ RNBD_F_SYNC,		"SYNC" }, \
+		{ RNBD_F_FUA,		"FUA" })
+
+TRACE_EVENT(process_rdma,
+	TP_PROTO(struct rnbd_srv_session *srv,
+		 const struct rnbd_msg_io *msg,
+		 struct rtrs_srv_op *id,
+		 u32 datalen,
+		 size_t usrlen),
+
+	TP_ARGS(srv, msg, id, datalen, usrlen),
+
+	TP_STRUCT__entry(
+		__string(sessname, srv->sessname)
+		__field(u8, dir)
+		__field(u8, ver)
+		__field(u32, device_id)
+		__field(u64, sector)
+		__field(u32, flags)
+		__field(u32, bi_size)
+		__field(u16, ioprio)
+		__field(u32, datalen)
+		__field(size_t, usrlen)
+	),
+
+	TP_fast_assign(
+		__assign_str(sessname, srv->sessname);
+		__entry->dir = id->dir;
+		__entry->ver = srv->ver;
+		__entry->device_id = le32_to_cpu(msg->device_id);
+		__entry->sector = le64_to_cpu(msg->sector);
+		__entry->bi_size = le32_to_cpu(msg->bi_size);
+		__entry->flags = le32_to_cpu(msg->rw);
+		__entry->ioprio = le16_to_cpu(msg->prio);
+		__entry->datalen = datalen;
+		__entry->usrlen = usrlen;
+	),
+
+	TP_printk("I/O req: sess: %s, type: %s, ver: %d, devid: %u, sector: %llu, bsize: %u, flags: %s, ioprio: %d, datalen: %u, usrlen: %zu",
+		   __get_str(sessname),
+		   __print_symbolic(__entry->dir,
+			 { READ,  "READ" },
+			 { WRITE, "WRITE" }),
+		   __entry->ver,
+		   __entry->device_id,
+		   __entry->sector,
+		   __entry->bi_size,
+		   show_rnbd_rw_flags(__entry->flags),
+		   __entry->ioprio,
+		   __entry->datalen,
+		   __entry->usrlen
+	)
+);
+
+TRACE_EVENT(process_msg_sess_info,
+	TP_PROTO(struct rnbd_srv_session *srv,
+		 const struct rnbd_msg_sess_info *msg),
+
+	TP_ARGS(srv, msg),
+
+	TP_STRUCT__entry(
+		__field(u8, proto_ver)
+		__field(u8, clt_ver)
+		__field(u8, srv_ver)
+		__string(sessname, srv->sessname)
+	),
+
+	TP_fast_assign(
+		__entry->proto_ver = srv->ver;
+		__entry->clt_ver = msg->ver;
+		__entry->srv_ver = RNBD_PROTO_VER_MAJOR;
+		__assign_str(sessname, srv->sessname);
+	),
+
+	TP_printk("Session %s using proto-ver %d (clt-ver: %d, srv-ver: %d)",
+		   __get_str(sessname),
+		   __entry->proto_ver,
+		   __entry->clt_ver,
+		   __entry->srv_ver
+	)
+);
+
+TRACE_DEFINE_ENUM(RNBD_ACCESS_RO);
+TRACE_DEFINE_ENUM(RNBD_ACCESS_RW);
+TRACE_DEFINE_ENUM(RNBD_ACCESS_MIGRATION);
+
+#define show_rnbd_access_mode(x) \
+	__print_symbolic(x, \
+		{ RNBD_ACCESS_RO,		"RO" }, \
+		{ RNBD_ACCESS_RW,		"RW" }, \
+		{ RNBD_ACCESS_MIGRATION,	"MIGRATION" })
+
+TRACE_EVENT(process_msg_open,
+	TP_PROTO(struct rnbd_srv_session *srv,
+		 const struct rnbd_msg_open *msg),
+
+	TP_ARGS(srv, msg),
+
+	TP_STRUCT__entry(
+		__field(u8, access_mode)
+		__string(sessname, srv->sessname)
+		__string(dev_name, msg->dev_name)
+	),
+
+	TP_fast_assign(
+		__entry->access_mode = msg->access_mode;
+		__assign_str(sessname, srv->sessname);
+		__assign_str(dev_name, msg->dev_name);
+	),
+
+	TP_printk("Open message received: session='%s' path='%s' access_mode=%s",
+		   __get_str(sessname),
+		   __get_str(dev_name),
+		   show_rnbd_access_mode(__entry->access_mode)
+	)
+);
+
+TRACE_EVENT(process_msg_close,
+	TP_PROTO(struct rnbd_srv_session *srv,
+		 const struct rnbd_msg_close *msg),
+
+	TP_ARGS(srv, msg),
+
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__string(sessname, srv->sessname)
+	),
+
+	TP_fast_assign(
+		__entry->device_id = le32_to_cpu(msg->device_id);
+		__assign_str(sessname, srv->sessname);
+	),
+
+	TP_printk("Close message received: session='%s' device id='%d'",
+		   __get_str(sessname),
+		   __entry->device_id
+	)
+);
+
+#endif /* _TRACE_RNBD_SRV_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE rnbd-srv-trace
+#include <trace/define_trace.h>
+
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 5e08da277ddf..3f6c268e04ef 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -14,6 +14,7 @@
 
 #include "rnbd-srv.h"
 #include "rnbd-srv-dev.h"
+#include "rnbd-srv-trace.h"
 
 MODULE_DESCRIPTION("RDMA Network Block Device Server");
 MODULE_LICENSE("GPL");
@@ -132,6 +133,8 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	struct bio *bio;
 	short prio;
 
+	trace_process_rdma(srv_sess, msg, id, datalen, usrlen);
+
 	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -244,6 +247,8 @@ static void destroy_sess(struct rnbd_srv_session *srv_sess)
 	if (xa_empty(&srv_sess->index_idr))
 		goto out;
 
+	trace_destroy_sess(srv_sess);
+
 	mutex_lock(&srv_sess->lock);
 	xa_for_each(&srv_sess->index_idr, index, sess_dev)
 		rnbd_srv_destroy_dev_session_sysfs(sess_dev);
@@ -290,6 +295,8 @@ static int create_sess(struct rtrs_srv_sess *rtrs)
 
 	rtrs_srv_set_sess_priv(rtrs, srv_sess);
 
+	trace_create_sess(srv_sess);
+
 	return 0;
 }
 
@@ -339,6 +346,8 @@ static int process_msg_close(struct rnbd_srv_session *srv_sess,
 	const struct rnbd_msg_close *close_msg = usr;
 	struct rnbd_srv_sess_dev *sess_dev;
 
+	trace_process_msg_close(srv_sess, close_msg);
+
 	sess_dev = rnbd_get_sess_dev(le32_to_cpu(close_msg->device_id),
 				      srv_sess);
 	if (IS_ERR(sess_dev))
@@ -643,9 +652,8 @@ static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 	struct rnbd_msg_sess_info_rsp *rsp = data;
 
 	srv_sess->ver = min_t(u8, sess_info_msg->ver, RNBD_PROTO_VER_MAJOR);
-	pr_debug("Session %s using protocol version %d (client version: %d, server version: %d)\n",
-		 srv_sess->sessname, srv_sess->ver,
-		 sess_info_msg->ver, RNBD_PROTO_VER_MAJOR);
+
+	trace_process_msg_sess_info(srv_sess, sess_info_msg);
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_SESS_INFO_RSP);
 	rsp->ver = srv_sess->ver;
@@ -690,9 +698,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_dev *rnbd_dev;
 	struct rnbd_msg_open_rsp *rsp = data;
 
-	pr_debug("Open message received: session='%s' path='%s' access_mode=%d\n",
-		 srv_sess->sessname, open_msg->dev_name,
-		 open_msg->access_mode);
+	trace_process_msg_open(srv_sess, open_msg);
+
 	open_flags = FMODE_READ;
 	if (open_msg->access_mode != RNBD_ACCESS_RO)
 		open_flags |= FMODE_WRITE;
-- 
2.25.1

