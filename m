Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4464EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 11:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiCULme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346173AbiCULmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 07:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E3ADDAFE9
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647862867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ptvizDovPmtjs9XVYgTQTlGfG8IkPLM6FzokPxfJF4=;
        b=XVtscEu4XEgpDxHme4fvh5AUz70Qt4kRoQf6q9qti/fZOx1LPWf48HidBMr73Gc12wt475
        0/Xcs20yEk9IqorIfrbu8xC8KaVxeh/R2lybl9ilLbVngH5YDYvAe3SvrtzcQsDs+5hXdo
        jHJW4V7WwXkaLNhDnpXtRNIFbx9NqZ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-I-wrUeCmMYa9uVc-plCmtQ-1; Mon, 21 Mar 2022 07:41:03 -0400
X-MC-Unique: I-wrUeCmMYa9uVc-plCmtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53F4685A5BC;
        Mon, 21 Mar 2022 11:41:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEDD0C26E8E;
        Mon, 21 Mar 2022 11:41:02 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Bikal Lem <gbikal+git@gmail.com>
Subject: [PATCH] src/Makefile: re-add major version number to soname
Date:   Mon, 21 Mar 2022 11:41:01 +0000
Message-Id: <20220321114101.682270-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit c0b43df28a982747e081343f23289357ab4615db ("src/Makefile: use
VERSION variable consistently") changed the library soname from
liburing.so.2 to liburing.so.

The idea of soname is that executables linked against liburing.so.2
continue to work with liburing.so.2.1, liburing.so.2.2, etc because the
soname matches. They must not work against liburing.so.1 or
liburing.so.3 though since those major versions are incompatible.

Dropping the major version makes the soname unversioned and executables
will link against future liburing releases that are not compatible.

Fix the soname compatibility problem by re-adding the major version
number. Compute it from the VERSION value instead of hardcoding it in
the Makefile.

liburing 2.1:
  $ readelf -a src/liburing.so.2.1 | grep SON
   0x000000000000000e (SONAME)             Library soname: [liburing.so.2]

commit c0b43df28a98:
  $ readelf -a src/liburing.so.2.2 | grep SON
   0x000000000000000e (SONAME)             Library soname: [liburing.so]

With this fix:
  $ readelf -a src/liburing.so.2.2 | grep SON
   0x000000000000000e (SONAME)             Library soname: [liburing.so.2]

Fixes: c0b43df28a982747e081343f23289357ab4615db ("src/Makefile: use VERSION variable consistently")
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: Bikal Lem <gbikal+git@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.common | 1 +
 src/Makefile    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.common b/Makefile.common
index e7c9412..27fc233 100644
--- a/Makefile.common
+++ b/Makefile.common
@@ -2,4 +2,5 @@ TOP := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
 NAME=liburing
 SPECFILE=$(TOP)/$(NAME).spec
 VERSION=$(shell awk '/Version:/ { print $$2 }' $(SPECFILE))
+VERSION_MAJOR=$(shell echo $(VERSION) | cut -d. -f1)
 TAG = $(NAME)-$(VERSION)
diff --git a/src/Makefile b/src/Makefile
index 0e04986..12cf49f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -16,8 +16,8 @@ LINK_FLAGS=
 LINK_FLAGS+=$(LDFLAGS)
 ENABLE_SHARED ?= 1
 
-soname=liburing.so
-libname=$(soname).$(VERSION)
+soname=liburing.so.$(VERSION_MAJOR)
+libname=liburing.so.$(VERSION)
 all_targets += liburing.a
 
 ifeq ($(ENABLE_SHARED),1)
-- 
2.35.1

