Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2DBC55178
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2840520825
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 20:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM8RiGv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgKDUMg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:12:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727245AbgKDUMf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Nov 2020 15:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604520754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGMHNK2TaE+ybJXbKA/0L0s+vi4Q11l7Tf40a9FUGL4=;
        b=LM8RiGv54TdVjM7TscYGiMwpuxkRTkwN4X0wFXvP3lIa8cg1Q3cUp6pd57cWKe+K47/LmP
        6UHxDBh8owWlj3diffZ0gSAbZfeFXDHID2xSHkPrCH0cs2t+WxS3VP2SuWz4PJc68zJGKC
        34iRu2Gwod+f9UoydVcKR/Vvjbemk14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-d0BatHi_N1W-psqslmLKpQ-1; Wed, 04 Nov 2020 15:12:30 -0500
X-MC-Unique: d0BatHi_N1W-psqslmLKpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C7881006CB8;
        Wed,  4 Nov 2020 20:12:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85EEE5B4AE;
        Wed,  4 Nov 2020 20:12:29 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 78A08181A050;
        Wed,  4 Nov 2020 20:12:29 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:12:26 -0500 (EST)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Message-ID: <803534645.17398688.1604520746475.JavaMail.zimbra@redhat.com>
In-Reply-To: <cki.1EF86A56CB.4YRW9Z76J1@redhat.com>
References: <cki.1EF86A56CB.4YRW9Z76J1@redhat.com>
Subject: =?utf-8?Q?Re:_=E2=9D=8C_FAIL:_Test_report_for_kernel_5.10.0-rc2_(block)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.195.209, 10.4.195.29]
Thread-Topic: =?utf-8?B?4p2MIEZBSUw6?= Test report for kernel 5.10.0-rc2 (block)
Thread-Index: F7t9eIHFGh9j4zp7g6XQseWZOoakjw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> From: "CKI Project" <cki-project@redhat.com>
> To: linux-block@vger.kernel.org, axboe@kernel.dk
> Sent: Wednesday, November 4, 2020 9:07:37 PM
> Subject: =E2=9D=8C FAIL: Test report for kernel 5.10.0-rc2 (block)
>=20
>=20
> Hello,
>=20
> We ran automated tests on a recent commit from this kernel tree:
>=20
>        Kernel repo:
>        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.=
git
>             Commit: 31823cc0ea9c - Merge branch 'for-5.11/io_uring' into
>             for-next
>=20
> The results of these automated tests are provided below.
>=20
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: FAILED
>=20
> All kernel binaries, config files, and logs are available for download he=
re:
>=20
>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?p=
refix=3Ddatawarehouse-public/2020/11/04/616937
>=20
> We attempted to compile the kernel for multiple architectures, but the
> compile
> failed on one or more architectures:
>=20
>            ppc64le: FAILED (see build-ppc64le.log.xz attachment)
>=20

Hi,

on the first look this seems to be introduced by

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-next&id=3D23209e3dc23c8422e670472ebdd1cc349879a64c


For convenience here's a direct error from the logs:

00:02:10 In file included from fs/io_uring.c:45:
00:02:10 ./include/linux/syscalls.h:238:18: error: conflicting types for =
=E2=80=98sys_io_uring_enter=E2=80=99
00:02:10   238 |  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))=
 \
00:02:10       |                  ^~~
00:02:10 ./include/linux/syscalls.h:224:2: note: in expansion of macro =E2=
=80=98__SYSCALL_DEFINEx=E2=80=99
00:02:10   224 |  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
00:02:10       |  ^~~~~~~~~~~~~~~~~
00:02:10 ./include/linux/syscalls.h:218:36: note: in expansion of macro =E2=
=80=98SYSCALL_DEFINEx=E2=80=99
00:02:10   218 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##n=
ame, __VA_ARGS__)
00:02:10       |                                    ^~~~~~~~~~~~~~~
00:02:10 fs/io_uring.c:9135:1: note: in expansion of macro =E2=80=98SYSCALL=
_DEFINE6=E2=80=99
00:02:10  9135 | SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_=
submit,
00:02:10       | ^~~~~~~~~~~~~~~
00:02:10 ./include/linux/syscalls.h:318:17: note: previous declaration of =
=E2=80=98sys_io_uring_enter=E2=80=99 was here
00:02:10   318 | asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to=
_submit,
00:02:10       |                 ^~~~~~~~~~~~~~~~~~
00:02:10 make[3]: *** [scripts/Makefile.build:283: fs/io_uring.o] Error 1
00:02:10 make[2]: *** [Makefile:1799: fs] Error 2


Veronika


> We hope that these logs can help you find the problem quickly. For the fu=
ll
> detail on our testing procedures, please scroll to the bottom of this
> message.
>=20
> Please reply to this email if you have any questions about the tests that=
 we
> ran or if you have any suggestions on how to make future tests more
> effective.
>=20
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
> _________________________________________________________________________=
_____
>=20
> Compile testing
> ---------------
>=20
> We compiled the kernel for 4 architectures:
>=20
>     aarch64:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>     ppc64le:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>     s390x:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>     x86_64:
>       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
>=20
>=20
>=20

