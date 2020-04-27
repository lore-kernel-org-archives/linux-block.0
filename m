Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526EC7C888
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A96820735
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ILlKwOUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgD0OLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgD0OLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:11:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013AFC03C1A8
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so19989964wrt.5
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuJOZVsEd9h9dD9WNCH05BihJUfcD+XqHViZvcPGzLM=;
        b=ILlKwOUY/SRHzaYXb/xFBLv/PhsD8h5HXe+f1AhiUEku9izjlWs9zpzQ0fXWnYYSTI
         7DVbfkKQP/rwfa4bdiLAdhKm38jCuc6pgUHfeSvHWYgkbVum07iZocQgMuj/HGI1fLb1
         SG7W9pdGFzOPLburVa5n23q0DKpd11C0fV7r4sWB8nUX9NVQeGoCRfr+pPjXio8Mg6eg
         6/rF/E4BjAWYnWnAWlT5/tIXWV7W/I7jmC7bRhi36BvmfLXqyYvgjoqcAGtpLdiOB0nR
         vDj0oGXd4TXg7NaMA2fgTxgsAAp/bDcrk1JQhWZM91ZFlSPfly1iKjXWoApwEhXm6IPW
         In8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuJOZVsEd9h9dD9WNCH05BihJUfcD+XqHViZvcPGzLM=;
        b=eUPIBxi8ijv403BH/zTOKp4aIHiG10qqx17niGv6tYdKSfCzdNGILdh7W4nJvFe33K
         iDXoJIVsUD6zDzq6BonH6C2yMcxKaTZ9X57vC2c3Mud8HEukr4DmKH0kg3Odhg1CHiUL
         1GbPGOCgBVmUd8S3WOzDYqMbokBpbWFguZUSoJHhyg/LL3RbDh0Fi59+cnbPEXKqaTxJ
         RWkdJzGGKZQcB6HLspzUWII6zrNFJjYpfeV1hj0zpKCXn1iIa6rkpmZXTN6z0jv8H0Zu
         ePsW4cfCvYmsNZjI7V4b0A40aic8wZSMFjgjCDWNFApbFqK8rU9cCDh9tW5gCuRPmkli
         1q8Q==
X-Gm-Message-State: AGi0PuYel3RQlG9Ce7EIq4q9/Xmc1NN8hSID1obN4ZO5q/03IpQjx1Q8
        iur8hckiwRjHkhwYfgl6eCoFwNHLeWMGrC8=
X-Google-Smtp-Source: APiQypJjAOtJm6tX513lSPpy/LeypI3m+dRO4Lh284HWqeB4xZ7q3gMq5b/Z4Llpl2oE1Eb/pLjjsQ==
X-Received: by 2002:adf:d087:: with SMTP id y7mr27396420wrh.321.1587996700569;
        Mon, 27 Apr 2020 07:11:40 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:40 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 23/25] block/rnbd: include client and server modules into kernel compilation
Date:   Mon, 27 Apr 2020 16:10:18 +0200
Message-Id: <20200427141020.655-24-danil.kipnis@cloud.ionos.com>
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

Add rnbd Makefile, Kconfig and also corresponding lines into upper
block layer files.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/Kconfig       |  2 ++
 drivers/block/Makefile      |  1 +
 drivers/block/rnbd/Kconfig  | 28 ++++++++++++++++++++++++++++
 drivers/block/rnbd/Makefile | 15 +++++++++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 drivers/block/rnbd/Kconfig
 create mode 100644 drivers/block/rnbd/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 025b1b77b11a..084b9efcefca 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -458,4 +458,6 @@ config BLK_DEV_RSXX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rsxx.
 
+source "drivers/block/rnbd/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 795facd8cf19..e1f63117ee94 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
+obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
new file mode 100644
index 000000000000..4b6d3d816d1f
--- /dev/null
+++ b/drivers/block/rnbd/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config BLK_DEV_RNBD
+	bool
+
+config BLK_DEV_RNBD_CLIENT
+	tristate "RDMA Network Block Device driver client"
+	depends on INFINIBAND_RTRS_CLIENT
+	select BLK_DEV_RNBD
+	help
+	  RNBD client is a network block device driver using rdma transport.
+
+	  RNBD client allows for mapping of a remote block devices over
+	  RTRS protocol from a target system where RNBD server is running.
+
+	  If unsure, say N.
+
+config BLK_DEV_RNBD_SERVER
+	tristate "RDMA Network Block Device driver server"
+	depends on INFINIBAND_RTRS_SERVER
+	select BLK_DEV_RNBD
+	help
+	  RNBD server is the server side of RNBD using rdma transport.
+
+	  RNBD server allows for exporting local block devices to a remote client
+	  over RTRS protocol.
+
+	  If unsure, say N.
diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
new file mode 100644
index 000000000000..450a9e4974d7
--- /dev/null
+++ b/drivers/block/rnbd/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -Idrivers/infiniband/ulp/rtrs
+
+rnbd-client-y := rnbd-clt.o \
+		  rnbd-common.o \
+		  rnbd-clt-sysfs.o
+
+rnbd-server-y := rnbd-srv.o \
+		  rnbd-common.o \
+		  rnbd-srv-dev.o \
+		  rnbd-srv-sysfs.o
+
+obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
+obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
-- 
2.20.1

