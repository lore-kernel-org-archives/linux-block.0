Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E9AC4332D
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5574820777
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="h0tOT4Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgCTMR3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:17:29 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46854 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgCTMR2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 08:17:28 -0400
Received: by mail-wr1-f48.google.com with SMTP id j17so3748895wru.13
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iPYPmVRAhmJcxYNSzpoEcSGiQntcbvpv/xix3SwP88Y=;
        b=h0tOT4PktzqbpxFovrCpeyjpGHvFM/IABNRm42Wr7UTwVfWFFWbrI7ivHQVbEIIFvp
         n1qmZG5UgztPgnsVbDRjff/Q9G24jrMU//hQz0g6FqHBCItZ7+eTMa0VgPrpP/sRhrNM
         3DMLt9JiURFgoMUeGBRFzfgkFlvxF6t5JB3X2HbOyrVJv2fNwu79uJji+3uDtF1NpaGO
         Hr+Vn4OOBTKIHR4/dbZo0eB6gw9cgeN9JamURCjGyJOAqU6Wi6g0qBoxLz2tiHn36Mma
         5P6ZUXr8R/A+kX1RhIwxu06TXNzaOhamMutq5unNzGKy3xXx+3NpiSajxmmaWphTyyQu
         eXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iPYPmVRAhmJcxYNSzpoEcSGiQntcbvpv/xix3SwP88Y=;
        b=CzLlUmSvtLbE5zsMSdBUCe52R7sHSfJWBVPe4rebHxmMPHlZVXqBQJinTogBEsLndz
         9+d/17H716CJ6ucH0adM+Y0NxBasqw0H7i9h6jAILAv1KwLWLpJ5CkLfNW7/ACLWaAIW
         YtSIZmI5SviEim4FGrPY7uAwn75NNRFxbwtuZeTpCh3x72rOyMiOU3Y0MQqwkjmVqwOH
         fWznJkXOFSkSV6iKkjH5Xzarwn3II3XUae8d0d62JKJL9zlLVUpFQgpi71XXszOuJsOK
         uD4vE865CImRKUBx103qAbzPNs1x1PVURKCyjCq1JnZdDkgZsvxI6VrY2/VU0P57U/uv
         UCvg==
X-Gm-Message-State: ANhLgQ3F7GDg5fenN+D61bYRc7HqQ9ADKkvdc1dfZZBD7TgS5TdHraJI
        acq3SUB38liv4DGqTeFBZJoq/RONvwY=
X-Google-Smtp-Source: ADFU+vvnIr0T9or63IRzSVweBCqQfBogWucp6g1aQLMlf+RVueYPjt/TOHWNrZ48hFA/qO6T05xadA==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr10208553wrp.327.1584706646189;
        Fri, 20 Mar 2020 05:17:26 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:25 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 16/26] block/rnbd: private headers with rnbd protocol structs and helpers
Date:   Fri, 20 Mar 2020 13:16:47 +0100
Message-Id: <20200320121657.1165-17-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These are common private headers with rnbd protocol structures,
logging, sysfs and other helper functions, which are used on
both client and server sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-common.c |  23 +++
 drivers/block/rnbd/rnbd-log.h    |  41 +++++
 drivers/block/rnbd/rnbd-proto.h  | 305 +++++++++++++++++++++++++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-common.c
 create mode 100644 drivers/block/rnbd/rnbd-log.h
 create mode 100644 drivers/block/rnbd/rnbd-proto.h

diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-common.c
new file mode 100644
index 000000000000..596c3f732403
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-common.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#include "rnbd-proto.h"
+
+const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
+{
+	switch (mode) {
+	case RNBD_ACCESS_RO:
+		return "ro";
+	case RNBD_ACCESS_RW:
+		return "rw";
+	case RNBD_ACCESS_MIGRATION:
+		return "migration";
+	default:
+		return "unknown";
+	}
+}
diff --git a/drivers/block/rnbd/rnbd-log.h b/drivers/block/rnbd/rnbd-log.h
new file mode 100644
index 000000000000..136e7d6c3451
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-log.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_LOG_H
+#define RNBD_LOG_H
+
+#include "rnbd-clt.h"
+#include "rnbd-srv.h"
+
+#define rnbd_clt_log(fn, dev, fmt, ...) (				\
+		fn("<%s@%s> " fmt, (dev)->pathname,			\
+		(dev)->sess->sessname,					\
+		   ##__VA_ARGS__))
+#define rnbd_srv_log(fn, dev, fmt, ...) (				\
+			fn("<%s@%s>: " fmt, (dev)->pathname,		\
+			   (dev)->sess->sessname, ##__VA_ARGS__))
+
+#define rnbd_clt_err(dev, fmt, ...)	\
+	rnbd_clt_log(pr_err, dev, fmt, ##__VA_ARGS__)
+#define rnbd_clt_err_rl(dev, fmt, ...)	\
+	rnbd_clt_log(pr_err_ratelimited, dev, fmt, ##__VA_ARGS__)
+#define rnbd_clt_info(dev, fmt, ...) \
+	rnbd_clt_log(pr_info, dev, fmt, ##__VA_ARGS__)
+#define rnbd_clt_info_rl(dev, fmt, ...) \
+	rnbd_clt_log(pr_info_ratelimited, dev, fmt, ##__VA_ARGS__)
+
+#define rnbd_srv_err(dev, fmt, ...)	\
+	rnbd_srv_log(pr_err, dev, fmt, ##__VA_ARGS__)
+#define rnbd_srv_err_rl(dev, fmt, ...)	\
+	rnbd_srv_log(pr_err_ratelimited, dev, fmt, ##__VA_ARGS__)
+#define rnbd_srv_info(dev, fmt, ...) \
+	rnbd_srv_log(pr_info, dev, fmt, ##__VA_ARGS__)
+#define rnbd_srv_info_rl(dev, fmt, ...) \
+	rnbd_srv_log(pr_info_ratelimited, dev, fmt, ##__VA_ARGS__)
+
+#endif /* RNBD_LOG_H */
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
new file mode 100644
index 000000000000..cb850e6ee840
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_PROTO_H
+#define RNBD_PROTO_H
+
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/limits.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <rdma/ib.h>
+
+#define RNBD_PROTO_VER_MAJOR 2
+#define RNBD_PROTO_VER_MINOR 0
+
+#define RNBD_PROTO_VER_STRING __stringify(RNBD_PROTO_VER_MAJOR) "." \
+			       __stringify(RNBD_PROTO_VER_MINOR)
+
+#define RTRS_PORT 1234
+
+/**
+ * enum rnbd_msg_types - RNBD message types
+ * @RNBD_MSG_SESS_INFO:	initial session info from client to server
+ * @RNBD_MSG_SESS_INFO_RSP:	initial session info from server to client
+ * @RNBD_MSG_OPEN:		open (map) device request
+ * @RNBD_MSG_OPEN_RSP:		response to an @RNBD_MSG_OPEN
+ * @RNBD_MSG_IO:		block IO request operation
+ * @RNBD_MSG_CLOSE:		close (unmap) device request
+ */
+enum rnbd_msg_type {
+	RNBD_MSG_SESS_INFO,
+	RNBD_MSG_SESS_INFO_RSP,
+	RNBD_MSG_OPEN,
+	RNBD_MSG_OPEN_RSP,
+	RNBD_MSG_IO,
+	RNBD_MSG_CLOSE,
+};
+
+/**
+ * struct rnbd_msg_hdr - header of RNBD messages
+ * @type:	Message type, valid values see: enum rnbd_msg_types
+ */
+struct rnbd_msg_hdr {
+	__le16		type;
+	__le16		__padding;
+};
+
+/**
+ * We allow to map RO many times and RW only once. We allow to map yet another
+ * time RW, if MIGRATION is provided (second RW export can be required for
+ * example for VM migration)
+ */
+enum rnbd_access_mode {
+	RNBD_ACCESS_RO,
+	RNBD_ACCESS_RW,
+	RNBD_ACCESS_MIGRATION,
+};
+
+/**
+ * struct rnbd_msg_sess_info - initial session info from client to server
+ * @hdr:		message header
+ * @ver:		RNBD protocol version
+ */
+struct rnbd_msg_sess_info {
+	struct rnbd_msg_hdr hdr;
+	u8		ver;
+	u8		reserved[31];
+};
+
+/**
+ * struct rnbd_msg_sess_info_rsp - initial session info from server to client
+ * @hdr:		message header
+ * @ver:		RNBD protocol version
+ */
+struct rnbd_msg_sess_info_rsp {
+	struct rnbd_msg_hdr hdr;
+	u8		ver;
+	u8		reserved[31];
+};
+
+/**
+ * struct rnbd_msg_open - request to open a remote device.
+ * @hdr:		message header
+ * @access_mode:	the mode to open remote device, valid values see:
+ *			enum rnbd_access_mode
+ * @device_name:	device path on remote side
+ */
+struct rnbd_msg_open {
+	struct rnbd_msg_hdr hdr;
+	u8		access_mode;
+	u8		resv1;
+	s8		dev_name[NAME_MAX];
+	u8		reserved[3];
+};
+
+/**
+ * struct rnbd_msg_close - request to close a remote device.
+ * @hdr:	message header
+ * @device_id:	device_id on server side to identify the device
+ */
+struct rnbd_msg_close {
+	struct rnbd_msg_hdr hdr;
+	__le32		device_id;
+};
+
+/**
+ * struct rnbd_msg_open_rsp - response message to RNBD_MSG_OPEN
+ * @hdr:		message header
+ * @device_id:		device_id on server side to identify the device
+ * @nsectors:		number of sectors in the usual 512b unit
+ * @max_hw_sectors:	max hardware sectors in the usual 512b unit
+ * @max_write_same_sectors: max sectors for WRITE SAME in the 512b unit
+ * @max_discard_sectors: max. sectors that can be discarded at once in 512b
+ * unit.
+ * @discard_granularity: size of the internal discard allocation unit in bytes
+ * @discard_alignment: offset from internal allocation assignment in bytes
+ * @physical_block_size: physical block size device supports in bytes
+ * @logical_block_size: logical block size device supports in bytes
+ * @max_segments:	max segments hardware support in one transfer
+ * @secure_discard:	supports secure discard
+ * @rotation:		is a rotational disc?
+ */
+struct rnbd_msg_open_rsp {
+	struct rnbd_msg_hdr	hdr;
+	__le32			device_id;
+	__le64			nsectors;
+	__le32			max_hw_sectors;
+	__le32			max_write_same_sectors;
+	__le32			max_discard_sectors;
+	__le32			discard_granularity;
+	__le32			discard_alignment;
+	__le16			physical_block_size;
+	__le16			logical_block_size;
+	__le16			max_segments;
+	__le16			secure_discard;
+	u8			rotational;
+	u8			reserved[11];
+};
+
+/**
+ * struct rnbd_msg_io - message for I/O read/write
+ * @hdr:	message header
+ * @device_id:	device_id on server side to find the right device
+ * @sector:	bi_sector attribute from struct bio
+ * @rw:		valid values are defined in enum rnbd_io_flags
+ * @bi_size:    number of bytes for I/O read/write
+ * @prio:       priority
+ */
+struct rnbd_msg_io {
+	struct rnbd_msg_hdr hdr;
+	__le32		device_id;
+	__le64		sector;
+	__le32		rw;
+	__le32		bi_size;
+	__le16		prio;
+};
+
+#define RNBD_OP_BITS  8
+#define RNBD_OP_MASK  ((1 << RNBD_OP_BITS) - 1)
+
+/**
+ * enum rnbd_io_flags - RNBD request types from rq_flag_bits
+ * @RNBD_OP_READ:	     read sectors from the device
+ * @RNBD_OP_WRITE:	     write sectors to the device
+ * @RNBD_OP_FLUSH:	     flush the volatile write cache
+ * @RNBD_OP_DISCARD:        discard sectors
+ * @RNBD_OP_SECURE_ERASE:   securely erase sectors
+ * @RNBD_OP_WRITE_SAME:     write the same sectors many times
+
+ * @RNBD_F_SYNC:	     request is sync (sync write or read)
+ * @RNBD_F_FUA:             forced unit access
+ */
+enum rnbd_io_flags {
+
+	/* Operations */
+
+	RNBD_OP_READ		= 0,
+	RNBD_OP_WRITE		= 1,
+	RNBD_OP_FLUSH		= 2,
+	RNBD_OP_DISCARD	= 3,
+	RNBD_OP_SECURE_ERASE	= 4,
+	RNBD_OP_WRITE_SAME	= 5,
+
+	RNBD_OP_LAST,
+
+	/* Flags */
+
+	RNBD_F_SYNC  = 1<<(RNBD_OP_BITS + 0),
+	RNBD_F_FUA   = 1<<(RNBD_OP_BITS + 1),
+
+	RNBD_F_ALL   = (RNBD_F_SYNC | RNBD_F_FUA)
+
+};
+
+static inline u32 rnbd_op(u32 flags)
+{
+	return flags & RNBD_OP_MASK;
+}
+
+static inline u32 rnbd_flags(u32 flags)
+{
+	return flags & ~RNBD_OP_MASK;
+}
+
+static inline bool rnbd_flags_supported(u32 flags)
+{
+	u32 op;
+
+	op = rnbd_op(flags);
+	flags = rnbd_flags(flags);
+
+	if (op >= RNBD_OP_LAST)
+		return false;
+	if (flags & ~RNBD_F_ALL)
+		return false;
+
+	return true;
+}
+
+static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
+{
+	u32 bio_opf;
+
+	switch (rnbd_op(rnbd_opf)) {
+	case RNBD_OP_READ:
+		bio_opf = REQ_OP_READ;
+		break;
+	case RNBD_OP_WRITE:
+		bio_opf = REQ_OP_WRITE;
+		break;
+	case RNBD_OP_FLUSH:
+		bio_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+		break;
+	case RNBD_OP_DISCARD:
+		bio_opf = REQ_OP_DISCARD;
+		break;
+	case RNBD_OP_SECURE_ERASE:
+		bio_opf = REQ_OP_SECURE_ERASE;
+		break;
+	case RNBD_OP_WRITE_SAME:
+		bio_opf = REQ_OP_WRITE_SAME;
+		break;
+	default:
+		WARN(1, "Unknown RNBD type: %d (flags %d)\n",
+		     rnbd_op(rnbd_opf), rnbd_opf);
+		bio_opf = 0;
+	}
+
+	if (rnbd_opf & RNBD_F_SYNC)
+		bio_opf |= REQ_SYNC;
+
+	if (rnbd_opf & RNBD_F_FUA)
+		bio_opf |= REQ_FUA;
+
+	return bio_opf;
+}
+
+static inline u32 rq_to_rnbd_flags(struct request *rq)
+{
+	u32 rnbd_opf;
+
+	switch (req_op(rq)) {
+	case REQ_OP_READ:
+		rnbd_opf = RNBD_OP_READ;
+		break;
+	case REQ_OP_WRITE:
+		rnbd_opf = RNBD_OP_WRITE;
+		break;
+	case REQ_OP_DISCARD:
+		rnbd_opf = RNBD_OP_DISCARD;
+		break;
+	case REQ_OP_SECURE_ERASE:
+		rnbd_opf = RNBD_OP_SECURE_ERASE;
+		break;
+	case REQ_OP_WRITE_SAME:
+		rnbd_opf = RNBD_OP_WRITE_SAME;
+		break;
+	case REQ_OP_FLUSH:
+		rnbd_opf = RNBD_OP_FLUSH;
+		break;
+	default:
+		WARN(1, "Unknown request type %d (flags %llu)\n",
+		     req_op(rq), (unsigned long long)rq->cmd_flags);
+		rnbd_opf = 0;
+	}
+
+	if (op_is_sync(rq->cmd_flags))
+		rnbd_opf |= RNBD_F_SYNC;
+
+	if (op_is_flush(rq->cmd_flags))
+		rnbd_opf |= RNBD_F_FUA;
+
+	return rnbd_opf;
+}
+
+const char *rnbd_access_mode_str(enum rnbd_access_mode mode);
+
+#endif /* RNBD_PROTO_H */
-- 
2.17.1

