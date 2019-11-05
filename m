Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD1CA9EDB
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 07:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23EC217F4
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 07:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQfdmP2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfKEHju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:39:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60722 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387484AbfKEHju (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 02:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572939588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSO/MwR5d6UQ4ybf91CFGN2YKZpcMYCX5AXv/RULnVY=;
        b=MQfdmP2zvznmuAEp6G4s+bxUQuMX2LOFdiBwZfSDqOEZAthErWgVNmOTrmeUddzS3qf6rH
        la5sXlmw3d3fHQJf/tF1GA/ILVTz5UaqSnCoV7PY7yQvEzf2E+nWg27XXRRGzl5K6hT985
        F1l/C0fGVoRXwzUgfb5JFTrAIKQ80gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-5N4truiPOT-cTTc_nKHOOQ-1; Tue, 05 Nov 2019 02:39:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 634161005500;
        Tue,  5 Nov 2019 07:39:45 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A55595C1B2;
        Tue,  5 Nov 2019 07:39:38 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing v3 3/3] spec: Fedora RPM cleanups
Date:   Tue,  5 Nov 2019 08:39:17 +0100
Message-Id: <20191105073917.62557-4-stefanha@redhat.com>
In-Reply-To: <20191105073917.62557-1-stefanha@redhat.com>
References: <20191105073917.62557-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5N4truiPOT-cTTc_nKHOOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

Cole Robinson and Fabio Valenti made a number of suggestions for the
.spec file:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1766157

 * Release should be Release: 1%{?dist} so the .fcXX bits get appended
   to the version string
 * Source: should be a pointer to the upstream URL that hosts the
   release. In this case I think it should be
   https://github.com/axboe/liburing/archive/...
   the ending weirdness is due to github renaming the archive strangely.
   You might need to pass '-n %{name}-%{name}-%{version}' to
   %setup/%autosetup to tell it what the extracted archive name is
 * The %defattr lines should be removed:
   https://pagure.io/packaging-committee/issue/77
 * The Group: lines should be removed
 * All the BuildRoot and RPM_BUILD_ROOT lines should be removed. %clean
   should be removed
 * The ./configure line should be replaced with just %configure
 * The 'make' call should be %make_build
 * The 'make install' call should be %make_install
 * The %pre and %post sections can be entirely removed, ldconfig is
   done automatically:
   https://fedoraproject.org/wiki/Changes/Removing_ldconfig_scriptlets
 * The devel package 'Requires: liburing' should instead be: Requires:
   %{name} =3D %{version}-%{release}
 * The devel package should also have Requires: pkgconfig
 * I think all the %attr usage can be entirely removed, unless they are
   doing something that the build system isn't doing.
 * The Provides: liburing.so.1 shouldn't be necessary, I'm pretty sure
   RPM automatically adds annotations like this
 * Replace %setup with %autosetup, which will automatically apply any
   listed Patch: in the spec if anything is backported in the future.
   It's a small maintenace optimization

These changes work on Fedora 31 and openSUSE Leap 15.1.  Therefore they
are likely to work on other rpm-based distributions too.

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 57 ++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/liburing.spec b/liburing.spec
index f9e9262..e542771 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -1,12 +1,11 @@
 Name: liburing
 Version: 0.2
-Release: 1
+Release: 1%{?dist}
 Summary: Linux-native io_uring I/O access library
 License: LGPLv2+
-Group:  System Environment/Libraries
 Source: %{name}-%{version}.tar.gz
-BuildRoot: %{_tmppath}/%{name}-root
-URL: http://git.kernel.dk/cgit/liburing/
+URL: https://git.kernel.dk/cgit/liburing/snapshot/%{name}-%{version}.tar.g=
z
+BuildRequires: gcc
=20
 %description
 Provides native async IO for the Linux kernel, in a fast and efficient
@@ -14,47 +13,49 @@ manner, for both buffered and O_DIRECT.
=20
 %package devel
 Summary: Development files for Linux-native io_uring I/O access library
-Group: Development/System
-Requires: liburing
-Provides: liburing.so.1
+Requires: %{name} =3D %{version}-%{release}
+Requires: pkgconfig
=20
 %description devel
 This package provides header files to include and libraries to link with
 for the Linux-native io_uring.
=20
 %prep
-%setup
+%autosetup
=20
 %build
-./configure --prefix=3D/usr --libdir=3D/%{_libdir} --mandir=3D/usr/share/m=
an
-make
+./configure --prefix=3D%{_prefix} --libdir=3D/%{_libdir} --mandir=3D%{_man=
dir} --includedir=3D%{_includedir}
=20
-%install
-[ "$RPM_BUILD_ROOT" !=3D "/" ] && rm -rf $RPM_BUILD_ROOT
-
-make install DESTDIR=3D$RPM_BUILD_ROOT
-
-%clean
-[ "$RPM_BUILD_ROOT" !=3D "/" ] && rm -rf $RPM_BUILD_ROOT
+%make_build
=20
-%post -p /sbin/ldconfig
-
-%postun -p /sbin/ldconfig
+%install
+%make_install
=20
 %files
-%defattr(-,root,root)
 %attr(0755,root,root) %{_libdir}/liburing.so.*
 %doc COPYING
=20
 %files devel
-%defattr(-,root,root)
-%attr(-,root,root) %{_includedir}/liburing/
-%attr(0644,root,root) %{_includedir}/liburing.h
-%attr(0755,root,root) %{_libdir}/liburing.so
-%attr(0644,root,root) %{_libdir}/liburing.a
-%attr(0644,root,root) %{_libdir}/pkgconfig/*
-%attr(0644,root,root) %{_mandir}/man2/*
+%{_includedir}/liburing/
+%{_includedir}/liburing.h
+%{_libdir}/liburing.so
+%{_libdir}/liburing.a
+%{_libdir}/pkgconfig/*
+%{_mandir}/man2/*
=20
 %changelog
+* Thu Oct 31 2019 Jeff Moyer <jmoyer@redhat.com> - 0.2-1
+- Add io_uring_cq_ready()
+- Add io_uring_peek_batch_cqe()
+- Add io_uring_prep_accept()
+- Add io_uring_prep_{recv,send}msg()
+- Add io_uring_prep_timeout_remove()
+- Add io_uring_queue_init_params()
+- Add io_uring_register_files_update()
+- Add io_uring_sq_space_left()
+- Add io_uring_wait_cqe_timeout()
+- Add io_uring_wait_cqes()
+- Add io_uring_wait_cqes_timeout()
+
 * Tue Jan 8 2019 Jens Axboe <axboe@kernel.dk> - 0.1
 - Initial version
--=20
2.23.0

