Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5761AC4332F
	for <linux-block@archiver.kernel.org>; Mon,  6 Nov 2023 00:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjKFAgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Nov 2023 19:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjKFAgc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Nov 2023 19:36:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E5D8
        for <linux-block@vger.kernel.org>; Sun,  5 Nov 2023 16:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699230940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8eT3U74GpkOTCZjOOX54dVXuB1WEnj3oz32bBLUbX3Y=;
        b=ZsmjSVZnCnPHAkRWM4GH6UYbXXQHDU7NvrWnNSy8DhmVawvRxeDLTkPfrHS5OW8F2QlmBt
        JdmcQ97MpzKNvYwXAfJ2YUldw6oo66hDU0AWlpZWAckewmj4fO4nuDckwRt80X+DgVThXc
        qNuOq4n28I/HKFst4M/MaSOMfScourU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-AszTItinOlun3pXQ2XsaDQ-1; Sun, 05 Nov 2023 19:35:38 -0500
X-MC-Unique: AszTItinOlun3pXQ2XsaDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 693D6811E7E;
        Mon,  6 Nov 2023 00:35:38 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B1F2166B26;
        Mon,  6 Nov 2023 00:35:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests] ublk/rc: prefer to rublk over miniublk
Date:   Mon,  6 Nov 2023 08:35:23 +0800
Message-ID: <20231106003523.1923694-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one wrapper script for using rublk to run ublk tests, and prefer
to rublk because it is well implemented and more reliable.

This way has been run for months in rublk's github CI test.

https://github.com/ming1/rublk

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 README.md            |  1 +
 src/rublk_wrapper.sh | 31 +++++++++++++++++++++++++++++++
 tests/ublk/rc        |  6 +++++-
 3 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100755 src/rublk_wrapper.sh

diff --git a/README.md b/README.md
index b6445d6..313a3cc 100644
--- a/README.md
+++ b/README.md
@@ -26,6 +26,7 @@ Some tests require the following:
 - multipath-tools (Debian, openSUSE, Arch Linux) or device-mapper-multipath
   (Fedora)
 - dmsetup (Debian) or device-mapper (Fedora, openSUSE, Arch Linux)
+- rublk (`cargo install --version=0.1.2 rublk`) for ublk test
 
 Build blktests with `make`. Optionally, install it to a known location with
 `make install` (`/usr/local/blktests` by default, but this can be changed by
diff --git a/src/rublk_wrapper.sh b/src/rublk_wrapper.sh
new file mode 100755
index 0000000..803743e
--- /dev/null
+++ b/src/rublk_wrapper.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ming Lei <ming.lei@redhat.com>
+#
+# rublk wrapper for adapting miniublk's command line
+
+PARA=""
+ACT=$1
+for arg in $@; do
+	if [ "$arg" = "-t" ]; then
+		continue
+	fi
+
+	if [ "$ACT" = "recover" ]; then
+		if [ "$arg" = "loop" ] || [ "$arg" = "null" ]; then
+			continue;
+		fi
+
+		if [ -f "$arg" ]; then
+			continue
+		fi
+
+		if [ "$arg" = "-f" ]; then
+			continue
+		fi
+		PARA+=" $arg"
+	else
+		PARA+=" $arg"
+	fi
+done
+rublk $PARA
diff --git a/tests/ublk/rc b/tests/ublk/rc
index c553296..5fbf861 100644
--- a/tests/ublk/rc
+++ b/tests/ublk/rc
@@ -14,4 +14,8 @@ group_requires() {
 	_have_fio
 }
 
-export UBLK_PROG="src/miniublk"
+if which rublk > /dev/null 2>&1; then
+	export UBLK_PROG="src/rublk_wrapper.sh"
+else
+	export UBLK_PROG="src/miniublk"
+fi
-- 
2.41.0

