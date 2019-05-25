Return-Path: <SRS0=ocky=TZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939DDC04AB0
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 09:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7327B217F9
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 09:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEYJGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 May 2019 05:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfEYJGu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 May 2019 05:06:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 846DF3083392;
        Sat, 25 May 2019 09:06:50 +0000 (UTC)
Received: from localhost (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 192545C206;
        Sat, 25 May 2019 09:06:49 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 2/2] configure: move directory options to ./configure
Date:   Sat, 25 May 2019 09:58:30 +0100
Message-Id: <20190525085830.31577-3-stefanha@redhat.com>
In-Reply-To: <20190525085830.31577-1-stefanha@redhat.com>
References: <20190525085830.31577-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 25 May 2019 09:06:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

libdir is hardcoded to ${prefix}/lib in Makefile.  Fedora x86_64 uses
/usr/lib64 and this means libaries will be installed in the wrong place.

This patch moves prefix, includedir, libdir, and mandir into ./configure
for easier customization.  To build and install on Fedora x86_64:

  # ./configure --libdir=/usr/lib64
  # make && make install

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Makefile  |  4 ----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index ef71a14..19c2b54 100755
--- a/configure
+++ b/configure
@@ -10,6 +10,10 @@ else
 fi
 
 cc=gcc
+prefix=/usr
+includedir="$prefix/include"
+libdir="$prefix/lib"
+mandir="$prefix/man"
 
 TMPC="${TMPDIR1}/fio-conf-${RANDOM}-$$-${RANDOM}.c"
 TMPC2="${TMPDIR1}/fio-conf-${RANDOM}-$$-${RANDOM}-2.c"
@@ -98,11 +102,60 @@ has() {
   type "$1" >/dev/null 2>&1
 }
 
+output_mak() {
+  echo "$1=$2" >> $config_host_mak
+}
+
 output_sym() {
-  echo "$1=y" >> $config_host_mak
+  output_mak "$1" "y"
   echo "#define $1" >> $config_host_h
 }
 
+print_and_output_mak() {
+  print_config "$1" "$2"
+  output_mak "$1" "$2"
+}
+
+for opt do
+  optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
+  case "$opt" in
+  --help|-h) show_help=yes
+  ;;
+  --prefix=*) prefix="$optarg"
+  ;;
+  --includedir=*) includedir="$optarg"
+  ;;
+  --libdir=*) libdir="$optarg"
+  ;;
+  --mandir=*) mandir="$optarg"
+  ;;
+  *)
+    echo "ERROR: unkown option $opt"
+    echo "Try '$0 --help' for more information"
+    exit 1
+  ;;
+  esac
+done
+
+if test "$show_help" = "yes"; then
+cat <<EOF
+
+Usage: configure [options]
+Options: [defaults in brackets after descriptions]
+  --help                   print this message
+  --prefix=PATH            install in PATH [$prefix]
+  --includedir=PATH        install headers in PATH [$includedir]
+  --libdir=PATH            install libraries in PATH [$libdir]
+  --mandir=PATH            install man pages in PATH [$mandir]
+EOF
+exit 0
+fi
+
+print_and_output_mak "prefix" "$prefix"
+print_and_output_mak "includedir" "$includedir"
+print_and_output_mak "libdir" "$libdir"
+print_and_output_mak "mandir" "$mandir"
+
 ##########################################
 # check for __kernel_rwf_t
 __kernel_rwf_t="no"
diff --git a/Makefile b/Makefile
index 6755713..ea639d6 100644
--- a/Makefile
+++ b/Makefile
@@ -5,10 +5,6 @@ TAG = $(NAME)-$(VERSION)
 RPMBUILD=$(shell `which rpmbuild >&/dev/null` && echo "rpmbuild" || echo "rpm")
 
 INSTALL=install
-prefix ?= /usr
-includedir=$(prefix)/include
-libdir=$(prefix)/lib
-mandir=$(prefix)/man
 
 default: all
 
-- 
2.21.0

