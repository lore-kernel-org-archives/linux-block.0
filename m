Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36054 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeKJA4c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Nov 2018 19:56:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id d13-v6so1064349pfo.3
        for <linux-block@vger.kernel.org>; Fri, 09 Nov 2018 07:15:32 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: osandov@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH blktests] makefile: Add install rule
Date: Fri,  9 Nov 2018 07:15:24 -0800
Message-Id: <20181109151524.50405-1-gwendal@chromium.org>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add rule to install to a target directory, /usr/local/blktests by
default.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Makefile     | 9 +++++++++
 src/Makefile | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index 38b8ad1..d7c2b74 100644
--- a/Makefile
+++ b/Makefile
@@ -1,9 +1,18 @@
+prefix ?= /usr/local
+dest = $(DESTDIR)$(prefix)/blktests
+
 all:
 	$(MAKE) -C src all
 
 clean:
 	$(MAKE) -C src clean
 
+install:
+	install -m755 -d $(dest)
+	install check $(dest)
+	cp -R tests common $(dest)
+	$(MAKE) -C src dest=$(dest) install
+
 # SC2119: "Use foo "$@" if function's $1 should mean script's $1". False
 # positives on helpers like _init_scsi_debug.
 SHELLCHECK_EXCLUDE := SC2119
diff --git a/src/Makefile b/src/Makefile
index 15c1022..f0ddbb5 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -20,6 +20,9 @@ all: $(TARGETS)
 clean:
 	rm -f $(TARGETS)
 
+install: $(TARGETS)
+	install $(TARGETS) $(dest)
+
 $(C_TARGETS): %: %.c
 	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^
 
-- 
2.16.4
