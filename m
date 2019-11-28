Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293EC432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD2D21775
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 10:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfK1K0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:26:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:50666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfK1K0K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 05:26:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4246EB25B;
        Thu, 28 Nov 2019 10:26:09 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH liburing] liburing: create an installation target for tests
Date:   Thu, 28 Nov 2019 11:26:06 +0100
Message-Id: <20191128102606.26353-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Create an installation target for liburing's regressen test suite.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 Makefile      |  3 +++
 configure     |  8 ++++++++
 test/Makefile | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 9e132183620a..89b3f1d50135 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,9 @@ install: $(NAME).pc
 	$(INSTALL) -m 755 -d $(DESTDIR)$(mandir)/man2
 	$(INSTALL) -m 644 man/*.2 $(DESTDIR)$(mandir)/man2
 
+install-tests:
+	@$(MAKE) -C test install prefix=$(DESTDIR)$(prefix) datadir=$(DESTDIR)$(datadir)
+
 clean:
 	@rm -f config-host.mak config-host.h cscope.out $(NAME).pc
 	@$(MAKE) -C src clean
diff --git a/configure b/configure
index 81e4bccab350..babbae1fafc2 100755
--- a/configure
+++ b/configure
@@ -24,6 +24,8 @@ for opt do
   ;;
   --mandir=*) mandir="$optarg"
   ;;
+  --datadir=*) datadir="$optarg"
+  ;;
   *)
     echo "ERROR: unkown option $opt"
     echo "Try '$0 --help' for more information"
@@ -44,6 +46,10 @@ fi
 if test -z "$mandir"; then
   mandir="$prefix/man"
 fi
+if test -z "$datadir"; then
+  datadir="$prefix/share"
+fi
+
 
 if test "$show_help" = "yes"; then
 cat <<EOF
@@ -55,6 +61,7 @@ Options: [defaults in brackets after descriptions]
   --includedir=PATH        install headers in PATH [$includedir]
   --libdir=PATH            install libraries in PATH [$libdir]
   --mandir=PATH            install man pages in PATH [$mandir]
+  --datadir=PATH           install shared data in PATH [$datadir]
 EOF
 exit 0
 fi
@@ -163,6 +170,7 @@ print_and_output_mak "prefix" "$prefix"
 print_and_output_mak "includedir" "$includedir"
 print_and_output_mak "libdir" "$libdir"
 print_and_output_mak "mandir" "$mandir"
+print_and_output_mak "datadir" "$datadir"
 
 ##########################################
 # check for __kernel_rwf_t
diff --git a/test/Makefile b/test/Makefile
index 40b7e76190d6..eb83bc1b7ad4 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -1,3 +1,8 @@
+prefix ?= /usr
+datadir ?= $(prefix)/share
+
+INSTALL=install
+
 CFLAGS ?= -g -O2
 XCFLAGS =
 override CFLAGS += -Wall -D_GNU_SOURCE -L../src/ -I../src/include/
@@ -41,6 +46,11 @@ send_recvmsg: XCFLAGS = -lpthread
 poll-link: XCFLAGS = -lpthread
 accept-link: XCFLAGS = -lpthread
 
+install: $(all_targets) runtests.sh runtests-loop.sh
+	$(INSTALL) -D -d -m 755 $(datadir)/liburing-test/
+	$(INSTALL) -D -m 755 $(all_targets) $(datadir)/liburing-test/
+	$(INSTALL) -D -m 755 runtests.sh  $(datadir)/liburing-test/
+	$(INSTALL) -D -m 755 runtests-loop.sh  $(datadir)/liburing-test/
 clean:
 	rm -f $(all_targets) $(test_objs)
 
-- 
2.16.4

