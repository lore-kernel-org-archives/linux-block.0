Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF9613FFC
	for <linux-block@vger.kernel.org>; Sat, 11 Nov 2023 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDOx2gYG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C23A9C
	for <linux-block@vger.kernel.org>; Sat, 11 Nov 2023 03:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699702983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mo+Ia/MY8T4xmWa/XL7VvYVIvvRuNaoJr//flWGWhhc=;
	b=hDOx2gYGD0CuDpfnw8+tQ0EEi4UyEdOe1nCdZYYYMhn+51EOWUd5mzrNzH5ITUfx7MS/5q
	h2tfYMV94/E9wsWmC8gx1IDGwtgUh5V+Gbdj0X1qKN8xnD3Ygbeg6/vswuhwvmZijxebxf
	eXQcpn2CSbGEZsimEfsVGDnSmNoc2Lk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-2uU4Fz-FMmG1BnDhlsdHig-1; Sat, 11 Nov 2023 06:43:02 -0500
X-MC-Unique: 2uU4Fz-FMmG1BnDhlsdHig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BED3485A58B;
	Sat, 11 Nov 2023 11:43:01 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2DA640C6EB9;
	Sat, 11 Nov 2023 11:43:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] ublk/rc: prefer to rublk over miniublk
Date: Sat, 11 Nov 2023 19:42:53 +0800
Message-ID: <20231111114253.2665981-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add one wrapper script for using rublk to run ublk tests, and prefer
to rublk because it is well implemented and more reliable.

This way has been run for months in rublk's github CI test.

https://github.com/ming1/rublk

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix 'make check' warning, by taking Shinichiro's delta change
	- rublk v0.1.3 fixes loop block size issue reported recently
	from Akinobu

 Makefile             |  2 +-
 README.md            |  1 +
 src/rublk_wrapper.sh | 31 +++++++++++++++++++++++++++++++
 tests/ublk/rc        |  6 +++++-
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100755 src/rublk_wrapper.sh

diff --git a/Makefile b/Makefile
index 4bed1da..43f2ab0 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,7 @@ SHELLCHECK_EXCLUDE := SC2119
 
 check:
 	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check new common/* \
-		tests/*/rc tests/*/[0-9]*[0-9]
+		tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
 	! grep TODO tests/*/rc tests/*/[0-9]*[0-9]
 	! find -name '*.out' -perm /u=x+g=x+o=x -printf '%p is executable\n' | grep .
 
diff --git a/README.md b/README.md
index b6445d6..09fbb1e 100644
--- a/README.md
+++ b/README.md
@@ -26,6 +26,7 @@ Some tests require the following:
 - multipath-tools (Debian, openSUSE, Arch Linux) or device-mapper-multipath
   (Fedora)
 - dmsetup (Debian) or device-mapper (Fedora, openSUSE, Arch Linux)
+- rublk (`cargo install --version=^0.1 rublk`) for ublk test
 
 Build blktests with `make`. Optionally, install it to a known location with
 `make install` (`/usr/local/blktests` by default, but this can be changed by
diff --git a/src/rublk_wrapper.sh b/src/rublk_wrapper.sh
new file mode 100755
index 0000000..2e79a01
--- /dev/null
+++ b/src/rublk_wrapper.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ming Lei <ming.lei@redhat.com>
+#
+# rublk wrapper for adapting miniublk's command line
+
+PARA=()
+ACT=$1
+for arg in "$@"; do
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
+		PARA+=("$arg")
+	else
+		PARA+=("$arg")
+	fi
+done
+rublk "${PARA[@]}"
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

