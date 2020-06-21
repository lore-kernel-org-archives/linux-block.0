Return-Path: <SRS0=th+H=AC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63269C433DF
	for <linux-block@archiver.kernel.org>; Sun, 21 Jun 2020 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3E525286
	for <linux-block@archiver.kernel.org>; Sun, 21 Jun 2020 20:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgFUUnH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:43:07 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35219 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFUUnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jun 2020 16:43:06 -0400
Received: by mail-pj1-f67.google.com with SMTP id i4so7463175pjd.0
        for <linux-block@vger.kernel.org>; Sun, 21 Jun 2020 13:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZJFuxpeovNsTz8JjTPclvnoWjQ+zufpJjAmZmgHwq8=;
        b=M4bLKXsNPa0YdaSRcljLbKP0k2TkYmVbpubnuk2NeYePTppVLJ8JqmkstF5OJMl7j4
         B9yS6TmO9Cx3A0OpU7iHYyTzJ2wr8wHit7auM62shCt4eC3McGsR08rBOhrHROg9QT9X
         tJyL4955YPFCDXpt5vyXPEPVgBBWcg2QlN8r8pUdYO8FHr2t9ffvvFIaxv8PhAoOs/5z
         CxFFp6vStj0ArUt5bTvS7maiQEr/6wJmQDcv+AAixKwQ8bqnYFZ7Nn9mPbWdxUm1n0rc
         ZJKON0KStQISpxsXskfioEcv6/PUODkIMzZNSw/RR+Z1sNdlsftZt0PqD6A4mSF7k1FZ
         a1KQ==
X-Gm-Message-State: AOAM5302yacIohXr1OVTq2Se2hQmM1WfzhCsCUXXTvEi4sJ82bZP58ky
        sucXHhJsyom/2S/N1xd+hLfSb5EO
X-Google-Smtp-Source: ABdhPJy31SWPHfIdq03HaUD4PH9lEjdVb2UU6UN5saVW0xarrNVNF5UJJ1QHFZvXyNVbmBWhLmezjw==
X-Received: by 2002:a17:90a:58f:: with SMTP id i15mr14224736pji.78.1592772184885;
        Sun, 21 Jun 2020 13:43:04 -0700 (PDT)
Received: from localhost.localdomain (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id k126sm11877427pfd.129.2020.06.21.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 13:43:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: Move the null_blk source files into a subdirectory
Date:   Sun, 21 Jun 2020 13:42:57 -0700
Message-Id: <20200621204257.16006-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the number of source files of the null_blk driver keeps growing,
move these source files into a new subdirectory.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/Kconfig                         | 8 +-------
 drivers/block/Makefile                        | 7 +------
 drivers/block/null_blk/Kconfig                | 9 +++++++++
 drivers/block/null_blk/Makefile               | 8 ++++++++
 drivers/block/{ => null_blk}/null_blk.h       | 0
 drivers/block/{ => null_blk}/null_blk_main.c  | 0
 drivers/block/{ => null_blk}/null_blk_trace.c | 0
 drivers/block/{ => null_blk}/null_blk_trace.h | 0
 drivers/block/{ => null_blk}/null_blk_zoned.c | 0
 9 files changed, 19 insertions(+), 13 deletions(-)
 create mode 100644 drivers/block/null_blk/Kconfig
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{ => null_blk}/null_blk.h (100%)
 rename drivers/block/{ => null_blk}/null_blk_main.c (100%)
 rename drivers/block/{ => null_blk}/null_blk_trace.c (100%)
 rename drivers/block/{ => null_blk}/null_blk_trace.h (100%)
 rename drivers/block/{ => null_blk}/null_blk_zoned.c (100%)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ecceaaa1a66f..262326973ee0 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -16,13 +16,7 @@ menuconfig BLK_DEV
 
 if BLK_DEV
 
-config BLK_DEV_NULL_BLK
-	tristate "Null test block driver"
-	select CONFIGFS_FS
-
-config BLK_DEV_NULL_BLK_FAULT_INJECTION
-	bool "Support fault injection for Null test block driver"
-	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION
+source "drivers/block/null_blk/Kconfig"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index e1f63117ee94..31bc2cfa342f 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -41,12 +41,7 @@ obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
-obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
-null_blk-objs	:= null_blk_main.o
-ifeq ($(CONFIG_BLK_DEV_ZONED), y)
-null_blk-$(CONFIG_TRACING) += null_blk_trace.o
-endif
-null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
+obj-$(CONFIG_BLK_DEV)		+= null_blk/
 
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/null_blk/Kconfig b/drivers/block/null_blk/Kconfig
new file mode 100644
index 000000000000..1ce02a3572bd
--- /dev/null
+++ b/drivers/block/null_blk/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config BLK_DEV_NULL_BLK
+	tristate "Null test block driver"
+	select CONFIGFS_FS
+
+config BLK_DEV_NULL_BLK_FAULT_INJECTION
+	bool "Support fault injection for Null test block driver"
+	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION
diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Makefile
new file mode 100644
index 000000000000..a93a16d5ba23
--- /dev/null
+++ b/drivers/block/null_blk/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
+null_blk-objs			:= null_blk_main.o
+ifeq ($(CONFIG_BLK_DEV_ZONED), y)
+null_blk-$(CONFIG_TRACING)	+= null_blk_trace.o
+endif
+null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk/null_blk.h
similarity index 100%
rename from drivers/block/null_blk.h
rename to drivers/block/null_blk/null_blk.h
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk/null_blk_main.c
similarity index 100%
rename from drivers/block/null_blk_main.c
rename to drivers/block/null_blk/null_blk_main.c
diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk/null_blk_trace.c
similarity index 100%
rename from drivers/block/null_blk_trace.c
rename to drivers/block/null_blk/null_blk_trace.c
diff --git a/drivers/block/null_blk_trace.h b/drivers/block/null_blk/null_blk_trace.h
similarity index 100%
rename from drivers/block/null_blk_trace.h
rename to drivers/block/null_blk/null_blk_trace.h
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk/null_blk_zoned.c
similarity index 100%
rename from drivers/block/null_blk_zoned.c
rename to drivers/block/null_blk/null_blk_zoned.c
