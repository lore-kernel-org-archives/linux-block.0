Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6BC43603
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FACF2073D
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 10:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+RsONNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLMKQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:16:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48883 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725906AbfLMKQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 05:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576232212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dZC3TLQvKNL9dxqm2y+N7UcG0Ltn/GJ3LHNlZCZCWpc=;
        b=P+RsONNdIdQmURIdHSfgsN+OdpYZ+ITZ+YMsJ/VKJqtOIl6NGOYuT94baKhJ8tTMqnNzMJ
        JQrsnxWafkQqCYRzgOxVvD3P0arhBZhaOQmmmC9tP728XrBy0EWrjGBfOupt+UPS11YQIv
        dSOYyUlaChF+iEjQqawbj/EVQQj44QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-j8tgXK5EM5eMBgJ1pdhukQ-1; Fri, 13 Dec 2019 05:16:46 -0500
X-MC-Unique: j8tgXK5EM5eMBgJ1pdhukQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18982DB61;
        Fri, 13 Dec 2019 10:16:45 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71D6A63BCD;
        Fri, 13 Dec 2019 10:16:41 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing] spec: additional Fedora RPM cleanups
Date:   Fri, 13 Dec 2019 10:16:40 +0000
Message-Id: <20191213101640.1180590-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cole Robinson made some more suggestions:

 * Use %set_build_flags before ./configure to get the default compiler
   flags.

 * Use '%license COPYING' instead of %doc.

 * Do not ship the static library.  This is distro policy and Fedora
   would ship a separate -static package if static libraries are
   desired.

 * Source: should be the URL to the sources.  URL: should be the URL of
   the website or git repo.

 * The devel package needs
   Requires: %{name}%{?_isa} =3D %{version}-%{release}

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/liburing.spec b/liburing.spec
index e542771..87b16b1 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -3,8 +3,8 @@ Version: 0.2
 Release: 1%{?dist}
 Summary: Linux-native io_uring I/O access library
 License: LGPLv2+
-Source: %{name}-%{version}.tar.gz
-URL: https://git.kernel.dk/cgit/liburing/snapshot/%{name}-%{version}.tar=
.gz
+Source: https://git.kernel.dk/cgit/liburing/snapshot/%{name}-%{version}.=
tar.gz
+URL: https://git.kernel.dk/cgit/liburing/
 BuildRequires: gcc
=20
 %description
@@ -13,7 +13,7 @@ manner, for both buffered and O_DIRECT.
=20
 %package devel
 Summary: Development files for Linux-native io_uring I/O access library
-Requires: %{name} =3D %{version}-%{release}
+Requires: %{name}%{_isa} =3D %{version}-%{release}
 Requires: pkgconfig
=20
 %description devel
@@ -24,6 +24,7 @@ for the Linux-native io_uring.
 %autosetup
=20
 %build
+%set_build_flags
 ./configure --prefix=3D%{_prefix} --libdir=3D/%{_libdir} --mandir=3D%{_m=
andir} --includedir=3D%{_includedir}
=20
 %make_build
@@ -33,13 +34,13 @@ for the Linux-native io_uring.
=20
 %files
 %attr(0755,root,root) %{_libdir}/liburing.so.*
-%doc COPYING
+%license COPYING
=20
 %files devel
 %{_includedir}/liburing/
 %{_includedir}/liburing.h
 %{_libdir}/liburing.so
-%{_libdir}/liburing.a
+%exclude %{_libdir}/liburing.a
 %{_libdir}/pkgconfig/*
 %{_mandir}/man2/*
=20
--=20
2.23.0

