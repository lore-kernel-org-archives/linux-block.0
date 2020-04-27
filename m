Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A653C7C88B
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E743A206BF
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="EoYyS1/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgD0OLk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgD0OLi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:11:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E1C0610D5
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so6442194wmb.4
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/LuLDh9YK1dQOSDUu8eDD6LepxCi9Ej7sBpxBWHxIk=;
        b=EoYyS1/c+R/w+Zz5nQRe2kZudhgR/UNKqahwHtuVsbXyM6t2jcqt8SiXm+7pp+84DN
         x9yKm2kb94kScfHzbmIc9kujNzZwRo3ydqUG+fiy52Kbn0xMpOucqhW51vGWSuve8oqm
         ZUP7Qa6fSszrXW7hv4psjM7TvgMXb/CBILgEzmyMtW8Kbqcb2967dMTJzVhELIYH3GkI
         80nXuq6/kBfBBfpZGUgZ0N7Y19sHgNsnS0m0AtYzEHlUJwVrwcc9MocWPUgKNGZQd62j
         +DgXlmQDtM2UMD5AxmEfwre05RMTcKZ82Ocj1PjSTXmrr0zK1gR6+gq2xQdT19mXR197
         qmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/LuLDh9YK1dQOSDUu8eDD6LepxCi9Ej7sBpxBWHxIk=;
        b=kJppw2C4S/isZgeDGo7K2erxqsVGyxhiIDpAhUt/WuQZV0puk5HcorQ+rkTVmTDayi
         aCrggrLz/Zr00wiCA+ereSTn7SIkDE5QXRlZfg3mzCNOOeXBZMK2FLme0buBcgrhwXwG
         wu+9u86+Dd/NYmsn54JCEtA89Apo3krFYfkey3pas+jizDkOuH5sx+G+LA8YiVFjhNDc
         uzTjJza3sJZvZpLKJpotV2u5hBYA2QPEBXcLdVFGDCiDbDjKTjAnY1s/nM7t/nkuFB0e
         UEFQBo3RhyHBk5xBzvjl3679JdKHDVTQkKMsAyJHXT81lUK8KT1vZKqdNrGclZrRoHO4
         LfSw==
X-Gm-Message-State: AGi0Pubh00Q1Un6iABCu0btbhDujxBrzqKpzhpckrh2/vsoBhT8eUmG0
        b4WOzQVJfsCHfPQm4yfRBjyIXZtkMxx9nGE=
X-Google-Smtp-Source: APiQypLgwhmkvkeKwCSAMaxxP3RcVeG47UIT2hwGI/DwneNS6Wb5xeTQQ/iDXDGLoYt/0/eZiU+oKQ==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr26516549wmi.103.1587996695320;
        Mon, 27 Apr 2020 07:11:35 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:34 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 19/25] block/rnbd: server: private header with server structs and functions
Date:   Mon, 27 Apr 2020 16:10:14 +0200
Message-Id: <20200427141020.655-20-danil.kipnis@cloud.ionos.com>
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

This header describes main structs and functions used by rnbd-server
module, namely structs for managing sessions from different clients
and mapped (opened) devices.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-srv.h | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.h

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
new file mode 100644
index 000000000000..89218024325d
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RNBD_SRV_H
+#define RNBD_SRV_H
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/kref.h>
+
+#include "rtrs.h"
+#include "rnbd-proto.h"
+#include "rnbd-log.h"
+
+struct rnbd_srv_session {
+	/* Entry inside global sess_list */
+	struct list_head        list;
+	struct rtrs_srv		*rtrs;
+	char			sessname[NAME_MAX];
+	int			queue_depth;
+	struct bio_set		sess_bio_set;
+
+	spinlock_t              index_lock ____cacheline_aligned;
+	struct idr              index_idr;
+	/* List of struct rnbd_srv_sess_dev */
+	struct list_head        sess_dev_list;
+	struct mutex		lock;
+	u8			ver;
+};
+
+struct rnbd_srv_dev {
+	/* Entry inside global dev_list */
+	struct list_head                list;
+	struct kobject                  dev_kobj;
+	struct kobject                  *dev_sessions_kobj;
+	struct kref                     kref;
+	char				id[NAME_MAX];
+	/* List of rnbd_srv_sess_dev structs */
+	struct list_head		sess_dev_list;
+	struct mutex			lock;
+	int				open_write_cnt;
+};
+
+/* Structure which binds N devices and N sessions */
+struct rnbd_srv_sess_dev {
+	/* Entry inside rnbd_srv_dev struct */
+	struct list_head		dev_list;
+	/* Entry inside rnbd_srv_session struct */
+	struct list_head		sess_list;
+	struct rnbd_dev			*rnbd_dev;
+	struct rnbd_srv_session		*sess;
+	struct rnbd_srv_dev		*dev;
+	struct kobject                  kobj;
+	u32                             device_id;
+	fmode_t                         open_flags;
+	struct kref			kref;
+	struct completion               *destroy_comp;
+	char				pathname[NAME_MAX];
+	enum rnbd_access_mode		access_mode;
+};
+
+/* rnbd-srv-sysfs.c */
+
+int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
+			      struct block_device *bdev,
+			      const char *dir_name);
+void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev);
+int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev);
+int rnbd_srv_create_sysfs_files(void);
+void rnbd_srv_destroy_sysfs_files(void);
+void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev);
+
+#endif /* RNBD_SRV_H */
-- 
2.20.1

