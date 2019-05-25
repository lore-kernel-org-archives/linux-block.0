Return-Path: <SRS0=ocky=TZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB9C04AB0
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47AA217F9
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 09:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEYJGt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 May 2019 05:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfEYJGt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 May 2019 05:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 016033086262;
        Sat, 25 May 2019 09:06:49 +0000 (UTC)
Received: from localhost (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D59F6269F;
        Sat, 25 May 2019 09:06:46 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 1/2] pkgconfig: install a liburing.pc file
Date:   Sat, 25 May 2019 09:58:29 +0100
Message-Id: <20190525085830.31577-2-stefanha@redhat.com>
In-Reply-To: <20190525085830.31577-1-stefanha@redhat.com>
References: <20190525085830.31577-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sat, 25 May 2019 09:06:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

pkg-config (https://pkgconfig.freedesktop.org/) makes it easier to build
applications that have library dependencies.  Libraries ship .pc files
containing the compiler and linker flags needed to build successfully.
This saves applications from hardcoding these details into their build
scripts, especially when these details can change between operating
systems or distributions.

To build a liburing application:

  gcc $(pkg-config --cflags --libs liburing) -o myapp myapp.c

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile       | 13 +++++++++++--
 .gitignore     |  2 ++
 liburing.pc.in | 12 ++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 liburing.pc.in

diff --git a/Makefile b/Makefile
index d42dd45..6755713 100644
--- a/Makefile
+++ b/Makefile
@@ -33,13 +33,22 @@ ifneq ($(MAKECMDGOALS),clean)
 include config-host.mak
 endif
 
-install:
+%.pc: %.pc.in
+	sed -e "s%@prefix@%$(prefix)%g" \
+	    -e "s%@libdir@%$(libdir)%g" \
+	    -e "s%@includedir@%$(includedir)%g" \
+	    -e "s%@NAME@%$(NAME)%g" \
+	    -e "s%@VERSION@%$(VERSION)%g" \
+	    $< >$@
+
+install: $(NAME).pc
 	@$(MAKE) -C src install prefix=$(DESTDIR)$(prefix) includedir=$(DESTDIR)$(includedir) libdir=$(DESTDIR)$(libdir)
+	$(INSTALL) -D -m 644 $(NAME).pc $(DESTDIR)$(libdir)/pkgconfig/$(NAME).pc
 	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man2
 	$(INSTALL) -m 644 man/*.2 $(DESTDIR)$(mandir)/man2
 
 clean:
-	@rm -f config-host.mak config-host.h cscope.out
+	@rm -f config-host.mak config-host.h cscope.out $(NAME).pc
 	@$(MAKE) -C src clean
 	@$(MAKE) -C test clean
 	@$(MAKE) -C examples clean
diff --git a/.gitignore b/.gitignore
index e292825..08ba0e0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,3 +12,5 @@
 config-host.h
 config-host.mak
 config.log
+
+liburing.pc
diff --git a/liburing.pc.in b/liburing.pc.in
new file mode 100644
index 0000000..e621939
--- /dev/null
+++ b/liburing.pc.in
@@ -0,0 +1,12 @@
+prefix=@prefix@
+exec_prefix=${prefix}
+libdir=@libdir@
+includedir=@includedir@
+
+Name: @NAME@
+Version: @VERSION@
+Description: io_uring library
+URL: http://git.kernel.dk/cgit/liburing/
+
+Libs: -L${libdir} -luring
+Cflags: -I${includedir}
-- 
2.21.0

