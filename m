Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C7ACA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72137217F4
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 12:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYGtE/uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKDMGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:06:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbfKDMGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 07:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572869165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQlTkYiEnk72oeer/A7iyRQHuIL3KuImRtIzh4DmmV4=;
        b=AYGtE/uBJ5toCyfeDJD4BL0HRBOFMBmdo9cKZmJwY/9XQiaoEJEFZhdn75ERvRiZNsqJ8I
        qy/S9jXejP+cABqHyveNuywmdaNujI6OPmf8NRHHrwnw4s+w5fnpBNamhDsfFAIyz4yXFK
        p5gU+27emgycyKgIB+jPcb2DZ4aaZSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-hI9PPT2kM2usK7j9OnY7-A-1; Mon, 04 Nov 2019 07:06:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCDD38017DD;
        Mon,  4 Nov 2019 12:06:01 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA7119C4F;
        Mon,  4 Nov 2019 12:05:55 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 3/3] spec: Fedora RPM cleanups
Date:   Mon,  4 Nov 2019 13:05:32 +0100
Message-Id: <20191104120532.32839-4-stefanha@redhat.com>
In-Reply-To: <20191104120532.32839-1-stefanha@redhat.com>
References: <20191104120532.32839-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hI9PPT2kM2usK7j9OnY7-A-1
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

 * Release should be Release: 1%{?dist} so the .fcXX bits get appended to t=
he version string
 * Source: should be a pointer to the upstream URL that hosts the release. =
In this case I think it should be https://github.com/axboe/liburing/archive=
/%{name}-%{version}.tar.gz#%{name}-%{name}-%{version}.tar.gz, the ending we=
irdness is due to github renaming the archive strangely. You might need to =
pass '-n %{name}-%{name}-%{version}' to %setup/%autosetup to tell it what t=
he extracted archive name is
 * The %defattr lines should be removed: https://pagure.io/packaging-commit=
tee/issue/77
 * The Group: lines should be removed
 * All the BuildRoot and RPM_BUILD_ROOT lines should be removed. %clean sho=
uld be removed
 * The ./configure line should be replaced with just %configure
 * The 'make' call should be %make_build
 * The 'make install' call should be %make_install
 * The %pre and %post sections can be entirely removed, ldconfig is done au=
tomatically: https://fedoraproject.org/wiki/Changes/Removing_ldconfig_scrip=
tlets
 * The devel package 'Requires: liburing' should instead be: Requires: %{na=
me} =3D %{version}-%{release}
 * The devel package should also have Requires: pkgconfig
 * I think all the %attr usage can be entirely removed, unless they are doi=
ng something that the build system isn't doing.
 * The Provides: liburing.so.1 shouldn't be necessary, I'm pretty sure RPM =
automatically adds annotations like this
 * Replace %setup with %autosetup, which will automatically apply any liste=
d Patch: in the spec if anything is backported in the future. It's a small =
maintenace optimization

These changes work on Fedora 31 and openSUSE Leap 15.1.  Therefore they
are likely to work on other rpm-based distributions too.

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/liburing.spec b/liburing.spec
index f9e9262..08d46f4 100644
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
+URL: http://brick.kernel.dk/snaps/%{name}-%{version}.tar.gz
+BuildRequires: gcc
=20
 %description
 Provides native async IO for the Linux kernel, in a fast and efficient
@@ -14,47 +13,39 @@ manner, for both buffered and O_DIRECT.
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
+- Initial fedora package.
+
 * Tue Jan 8 2019 Jens Axboe <axboe@kernel.dk> - 0.1
 - Initial version
--=20
2.23.0

